# macOS 下输出 Hello,World

基于 `蓝鲸开发框架 2.0` 上输出 `Hello,World!`

> 开发语言：`Python 3.6.X`
>
> 操作系统：`macOS`

## 环境准备

安装 Python 3.6.X、准备数据库、创建应用和准备代码仓库地址、虚拟环境（可选）

### 安装 Python 3.6.X

下载并安装 [Python 3.6.X](https://www.python.org/downloads/)

### 部署 MySQL

- [官网下载 MySQL](https://dev.mysql.com/downloads/mysql/)
- 修改用户环境变量和 MySQL 密码

```bash
export PATH=$PATH:/Users/{YOUR_USERNAME}/Library/Python/3.7/bin:/usr/local/mysql/bin/
mysqladmin -uroot -p password {new_password}
```

### 创建应用

创建应用前，需提前准备代码仓库 (Git/SVN) ，推荐 `Git`

- 创建代码仓库

    例如 `GitHub` 或 `GitLab`

- 开发者中心创建应用

    进入 `开发者中心` - `应用创建` ，填写上一步获取的 `git` 仓库地址和账号，创建成功后会获取 `应用 ID:{APP_CODE}`、`应用 TOKEN:{SECRET_KEY}` ，这两个变量后续会用到。

### 准备虚拟环境

- [修改 pip 源](https://pip.pypa.io/en/stable/user_guide/#config-file) (国内镜像)

```bash
vim ~/.pip/pip.conf
```

```bash
[global]
trusted-host = pypi.tuna.tsinghua.edu.cn
index-url = https://pypi.tuna.tsinghua.edu.cn/simple/
 ```

- 安装 [pipenv](https://zhuanlan.zhihu.com/p/37581807)

```bash
pip3 install pipenv
```

- 创建虚拟环境

```bash
pipenv install
```

- 激活虚拟环境

```bash
pipenv shell
```

## 初始化开发框架

### 下载开发框架

- 下载开发框架 `http://{PAAS_URL}/guide/newbie/#step3`

`{PAAS_URL}` 为蓝鲸 PaaS 访问地址，例如 `paas.blueking.com`

- 安装框架依赖包

```bash
pip3 install -r requirements.txt
```

### 配置环境变量

修改 config/\_\__init\_\_.py 中的 `BK_URL`
```bash
BK_URL = os.getenv("BK_PAAS_HOST")
```

添加环境变量

BK_PAAS_HOST=`PaaS_URL`
APP_ID=`APP_CODE`
APP_TOKEN=`SECRET_KEY`(应用 TOKEN)

不同开发环境下，设置环境变量的方法各不相同。常用的有：

- [如何在 Mac 下设置环境变量](https://apple.stackexchange.com/questions/106778/how-do-i-set-environment-variables-on-os-x)


### 创建和初始化数据库

打开 `MySQL` 命令行执行

```bash
CREATE DATABASE `{APP_CODE}` default charset utf8 COLLATE utf8_general_ci;
```

> 如果{APP_CODE}中包含连接符(-)，需要使用反引号( ` )转译，否则会报错

> `ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '-blueking' at line 1`

并修改 `config/dev.py` 中 `DATABASES` 配置项

- 初始化本地数据库(在工程根目录下)

```bash
python manage.py migrate
```

### 启动本地项目

- 先修改本地 hosts

```127.0.0.1 appdev.{PAAS_URL}```

- 启动项目

```bash
python manage.py runserver appdev.{PAAS_URL}:8000
```

- 本地访问

用浏览器访问 `http://appdev.{PAAS_URL}:8000` , 就可以看到开发框架

![开发框架首页](../assets/usage-index.png)

## Hello,World

- 修改视图 home_application/views.py

```python
from django.http import HttpResponse
def hello(request):
    return HttpResponse('Hello World!')
```

- 添加路由 home_application/urls.py

```python
url(r'^$', views.hello),
```

- 重新 `runserver` ,或在 `Visio Studio Code` 中保存会自动重新运行

![-w964](../assets/15585122671345.jpg)
