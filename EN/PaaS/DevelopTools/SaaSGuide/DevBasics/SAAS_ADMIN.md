### 创建 SaaS 管理员方法

1. 背景说明

   蓝鲸 SaaS 开发框架在 3.1.0.75 版本后，默认是将 SaaS 管理员的权限与 PaaS 平台管理员权限解除绑定，两者可以独立配置。文章主要说明已有的 SaaS 如何升级使用该特性，并注入新的管理员权限。

2. 环境准备

   - Python 开发框架: 版本 >= 3.1.0.75 [点我下载](../../../../DevelopGuide/7.0/DevTools.md)

   - 将开发框架 blueapps 模块替换已有 SaaS 的 blueapps 模块

     > 注意：如果对开发框架有自定义修改，请注意备份

3. 注入新管理员方法

   - 修改 INIT_SUPERUSER 配置

     打开 config/default.py 配置文件，找到 INIT_SUPERUSER 配置，添加上需要注入的管理员账号名。

     ```python
     INIT_SUPERUSER = ["admin", "other_admin"]
     ```

   - 添加 migration

     找到项目下任意一个 django app，进入到对应的 migrations 文件夹下，添加一个新的 migration，样例内容如下

     ```python
     from django.db import migrations
     from django.conf import settings
     def load_data(apps, schema_editor):
         """
         添加用户为管理员
         """
         User = apps.get_model("account", "User")
         for name in settings.INIT_SUPERUSER:
             User.objects.update_or_create(
                 username=name,
                 defaults={'is_staff': True, 'is_active': True, 'is_superuser': True}
             )
     class Migration(migrations.Migration):
         dependencies = [
             # 分别修改为django app名及最后一个migration文件名
           	# 例如：('home_application', '0001_initial')
             ('your_app_name', 'last_migration_name')
         ]
         operations = [
             migrations.RunPython(load_data)
         ]
     ```
        > 注意：需要修改其中`dependencies`中的`your_app_name`和`last_migration_name`。

   - 重新提测

     代码提交到仓库后，重新提测或上线后，将会通过 migration 自动注入新的管理员配置。

4. FAQ
   - Q：是否必须通过 migrations 注入新管理员？
   - A：不是，这只是一个建议的用法。开发者也可以通过其他手段进行修改。例如，通过一个中间件确保每次请求时，都可以判断用户的身份是否需要提升为管理员。
   - Q：为什么后面增加 INIT_SUPERUSER 不再生效？
   - A：上面的方案是通过 migrations 注入管理员信息，是一个**一次性**的注入操作。我们预期是先给一批用户提供了管理员权限，其他用户的权限后续可以由第一批管理员通过 django admin 页面进行操作。
