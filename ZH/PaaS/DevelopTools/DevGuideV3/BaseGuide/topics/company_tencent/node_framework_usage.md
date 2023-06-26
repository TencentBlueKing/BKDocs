---
title: 蓝鲸 NodeJS 全栈开发框架 使用说明
sidebar: topics_company_tencent_sidebar
permalink: topics/company_tencent/node_framework_usage
---

## 1.简介

基于 NodeJS10.x + Koa2.x + Vue2.0 研发的蓝鲸 NodeJS 全栈开发，包括了：
- 基础工程化能力：开箱即用，无需过多配置，开发完成直接在 PaaS3.0 可部署
- 蓝鲸前端/设计规范：提供统一设计及代码检测
- 前端 bk-magic-vue 组件库：提供丰富的组件
- 蓝鲸前端通用逻辑：包含登录模块、异步请求管理等
- Mysql 数据表定义及操作示例，使用 ORM 更方便多人开发的数据同步
- 提供对象存储操作示例

框架在代码组织上保持前后端分离，在部署上保持统一，如果你对 NodeJS 比较熟悉或有兴趣欢迎使用

## 2.框架目录

```bash

├── Procfile                                           # 编译钩子
├── README.md
├── bin
│   ├── post-compile                                   # npm run build后执行的钩子
│   └── pre-compile                                    # npm install前执行的钩子
├── bk-eslint-vue.js
├── bk-eslint.js
├── config.json
├── forever.json
├── lib
│   ├── client                                         # 前端代码
│   │   ├── build                                      # 前端构建的配置文件
│   │   │   ├── build-dll.js
│   │   │   ├── build.js
│   │   │   ├── conf.js
│   │   │   ├── replace-static-url-plugin.js
│   │   │   ├── webpack.base.conf.js
│   │   │   ├── webpack.dev.conf.js
│   │   │   └── webpack.prod.conf.js
│   │   ├── index-dev.html                             # 开发时前端的首页模板
│   │   ├── index.html                                 # 部署运行时前端的首页模板
│   │   ├── src
│   │   │   ├── App.vue
│   │   │   ├── api                                    # ajax请求封装
│   │   │   │   ├── cached-promise.js
│   │   │   │   ├── index.js
│   │   │   │   └── request-queue.js
│   │   │   ├── common                                  # 公共
│   │   │   │   ├── auth.js
│   │   │   │   ├── bkmagic.js
│   │   │   │   ├── bus.js
│   │   │   │   ├── demand-import.js
│   │   │   │   ├── fully-import.js
│   │   │   │   ├── preload.js
│   │   │   │   └── util.js
│   │   │   ├── components                              # 组件
│   │   │   │   ├── auth
│   │   │   │   │   ├── index.css
│   │   │   │   │   └── index.vue
│   │   │   │   └── exception
│   │   │   │       └── index.vue
│   │   │   ├── css                                     # 样式文件
│   │   │   │   ├── app.css
│   │   │   │   ├── bk-patch.css
│   │   │   │   ├── mixins
│   │   │   │   │   ├── clearfix.css
│   │   │   │   │   ├── create-label.css
│   │   │   │   │   ├── ellipsis.css
│   │   │   │   │   └── scroller.css
│   │   │   │   ├── reset.css
│   │   │   │   └── variable.css
│   │   │   ├── images                                  # 图片
│   │   │   │   ├── 403.png
│   │   │   │   ├── 404.png
│   │   │   │   ├── 500.png
│   │   │   │   └── building.png
│   │   │   ├── main.js                                 # 前端主入口
│   │   │   ├── router                                  # 前端路由
│   │   │   │   └── index.js
│   │   │   ├── store                                   # 前端状态管理vuex
│   │   │   │   ├── index.js
│   │   │   │   └── modules
│   │   │   │       └── example.js
│   │   │   └── views                                   # 前端模板
│   │   │       ├── 404.vue
│   │   │       ├── example1
│   │   │       │   ├── index.css
│   │   │       │   └── index.vue
│   │   │       ├── example2
│   │   │       │   ├── index.css
│   │   │       │   └── index.vue
│   │   │       ├── example3
│   │   │       │   ├── index.css
│   │   │       │   └── index.vue
│   │   │       ├── example4
│   │   │       │   ├── index.css
│   │   │       │   └── index.vue
│   │   │       └── index.vue
│   │   └── static                                      # 静态资源
│   │       ├── images
│   │       │   ├── empty.png
│   │       │   └── favicon.ico
│   │       ├── lib-manifest.json
│   │       ├── lib.bundle.js
│   │       └── login_success.html
│   └── server                                          # 后端代码
│       ├── app.browser.js                              # 后端主入口
│       ├── conf                                        # 配置文件
│       │   ├── auth.js                                 # 登录配置
│       │   ├── code.js
│       │   ├── db.js                                   # 数据库配置
│       │   └── s3.js                                   # 存储服务配置
│       ├── controller                                  # 程序业务控制器
│       │   ├── project.js
│       │   ├── s3.js
│       │   ├── upload.js
│       │   └── user.js
│       ├── logger.js                                   # 日志服务
│       ├── middleware                                  # 中间件
│       │   ├── auth.js
│       │   ├── error.js
│       │   ├── http.js
│       │   └── json-send.js
│       ├── model                                       # 数据库模型定义
│       │   ├── db.js
│       │   └── project.js
│       ├── router                                      # 后端路由
│       │   ├── index.js
│       │   ├── project.js
│       │   ├── test.js
│       │   ├── upload.js
│       │   └── user.js
│       └── util.js
├── nodemon.json
├── package-lock.json
├── package.json                                         # 项目描述信息
```

## 3.开发环境搭建

### 3.1 开发环境依赖
- NodeJS >= 10.10.0
- koa2
- mysql5.6

### 3.2 本地运行

#### 3.2.1 配置数据库

- 安装 Mysql 后，创建数据库`my_project`

``` shell
mysql -u root -p

create database my_project;
``` 

- 配置数据库账号密码

lib  ->  server  ->  conf  ->  db.js

```javascript
if (process.env.NODE_ENV === 'development') {
    config = {
        database: 'mydb', // 数据库
        username: 'root', // 用户
        password: '', // 密码
        host: 'localhost', // host
        port: 3306 // 端口
    }
}
```

#### 3.2.2 安装依赖

- 进入代码根目录，安装依赖

``` shell
npm install
```

#### 3.2.3 配置 host

```bash
127.0.0.1 dev.xxx.xxx（注意：必须与PaaS平台主站在同一个一级域名)
```

#### 3.2.4 运行并访问

```bash
npm run dev
```
dev.xxx.xxx:5000

## 4. 前端和后端配合快速入门

整个架构在代码上是前端和后端分离，合在一起进行部署，下面以一个项目列表的例子来展示整个架构从数据库、后台到前台的整个过程

### 4.1 数据表定义及操作封装

- 首先，需要定义一张项目表来保存你的项目数据
- 在之前的开发都是先在数据库建表再写逻辑代码，但如果多人同时开发，数据表的同步成为难题，需要互相手动拷贝 SQL 来同步
- 在这个架构，不再使用 SQL，而是 ORM（对象关系映射），对 SQL 查询语句的封装，让我们可以用 OOP 的方式操作数据库，优雅的生成安全、可维护的 SQL 代码，是一种 Model 和 SQL 的映射关系，把数据表的定义和操作集成在代码里，做到运行后立即同步
- 在这里，选取 Sequelize，因此，你需要了解，详情看[官网](https://sequelize.org/)

在 src -> server -> model 下创建 project.js，服务运行时，sequelize 会按照定义映射为 SQL 操作在相应的数据里建表

```javascript
// 定义project表结构
const Project = db.defineModel('project', {
    // 项目ID
    id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },

    // 项目名称, 2到50个字符以内
    name: {
        type: Sequelize.STRING,
        validate: {
            len: [2, 50]
        }
    },

    // 英文名
    englishName: {
        type: Sequelize.STRING
    },

    // 项目描述, 200个字符以内
    desc: {
        type: Sequelize.STRING,
        allowNull: true,
        validate: {
            len: [0, 200]
        }
    },

    // 项目创建者（不可变）
    creator: {
        type: Sequelize.STRING
    },

    // 项目状态
    status: {
        type: Sequelize.STRING,
        validate: {
            isIn: ['RUNNING', 'DELETE']
        }
    }
})

```

封装操作，这里以获取项目列表为例

```javascript
const model = {
    /**
     * 获取拥有的项目列表
     */
    async getOwnProjects (user) {
        return await Project.findAll({ where: { creator: user } })
    },
    /**
     * 更新项目
     * @param {*} updateDic 需要更新的键值对
     * @param {*} where 查询条件
     */
    async updateProject (updateDic, id) {
        const res = await Project.update(updateDic, { where: { id } })
        return res
    },

    /**
     * 获取所有项目
     */
    async getTotalProjects (query) {
        const projects = await Project.findAll()
        return projects
    }
}
```

### 4.2 后端业务逻辑封装

在 src -> server -> controller 下创建 project.js，用于具体的业务逻辑处理

```javascript
const project = {
    async getProjectList (ctx) {
        try {
            const projects = await projectModel.getTotalProjects()
            ctx.send({
                code: 0,
                data: projects,
                message: 'success'
            })
        } catch (error) {
            ctx.throwError({
                status: 200,
                message: error
            })
        }
    }
}
```

### 4.3 后端路由配置

在 src -> server -> router 下创建 project.js，配置路由

```javascript
const KoaRouter = require('koa-router')
const projectController = require('../controller/project')

const router = new KoaRouter({
    prefix: '/api'
})

router.get('/projects', projectController.getProjectList)

```

到目前为止，后端一个获取所有项目列表的接口已经完成，那前端要怎样调用？

### 4.4 前端状态管理

> Vuex 是一个专为 Vue.js 应用程序开发的状态管理模式，它采用集中式存储管理应用的所有组件的状态，详情查看[官方文档](https://vuex.vuejs.org/zh/)

在 src -> client -> store -> modules 下配置 action，请求刚才写的获取项目接口

```javascript
export default {
    namespaced: true,
    state: {},
    mutations: {},
    actions: {
        getTableData (context, params, config = {}) {
            return http.get('/api/projects', params, config)
        }
    }
}
```

### 4.5 前端展示

> Vue 渐进式 JavaScript 框架，专注于视图展示，详情请查看[官方文档](https://cn.vuejs.org/)

在 src -> client -> views 下创建 example1 -> index.vue，包括了前端的模板和业务代码

```javascript
<!--模板- -> 
<template>
    <div class="example1-wrapper">
        <bk-table style="margin-top: 15px;"
            :data="tableData"
            :pagination="pagination"
            @page-change="handlePageChange">
            <bk-table-column type="index" label="序列" align="center" width="60"></bk-table-column>
            <bk-table-column label="项目名称" prop="name"></bk-table-column>
            <bk-table-column width="450" label="项目描述" prop="desc"></bk-table-column>
            <bk-table-column label="管理员" prop="creator"></bk-table-column>
            <bk-table-column label="创建时间" prop="createdAt"></bk-table-column>
        </bk-table>
    </div>
</template>

<!--业务代码- -> 
<script>
    export default {
        components: {
        },
        data () {
            return {
                tableData: [],
                pagination: {
                    current: 1,
                    count: 0,
                    limit: 10
                }
            }
        },
        created () {
            this.init()
        },
        methods: {
            init () {
                this.getTableData()
            },
            async getTableData () {
                try {
                    const res = await this.$store.dispatch('example/getTableData', {}, { fromCache: true })
                    this.tableData = res.data
                    this.pagination.count = res.data.length
                } catch (e) {
                    console.error(e)
                }
            }
        }
    }
</script>
<!--样式- -> 
<style scoped>
    @import './index.css';
</style>
```

### 4.6 前端路由

在 src -> client -> router 下配置前端页面的路由

```javascript
const Example1 = () => import(/* webpackChunkName: 'example1' */'@/views/example1')
const routes = [
    {
        path: '/',
        name: 'appMain',
        component: MainEntry,
        alias: '',
        children: [
            {
                path: 'example1',
                name: 'example1',
                component: Example1
            }
        ]
    }
]
```

到目前为止，从数据到后端到前端展示了整个架构前后配合的过程

### 4.7 线上部署

在 PaaS 上部署前，首先要确保你的应用已经启用增强服务 -> GCS-MySQL

## 5. 对象存储服务

> 对象存储，可存储图片、文件等，蓝鲸对象存储服务拥有与 Amazon S3 完全兼容的 API

在 PaaS 上部署前，首先要确保你的应用已经启用增强服务 -> 对象存储（Ceph)

### 5.1 配置

在 src -> server -> conf -> s3.js

```javascript
module.exports = {
    region: 'us-east-1',
    accessKeyId: '', // PaaS 对象存储CEPH_AWS_ACCESS_KEY_ID
    secretAccessKey: '', // PaaS 对象存储CEPH_AWS_SECRET_ACCESS_KEY
    buketName: '', // PaaS 对象存储BUCKET NAME
    s3Url: ''
}
```

### 5.2 使用 aws-sdk

```javascript
// S3初始化
const AWS = require('aws-sdk')

AWS.config.update({
    region: config.region,
    accessKeyId: config.accessKeyId,
    secretAccessKey: config.secretAccessKey
})
AWS.config.setPromisesDependency(null)
const s3 = new AWS.S3({
    apiVersion: '2006-03-01',
    endpoint: config.s3Url,
    s3ForcePathStyle: true
})

```

### 5.3 调用服务

以下例子演示一个图片上传并保存功能

```javascript
const uploadImage = async  ({userName, fileName, data}) => {
    const buffer = new Buffer(data, 'base64')
    const svgFilePath = encodeURIComponent(userName) + '/' + fileName // 构建文件上传路径
    const params = { 
        Bucket: config.buketName,
        ACL: FILE_PERMISSION,
        Key: svgFilePath,
        Body: buffer,
        ContentEncoding: 'base64',
        ContentType: 'image/jpeg'
    }
    return s3.upload(params).promise()
}
```
详情操作，请查看[amazon-sdk 官方文档](https://aws.amazon.com/cn/sdk-for-node-js/)

最后，如果你在使用框架的过程中遇到任何问题请您联系**蓝鲸 MagicBox 助手**！！

## 接入日志

### 接入结构化日志

入口: 『应用引擎』-『日志查询』-『结构化日志』

蓝鲸 Node 全栈开发框架中已经给定默认日志模块，引用后可以直接使用。整个日志是基于**koa-log4**模块，详细请查看[官方文档](https://github.com/dominhhai/koa-log4js#readme)

#### 日志级别

log4 的日志分为 9 个级别，各个级别的名称和权重如下：

```javascript
{
  ALL: new Level(Number.MIN_VALUE, "ALL"),
  TRACE: new Level(5000, "TRACE"),
  DEBUG: new Level(10000, "DEBUG"),
  INFO: new Level(20000, "INFO"),
  WARN: new Level(30000, "WARN"),
  ERROR: new Level(40000, "ERROR"),
  FATAL: new Level(50000, "FATAL"),
  MARK: new Level(9007199254740992, "MARK"),
  OFF: new Level(Number.MAX_VALUE, "OFF")
}
```
实际业务中使用比较多的是**INFO**、**WARN**、**ERROR**级别

#### 日志格式

结构化日志只能采集 JSON 格式的日志，**/lib/server/logger.js**已经封装好，部署到预发布环境/正式环境会自动输出为 JSON 格式，每行一条日志，且不同 logger 对应不同的日志文件

#### 示例

开发框架中预定义了两个`logger`

|  logger | 备注 |
| --- | --- |
|  access | 访问日志 |
|  application | 应用业务日志 |

其中**access**日志已经写入到框架的中间件，服务收到的所有访问请求都会写入到此日志里，**application**则用于记录应用在运行过程的日志，你也可以调整**/lib/server/logger.js**日志模块来加入新的 logger 类型

具体的 logger 使用如下：
```javascript
const { accessLogger, applicationLogger } = require('./logger')
// INFO级别
applicationLogger.info({
    levelname: 'INFO',
    message: '项目启动完成'
})

// WARN级别
applicationLogger.warn({
    levelname: 'WARN',
    message: '这是一条告警日志'
})

// ERROR级别
applicationLogger.error({
    levelname: 'ERROR',
    message: '这是一条错误日志'
})
```
> 注意：**levelname**和**message**这两个字段是必填的，一条日志需要含这两个字段才可被后续结构化日志所采集、展示

#### 如何增加自定义字段

如果需要增加其它字段，首先修改**lib/server/loger.js**模块里的**application** logger，在**include**加入需要采集的字段，这里以增加**funcname**为例
```javascript
application: {
    type: 'dateFile',
    layout: {
        ...
        include: ['asctime', 'levelname', 'message', ‘funcname’]
    },
    ...
},
```
配置后好，就可以在调用时使用**funcname**字段
```javascript
// ERROR级别
applicationLogger.error({
    levelname: 'ERROR',
    funcname: 'test',
    message: '此方法出错'
})
```

### 接入标准输出日志

入口: 『应用引擎』-『日志查询』-『标准输出日志』

应用直接输出到标准输出（stdout 或者 stderr）的日志，同样也会被采集，但是不会对字段做解析，示例代码如下：

```javascript
console.log('这是一条日志'')
```
![-w2021](../../images/docs/paas/log_search_intro2.png)






