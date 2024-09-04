# 如何管理 Django Admin 

## Django Admin 管理员设置

修改 config/default.py 的 INIT_SUPERUSER 配置，填写用户名列表，默认值是应用创建人，列表中的人员将拥有预发布环境和正式环境的管理员权限。

需要注意的是，该配置需要在首次提测和上线前修改，之后的修改将不会生效。

如果不小心将唯一的管理员权限去掉了，有两种方式新增管理员：

- 通过 migrations 实现

在你的 APP 目录下，找到 migrations 文件夹，新建文件 {INDEX}_init_superuser.py：

```python
# -*- coding: utf-8 -*-
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

- 通过 views 实现

在你的 APP 目录的 views 文件中，添加如下代码：

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