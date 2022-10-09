# beego 内部版开发框架 使用说明

## 1.框架目录

```bash
.
├── bin										# 编译钩子
│   ├── post-compile
│   └── pre-compile
├── conf
│   └── app.conf							# 配置文件
├── config									# 程序内部配置
│   └── app_config.go
├── controllers								# 程序视图控制器
│   ├── account.go
│   ├── base.go
│   ├── default.go
│   └── esb_sdk_example.go
├── dao										# 数据访问接口
│   ├── base.go
│   ├── errors.go
│   └── user.go
├── database
│   └── migrations
│       └── 20180914_191929_account_user.go	# 数据库迁移文件
├── Gopkg.lock								# 项目依赖快照
├── Gopkg.toml								# 项目依赖配置
├── main.go									# 程序入口
├── Makefile
├── models									# 数据库模型定义
│   ├── base.go
│   └── user.go
├── Procfile								# 应用进程管理文件
├── routers
│   └── router.go							# 路由配置
├── static									# 静态文件
├── vendor									# 项目依赖
└── views									# 模版目录
```

## 2.开发环境搭建

### 2.1 依赖工具

1. Go 1.6 以上
2. Godep 0.4.1 以上：`go get github.com/tools/godep`
3. bee 1.10.0 以上：`go get github.com/beego/bee`
4. 相关 IDE：*goland* 或 *vs code*

### 2.2 配置 hosts

```bash
127.0.0.1 dev.xxx.xxx（注意：必须与PaaS平台主站在同一个一级域名)
```

### 2.3 配置数据库

```sql
CREATE DATABASE `{APP_CODE}` default charset utf8 COLLATE utf8_general_ci; 
```

## 3.初始化项目

创建项目后签出代码到本地 **GOPATH** 下：

```shell
cd ${GOPATH}/src
svn co {SVN_URL}
```

更新 vendor 依赖：

```shell
dep ensure -update
```

初始化数据库：

```shell
bee migrate -conn='root:@tcp(127.0.0.1:3306)/{APP_CODE}'
```

启动调试服务器：

```shell
bee run
```

## 4.快速入门

### 4.1 视图模版

在 views 新建 hello.tmpl.html 文件，写入：

```html
Hello {.To}
```

### 4.2 视图控制器

创建`HelloController`来处理相关的视图逻辑：

```go
package controllers

import (
	"github.com/astaxie/beego"
)

type HelloController struct {
	beego.Controller
}

// Get :
func (c *HelloController) Get() {
	c.Data["To"] = "world"
	c.TplName = "hello.tmpl.html"
}
```

### 4.5 路由设置

将控制器注册到对应路径下：

```go
beego.Router("/hello", &controllers.HelloController{})
```

### 4.6 访问效果

```shell
$ curl http://dev.xxx.xxx:5000/hello
Hello world
```

## 5.高阶教程

### 5.1 Beego 开发教程

详细：[https://beego.gocn.vip/beego/zh/developing/](https://beego.gocn.vip/beego/zh/developing/)

### 5.2 应用配置

默认配置使用 ini 格式，名字固定为*conf/app.conf*，支持读取环境变量，如：

```ini
httpport = 5000
runmode = ${BKPAAS_ENVIRONMENT||dev} ； 从环境变量BKPAAS_ENVIRONMENT读取，如果没有使用默认值dev
```

因 beego 的限制，以下方式是不支持的：

```ini
staticurl = ${BKPAAS_SUB_PATH}/static ; 环境变量配置不能嵌入，必须完整匹配
```

### 5.3 创建 migration

使用 bee 命令生成空文件：

```shell
bee generate migration mymigration
```

在 Up 和 Down 函数中加入对应的 sql 即可：

```go
package main

import (
	"github.com/astaxie/beego/migration"
)

// DO NOT MODIFY
type MyMigration_20180914_191929 struct {
	migration.Migration
}

// DO NOT MODIFY
func init() {
	m := &MyMigration_20180914_191929{}
	m.Created = "20180914_191929"

	migration.Register("MyMigration_20180914_191929", m)
}

// Run the migrations
func (m *MyMigration_20180914_191929) Up() {
	m.SQL("create table xxxxx")
}

// Reverse the migrations
func (m *MyMigration_20180914_191929) Down() {
	m.SQL("drop table xxxxx")
}
```
