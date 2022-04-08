# 增强服务：MySQL

## 实例使用指南

### 蓝鲸开发框架 / Django

如何将已申请的 MySQL 服务实例配置为 Django 默认数据库：

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

> 帮助：蓝鲸开发框架已实现自动探测是否需要配置 MySQL 实例为默认数据库，你无需手动配置。

