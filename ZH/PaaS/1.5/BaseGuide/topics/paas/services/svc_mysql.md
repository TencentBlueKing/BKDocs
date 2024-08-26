# 增强服务：MySQL

## 实例使用指南

### 蓝鲸开发框架 / Django

首先你需要在环境变量中获取到 MySQL 的相关信息，并添加到 Django 的配置文件中：

```python
import os

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': os.environ.get('MYSQL_NAME'),
        'USER': os.environ.get('MYSQL_USER'),
        'PASSWORD': os.environ.get('MYSQL_PASSWORD'),
        'HOST': os.environ.get('MYSQL_HOST'),
        'PORT': os.environ.get('MYSQL_PORT'),
    }
}
```

**说明**：蓝鲸开发框架中`blueapps`模块已经默认集成了上面的获取方法，如果你已经使用则不需要再手动修改。

### Node.js

首先你需要在环境变量中获取到 MySQL 的相关信息，并添加到 Nodejs 的配置文件中：

```
const config = {
    database: process.env.MYSQL_NAME,
    username: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    host: process.env.MYSQL_HOST,
    port: process.env.MYSQL_PORT
}
```

**说明**：蓝鲸前端开发框架的 server/conf/db.js 配置已经默认集成了上面的获取方法，如果你已经使用则不需要再手动修改。
