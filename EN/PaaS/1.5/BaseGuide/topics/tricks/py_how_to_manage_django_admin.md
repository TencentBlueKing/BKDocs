# How to Manage Django Admin

## Django Admin Administrator Settings

Modify the `INIT_SUPERUSER` configuration in `config/default.py`, fill in the list of usernames. The default value is the creator of the application, and the personnel in the list will have administrator permissions for both the staging and production environments.

It should be noted that this configuration needs to be modified before the initial testing and deployment, as subsequent modifications will not take effect.

If you accidentally remove the only administrator permission, there are two ways to add a new administrator:

- Through migrations

In your APP directory, find the `migrations` folder and create a new file `{INDEX}_init_superuser.py`:

```python
# -*- coding: utf-8 -*-
from django.db import migrations
from django.conf import settings


def load_data(apps, schema_editor):
    """
    Add user as admin
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

Where `{APP}` represents your current APP, `{APP_LAST_MIGRATION}` represents the name of the latest file in the current migrations (e.g., "0003_auto_20180301_1732"), and `{INDEX}` represents the prefix number of the latest file name plus 1 (e.g., the prefix number of "0003_auto_20180301_1732" is "0003", so `{INDEX}` should be set to "0004").

- Through views

In the `views` file of your APP directory, add the following code:

```python
from django.conf import settings
from django.http import HttpResponse

from blueapps.account import get_user_model


def load_data(request):
    """
    Add user as admin
    """
    User = get_user_model()
    for name in settings.INIT_SUPERUSER:
        User.objects.update_or_create(
            username=name,
            defaults={'is_staff': True, 'is_active': True, 'is_superuser': True}
        )
    return HttpResponse('Success')
```

Then configure a URL routing rule to this view, and after testing and deployment, visit the corresponding URL to initialize the administrator.