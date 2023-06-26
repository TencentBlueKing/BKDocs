# Node框架使用相关

## PaaS在部署Node应用时做了那些处理
PaaS在部署Node应用整个过程包括：

- 启用一个容器（Docker）来初始服务系统（ubuntu linux）
- 检测是否存在bin/pre-compile，执行pre-compile hook
- 根据package.json的engines配置来安装Node和npm环境
- 根据package.json的dependencies和devDependencies来安装包依赖
- 缓存node_modules目录，如果下次package.json没更新部署时直接用缓存
- 检测scripts.build，执行npm run build
- 移除devDependencies下的依赖包
- 检测是否存 在bin/post-compile，执行post-compile hook
- 根据Profile定义服务入口来初始化服务 [什么是Profile？](../topics/paas/process_procfile.md)
 

## 除了Express, 还支持那些Node框架，如koa、egg、nest

根据上面的部署过程，Node主流框架都是可以支持的，只需要将使用的框架依赖写入dependencies，Node构建工具会自动帮你初始化整个应用的运行环境

## PaaS平台内置那些环境变量

PaaS内置的环境变量包括

- BKPAAS_APP_ID
- BKPAAS_APP_SECRET
- BKPAAS_URL
- BKPAAS_ENVIRONMENT
- BKPAAS_REMOTE_STATIC_URL
- BKPAAS_WEIXIN_URL
- BKPAAS_WEIXIN_REMOTE_STATIC_URL
- BKPAAS_ENGINE_APP_NAME
- BKPAAS_ENGINE_REGION
- BKPAAS_LOG_NAME_PREFIX
- BKPAAS_ENGINE_APP_DEFAULT_SUBDOMAINS

请参考文档：[内置环境变量](../topics/paas/builtin_configvars.md)

## 在Node前端框架里怎么设置环境变量和获取

选择『应用引擎-环境变量』设置页面，输入 KEY 和对应的值，然后通过全局对象process来获取相应值

```javascript
// 获取应用的app_code
const appCode = process.env.BKPAAS_APP_ID
// 获取自定义环境变量
const myKey = process.env.myKey
```

## 部署Node服务时提供了那些hook

PaaS3.0 在Node应用部署过程，提供了相应hook，方便开发者介入，做一些自定义处理，包括

- pre-compile：构建工具在安装Node前执行
- post-compile：构建工具在build后执行

你只需要新建shell脚本命名为pre-compile和post-compile并放在bin目录下就可自动执行

例如，你想知道构建的的开始和结束时间来大概估算整个部署所花的时间
```bash
#!/bin/bash
# 显示当前时间
start_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "开始时间：${start_time}"
```

## 如何配置要使用的node和npm版本

配置package.json，加入engines信息，Node构建工具在安装node时会先检测engines，根据engines.ndoe的版本来尝试安装，如果不成功会自动安装默认版本

注意：“>= 10.10.0”，这样的写法，PaaS依然只是安装10.10.0版本，并不会安装比这更新的版本，主要是我们目前还没有提供Node版本检测机制

```json
"engines": {
    "node": "10.10.0",
    "npm": "6.4.1"
  }
```

## 关于dependencies和devDependencies的区别及部署时注意事项

PaaS在安装完成Node环境后，下一步执行npm install来进行依赖安装，此时dependencies和devDependencies下的依赖包会逐一安装

- dependencies：官方定义是在生产环境下使用该依赖
- devDependencies：官方定义是仅在开发环境使用该依赖

举个例子，要用 webpack 构建代码，所以在执行npm run build时，它是必需的。但在执行运行服务时只需要 webpack 构建后的代码，webpack 本身是不必要的，所以webpack的依赖是放在devDependencies

注意：devDependencies下的依赖包在PaaS构建过程中执行build后会自动移除，例如你的一个依赖包需要在服务运行时使用如express，但不小心写在devDenpencies时，当服务运行就会报module not found

## 请问前端部署会执行npm install么

PaaS部署时，Node构建工具在安装完依赖后会检测package.json的scripts是否有build入口，如果有则自动执行npm run build来对项目进行构建

##  如何配置独立域名及域名申请的ip地址

应用IP查询：选择『应用引擎-访问入口』页面，查看IP 信息

详情查看文档：[应用访问入口配置](../topics/paas/app_entry_intro.md)

## 部署默认端口是5000，能调整？

服务默认是使用5000端口映射为80，如果你的服务端口不是5000端口，则部署状态会一直为部署中，这是因为PaaS会默认对5000端口进行探测来判断服务有没有启动。因此，对非5000端口需要进行配置，具体如下

选择『应用引擎-访问入口』设置页面，配置『服务进程管理』，调整完后立即重新部署


## 如何确定当前运行环境是测试环境（stag）还是正式环境（prod）

你可以通过系统内置环境变量BKPAAS_ENVIRONMENT来对当前部署环境进行区分

```javascript
const env = process.env.BKPAAS_ENVIRONMENT
if (env === 'stag') {
	// 测试环境
} else if (env === 'prod') {
	// 正式环境
}
```

## 如何进行前后端分离

详情查看文档： [如何进行前后端分离开发](../topics/paas/multi_modules/separate_front_end_dev.md)


## 蓝鲸统一登录失败

可能是 cookie 被污染，可以尝试下清理缓存再重新登录刷新页面

## 非蓝鲸Node框架如何启动Node服务

整个前端web服务的思路是：使用Node服务将build后的静态资源运行起来，因此可以先定义一个Node服务

```javascript
const express = require('express')
const path = require('path')
const app = new express()
const PORT = 5000
// 首页
app.get('/', (req, res) => {
	const index = path.join(__dirname, './dist/index.html')
	res.render(index)
})
// 配置静态资源
app.use('/', express.static(path.join(__dirname, './dist')))
// 服务启动
app.listen(PORT, () => {
	console.log(`App is running in port ${PORT}`)
})
```

package.json scripts加入server入口
```javascript
scripts: {
	server: node prod-server.js
}
```

Procfile文件加入如下内容即可：

```javascript
web: npm run server
```

## 部署不成功，遇到import语法 SyntaxError: Unexpected identifier报错如何处理

在使用蓝鲸提供的Node框架直接部署时，遇到以下报错信息

```bash
import path from 'path';
       ^^^^
SyntaxError: Unexpected identifier
    at new Script (vm.js:79:7)
    at createScript (vm.js:251:10)
    at Object.runInThisContext (vm.js:303:10)
```
Node版本8.5以上已经开始支持import，Node版本10LTS中已经默认支持ES6模块，详见github issue:[https://github.com/nodejs/node/pull/15308](https://github.com/nodejs/node/pull/15308)

因此，可以进行以下几步检查

- 查看配置文件.babelrc、.eslintrc.js是否都按框架模板来提交，特别是window下，以.开头会设置为隐藏文件导致没有提交成功
- 检查package.json里engines配置的Node版本是否过低
- 检查环境配置的运行时配置所选择的构建工具，选择Node + TNPM环境(默认 Node 版本为10.10.0）


## npm安装依赖包失败

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

解决思路：遇到这种提示往往是由于多个模块依赖同一模块的不同版本导致了冲突，因此可以在package.json的dependencies或devDependencies加入冲突模块的版本配置



## npm安装依赖包提示找不到匹配的版本

- 失败提示
```
npm ERR! notarget No matching version found
```

解决方案：
1. 将需要的包版本下载到本地后，通过命令上传到 bkrepo 上

一般情况下, NodeJS SDK 往往具有复杂的依赖关系, 如需往 bkrepo 添加额外的 NodeJS SDK, 则需要将该 SDK 依赖的其他 SDK 一并上传至 bkrepo。
为此, 平台提供了 NodeJS 依赖管理工具 bk-npm-mgr。该工具已集成至镜像 paas3-npm-mgr, 也可直接从 bkrepo 中下载安装(运行依赖 node >= 12)。
以下讲解如何使用 bk-npm-mgr 工具上传额外的 NodeJS SDK 至 bkrepo。

```bash
# 在能访问外网的机器中执行以下操作.
# 1. 启动容器
docker run -it --rm --entrypoint=bash ${your-docker-registry}/paas3-npm-mgr:${image-tag}
# 2. 安装需要上传额外的 NodeJS SDK, 以 vue 为例.
yarn add vue@3.0.11
# 3. 下载依赖至 dependencies 目录(执行步骤2时, 会生成 package.json 文件)
bk-npm-mgr download package.json -d dependencies
# 4. 上传 dependencies 目录中的 NodeJS SDK 至 bkrepo
bk-npm-mgr upload --username ${your-bkrepo-username} --password ${your-bkrepo-username} --registry ${your-bkrepo-endpoint}/npm/bkpaas/npm -s dependencies -v

# 如需上传自研的 SDK 至 bkrepo, 则需要将源码挂载至容器中, 可参考以下流程.
# 1. 启动容器, 并将源码挂载至启动目录.
docker run -it --rm --entrypoint=bash -v ${NodeSDK源码的绝对路径}:/blueking ${your-docker-registry}/paas3-npm-mgr:${image-tag}
# 2. 下载依赖至 dependencies 目录
bk-npm-mgr download package.json -d dependencies
# 3. 打包 SDK 至 dependencies
yarn pack -f dependencies/${your-sdk-name.tgz}
# 4. 上传 dependencies 目录中的 NodeJS SDK 至 bkrepo
bk-npm-mgr upload --username ${your-bkrepo-username} --password ${your-bkrepo-username} --registry ${your-bkrepo-endpoint}/npm/bkpaas/npm -s dependencies -v
```

2. 如果有外部 npm 源，可以找运维同学修改 `BUILDPACK_NODEJS_NPM_REGISTRY` 指向外网后，重启 apiserver 模块
