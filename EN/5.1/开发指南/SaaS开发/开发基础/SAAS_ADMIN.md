### Create saas administrator method.

1. Background notes.

   After version 3.1.0.75 of the saas development framework of blueking enterprise edition, the default is to bind the permissions of saas administrator to the permissions of paas platform administrator, and the two can be configured independently. This article mainly explains how to upgrade the existing saas to use this feature and inject new administrator rights.

2. Environmental preparation.

   - Python development framework: version >= 3.1.0.75 [Click me to download](https://docs.bk.tencent.com/download/).

   - Replace the existing saas blueapps module with the development framework blueapps module.

     > Note：If there are customized changes to the development framework, please pay attention to the backup.

3. Inject new administrator method.

   - Modify INIT_SUPERUSER configuration.

     Open the config/default.py configuration file, find the INIT_SUPERUSER configuration, and add the administrator account name to be injected.

     ```python
     INIT_SUPERUSER = ["admin", "other_admin"]
     ```

   - Add migration.

     Find any Django app under the project, enter the corresponding migrations folder, and add a new migration. The sample content is as follows.
     ```python
     from django.db import migrations
     from django.conf import settings
     def load_data(apps, schema_editor):
         """
         Add user as Administrator.
         """
         User = apps.get_model("account", "User")
         for name in settings.INIT_SUPERUSER:
             User.objects.update_or_create(
                 username=name,
                 defaults={'is_staff': True, 'is_active': True, 'is_superuser': True}
             )
     class Migration(migrations.Migration):
         dependencies = [
             # Change to Django app name and last migration file name respectively.
           	# for example：('home_application', '0001_initial').
             ('your_app_name', 'last_migration_name')
         ]
         operations = [
             migrations.RunPython(load_data)
         ]
     ```
        > Note：You need to modify `your_app_name` and `last_migration_namee` in `dependencies`.

   - Resubmit test.

     After the code is submitted to the warehouse, the new administrator configuration will be automatically injected through migration after it is re tested or online.

4. FAQ.
   - Q：Must new administrators be injected through migrations?
   - A：No, it's just a suggested use. Developers can also modify it by other means. For example, a middleware ensures that each request can determine whether the user's identity needs to be promoted to administrator.
   - Q：Why is it no longer effective to add INIT_SUPERUSER later?
   - A：The above scheme is to inject administrator information through migrations, which is a **one-time** injection operation. We expect to provide administrator rights to a group of users first, and then the rights of other users can be operated by the first group of administrators through the django admin page.