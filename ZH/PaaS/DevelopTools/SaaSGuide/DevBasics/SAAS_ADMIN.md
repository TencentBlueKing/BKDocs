

### 创建 SaaS 管理员方法

1. 背景说明

   蓝鲸 SaaS 开发框架在 3.1.0.75 版本后，默认是将 SaaS 管理员的权限与 PaaS 平台管理员权限解除绑定，两者可以独立配置。文章主要说明已有的 SaaS 如何升级使用该特性，并注入新的管理员权限。

2. 环境准备

   - Python 开发框架: 版本 >= 3.1.0.75 [点我下载](../../../../DevelopGuide/7.0/DevTools.md)

   - 将开发框架 blueapps 模块替换已有 SaaS 的 blueapps 模块

     > 注意：如果对开发框架有自定义修改，请注意备份

3. 注入新管理员方法

   - 修改 config/default.py 的 INIT_SUPERUSER 配置，填写用户名列表，默认值是应用创建人，列表中的人员将拥有预发布环境和正式环境的管理员权限。需要注意的是，该配置需要在首次提测和上线前修改，之后的修改将不会生效。
     如果不小心将唯一的管理员权限去掉了，有两种方式新增管理员：

   - 通过 migration 实现

        INIT_SUPERUSER 配置，打开 config/default.py 配置文件，找到 INIT_SUPERUSER 配置，添加上需要注入的管理员账号名

        ```python
        INIT_SUPERUSER = ["admin", "other_admin"]	
        ```
   
        接着在你的 APP 目录下，找到 migrations 文件夹，新建文件 {INDEX}_init_superuser.py：
   
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
               ('{APP}', '{APP_LAST_MIGRATION}')
           ]
           operations = [
               migrations.RunPython(load_data)
           ]        
     ```
     
        其中，{APP} 表示你的当前 APP，{APP_LAST_MIGRATION} 表示当前 mirgations 文件中最新一个文件名（如 “0003_auto_20180301_1732”），{INDEX} 表示最新一个文件名的前缀数字加 1（如 “0003_auto_20180301_1732” 的前缀数字是 “0003”，那么 {INDEX} 设置为 “0004”）。
     
     
     
   -  通过 views 实现，同上面一样先修改INIT_SUPERUSER 配置，接着在你的 APP 目录的 views 文件中，添加如下代码：
   
        ```python
        from django.conf import settings
        from django.http import HttpResponse
        from blueapps.account import get_user_model
        def load_data(request):
            """
            添加用户为管理员
            """
            User = get_user_model()
            for name in settings.INIT_SUPERUSER:
                User.objects.update_or_create(
                    username=name,
                    defaults={'is_staff': True, 'is_active': True, 'is_superuser': True}
                )
            return HttpResponse('Success')
        ```

  		然后配置一条 URL 路由规则到该 view，提测、上线后访问对应 URL 就可以初始化管理员了。
