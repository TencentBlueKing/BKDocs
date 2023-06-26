# 安装包

- 文件

`open_paas_ee-*.tgz` 集成平台安装包

`paas_agent_ee-*.tgz` 集成平台 agent 安装包

- 文件目录结构和功能说明

```bash
open_paas
|-- README.md
|-- README.pdf 文档
|-- VERSION    版本
|-- appengine  引擎代码
|-- bin
|-- console    桌面代码
|-- esb        组件代码
|-- login      统一登录代码
|-- paas       开发者中心代码
|-- apigw      API网关代码
|-- release.md
|-- support-files 依赖文件及配置文件模板
```

```bash
paas_agent
|-- bin        二进制代码
|   |-- paas_agent
|-- etc
|   |-- build
|   |-- nginx
|   |-- supervisord.conf
|   |-- templates
|-- support-files 依赖文件
|-- images
|-- pkgs
|-- templates
```
- MD5 值

# 安装方案

<table>
    <tr>
        <th>序号</th>
        <th>用户需求</th>
        <th>部署模块</th>
        <th>机器数量</th>
        <th>推荐部署方案</th>
    </tr>
    <tr>
        <td>方案一</td>
        <td>仅安装配置平台和作业平台</td>
        <td>基本模块</td>
        <td>1</td>
        <td></td>
    </tr>
    <tr>
        <td rowspan="6">方案二</td>
        <td rowspan="6">除了上述需求外，还需要安装内置 APP</td>
        <td rowspan="6">基础模块、<br>APP 正式环境、<br>RabbitMQ</td>
        <td>1</td>
        <td></td>
    </tr>
    <tr>
        <td rowspan="2">2</td>
        <td>基础模块</td>
    </tr>
    <tr>
        <td>APP 正式环境、RabbitMQ</td>
    </tr>
    <tr>
        <td rowspan="3">3</td>
        <td>基础模块</td>
    </tr>
    <tr>
        <td>APP 正式环境</td>
    </tr>
    <tr>
        <td>RabbitMQ</td>
    </tr>
    <tr>
        <td rowspan="9">方案三</td>
        <td rowspan="9">除了上述需求外，还需要在蓝鲸上开发自己的 APP</td>
        <td rowspan="9">基础模块、<br>APP 正式环境、<br>RabbitMQ、<br>APP 测试环境</td>
        <td rowspan="2">2</td>
        <td>基础模块、APP 正式环境、RabbitMQ</td>
    </tr>
    <tr>
        <td>APP测试环境</td>
    </tr>
    <tr>
        <td rowspan="3">3</td>
        <td>基础模块</td>
    </tr>
    <tr>
        <td>APP 正式环境、RabbitMQ</td>
    </tr>
    <tr>
        <td>APP 测试环境</td>
    </tr>
    <tr>
        <td rowspan="4">4</td>
        <td>基础模块</td>
    </tr>
    <tr>
        <td>APP 正式环境</td>
    </tr>
    <tr>
        <td>RabbitMQ</td>
    </tr>
    <tr>
        <td>APP 测试环境</td>
    </tr>
</table>

# 安装环境

- 操作系统

- 网络要求

- YUM 源

- 网络策略

# 安装步骤
## 依赖及基本服务

**1. 安装基本依赖**

```bash
$ sudo yum install gcc gcc-c++ make cmake bison-devel ncurses-devel zlib-devel pcre-devel openssl openssl-devel python-devel python-pip mysql-devel libevent-devel bzip2-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel mysql
```

**2. MySQL 和 nginx**

- 如果有 mysql 和 nginx ，可以复用现有服务

- 如果没有 mysql 和 nginx ，需要安装

  执行如下步骤(如果没有 YUM 源，请自行下载 nginx / mysql 的 rpm 包进行安装)

  ```bash
  $ sudo yum install nginx mysql-server
  ```

## 安装 Python2.7

**确认 Python 版本，2.7.x**
```bash
$ python --version
```

**安装 setuptools & pip**
```bash
$ wget https://bootstrap.pypa.io/get-pip.py
$ python get-pip.py
```

**安装 virtualenv**
```bash
$ pip install virtualenv virtualenvwrapper
```

**使用 virtualenvwrapper 构建虚拟环境，如果找不到，请确认 which python 的位置**
```bash
$ source /usr/bin/virtualenvwrapper.sh
```

**如果上一个命令找不到，可能在**
```bash
$ source /usr/local/bin/virtualenvwrapper.sh
```

## 创建数据库

```bash
CREATE DATABASE IF NOT EXISTS open_paas DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
```

## 部署 web

以 paas 为例，其他同

**1. 构建虚拟环境**

```bash
$ source /usr/bin/virtualenvwrapper.sh
$ mkvirtualenv paas
```

**2. 进入虚拟环境**

```bash
$ workon paas
```

**3. 进入 paas 目录，编辑配置文件**

```bash
$ cd paas
```

**4. 安装依赖**

```bash
$ pip install -r requirements.txt
```

**5. 确认环境，编辑对应配置文件，更新数据库配置等**

```bash
$ export BK_ENV="development"
$ vim conf/settings_development.py
```

**6. 执行 migration**

```bash
$ python manage.py migrate
```

**7. 启动项目**

```bash
$ python manage.py runserver 127.0.0.1:8001
```

或者使用 gunicorn

```bash
$ gunicorn --bind 0.0.0.0:8001 -w 4 -n paas
```

## 进行 Nginx 配置

因为 `login` 是登录信息保存在对应域名的 `cookie`，所以需要配置域名反向代理

- paas 配置中

```bash
PAAS_DOMAIN = 'bking.com'
BK_COOKIE_DOMAIN = '.bking.com'
```

- login 配置中

```bash
BK_COOKIE_DOMAIN = '.bking.com'
```

- nginx 基础配置:

```bash
# nginx.conf
use root;

# 确保 nginx 服务能正确标示指定内容的文件格式
http {
    include  mime.types;
    ...
}
```

nginx 反向代理的配置，注意替换对应每个服务的 `ip:port`，以及将 `paasagent` 测试/正式机器的 `ip` 分别替换 `192.168.1.1`/`192.168.1.2`

具体 nginx 配置参照 samples/nginx/paas.conf

## 验证结果
