## Overall upgrade plan

- Remove the dependency of celery in the blueapps package
- Since djcelery only supports celery3x, upgrade celery4x version and use django-celery-beat and django-celery-result packages to replace djcelery functions
- The main problem with the upgrade is that the time flow of celery4x is different from that of celery3x, which leads to abnormal execution of scheduled tasks and asynchronous tasks. The subsequent chapters will introduce it in detail. Please refer to the [Old User Upgrade] and [New User Usage Notes] chapters of this article
- celery4x solves the conflict with the async keyword. After upgrading, you can use python3.7 and above (currently only tested to 3.7.4)

## Changes to configuration files after upgrade

- After upgrading, the default `USE_TZ=True`
- Replace djcelery dependencies with django_celery_beat and django_celery_results

Before upgrading: conf/default.py

```python 

...
# Internationalization Configuration
LOCALE_PATHS = (os.path.join(BASE_DIR, 'locale'),)  # noqa

TIME_ZONE = 'Asia/Shanghai'
LANGUAGE_CODE = 'zh-hans'
....

if IS_USE_CELERY:
    INSTALLED_APPS = locals().get('INSTALLED_APPS', [])
    import djcelery
    INSTALLED_APPS += (
        'djcelery',
    )
    djcelery.setup_loader()
    CELERY_ENABLE_UTC = False
    CELERYBEAT_SCHEDULER = "djcelery.schedulers.DatabaseScheduler"

```

升级后：conf/default.py

```python

...
# Internationalization Configuration
LOCALE_PATHS = (os.path.join(BASE_DIR, 'locale'),)  # noqa

USE_TZ = True
TIME_ZONE = 'Asia/Shanghai'
LANGUAGE_CODE = 'zh-hans'
....

if IS_USE_CELERY:
    INSTALLED_APPS = locals().get('INSTALLED_APPS', [])
    INSTALLED_APPS += (
        'django_celery_beat',
        'django_celery_results'
    )
    CELERY_ENABLE_UTC = False
    CELERYBEAT_SCHEDULER = "django_celery_beat.schedulers.DatabaseScheduler"

```

## New features of celery4

### System-level updates

1. No longer support for Windows platform. There are currently two main problems with the Windows platform, and other basic functions are normal.

- One is that you need to join eventlet to use it.
- Multiple workers cannot be started at the same time on the Windows platform. The main reason is that starting multiple workers depends on the resource library, which only supports Linux and Unix platforms.

2. No longer support Python 2.6 and Python 3.3

3. No longer support Jpython.

4. **The minimum Django version supported by celery4.x is 1.8, and the official recommendation is to start from 1.9. **

5. celery4 will be the last version to support python2, and the minimum supported python version of celery5 is python3.5

### Functional level update

6. New setting names are used

Specifically, the configuration abbreviations of celery4.x are all lowercase, but in order to consider the support for celery3.x, the uppercase configuration names can still be used. For example:

```bash
CELERY_TIMEZONE = 'Asia/Shanghai' # The default time zone is UTC old
timezone = 'Asia/Shanghai' # The default time zone is UTC new
```

Regarding the upgrade of celery uppercase and lowercase, celery provides a new command to batch migrate configurations:

```bash
celery upgrade settings [filename]
```

The specific mapping content is described in the official document:
https://docs.celeryproject.org/en/4.0/userguide/configuration.html#conf-old-settings-map

7. json is now the default serializer.

In daily use, json may not be serialized. If you still need to use pickle as a serializer, you need to add the following configuration:

```python
task_serializer = 'pickle'
result_serializer = 'pickle'
accept_content = {'pickle'}
```

8. Tasks using Task as the base class will not be automatically registered

. The new version of celery4.x needs to use a decorator to decorate Task before it will be automatically registered.

```python
# Create a normal task
@app.task()
def add(x, y):
print("Calculate the sum of 2 values: %s %s" % (x, y))
return x + y
```

9. **Priorities have changed, now the order of priorities is 0-9 in ascending order**. Mainly to be consistent with the way things work in AMQP.

10. **Command line parameters have changed**. celeryd -> celery worker, celerybeat-> celery beat, celeryd-multi-> celery multi

11. Auto-discover now supports Django app configuration

12. Support for RabbitMQ priorities.

13. Added broker_read_url and broker_write_url settings so that separate broker urls can be provided for connections used for consumption/publishing.

14. Added support for RabbitMQ extensions.

```python
# Set the queue expiration time in floating seconds.
Queue(expires=20.0)
# Set the queue message real-time floating seconds.
Queue(message_ttl=30.0)
# Set the queue maximum length (number of messages) to int.
Queue(max_length=1000)
# Set the queue maximum length (total message size in bytes) to int.
Queue(max_length_bytes=1000)
# Declare the queue as a priority queue that routes messages based on message fields. priority
Queue(max_priority=10)
```

15. Support for `Amazon SQS transport` `Apache QPid transport`.

16. Support for redis sentinel.

```bash
sentinel://0.0.0.0:26379;sentinel://0.0.0.0:26380/...
```

17. New way to write scheduled tasks.

    ```python
    from blueapps.core.celery.celery import app
    from django_celery_beat.tzcrontab import TzAwareCrontab
    
    
    @app.on_after_configure.connect
    def setup_periodic_tasks(sender, **kwargs):
        # Calls test('hello') every 10 seconds.
        sender.add_periodic_task(10.0, test.s('hello'), name='add every 10')
    
        # Calls test('world') every 30 seconds
        sender.add_periodic_task(30.0, test.s('world'), expires=10)
    
        # Executes every Monday morning at 7:30 a.m.
        sender.add_periodic_task(
            crontab(hour=7, minute=30, day_of_week=1,tz=timezone.get_current_timezone()),
            test.s('Happy Mondays!'),
        )
    
    @app.task
    def test(arg):
        print(arg)
    ```

18. AsyncResult adds a new callback method then, which needs to be used in conjunction with the gevent module.

    ```python
    import gevent.monkey
    monkey.patch_all()
    
    import time
    from blueapps.core.celery.celery import app
    
    @app.task
    def add(x, y):
        return x + y
    
    def on_result_ready(result):
        print('Received result for id %r: %r' % (result.id, result.result,))
    
    add.delay(2, 2).then(on_result_ready)
    
    time.sleep(3)  # run gevent event loop for a while.
    ```
19. Support redis ssl connection method

### No longer supported parts

1. Removed celery.task.http, emails.app.mail_admins and celery.contrib.batches

2. No longer support using Django ORM, SQLAlchemy, CouchDB, IronMQ, Beanstalk as broker.

3. **No longer support rabbitMQ as backend to store results. **

## Notes for old users to upgrade

- After upgrading, old users with `USE_TZ=False` will not be able to write configuration content with time zone in DB when using MysSQL backend. The specific error is `ValueError: MySQL backend does not support timezone-aware datetimes when USE_TZ is False`

Solution:

- Solution 1 (recommended): Add `USE_TZ = True` to the config/default.py file to enable Django time zone

- Solution 2: Add `DJANGO_CELERY_BEAT_TZ_AWARE = ​​False` to config/default.py to disable Celery time zone awareness

- For old Windows users, Celery 4.4 no longer supports Windows platform and cannot start multiple workers. You can only start a single worker through `-p eventlet`. The evenlet package needs to be installed through pip before use

```python
# eventlet installation command
pip install eventlet==0.26.1
# Windows user start worker command
celery -A blueapps.core.celery worker -l info -P eventlet
```

- djcelery does not support celery4.4. After upgrading, django-celery-beat and django-celery-result are used to replace the functions of djcelery. Therefore, the celery startup command provided by djcelery is no longer supported. The new beat and worker startup commands are

```python
# beat startup command
celery -A blueapps.core.celery beat -l info
# worker startup command. Windows users should add the -P eventlet parameter
celery -A blueapps.core.celery worker -l info
```

> Note: Here `-A blueapps.core.celery` is used to specify the use of the celery app encapsulated inside the development framework. It can be used to load the configuration in /conf/default.py and other functions. If other apps are used in the configuration, the configuration cannot be loaded and the task cannot be automatically discovered

### Configurations that need to be modified for asynchronous tasks after upgrading

- `T.delay(arg, kwarg=value)` configuration: no impact after upgrading

- Asynchronous tasks configured with `datetime.datetime.now()` in the `eta` parameter in `apply_async` will be treated as UTC time in the new version because there is no time zone. Similarly, if the time object generated by `datetime()` has no time zone information, it will also be treated as UTC time

For example, if the time zone is Asia/Shanghai and the current time is 12:00+0800, it will be treated as 12:00+00:00, that is, delayed by 8 hours
Solution:

- Use `django.utils.timezone.now()` instead of `datetime.datetime.now()` to get the current time

- Use `django.utils.timezone.make_aware()` to make the time object generated by `datetime` carry the time zone information

```python
# Configure the user's current time to 12:00+08:00, delay the current time by 2s,
# Wrong configuration: Since there is no time zone, use the UTC time zone, the actual time will be 12:00+00:00, and the execution will be delayed by 2s
T.apply_async(eta=datetime.datetime.now() + timedelta(seconds=2))
# Correct configuration:
T.apply_async(eta=django.utils.timezone.now() + timedelta(seconds=2))

# Configure the user to execute at 12:02+08:00 on September 21, 2020
# Wrong configuration: Since there is no time zone, use the UTC time zone, the actual execution will be at 12:02+00:00 on September 21, 2020
T.apply_async(eta=datetime.datetime(2020, 9, 21, 12, 0) + timedelta(seconds=2))
# Correct configuration:
T.apply_async(eta=django.utils.timezone.make_aware(datetime.datetime(2020, 9, 16, 17, 38)) + timedelta(seconds=2))
```

### Scheduled task configuration

- Scheduled tasks configured using `crontab`, since there is no time zone, will be specified according to the time zone configured by `CELERY_TIMEZONE` (default configuration UTC),

Solution: Use `TzAwareCrontab` configuration, add the `tz=timezone.get_current_timezone()` parameter, that is, the scheduled task can be executed in the user's time zone

```python
from celery.task import periodic_task
from django.utils import timezone
from celery.schedules import crontab
from django_celery_beat.tzcrontab import TzAwareCrontab

# Configure the user's time zone to execute the scheduled task at 10:00 every day
# Wrong configuration: Since the scheduled task time zone is not configured, the UTC time zone is used, and it will actually be executed at 10:00+00:00
@periodic_task(run_every=celery.schedule.crontab(minute="0", hour="10",tz=timezone.get_current_timezone()))
def crontab_timezone():
logger.info("test timezone")
return True

# Correct configuration
@periodic_task(run_every=django_celery_beat.tzcrontab.TzAwareCrontab(minute="0", hour="10",tz=timezone.get_current_timezone()))
def crontab_timezone():
logger.info("test timezone")
return True
```
- After the upgrade, the `CrontabSchedule` table of scheduled tasks adds a `timezone` field. When creating a scheduled task, you can configure the time zone where the scheduled task is executed by specifying the time zone of the `timezone` field

Sample code: home_application/celery_utils.py

```python
from django.utils import timezone
from django_celery_beat.models import CrontabSchedule, PeriodicTask
# Users add scheduled tasks in real time
  def add_period_task(task, name=None, minute='*', hour='*',
                      day_of_week='*', day_of_month='*',
                      month_of_year='*', args="[]", kwargs="{}", tz=None):
      """
      @summary: Add a periodic task
      @param task: The module path name of the task, for example, celery_sample.crontab_task
      @param name: User-defined task name, unique
      @note: PeriodicTask has many parameters that can be set. Here we only provide simple and commonly used
      """
      cron_param = {
          'minute': minute,
          'hour': hour,
          'day_of_week': day_of_week,
          'day_of_month': day_of_month,
          'month_of_year': month_of_year,
          'timezone': timezone.get_current_timezone() if tz is None else tz
      }
      if not name:
          name = task
      try:
          cron_schedule = CrontabSchedule.objects.get(**cron_param)
      except CrontabSchedule.DoesNotExist:
          cron_schedule = CrontabSchedule(**cron_param)
          cron_schedule.save()
      try:
          PeriodicTask.objects.create(
              name=name,
              task=task,
              crontab=cron_schedule,
              args=args,
              kwargs=kwargs,
          )
      except Exception as e:
          return False, '%s' % e
      else:
          return True, ''
  
  # Users edit scheduled tasks by scheduled task ID
  def edit_period_task_by_id(task_id, minute='*', hour='*',
                             day_of_week='*', day_of_month='*',
                             month_of_year='*', args="[]", kwargs="{}", tz=None):
      """
      @summary:Update a periodic task
      @param name: User-defined task name, unique
      """
      try:
          period_task = PeriodicTask.objects.get(id=task_id)
      except PeriodicTask.DoesNotExist:
          return False, 'PeriodicTask.DoesNotExist'
      cron_param = {
          'minute': minute,
          'hour': hour,
          'day_of_week': day_of_week,
          'day_of_month': day_of_month,
          'month_of_year': month_of_year,
          'timezone': timezone.get_current_timezone() if tz is None else tz
      }
      try:
          cron_schedule = CrontabSchedule.objects.get(**cron_param)
      except CrontabSchedule.DoesNotExist:
          cron_schedule = CrontabSchedule(**cron_param)
          cron_schedule.save()
      period_task.crontab = cron_schedule
      period_task.args = args
      period_task.kwargs = kwargs
      period_task.save()
      return True, ''
  ```
  
  hoeme_application/views.py
  
  ```python
  
  def save_task(request):
      """
      Create/Edit a periodic task and run it
      """
      tz = request.POST.get('tz')
      if tz:
          timezone.activate(tz)
      periodic_task_id = request.POST.get('periodic_task_id', '0')
      params = request.POST.get('params', {})
      try:
          params = json.loads(params)
          add_param = params.get('add_task', {})
      except Exception:
          msg = u"参数解析出错"
          logger.error(msg)
          result = {'result': False, 'message': msg}
          return JsonResponse(result)
      task_args1 = add_param.get('task_args1', '0')
      task_args2 = add_param.get('task_args2', '0')
      # 任务参数
      try:
          task_args1 = int(task_args1)
          task_args2 = int(task_args2)
          task_args_list = [task_args1, task_args2]
          task_args = json.dumps(task_args_list)
      except Exception:
          task_args = '[0,0]'
          logger.error(u"解析任务参数出错")
      #  周期参数
      minute = add_param.get('minute', '*')
      hour = add_param.get('hour', '*')
      day_of_week = add_param.get('day_of_week', '*')
      day_of_month = add_param.get('day_of_month', '*')
      month_of_year = add_param.get('month_of_year', '*')
      # 创建周期任务时，任务名必须唯一
      now = int(time.time())
      task_name = "{}_{}".format(TASK, now)
      if periodic_task_id == '0':
          # 创建任务并运行
          res, msg = add_period_task(TASK, task_name, minute, hour,
                                     day_of_week, day_of_month,
                                     month_of_year, task_args)
      else:
          # 修改任务
          res, msg = edit_period_task_by_id(periodic_task_id, minute, hour,
                                            day_of_week, day_of_month,
                                            month_of_year, task_args)
      return JsonResponse({'result': res, 'message': msg})
  
  ```
### DB data migration

Note:

- Since djcelery is deprecated after the upgrade and replaced by django-celery-beat and django-celery-results, data table migration is required
- Tables that cannot be migrated after the upgrade
- The TaskState table in the djcelery package is only used to record the task status of tasks and does not affect the execution of tasks. Since the table structure in the django-celery-beat package has changed too much, it cannot be migrated
- The WorkerState table in the djcelery package is used to record the celery worker status and is removed in the django-celery-beat package
- The migration command should be executed after the celery4, django-celery-beat, and django-celery-results packages are installed and configured, and the migrate command is executed, for example, configured in bin/postcompile
- Before migration, the target database will be checked to see if it is empty. If it is not empty, the migration fails
- If it is a migration with time zone, the old The crontab configuration is still time without time zone, such as `crontab(minute="57", hour="10")`. After the beat is restarted, the timezone in the crontab table will be refreshed with the time zone configured by `CELERY_TIMEZONE`, which may cause time zone execution problems for scheduled tasks. Therefore, crontab needs to be modified to TzAwareCrontab. For example, see the [Scheduled Task Configuration] section of this article for sample code

Migration command

```python
python manage.py migrate_from_djcelery
# Optional parameter: -tz specifies the time zone of the previous celery operation. If it is not specified, the UTC time zone is used by default. For example: -tz Asia/Shanghai
```

**User Note**, please use the following migrations file to migrate the online database

How to use:

1. Put the following file in the migrations folder of any app, such as: home_application/migrations/

2. Migration command: execute `python manage.py migrate` to apply the migration file

3. Use tz in the handle function on line 11 Parameter specifies the time zone of the previous celery run

```python
# migrations file
# -*- coding: utf-8 -*-
from django.db import migrations

from blueapps.contrib.bk_commands.management.commands import migrate_from_djcelery

def migrate_db_from_djcelery(*arg, **kwargs):
migrate_command = migrate_from_djcelery.Command()
#Modify the tz parameter to specify the time zone
migrate_command.handle(tz='Asia/Shanghai')

class Migration(migrations.Migration):
# Fill in the last executed migrations in dependencies
dependencies = []

operations = [
migrations.RunPython(migrate_db_from_djcelery),
]
```

## Notes for new users

- Default time zone configuration

```python
# default.py
TIME_ZONE = 'Asia/Shanghai'
USE_TZ=True
CELERY_ENABLE_UTC = False
```

- Beat and worker startup commands

```python
# Beat startup command
celery -A blueapps.core.celery beat -l info
# Worker startup command, Windows users please add -P eventlet parameter
celery -A blueapps.core.celery worker -l info
```

> Note:
>
> 1. Here `-A blueapps.core.celery` is used to specify the use of the celery app encapsulated inside the development framework, which can be used to load the configuration in /conf/default.py and other functions. If other apps are configured, it will cause the configuration to be unable to load and the automatic discovery of tasks

**User note**, due to the limitations of the PaaS platform, only the following startup methods can be used

```python
# Worker startup command
python manage.py celery worker -l info
# Worker startup command
python manage.py celery beat -l info
```

> Note:
>
> 1. This startup command is migrated from djcelery,
> 2. Since Django orm can only allow single-threaded operation of database handles, the worker started by `python manage.py` is not the same thread as Django and cannot be modified
> 3. The monkey patch of `patch_thread_ident` is used to patch out the logic of Django verifying orm multi-threaded operation data, which will change the thread ID of the worker

- Asynchronous task configuration

```python
# Configure the user's current time to 12:00+08:00, delay the current time by 2s,
T.apply_async(eta=django.utils.timezone.now() + timedelta(seconds=2))

# Configure the user to execute at 12:02+08:00 on September 21, 2020
T.apply_async(eta=django.utils.timezone.make_aware(datetime.datetime(2020, 9, 16, 17, 38)) + timedelta(seconds=2))
```

- Scheduled task configuration

```python
from celery.task import periodic_task
from django.utils import timezone
from django_celery_beat.tzcrontab import TzAwareCrontab

# Configure the user's time zone to execute the scheduled task at 10:00 every day
  @periodic_task(run_every=django_celery_beat.tzcrontab.TzAwareCrontab(minute="0", hour="10",tz=timezone.get_current_timezone()))
def crontab_timezone():
      logger.info("test timezone")
      return True
  ```
  
  

