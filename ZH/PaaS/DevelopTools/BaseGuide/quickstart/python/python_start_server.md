# 运行项目

环境配置完成后，我们还需要做一些额外配置，才能让项目顺利跑起来。

## 配置环境变量

应用在 PaaS3.0 开发者中心上运行时，主要通过环境变量来获取各类配置信息。

当我们在本地开发应用时，为了尽量模拟与平台一样的运行环境，至少需要设置以下这些环境变量：

- `BKPAAS_APP_ID`: bk_app_code，应用 ID，创建应用时填写的值
- `BKPAAS_APP_SECRET`: bk_app_secret，在应用的 “基本信息” 页面查看
- `BKPAAS_MAJOR_VERSION`: "3", 表示部署在 PaaS3.0 开发者中心
- `BK_PAAS2_URL`: 蓝鲸桌面的地址，用于拼接登录链接，注意不要带 console 路径，形如: http://paas.example.com
- `BK_COMPONENT_API_URL`: 蓝鲸 ESB API 地址，形如: http://bkapi.example.com
- `BKPAAS_LOGIN_URL`: 蓝鲸登录链接，形如: http://paas.example.com/login

不同开发环境下，设置环境变量的方法各不相同。常用的有：

- [如何在 Mac 下设置环境变量](https://apple.stackexchange.com/questions/106778/how-do-i-set-environment-variables-on-os-x)
- [如何在 Windows 下设置环境变量](https://stackoverflow.com/questions/32463212/how-to-set-environment-variables-from-windows?noredirect=1&lq=1)

如果本地开发不同的 SaaS 需要配置多套环境变量，可以采用一些基于项目的环境变量设置方案。常用的有：

- [在 PyCharm 下设置环境变量](https://stackoverflow.com/questions/42708389/how-to-set-environment-variables-in-pycharm) ：在 PyCharm 中运行 SaaS，PyCharm 会根据不同的项目配置读取不同的环境变量值。
- [在 virtualenv 虚拟环境中 postactive 文件中设置环境变量](https://stackoverflow.com/questions/9554087/setting-an-environment-variable-in-virtualenv) ：这种做法需要在不同的项目使用不同的虚拟环境，每次激活虚拟环境时可以自动加载对应的环境变量值。

## 配置项目数据库连接

首先，请尝试在项目目录下执行 `python manage.py migrate` 来初始化数据库数据。这条命令可能会产生下列报错信息：

### 错误 1：2003, "Can't connect to MySQL server on '... ...'

出现这个错误的原因是 Django 不能正常连接到你的 MySQL 数据库，首先，请你确保你的数据库服务确实在运行状态。然后打开 `configs/dev.py`，找到以下这段代码：

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': APP_CODE,
        'USER': 'root',
        'PASSWORD': '',
        'HOST': '127.0.0.1',
        'PORT': '3306',
    },
}
```
请将上面配置中的 `USER`、`PASSWORD`、`HOST`、`PORT` 修改为你所使用的正确配置信息，之后 Django 就可以正常连接上你的数据库了。

### 错误 2：1049, "Unknown database '... ...'"

出现这个错误的原因是因为你没有创建应用的 MySQL 数据库，请使用 mysql 客户端连接上数据库，将下面语句中的 数据库名称 换为 **应用 ID** 后，然后执行：

```sql
mysql> CREATE DATABASE `... ...` default charset utf8 COLLATE utf8_general_ci;
Query OK, 1 row affected (0.01 sec)
```

解决掉这些问题后，执行 `python manage.py migrate` 命令，你将会看到与下面类似的输出信息：

```bash
$ python manage.py migrate
Operations to perform:
  Synchronize unmigrated apps: staticfiles, weixin, home_application, messages
  Apply all migrations: app_control, account, sessions, admin, sites, auth, contenttypes
Synchronizing apps without migrations:
  Creating tables...
    Running deferred SQL...
  Installing custom SQL...
Running migrations:
  Rendering model states... DONE
  Applying contenttypes.0001_initial... OK
  Applying contenttypes.0002_remove_content_type_name... OK
... ...
```

这代表你的数据库已经初始化成成功啦！

## 启动开发服务器

### 配置 hosts

首先，本地需要配置 hosts 文件，添加如下内容：

```bash
127.0.0.1 dev.xxx.xxx（注意：必须与PaaS平台主站在同一个一级域名)
```

### 本地启动项目

在项目根目录下执行如下命令：

```python
python manage.py runserver 127.0.0.1:8000
```

接着在浏览器访问 http://dev.xxx.xxx:8000/ 就可以看到项目首页啦。
