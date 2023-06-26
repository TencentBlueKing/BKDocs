# 蓝鲸应用前端开发框架(BKUI-CLI) 使用说明

## 1.简介

基于 NodeJS10.x + Express4.x + Vue2.0 研发的蓝鲸应用前端开发框架（BKUI-CLI），包括了：
- 基础工程化能力：开箱即用，无需过多配置，开发完成直接在 PaaS3.0 可部署
- 基础 mock 服务：帮助开发者无需等待接口而快速伪造接口数据进行开发测试
- 蓝鲸前端/设计规范：提供统一设计及代码检测
- bk-magic-vue 组件库：提供丰富的组件
- 蓝鲸前端通用逻辑：包含登录模块、异步请求管理等
- 最佳实践以及开发示例

框架只提供前端服务部分，因此，你可以选用你熟悉的后端服务来一起配合形成前后端分离的开发模式(可参考文档：[前后台分离开发实践](../paas/multi_modules/separate_front_end_dev.md))

## 2.代码结构

整体目录结构

```bash
├── Procfile                                      # 在PaaS3.0部署成功时，默认执行的入口文件
├── README.md                                     # 使用文档
├── bin
│   ├── post-compile                              # PaaS3.0部署时Hook，在npm build成功后执行
│   ├── pre-compile                               # PaaS3.0部署时Hook，在npm install前执行
│   └── pre-heroku                                # 在package.json指向的Hook
├── build
│   ├── ajax-middleware.js                        # mock服务中间件
│   ├── build-dll.js
│   ├── build.js
│   ├── check-dll.js
│   ├── check-versions.js
│   ├── config.js
│   ├── dev-client.js
│   ├── dev-server.js                             # 本地开发启动的server，含登录、mock
│   ├── dev.env.js                                # 本地运行配置
│   ├── prod-server.js                            # PaaS3.0部署成功后会启动prod-server作为前端服务，含登录、mokc、环境变量注入等
│   ├── stag.env.js                               # PaaS测试环境运行的配置
│   ├── prod.env.js                               # PaaS正式环境运行的配置
│   ├── replace-css-static-url-plugin.js
│   ├── util.js
│   ├── webpack.base.conf.js
│   ├── webpack.dev.conf.js 
│   └── webpack.prod.conf.js
├── doc
├── index-dev.html                                # 本地开发时用的入口模板, 用于webpack
├── index.html                                    # 线上运行时用的入口模板，用于webpack
├── mock
│   └── ajax                                      # 存放mock数据
├── package.json
├── postcss.config.js
├── src
│   ├── App.vue
│   ├── api                                       # 统一异步处理
│   ├── common                                    # 公共代码
│   ├── components                                # 公共组件
│   ├── css                                       # 公共样式
│   ├── images                                    # 图片
│   ├── main.js                                   # 主入口文件
│   ├── public-path.js
│   ├── router                                    # 路由
│   ├── store                                     # 状态管理vuex
│   └── views                                     # 模板
└── static
```

## 3.蓝鲸 Vue 组件库

> 蓝鲸 Vue 组件库，提供丰富和风格统一的组件，包括表单、导航、人员选择器、对话框等常用近 50 多个组件

- [文档](https://magicbox.bk.tencent.com/static_api/v3/components_vue/2.0/example/index.html#/)

## 4.异步请求快速入门

### 4.1 提前了解

- 使用 axios 来处理异步请求,  [详细请查看官方文档](https://github.com/axios/axios)
- 使用 Vuex 来进行状态管理，[详细查看官方文档](https://vuex.vuejs.org/zh/)

### 4.2 添加 store 模块

例如，你需要获取一个表格数据，可以

```bash
store
├── index.js
└── modules
    └── example.js
```

```javascript
getTableData (context, params, config = {}) {
    // mock 的地址，示例先使用 mock 地址
    const mockUrl = `${AJAX_URL_PREFIX}/table?${AJAX_MOCK_PARAM}=index&invoke=getTableData&${queryString.stringify(params)}`
    return http.get(mockUrl, params, config)
}
```
### 4.3 调用

```javascript
async getTableData () {
    try {
        const res = await this.$store.dispatch('example/getTableData', {})
        this.tableData = res.data.list
        this.pagination.count = res.data.list.length
    } catch (e) {
        console.error(e)
    }
},
```
### 4.4 Mock 服务

使用 Mock 能在接口没完成前就可以快速伪造数据进行本地开发，另外也可以构造边界数据进行各个代码分支测试。

```bash
mock
└── ajax
    ├── index.js
    └── util.js
```

构建 10 条数据

```javascript
if (invoke === 'getTableData') {
        // https://github.com/nuysoft/Mock/wiki/Getting-Started
        const list = Mock.mock({
            'list|10': [{
                // 属性 id 是一个自增数，起始值为 1，每次增 1
                'id|+1': 1,
                'ip': Mock.mock('@ip()'),
                'source': '微信',
                'status': '正常',
                'create_time': '2018-05-25 15:02:24',
                'children': [
                    {
                        'name': '用户管理',
                        'count': '23',
                        'creator': 'person2',
                        'create_time': '2017-10-10 11:12',
                        'desc': '用户管理'
                    },
                    {
                        'name': '模块管理',
                        'count': '2',
                        'creator': 'person1',
                        'create_time': '2017-10-10 11:12',
                        'desc': '无数据测试'
                    }
                ]
            }]
        })
        return {
            code: 0,
            data: list,
            message: 'ok'
        }
    }

```

其中，index.js 就是上面`${AJAX_MOCK_PARAM}=index`指向的文件

> 注意：如果一个请求带上 mcok 标志，前端会做拦截处理，重定向走前端 mock 服务，就算配置`AJAX_URL_PREFIX`也不生效

## 5. 蓝鲸统一登录

在本地开发和线上部署，框架已经集成蓝鲸统一登录，接口详情可以查看`/build/dev-server`和`/build/prod-server`，你可以把登录放在你所属的后端服务。

返回数据格式为
```javascript
{
    "code": 0,
    "data": {
        "username": "test",
        "avatar_url": "http://xx.bking.com/avatars/test/avatar.jpg"
    },
    "message": "用户信息获取成功"
}

```
然后修改`/build/dev.env.js`和`prod.env.js`下的 USER_INFO_URL

## 6. 部署 Hook

PaaS3.0 在 NodeJS 应用部署时，提供了`pre-compile`和`post-compile` Hook，方便开发者介入，做一些自定义配置。

例如，应用需要使用公司内部的 npm 包进行依赖安装，可以在`pre-build`进行处理。

```bash
#!/bin/bash
#echo "pre install tnpm"
npm install @tencent/tnpm -g --registry=http://your_npm.com --no-proxy
cp -rf .heroku/node/bin/tnpm .heroku/node/bin/npm

if [ $? == 0 ]; then
    echo "post install npm, npm has been replace with npm"
else
    echo "post install tnpm, install npm failed."
fi
```

## 7. 环境变量

部署在线上后，PaaS3.0 提供的环境变量已经注入进来，包括`APP ID`、应用的环境等，详情有那些，可以查`index.html`。

例如，要获取`APP ID`

```bash
const appId = window.PROJECT_CONFIG.BKPAAS_APP_ID 
```

注意，如果是本地开发，程序用`index.dev.html`，因此，这些变量需要自己手动配置，例如`APP ID`。

```javascript
const SITE_URL = '/'
const BK_STATIC_URL = ''
const REMOTE_STATIC_URL = ''
// 蓝鲸PaaS平台访问URL
const BKPAAS_URL = ''
// 当前应用的环境，预发布环境为 stag，正式环境为 prod
const BKPAAS_ENVIRONMENT = ''
// EngineApp名称，拼接规则：bkapp-{appcode}-{BKPAAS_ENVIRONMENT}
const BKPAAS_ENGINE_APP_NAME = ''
// MagicBox静态资源URL
const BKPAAS_REMOTE_STATIC_URL = ''
const BKPAAS_ENGINE_REGION = ''
// APP CODE
const BKPAAS_APP_ID = 'todolist-demo'
```

更多的平台内置变量请查看[内置环境变量说明](../paas/builtin_configvars.md)

## 8. webpack 打包配置

PasS 部署环境有测试（stag）和正式（prod），因此，webpack 打包配置文件分别对应

```bash
stag.env.js # PaaS测试环境运行的配置
prod.env.js # PaaS正式环境运行的配置
```




