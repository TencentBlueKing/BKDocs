# 开发 Node.js 应用

本文将介绍如何在蓝鲸开发者中心上开发一个 Node.js 应用，学完整个教程后，你可以了解到：

- 蓝鲸开发者中心的基本概念：蓝鲸应用、应用部署等
- 如何开发一个简单的 Node.js 蓝鲸应用
- 如何使用 Node.js 开发框架

为了顺利完成教程，你需要：

- 了解 JavaScript 语言的基本语法
- 了解 Node.js Express 框架的基本概念

蓝鲸 Node.js 开发框架使用 Express 作为开发框架，集成蓝鲸统一登录。

> Node.js 新手？我们建议你学习 Node.js 的 [Node.js 官方文档](https://nodejs.org/zh-cn/docs/)、[Express 官方文档](https://expressjs.com/zh-cn/)

## 准备工作

#### 创建 Node.js 应用

开始教程前，你需要通过蓝鲸开发者中心『应用开发-创建应用』页面选择`Node.js  开发框架`创建一个蓝鲸应用。

应用创建成功后，根据页面的指引将开发框架的代码克隆到本地。

## 开发环境配置

开始应用开发前，你的机器上需要安装好 Node.js 及蓝鲸应用所需的第三方模块。针对不同的操作系统，环境配置方式可能略有不同。请跟随你所使用的操作系统内容进行配置。

在项目构建目录（未设置则默认为根目录） `package.json` 文件中的中查看 项目使用的 Node.js 和 NPM 的版本。

```json
"engines": {
    "node": ">= 16.16.0",
    "npm": ">= 6.4.1"
}
```

也可以根据你项目需求，配置依赖包的版本，并修改 **package.json**。

### 1. 安装 Node.js

访问 [Node.js 官方下载页面](https://nodejs.org/zh-cn/download/)，下载你需要的 Node.js 版本。

安装完成后，在命令行输入 `node -v` 命令验证安装：

```bash
v16.16.0
```

### 2. 安装包管理器 NPM

npm 能方便管理你项目的依赖包，安装 Node.js 时默认安装 npm，你可以在命令行输入 `npm -v` 命令验证安装：

```bash
6.11.3
```

### 4. 安装依赖

进入构建目录（未设置则默认为根目录），执行命令 **npm install** 来安装依赖，安装成功后会多出 node_modules 目录。

### 5. 完成开发环境配置

恭喜你！如果你在上面的各项安装没有碰到过任何问题，那么，你的开发环境就已经配置完成啦。

## 运行项目

环境配置完成后，我们还需要做一些额外配置，才能让项目顺利跑起来。

### 配置 hosts

首先，本地需要配置 hosts 文件，添加如下内容

```bash
127.0.0.1 dev.xxx.xxx（注意：必须与PaaS平台主站在同一个一级域名
```

### 本地启动项目

在项目构建目录（未设置则默认为根目录）下执行如下命令

```shell
npm run start
```

接着在浏览器访问 http://dev.xxx.xxx:5000 就可以看到项目首页啦

## 开发一个页面

### 1. 新建视图模板

在 views 加入你的模板 db.ejs

```html
<ul>
  <% results.forEach(function(r) { %>
  <li><%= r.id %> - <%= r.name %></li>
  <% }); %>
</ul>
```

### 2. 设置路由

在 index.js 加入你的路由

```bash
app.get('/db', function(request, response) {
    response.render('pages/db', {
        'SITE_URL': process.env.BKPAAS_SUB_PATH,
        'results': [
            {
                id: '1',
                name: 'test1'
            }
        ]
    });
});
```

### 3. 再次重启项目

再次重启项目，访问 http://dev.xxx.xxx:5000/db，就可以看到你新加的页面并把数据渲染出来

## 发布应用

### 部署应用

关于部署应用，你可以阅读[如何部署蓝鲸应用](../../topics/paas/deploy_intro.md)了解更多。

### 发布到应用市场

在你部署到生产环境之前，你需要：

- 在『应用推广』-『应用市场』完善你的市场信息
- 部署到生产环境

然后就能够直接在应用市场找到你的应用了。
