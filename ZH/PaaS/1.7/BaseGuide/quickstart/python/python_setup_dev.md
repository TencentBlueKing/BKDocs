## 如何配置 Python 本地开发环境

## 配置本地环境变量

应用在开发者中心上运行时，主要通过环境变量来获取各类配置信息。

当我们在本地开发应用时，为了尽量模拟与平台一样的运行环境，至少需要设置以下这些环境变量：

- `BKPAAS_APP_ID`: bk_app_code，应用 ID，在应用的 “基本信息” 页面查看
- `BKPAAS_APP_SECRET`: bk_app_secret，在应用的 “基本信息” 页面查看
- `BKPAAS_MAJOR_VERSION`: "3", 表示部署在 PaaS3.0 开发者中心
- `BK_PAAS2_URL`: 蓝鲸桌面的地址，在环境变量页面，点击`查看内置环境变量`查看
- `BK_COMPONENT_API_URL`: 蓝鲸 ESB API 地址，在环境变量页面，点击`查看内置环境变量`查看
- `BKPAAS_LOGIN_URL`: 蓝鲸登录服务地址，在环境变量页面，点击`查看内置环境变量`查看

不同开发环境下，设置环境变量的方法各不相同。常用的有：

- [如何在 Mac 下设置环境变量](https://apple.stackexchange.com/questions/106778/how-do-i-set-environment-variables-on-os-x)
- [如何在 Windows 下设置环境变量](https://stackoverflow.com/questions/32463212/how-to-set-environment-variables-from-windows?noredirect=1&lq=1)

## 配置开发环境

开始应用开发前，你的机器上需要安装好 Python 及蓝鲸应用所需的第三方模块。

针对不同的操作系统，环境配置方式可能略有不同。请跟随你所使用的操作系统内容进行配置。

### 1. 安装 Python3

在项目构建目录（未设置则默认为根目录） `runtime.txt` 文件（跟 `requirements.txt` 在同级目录下）中定义项目使用的 Python 版本，若没有该文件项目部署到开发者中心时将使用 Python 3.10 版本。

为了保证本地开发与线上环境一致，你可以先到 [文档：自定义 Python 版本](../../topics/paas/choose_python_version.md) 里看看平台所支持的所有 Python 版本。

访问 [Python 官方下载页面](https://www.python.org/downloads/)下载你需要的 Python 版。

安装完成后，在命令行输入 **python3** 命令验证安装：

```bash
Python 3.10.5 (main, May 27 2024, 12:04:02) [Clang 15.0.0 (clang-1500.3.9.4)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
```

如果你需要同时开发多个 Python 项目，我们推荐使用 [virtualenv](https://virtualenv.pypa.io/en/stable/) 来进行环境管理。
同时也可以尝试使用 [poetry](https://github.com/python-poetry/poetry)。

### 2. 配置 MySQL 数据库

为了和应用线上环境保持一致，我们建议你在本地使用 MySQL 作为开发数据库。

访问 [MySQL 官方下载页面](http://dev.mysql.com/downloads/mysql/)，下载安装 MySQL 5.7 版本 数据库。

### 3. 安装 Python 第三方模块依赖

接下来需要安装蓝鲸应用依赖的第三方模块。首先进入你的蓝鲸应用所在的源码目录，然后执行命令：

```shell
pip install -r requirements.txt
```

该命令会安装上包括 Django、PyMySQL / mysqlclient 在内的第三方依赖模块。
