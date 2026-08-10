## 开发 Golang 应用

该教程将帮助你开发一个运行在蓝鲸 PaaS 平台上的 Golang 应用，通过该教程，你可以了解：

- 蓝鲸 PaaS 平台的基本概念：蓝鲸应用、应用部署等
- 如何开发一个简单的蓝鲸 Golang 应用
- 如何使用蓝鲸 Golang 开发框架
- 如何在应用中调用蓝鲸云 Golang API

为了顺利完成教程，你需要：

- 了解 Golang 语言的基本语法
- 了解 Golang Gin 框架的基本概念

> 蓝鲸 Golang 开发框架使用 Gin 作为开发框架，集成蓝鲸统一登录和蓝鲸云 API。Golang 新手？我们建议你先学习 Golang 的基础知识，了解一下 Gin 开发框架，再进行应用开发。<br/> > <i class="fa fa-book" aria-hidden="true"></i> [官方文档](https://golang.org/) <br/> > <i class="fa fa-book" aria-hidden="true"></i> [ Golang 语言教程](http://www.runoob.com/go/go-tutorial.html) <br/> > <i class="fa fa-book" aria-hidden="true"></i> [ Gin 官方文档](https://gin-gonic.com/zh-cn/docs/) <br/>

## 准备工作

### 创建蓝鲸 Golang 应用

开始教程前，你需要在蓝鲸开发者中心『应用开发-创建应用』页面，选择 Golang 开发框架 -> Gin 开发框架，创建一个蓝鲸 Golang 应用。

## 开发环境配置

### 签出应用代码

在蓝鲸开发者中心创建应用后，会给出模板代码推送到仓库的提示，按提示下载代码并使用 Git 命令推送代码到远程仓库即可。

### 安装 Golang

访问 [Golang 官方下载页面](https://go.dev/dl/)，下载你所想要的 Golang 版本，最好是 Go 1.22 版本（如 Go 1.22.5）。

我们推荐使用 JetBrain 的 Goland IDE 来开发 Golang 项目，通过 Goland 打开项目后，通过 Goland -> Settings -> Go -> GOROOT 设置使用最高的 Go 1.22 版本（如 Go 1.22.5）。

在 IDE 中打开 Terminal，输入 go version 确定 Go 版本是否正确

```
$ go version
go version go1.22.5 linux/amd64
```

### 安装依赖

通过在项目根目录下执行 `make tidy` 命令下载项目所需要的 Golang 依赖包（此步需要耐心等待）。

### 配置 MySQL 数据库

为了和应用线上环境保持一致，我们建议你在本地使用 MySQL 作为开发数据库。

访问 [MySQL 官方下载页面](http://dev.mysql.com/downloads/mysql/)，下载安装最新的 MySQL 数据库。

## 启动开发服务器

### 配置 hosts

首先，本地需要配置 hosts 文件，添加如下内容

```bash
127.0.0.1 dev.xxx.xxx（注意：必须与PaaS平台主站在同一个一级域名
```

### 本地启动项目

```
# web 页面 & API 服务
$ go run main.go webserver --conf=configs/config.yaml
# 定时任务调度器进程
$ go run main.go scheduler --conf=configs/config.yaml
```

接着在浏览器访问 http://dev.xxx.xxx:8080 就可以看到项目首页啦。

在框架中还提供了数据库迁移和初始化数据的命令，方便查看 CRUD 示例。

```
# 数据库迁移
$ go run main.go migrate --conf=configs/config.yaml
# 初始化数据
$ go run main.go init-data --conf=configs/config.yaml
```

## 开发第一个 Hello World 应用

### 新建视图模板

在项目 templates/web 目录下新建 hello.html 文件，写入：

```
Hello World!
```

### 创建视图

在项目 pkg/web/handler/handler.go 文件中新增函数：

```golang
// GetHelloPage Hello World
func GetHelloPage(c *gin.Context) {
	c.HTML(http.StatusOK, "hello.html", nil)
}
```

### 设置路由

在项目 pkg/web/router.go 文件中新加入一条路由规则：

```golang
rg.GET("hello", handler.GetHelloPage)
```

再次运行项目吧，在浏览器中输入 http://dev.xxx.xxx:8080/hello 将打开 Hello world 页面，“世界就在你眼前”！

## 申请 API 权限

访问蓝鲸云 API，必须要申请调用权限。

在开发者中心应用页面，点击左侧菜单云 API 权限，进入云 API 权限管理页，切换到网关 API 页。

在网关列表中，筛选出待申请权限的网关，点击网关名，然后，在右侧页面选中需访问的网关 API，点击批量申请。

在申请记录中，可查看申请单详情。待权限审批通过后，即可访问网关 API。


> 提示：无需申请权限的 API，默认拥有权限，无需申请

- 管理员审批后，可以查看资源的拥有权限

> 提示：现阶段，申请 API 权限通过后，会拥有 180 天的访问权限；而且为了方便用户的持续使用，如果半年内有访问，则自动续期半年；否则，邮件通知蓝鲸应用开发者手动续期。

## 云 API 调用示例

云 API 是 蓝鲸开发者中心 与 蓝鲸 API 网关 联合提供的扩展能力，开发者可在开发者中心中查阅 & 申请相应的 API 权限，并通过 SDK 进行调用。

在 Golang 开发框架中，我们推荐使用蓝鲸 API 网关提供的 SDK 来接入并调用 API，目前开发框架提供了对接组件 API (cmsi.send_mail) 的示例 (pkg/infras/cloudapi/cmsi) 以供开发者参考。

请阅读该示例来了解蓝鲸 Golang API 的使用。

## 发布应用

### 部署应用

关于部署应用，你可以阅读[如何部署蓝鲸应用](../../topics/paas/deploy_intro.md)了解更多。

### 发布到应用市场

在你部署到生产环境之前，你需要：

- 在『应用配置』-『应用市场』完善你的市场信息
- 部署到生产环境

然后就能够直接在应用市场找到你的应用了。
