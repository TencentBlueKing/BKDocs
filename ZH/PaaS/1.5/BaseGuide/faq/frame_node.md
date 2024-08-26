# Node 框架使用相关

## PaaS 在部署 Node 应用时做了那些处理

PaaS 在部署 Node 应用整个过程包括：

- 启用一个容器（Docker）来初始服务系统（ubuntu linux）
- 检测是否存在 bin/pre-compile，执行 pre-compile hook
- 根据 package.json 的 engines 配置来安装 Node 和 npm 环境
- 根据 package.json 的 dependencies 和 devDependencies 来安装包依赖
- 缓存 node_modules 目录，如果下次 package.json 没更新部署时直接用缓存
- 检测 scripts.build，执行 npm run build
- 移除 devDependencies 下的依赖包
- 检测是否存 在 bin/post-compile，执行 post-compile hook
- 根据应用描述文件定义服务入口来初始化服务 [应用进程](../topics/paas/process_procfile.md)

## 除了 Express, 还支持那些 Node 框架，如 koa、egg、nest

根据上面的部署过程，Node 主流框架都是可以支持的，只需要将使用的框架依赖写入 dependencies，Node 构建工具会自动帮你初始化整个应用的运行环境

## PaaS 平台内置那些环境变量

请参考文档：[内置环境变量](../topics/paas/builtin_configvars.md)

## 在 Node 前端框架里怎么设置环境变量和获取

添加环境变量入口：

- 云原生应用：『模块配置』-『环境变量』
- 普通应用：『应用引擎』-『环境配置』

在代码中通过全局对象 process 来获取相应值

```javascript
// 获取应用的app_code
const appCode = process.env.BKPAAS_APP_ID
// 获取自定义环境变量
const myKey = process.env.myKey
```

## 部署 Node 服务时提供了那些 hook

在 Node 应用部署过程，提供了相应 hook，方便开发者介入，做一些自定义处理，包括

- pre-compile：构建工具在安装 Node 前执行
- post-compile：构建工具在 build 后执行

你只需要新建 shell 脚本命名为 pre-compile 和 post-compile 并放在 bin 目录下就可自动执行

例如，你想知道构建的的开始和结束时间来大概估算整个部署所花的时间

```bash
#!/bin/bash
# 显示当前时间
start_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "开始时间：${start_time}"
```

## 如何配置要使用的 node 和 npm 版本

配置 package.json，加入 engines 信息，Node 构建工具在安装 node 时会先检测 engines，根据 engines.ndoe 的版本来尝试安装，如果不成功会自动安装默认版本

注意：“>= 10.10.0”，这样的写法，PaaS 依然只是安装 10.10.0 版本，并不会安装比这更新的版本，主要是我们目前还没有提供 Node 版本检测机制

```json
"engines": {
    "node": "10.10.0",
    "npm": "6.4.1"
  }
```

## 关于 dependencies 和 devDependencies 的区别及部署时注意事项

PaaS 在安装完成 Node 环境后，下一步执行 npm install 来进行依赖安装，此时 dependencies 和 devDependencies 下的依赖包会逐一安装

- dependencies：官方定义是在生产环境下使用该依赖
- devDependencies：官方定义是仅在开发环境使用该依赖

举个例子，要用 webpack 构建代码，所以在执行 npm run build 时，它是必需的。但在执行运行服务时只需要 webpack 构建后的代码，webpack 本身是不必要的，所以 webpack 的依赖是放在 devDependencies

注意：devDependencies 下的依赖包在 PaaS 构建过程中执行 build 后会自动移除，例如你的一个依赖包需要在服务运行时使用如 express，但不小心写在 devDenpencies 时，当服务运行就会报 module not found

## 请问前端部署会执行 npm install 么

PaaS 部署时，Node 构建工具在安装完依赖后会检测 package.json 的 scripts 是否有 build 入口，如果有则自动执行 npm run build 来对项目进行构建

## 如何配置独立域名及域名申请的 ip 地址

应用 IP 查询：选择『访问管理』页面，查看 IP 信息

详情查看文档：[应用访问入口配置](../topics/paas/app_entry_intro.md)

## 部署默认端口是 5000，能调整？

服务默认是使用 5000 端口映射为 80，如果你的服务端口不是 5000 端口，则部署状态会一直为部署中，这是因为 PaaS 会默认对 5000 端口进行探测来判断服务有没有启动。因此，对非 5000 端口需要进行配置，具体如下

选择『应用引擎-访问入口』设置页面，配置『服务进程管理』，调整完后立即重新部署

## 如何确定当前运行环境是测试环境（stag）还是正式环境（prod）

你可以通过系统内置环境变量 BKPAAS_ENVIRONMENT 来对当前部署环境进行区分

```javascript
const env = process.env.BKPAAS_ENVIRONMENT
if (env === "stag") {
  // 测试环境
} else if (env === "prod") {
  // 正式环境
}
```

## 如何进行前后端分离

详情查看文档： [如何进行前后端分离开发](../topics/paas/multi_modules/separate_front_end_dev.md)

## 蓝鲸统一登录失败

可能是 cookie 被污染，可以尝试下清理缓存再重新登录刷新页面

## 非蓝鲸 Node 框架如何启动 Node 服务

整个前端 web 服务的思路是：使用 Node 服务将 build 后的静态资源运行起来，因此可以先定义一个 Node 服务

```javascript
const express = require("express")
const path = require("path")
const app = new express()
const PORT = 5000
// 首页
app.get("/", (req, res) => {
  const index = path.join(__dirname, "./dist/index.html")
  res.render(index)
})
// 配置静态资源
app.use("/", express.static(path.join(__dirname, "./dist")))
// 服务启动
app.listen(PORT, () => {
  console.log(`App is running in port ${PORT}`)
})
```

package.json scripts 加入 server 入口

```javascript
scripts: {
	server: node prod-server.js
}
```

app_desc.yaml 文件加入如下内容即可：

```
spec_version: 2
module:
  language: Node.js
  processes:
    web:
      command: npm run server
```

## 部署不成功，遇到 import 语法 SyntaxError: Unexpected identifier 报错如何处理

在使用蓝鲸提供的 Node 框架直接部署时，遇到以下报错信息

```bash
import path from 'path';
       ^^^^
SyntaxError: Unexpected identifier
    at new Script (vm.js:79:7)
    at createScript (vm.js:251:10)
    at Object.runInThisContext (vm.js:303:10)
```

Node 版本 8.5 以上已经开始支持 import，Node 版本 10LTS 中已经默认支持 ES6 模块，详见 github issue:[https://github.com/nodejs/node/pull/15308](https://github.com/nodejs/node/pull/15308)

因此，可以进行以下几步检查

- 查看配置文件.babelrc、.eslintrc.js 是否都按框架模板来提交，特别是 window 下，以.开头会设置为隐藏文件导致没有提交成功
- 检查 package.json 里 engines 配置的 Node 版本是否过低
- 检查环境配置的运行时配置所选择的构建工具，选择 Node + TNPM 环境(默认 Node 版本为 10.10.0）

## npm 安装依赖包失败

- 失败提示

```
npm ERR! code EINTEGRITY npm ERR! sha
```

解决思路：下载 npm 包的时候，npm 会做包的哈希检测，有时候因为 不同的源混用导致这个问题。一般可以删除 package-lock.json 来解决

- 失败提示：

```
npm ERR! ERESOLVE unable to resolve dependency tree
npm ERR! Could not resolve dependency
npm ERR! Fix the upstream dependency conflict, or retry
npm ERR! this command with --force, or --legacy-peer-deps
```

解决思路：遇到这种提示往往是由于多个模块依赖同一模块的不同版本导致了冲突，因此可以在 package.json 的 dependencies 或 devDependencies 加入冲突模块的版本配置

## npm 安装依赖包提示找不到匹配的版本

- 失败提示

```
npm ERR! notarget No matching version found
```

解决方案：

1. 将需要的包版本下载到本地后，通过命令上传到 bkrepo 上

一般情况下, Node.js SDK 往往具有复杂的依赖关系, 如需往 bkrepo 添加额外的 Node.js SDK, 则需要将该 SDK 依赖的其他 SDK 一并上传至 bkrepo。
为此, 平台提供了 Node.js 依赖管理工具 bk-npm-mgr。该工具已集成至镜像 paas3-npm-mgr, 也可直接从 bkrepo 中下载安装(运行依赖 node >= 12)。
以下讲解如何使用 bk-npm-mgr 工具上传额外的 Node.js SDK 至 bkrepo。

```bash
# 在能访问外网的机器中执行以下操作.
# 1. 启动容器
docker run -it --rm --entrypoint=bash ${your-docker-registry}/paas3-npm-mgr:${image-tag}
# 2. 安装需要上传额外的 Node.js  SDK, 以 vue 为例.
yarn add vue@3.0.11
# 3. 下载依赖至 dependencies 目录(执行步骤2时, 会生成 package.json 文件)
bk-npm-mgr download package.json -d dependencies
# 4. 上传 dependencies 目录中的 Node.js  SDK 至 bkrepo
bk-npm-mgr upload --username ${your-bkrepo-username} --password ${your-bkrepo-username} --registry ${your-bkrepo-endpoint}/npm/bkpaas/npm -s dependencies -v

# 如需上传自研的 SDK 至 bkrepo, 则需要将源码挂载至容器中, 可参考以下流程.
# 1. 启动容器, 并将源码挂载至启动目录.
docker run -it --rm --entrypoint=bash -v ${NodeSDK源码的绝对路径}:/blueking ${your-docker-registry}/paas3-npm-mgr:${image-tag}
# 2. 下载依赖至 dependencies 目录
bk-npm-mgr download package.json -d dependencies
# 3. 打包 SDK 至 dependencies
yarn pack -f dependencies/${your-sdk-name.tgz}
# 4. 上传 dependencies 目录中的 Node.js  SDK 至 bkrepo
bk-npm-mgr upload --username ${your-bkrepo-username} --password ${your-bkrepo-username} --registry ${your-bkrepo-endpoint}/npm/bkpaas/npm -s dependencies -v
```

2. 如果有外部 npm 源，可以找运维同学修改 `BUILDPACK_NODEJS_NPM_REGISTRY` 指向外网后，重启 apiserver 模块
