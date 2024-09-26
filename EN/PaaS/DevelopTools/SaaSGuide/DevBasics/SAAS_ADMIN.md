

### How to create a SaaS administrator

1. Background

After version 3.1.0.75 of the BlueKing SaaS development framework, the default is to unbind the SaaS administrator's permissions from the PaaS platform administrator's permissions, and the two can be configured independently. This article mainly explains how to upgrade the existing SaaS to use this feature and inject new administrator permissions.

2. Environment preparation

- Python development framework: version >= 3.1.0.75 [Click here to download](../../../../DevelopGuide/7.0/DevTools.md)

- Replace the blueapps module of the development framework with the blueapps module of the existing SaaS

> Note: If you have customized modifications to the development framework, please backup it

3. How to inject a new administrator

- Modify the INIT_SUPERUSER configuration of config/default.py and fill in the user name list. The default value is the application creator. The people in the list will have administrator permissions for the pre-release environment and the official environment. It should be noted that this configuration needs to be modified before the first test and launch, and subsequent modifications will not take effect.
If the only administrator privilege is accidentally removed, there are two ways to add an administrator:

- Implement through migration

INIT_SUPERUSER configuration, open the config/default.py configuration file, find the INIT_SUPERUSER configuration, and add the administrator account name to be injected

```python
INIT_SUPERUSER = ["admin", "other_admin"]
```

Then in your APP directory, find the migrations folder and create a new file {INDEX}_init_superuser.py:
   
     ```python
      from django.db import migrations
      from django.conf import settings
      def load_data(apps, schema_editor):
         """
         Add a user as an administrator
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
     
        Among them, {APP} represents your current APP, {APP_LAST_MIGRATION} represents the latest file name in the current mirgations file (such as "0003_auto_20180301_1732"), and {INDEX} represents the prefix number of the latest file name plus 1 (such as the prefix number of "0003_auto_20180301_1732" is "0003", then {INDEX} is set to "0004").
     
     
     
   -  To implement it through views, modify the INIT_SUPERUSER configuration as above, then add the following code to the views file in your APP directory
   
        ```python
        from django.conf import settings
        from django.http import HttpResponse
        from blueapps.account import get_user_model
        def load_data(request):
            """
            Add a user as an administrator
            """
            User = get_user_model()
            for name in settings.INIT_SUPERUSER:
                User.objects.update_or_create(
                    username=name,
                    defaults={'is_staff': True, 'is_active': True, 'is_superuser': True}
                )
            return HttpResponse('Success')
        ```

  		Then configure a URL routing rule to the view. After testing and going online, you can initialize the administrator by accessing the corresponding URL.
