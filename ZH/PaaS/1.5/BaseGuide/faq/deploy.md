# 应用部署类

### 应用部署报错：解析应用进程信息出错了，原因：the file "Procfile" does not exists

请检查源码目录下是否有 Procfile 或 app_desc.yaml 文件，如果文件不存在，请手动添加，可以参考相关指引: [应用进程](../topics/paas/process_procfile.md)

### 为什么我的 Python 应用在装包的时候卡死了？

首先检查下卡住的最后一行输出是 Download 还是 Running setup.py：

- 如果是 Download，说明下载慢或网络卡顿，请稍等或重试；
- 如果是 Running setup.py，请往下；

检查 setup.py 中是否有指定额外依赖：

```python
setup(
    setup_requires=[...],
)
```

因为 setuptools 和 pypi 安装的逻辑是独立的，这里不会使用 pip 指定的源，而是默认使用 pypi.python.org，可能会因为网络限制卡住。

尝试在 pre-compile 中为 setuptools 指定源：

```bash
cat > ~/.pydistutils.cfg << EOF
[easy_install]
index_url = https://mirrors.cloud.tencent.com/pypi/simple/
EOF
```

重新部署即可正确下载额外依赖，但需注意，这个办法仅解决网络卡住的问题，依然会有安装失败的情况。

比如当前包依赖的是 setuptools>=38.6.0，可能会出现类似以下的报错：

```bash
setuptools_scm.version.SetuptoolsOutdatedWarning: your setuptools is too old (<12)
```

这个说明当前包的 setup.py 使用的高版本的 setuptools 特性，无法进行升级，此时需要迁移到 Python3 才能彻底解决。

## 常见部署错误修复指南

### 修复 Procfile 报错（fix-procfile）

app_desc.yaml 或 Procfile 文件是用来定义应用进程的配置文件，它位于应用的构建目录（未设置则默认为根目录）。如果你在部署时碰到 ”Procfile error: “ 相关的错误，请检查在应用构建目录是否存在有效的 app_desc.yaml 或 Procfile 文件。假如应用构建目录没有该文件，请创建 Procfile 或 app_desc.yaml 文件并提交到源码仓库中。

推荐使用 app_desc.yaml 来定义进程，格式如下：

```yaml
module:
  language: Python
  processes:
    web:
      command: gunicorn wsgi -b :$PORT --log-file -
    worker:
      command: python manage.py celery worker -l info
    beat:
      command: python manage.py celery beat -l info
```

[查看更多与应用进程相关的内容](../topics/paas/process_procfile.md)

### 修复 python mysql 模块安装时报错（fix-pkg-install-mysql-python）

一些 Python MySQL 相关的库是基于 C 版本的开发库封装的，因此必须要安装相关的系统包来支持。为了安装系统包，需要更新运行时配置：

1. 访问开发者中心，进入应用详情页
2. 点击左侧菜单：“应用引擎” - “环境配置”
3. 绑定支持多个构建工具基础镜像 Ubuntu18（蓝鲸版） 和对应的构建工具 安装系统包。

构建工具会逐个进行构建，因此需要注意构建工具选择的顺序，比如为了在 python 构建时能够使用 apt 安装的一些系统依赖，安装系统包必须要位于 python 环境之前：

![-w2021](../assets/images/apt.png)

注意：构建工具会逐个进行构建，一定要把 安装系统包 放在最前面

代码仓库构建目录（未设置则默认为根目录）加入 Aptfile 文件，内容如下：

```txt
libssl-dev
default-libmysqlclient-dev
```

### 应用无法开始构建（fix-unable-select-buildpack）

如果你使用了蓝鲸 V7 ，请先确认是否完成了 “上传 PaaS runtimes 到制品库” 步骤，请点击版本号查看对应的文档：

- [7.0 环境](../../../../DeploymentGuides/7.0/paas-upload-runtimes.md)
- [7.1 环境](../../../../DeploymentGuides/7.1/paas-upload-runtimes.md)

应用项目结构不符合所选的构建工具，请检查和修复项目结构：

1. 是否错误选择了构建工具；
2. 确保依赖描述文件位于项目合适位置，一般位于构建目录（未设置则默认为根目录），如 Python 的 requirements.txt、Pipenv.lock 文件，Node.js 的 package.json 文件等；

### 修复 collectstatic 阶段报错（fix-py-collect-static）

如果你开发的是 Django 应用，那么在构建阶段，平台会默认执行 python manage.py collectstatic 来收集所有静态文件。

假如命令执行过程中报错，请进行检查：

程序是否有语法错误、引入异常等问题导致不能启动，如有请按具体报错进行修复；
你的 Django 配置文件中是否存在 STATIC_ROOT 配置项。如果没有，添加配置项后重新部署即可：

```bash
# 建议使用 /tmp 临时目录
STATIC_ROOT = '/tmp'
```

除此之外，你也可以在“环境配置”新增一个 DISABLE_COLLECTSTATIC = 1 的环境变量，这样做可以跳过整个 collectstatic 阶段。除非确实需要，否则不建议使用这种方式解决报错问题。

### 修复 Python 应用 runtime 报错问题（fix-py-runtime-error）

如果你使用了蓝鲸 V7 ，请先确认是否完成了 “上传 PaaS runtimes 到制品库” 步骤，请点击版本号查看对应的文档：

- [7.0 环境](../../../../DeploymentGuides/7.0/paas-upload-runtimes.md)
- [7.1 环境](../../../../DeploymentGuides/7.1/paas-upload-runtimes.md)

出现这个问题的原因是应用指定的 Python 版本和 Stack（镜像）不兼容。请先打开“环境管理”，检查应用当前的 Stack 版本，比如 heroku-18 或者 blueking-18。

然后访问 [自定义 Python 版本文档](../topics/paas/choose_python_version.md)，挑选你需要的版本号。然后参考文档指引修复该问题。

### 部署发布阶段耗时过长（fix-release-polling-timeout）

一次部署分为“构建（Build）”与“发布（Release）”两个阶段。在发布阶段，平台会将构建完成的应用可执行包，更新到集群上。在这个过程中，会创建出新的进程实例，同时销毁旧实例。一般来说，一次发布的耗时在 3-15 分钟之间。但是，如果你的应用有下面这些问题，则会拖慢整个发布过程，导致最终部署失败。

1. 应用代码有 Bug，进程无法正常启动

具体表现为新创建的进程实例不断重启，无法达到稳定状态。出现这类情况，请到 应用的“日志查询” - “标准输出日志” 页面，检查是否有相关报错日志。 大部分这类失败，都可以在日志里查到具体的错误原因。确认原因后，修复代码重新部署即可。

2. 应用进程和实例过多，发布过程耗时超过 15 分钟

如果部署因为这个原因失败，不代表这次发布真的失败了。当发布阶段超过 15 分钟后，实例的更新过程，仍然会在后台继续进行。 请到“进程管理”页面，继续观察进程更新过程，检查实例是否正常更新。

### Python 无法安装带.的包

高版本的 pypi 源更新了协议，导致低版本的 pip 无法安装带.的包，有以下两种方案修复：

1. 升级 pip 版本到 19.0 之后的版本，推荐 20.2.3，可通过增加环境变量 PIP_VERSION 来指定具体版本；
2. 将包名中的点(.)改成连字符(-)，如 a.b.c 需改成 a-b-c；

### Python 安装依赖时提示缺少 setuptools_rust 模块

安装类似 cryptography 等依赖时，有时候会报这样的错误：

```
Traceback (most recent call last):
       File "<string>", line 1, in <module>
       File "/tmp/pip-build-2rt9bp57/cryptography/setup.py", line 14, in <module>
       from setuptools_rust import RustExtension
       ModuleNotFoundError: No module named 'setuptools_rust'
```

原因是这些模块是基于 rust 开发的，需要将 pip 升级到 19.0 以上（推荐 21.0），需要设置环境变量：

```
PIP_VERSION=19.0
或
PIP_VERSION=21.0
```

重新部署即可。

### Python 安装 greenlet 包时报错：error: command 'gcc' failed with exit status 1

Python 开发框架老版的 requirements.txt 中添加了 `eventlet==0.31.0`，在安装 eventlet 包时会依赖安装 greenlet，greenlet 新的 2.0.x 的版本在平台安装会报错。

解决方案：在 requirements.txt 中添加：

```
greenlet==1.1.3
```

如上述方法不能解决，也可参考文档 [如何安装 apt 包](../topics/tricks/py_how_to_install_apt_packages.md) 通过 apt 来安装依赖的软件。
