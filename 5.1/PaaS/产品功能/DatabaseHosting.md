### 应用数据库托管服务 {#DatabaseHosting}

在创建蓝鲸 SaaS 的时候，蓝鲸为每个应用分配有两套独立数据库（测试库和正式库），并配备高可用方案，保证数据可靠性；且支持几乎所有的 MySQL 特性。

(1)Django admin

蓝鲸的应用采用了 Django 框架，Django 是基于 WEB 的数据库管理工具。你只需要将数据模型注册到 admin.py 文件中，就可以在页面上对数据进行 增、删、改、查。

![](../assets/image048.png)

![](../assets/image049.png)

(2)在线操作

蓝鲸应用直接集成 Django 框架自带的数据库后台管理服务。开发者可以在页面上管理测试环境和正式环境的数据库。

![](../assets/image050.png)
