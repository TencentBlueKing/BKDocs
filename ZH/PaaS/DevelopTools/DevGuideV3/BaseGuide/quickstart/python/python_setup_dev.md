## 开发环境配置

开始应用开发前，你的机器上需要安装好 Python 及蓝鲸应用所需的第三方模块。

针对不同的操作系统，环境配置方式可能略有不同。请跟随你所使用的操作系统内容进行配置。

### 1. 安装 Python3

访问 [Python 官方下载页面](https://www.python.org/downloads/)，你可以看到一些可供下载的 Python 版本，建议选择 Python 3.6 版本。

为了保证本地开发与线上环境一致，你可以先到 [文档：自定义 Python 版本](../../topics/paas/choose_python_version.md) 里看看平台所支持的所有 Python 版本。

安装完成后，在命令行输入 **python3** 命令验证安装：

```bash
Python 3.6.8 (default, Jan  8 2020, 18:10:42)
[GCC X]
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

如果你需要同时开发多个 Python 项目，我们推荐使用 [virtualenv](https://virtualenv.pypa.io/en/stable/) 来进行环境管理。
同时也可以尝试使用 [poetry](https://github.com/python-poetry/poetry)。

### 2. 配置 MySQL 数据库

为了和应用线上环境保持一致，我们建议你在本地使用 MySQL 作为开发数据库。

访问 [MySQL 官方下载页面](http://dev.mysql.com/downloads/mysql/)，下载安装 MySQL 5.7 版本  数据库。

### 3. 安装 Python 第三方模块依赖

接下来需要安装蓝鲸应用依赖的第三方模块。首先进入你的蓝鲸应用所在的源码目录，然后执行命令：

```shell
pip install -r requirements.txt
```

该命令会安装上包括 Django、MySQL-Python 在内的第三方依赖模块。

## 完成开发环境配置

恭喜你！如果你在上面的各项安装没有碰到过任何问题，那么，你的开发环境就已经配置完成啦。

