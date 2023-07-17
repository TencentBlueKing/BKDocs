# 插件自定义UI

## 自定义插件前端框架

> 随着越来越多的用户使用研发商店开发流水线插件，用户对组件及交互场景的要求越来越高。  
> 由于大部分个性用户提的组件和交互场景不具有通用性，平台无法一一封装，因此设计开发了一套由用户自定义开发插件前端部分的框架。  
> 框架将插件的前端部分开放给用户自定义开发，适用于实现复杂交互场景的插件前端部分。

## 原理简介

* 将流水线编辑插件面板划分出一块区域以iframe的形式加载，iframe的内容由用户自定义实现。
* 点开插件时，平台上层会把插件的 atomValue 和 atomModel 通过 postMessage 的方式传递给 iframe，iframe 内部拿到 atomModel 和 atomValue 后即可以自定义实现插件部分。
* 当用户输入相应参数后，把值更新到 atomValue 即可，插件面板在关闭时会自动把 atomValue 的值传回给平台上层保存。

对于vue开发者，我们封装了一个基于 vue、集成了蓝鲸 magixbox 组件库、bkci 业务组件、bkci 插件能力的脚手架，并封装了与平台上层通信的 api，使开发者可以只专注于处理的业务逻辑部分。

## 框架目录结构介绍

插件代码库根目录下的 bk-frontend 目录为前端代码根目录。  
其下代码结构如下： ![png](../../../assets/store_plugin_customui_folder.png)

## 开发步骤

* 1、研发商店在新增件时，自定义插件前端部分选项选择“是”
* 2、运行：
  * 代码根目录下创建 bk-frontend 目录
  * 进到 bk-frontend 目录下
  * 将框架代码 [bkci-customAtom-frontend](https://github.com/ci-plugins/bkci-customAtom-frontend) 拷贝到当前目录下
  * 执行 npm install
  * 执行 npm run dev 此时打开浏览器打开 [http://localhost:8001](http://localhost:8001/), 即可看到我们内置的简单demo工程的效果
* 3、开发：
  * 配置 bk-frontend/data 目录下的task.json
  * 在 Atom.vue 里开发插件业务逻辑（具体开发注意事项见下面插件业务逻辑开发介绍）
* 4、本地调试ok后：
  * 把 bk-frontend/data 目录下的 task.json 里的内容复制到根目录下的 task.json

## Atom.vue \(用户插件逻辑部分开发注意事项\) 

* 用户在 Atom.vue 中开发插件时，需先引用 atomMixin，atomMixin 内置了平台上层通信的能力和交互api

```text
import { atomMixin }from 'bkci-atom-components'
mixins: [atomMixin],
```

* 引用 atomMixin.js 后，data 里已经内置了atomValue 和 atomModel 两个变量（说明如下）：

  * atomModel: 即 task.json 的 input 部分，在自定义插件框架下，可以把 task.json 的 input 部分理解 vue 文件里的 data 变量。 把一些配置放到 task.json 时，可以直接在 atomModel 变量里面取到，可以使 vue 文件更简洁好维护。
  * atomValue： 需要提交到平台上层，保存到后端插件执行时所用的值，格式如：

  ```text
  {
      "item1": "111",
      "item2": "222"
  }
  ```

  当用户修改相应参数后，把值更新到 atomValue 即可，插件面板在关闭时会自动把 atomValue 的值传回给上层保存

## 本地调试

> 框架提供了本地调试模块，用户可在本地调试好前端部分再提交

package.json 提供了两个打包命令

* npm run dev : 本地运行调试此工程，运行此命令时，程序的执行路径大致是 main.js -&gt; data/LocalAtom.vue -&gt; Atom.vue
* npm run public：本地开发完成后，准备发布包时执行此命令, main.js -&gt; data/PublicAtom.vue -&gt; Atom.vue
* 本地开发时，用户把 task.json 的内容放到 data/task.json下，则运行npm run dev后，框架会读取 data/task.json 里的 input 作为 atomModel，提取每个字段的 default 值作为 atomValue 里对应的默认值
* 线上运行时，atomModel 和 atomValue 的值由平台上层传递到iframe内部

用户在本地运行时调试正常，上线后在平台插件面板点开效果是一样的

## 发布

插件调试好之后，通过研发商店工作台进行发布，发布包准备过程如下：

1. 执行 npm run public 打包
2. 在发布包根目录下创建名为 frontend 的目录 [插件发布规范](release.md)
3. 将打包结果文件\( dist 目录下的所有文件\)拷贝到 frontend 目录下
4. 将发布包根目录下的所有文件打成 zip 文件，通过工作台上传到商店

## 常见问题

1、框架内置的 bkci 组件库和 magixbox 组件库怎么使用？

* bkci 组件库： task.json 可以配的组件也都可以直接以组件的形式使用，组件的属性即为 task.json 可配置的属性（[点击查看](plugin-config.md)），bkci 组件库的值变更事件统一封装为 :handle-change="functionxxx", 其中 functionxxx 有两个参数，一个是组件的 name，一个是组件的新 value
* 蓝鲸magixbox组件库种类丰富，基本能覆盖日常开发所需的组件类型，框架内可以直接使用 magixbox 组件库进行开发，具体使用请查看[官方文档](https://magicbox.bk.tencent.com/)

2、本地调试时，我需要结合某个具体项目，如使用 selector 组件拉取某某项目的代码库列表、凭证列表，怎么把项目信息带过来？

* 在访问的 url 后面通过 query 方式传递 projectId=${projectId} 即可，如 [http://local.XX.com:8001?projectId=abc](http://local.xx.com:8001/?projectId=abc), bkci 内置的 selector/select-input 组件会自动解析 url 里面的 projectId参数作为请求的参数

3、使用自定义插件框架开发后，task.json 还有用吗？两者关系是什么？

* 一定程度上来讲，使用自定义框架后，即使 task.json 里面的 input 内容为空，自定义框架也可以正常运行，但我们还是建议用户配置 task.json 的 input 部分，input 部分里的内容都会以通过 atomModel 变量传到iframe 中，可以使代码更简洁，提前定义好插件所需字段，也方便后端做一些检验和拓展，另一方面之前用惯了task.json 直接生成的用户，也可以参照 demo 内的写法，直接以高阶组件遍历的形式完成字段的渲染，task.json 里面配置的 rely 等交互能力也可以在引用了atomMixin 后直接使用

4、代码仓库根目录下有一个 task.json，bk-frontend/data 目录下也有一个 task.json，两者关系是什么, 为什么不统一成一个?

* 两个 task.json 的规范，配置方式一样，bk-frontend/data 下的 task.json 为本地调试时的数据源，本地调试时 atomModel 的值即为里面的 input 部分，根目录下的 task.json 为线上运行时 atomModel 的数据源，同时若插件里面还有 output 部分，可以在根目录下的 task.json 加上，即开发调试阶段，先在bk-frontend/data 写配置 task.json，上线提交前再把 bk-frontend/data 里 task.json 里的内容复制到根目录下的 task.json 即可（如果output部分，再单独加上）

5、 插件开发过程中，如果存在字段校验的情形，怎么和平台上层交互？

* 当引用了 atomMixin 后，框架内置封装好了与上层插件状态通信的 api，当用户填写的参数非法时，调用 this.setAtomIsError\(true\)，可将该插件框标红，此时流水线无法保存，当用户填写了合法的参数后，调用 this.setAtomIsError\(false\)，将状态重置回正常

