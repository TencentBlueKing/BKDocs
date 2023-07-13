## 开发环境配置

开始应用开发前，你的机器上需要安装好 Golang，并且设置好 Golang 的环境变量 GOROOT 和 GOPATH。

针对不同的操作系统，环境配置方式可能略有不同。请跟随你所使用的操作系统内容进行配置。

### 1. 安装 Golang

访问 [Golang 官方下载页面](https://golang.org/dl/)，下载你所想要的 Golang 版本，最好是最新稳定版。

安装完成后，在命令行输入 **go version**  命令来验证安装：

```bash
$ go version
go version go1.10 darwin/amd64

$ go env
GOARCH="amd64"
GOBIN=""
GOROOT="/usr/local/Cellar/go/1.10.1/libexec"
...
```

安装完成后，设置 Golang 开发的环境变量。

- `GOROOT`：Golang 的安装路径，可以通过 `go env` 命令查看
- `GOPATH`：Golang 的开发目录，例如：`GOPATH="$HOME/go"`

不同开发环境下，设置环境变量的方法各不相同。常用的有：

- [如何在 Mac 下设置环境变量](https://apple.stackexchange.com/questions/106778/how-do-i-set-environment-variables-on-os-x)
- [如何在 GoLand 中设置 GOROOT 和 GOPATH](https://www.jetbrains.com/help/go/configuring-goroot-and-gopath.html)


### 2. 安装 beego bee 工具

bee 工具是一个为了协助快速开发 beego 项目而创建的项目，通过 bee 您可以很容易的进行 beego 项目的创建、热编译、开发、测试、和部署。[bee 工具简介](https://beego.gocn.vip/beego/zh/developing/bee/)

通过如下的方式安装 bee 工具：

```bash
go get github.com/beego/bee
```

安装完之后，bee 可执行文件默认存放在 `$GOPATH/bin` 里面，需要把它添加到 `PATH` 环境变量中，才可以进行下一步。

Mac 下添加命令示例如下：

```bash
export PATH="$GOPATH/bin:$PATH"
```

完成后，在命令行输入 **bee** 命令来验证安装：

```bash
Bee is a Fast and Flexible tool for managing your Beego Web Application.

USAGE
    bee command [arguments]
```

### 3. 配置 MySQL 数据库

为了和应用线上环境保持一致，我们建议你在本地使用 MySQL 作为开发数据库。

访问 [MySQL 官方下载页面](http://dev.mysql.com/downloads/mysql/)，下载安装 5.7版本 MySQL 数据库。

### 4. 签出应用代码

蓝鲸应用的源码被托管在**工蜂 Git （推荐）**或蓝鲸 SVN ，在你创建蓝鲸应用后，你需要将其签出到本地来继续之后的开发工作。

- SVN 源码目录下拥有 tags、trunk 等多个子目录，我们建议你先只使用 trunk 目录

把代码签出到本地 `$GOPATH/src` 目录下，如：`$GOPATH/src/{APP_ID}`。

## 完成开发环境配置

恭喜你！如果你在上面的各项安装没有碰到过任何问题，那么，你的开发环境就已经配置完成啦。

