# 增强服务：GCS-MySQL

## 实例使用指南

### 蓝鲸开发框架 / Django

如何将已申请的 GCS-MySQL 服务实例配置为 Django 默认数据库：

```python
import os

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql', 
        'NAME': os.environ.get('GCS_MYSQL_NAME'),
        'USER': os.environ.get('GCS_MYSQL_USER'),
        'PASSWORD': os.environ.get('GCS_MYSQL_PASSWORD'),
        'HOST': os.environ.get('GCS_MYSQL_HOST'), 
        'PORT': os.environ.get('GCS_MYSQL_PORT'),
    }
}
```

> 帮助：蓝鲸开发框架（`blueapps`）已实现自动探测是否需要配置 GCS-MySQL 实例为默认数据库，你无需手动配置。

### 如何使用 DBS 在线查询数据

新版的 GCS-MySQL 增强服务已经对接了公司内的 DBS 服务, 由 DBS 提供了在线查询数据库的服务。

> 备注: 该工具连接的是 **数据库从库** ，仅支持查询与数据导出功能。 

#### 1. 启用 新版 GCS-MySQL 增强服务

![-w2021](../../../images/docs/paas/gcs-mysql/gcs-mysql-1.png)

#### 2. 从管理入口进入增强服务管理页面

![-w2021](../../../images/docs/paas/gcs-mysql/gcs-mysql-2.png)

#### 3. 点击「使用 dbs 在线工具管理数据」进入 DBS

![-w2021](../../../images/docs/paas/gcs-mysql/gcs-mysql-3.png)

#### 4. 使用 DBS 查看数据

![-w2021](../../../images/docs/paas/gcs-mysql/gcs-mysql-4.png)
