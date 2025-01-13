# Development Framework 2.0 Instructions
## Directory Structure
### Project Directory Structure

```bash
- blueking # ESB call module
- bk_framework_api # Django template application example
- bk_framework_app # drf interface template example
- templates # Django template
- bk_framework_app
- contact.html # Contact us page
- dev_guide.html # Development guide
- index_home.html # Home page
- config # Application configuration directory
- __init__.py # Application RUN_VER, APP_CODE and SECRET_KEY and other configurations
- dev.py # Local development configuration (shared by the development team)
- default.py # Global configuration
- prod.py # Production environment configuration
- stag.py # Pre-release environment configuration
- locale
- en
- zh-hans
- static # Public static files
- account
- djcelery
- js # public js
- csrftoken.js # CSRFTOKEN
- settings.js # exception handling
- open
- remote
- templates # public template files
- 403.html
- 500.html
- base.html # Django template base file, other pages can inherit from here
- __init__.py
- manage.py # Django project manage
- app_desc.yaml # application description file
- Aptfile # system packages that the project depends on
- pyproject.toml # unified configuration file for code standards
- requirements.txt # list of dependent python packages
- requirements_dev.txt # list of python packages that the local environment depends on
- settings.py # Django project settings
- urls.py # Django project main route URL configuration
- wsgi.py # WSGI configuration
- runtime.txt # Python version configuration file, points to Python by default Version 3.10.5
```

### Common configuration instructions

- Basic App information

In config/\__init\__.py, you can view the basic App information. Please modify: APP_CODE, SECRET_KEY (for App authentication) and BK_URL (URL of BlueKing SaaS platform). RUN_VER is the PaaS version currently running the App. Please do not modify it.

- App operating environment

In config/dev.py, config/stag.py, and config/prod.py, there is a RUN_MODE variable to mark the App operating environment (DEVELOP: local environment, STAGING: pre-release environment, PRODUCT: official environment). Please do not modify it.

- Log level and path

The default log level of the development framework is INFO. You can modify the LOG_LEVEL variable in config/default.py, which will take effect on all running environments. You can also modify the config/dev.py, config/stag.py, and config/prod.py files separately. For details, please refer to [Log Usage] in this document.

You don't need to care about the log path of the online running environment, as these development frameworks have automatically configured them for you;

Local logs are placed in the logs directory at the same level as the project root directory, in a folder named APP_CODE, where {APP_CODE}-django.log is the application log, {APP_CODE}-celery.log is the celery log, {APP_CODE}-component.log is the component log, and {APP_CODE}-mysql.log is the database log.

- Database configuration

For local database configuration, modify the DATABASES variable in config/dev.py; for collaborative development, it is recommended to create a local_settings.py file in the root directory and configure the DATABASES variable, and ignore local_settings.py in version control. The advantage of this is to prevent inconsistent local configurations and code conflicts during collaborative development.

## Development environment setup (Python)
### Install Python (3.10)

If Python2 is already installed in the system, refer to Python version switching to learn about [Solutions for coexistence of Python3 and Python2] (PYTHON2_3.md)

### Install MySQL (5.5 or above)
### Install setuptools, pip, and project dependencies

```bash
pip3 install -r requirements.txt
```

### Install celery (projects that need to use background tasks)

When installing project dependencies, celery==4.4.0 will be automatically installed. Currently, Celery supports redis and rabbitmq as task message queues. It is recommended to use redis.

- Mac system redis usage guide:

Installation command `brew install redis`;

Start command `redis-server`;

Test whether the redis service starts normally, and `redis-cli` tries to connect to the local redis service.

- Windows system redis usage guide

Download and installation address: [https://github.com/MicrosoftArchive/redis/releases](https://github.com/MicrosoftArchive/redis/releases)

Click redis-server.exe in the installation directory to start the redis service.

- Configuration items (modify the message queue configuration in the config/dev.py file)
```python
# Celery message queue settings RabbitMQ
# BROKER_URL = 'amqp://guest:guest@localhost:5672//'

# Celery message queue settings Redis
BROKER_URL = 'redis://localhost:6379/0'
```
### Configure hosts

Local hosts file needs to be modified and the following content added:

> **Note**: domain_name should be changed to the domain name of the PaaS platform

```bash
127.0.0.1 appdev.`{domain_name}`
```

### Configure local database

First, create a database in the MySQL command line:

```bash
CREATE DATABASE `{APP_CODE}` default charset utf8 COLLATE utf8_general_ci;
```

Then configure the local database account and password. You need to find the DATABASES configuration item in config/dev.py and modify it. USER and PASSWORD.

### Initialize the local database

In the project root directory, execute the following command to initialize the local database:

```bash
python manage.py migrate
```

If you encounter an error, please comment out the APP list in INSTALLED_APPS of config/default.py first, and then remove the comment after executing the command.

### Start the project

In the project root directory, execute the following command to start the project:

```bash
python manage.py runserver
```

Then visit appdev.`{domain_name}` in the browser to access the project homepage.

## Create a new application
### Execute django-admin startapp yourappname in the root directory
### Enter the yourappname directory and add urls.py
### Write logic code and route configuration code
### Add yourappname to INSTALLED_APPS in config/default.py

## Define model
### Define model in models.py in the newly created application

Official document: [Django Models](https://docs.djangoproject.com/en/3.2/topics/db/models/)

### Generate database change files

Execute the following command in the project root directory:

```bash
python manage.py makemigrations yourappname
```
After successful execution, a database change file will be generated and located in the migrations directory of the newly created APP.

### Effective database changes

Execute the following command in the project root directory:

```bash
python manage.py migrate yourappname
```

> **Note**: Before adding yourappname to INSTALLED_APPS in config/default.py, execute python manage.py migrate to initialize the database.

## Static resource usage specifications

- Static files are divided by modules and placed in the static directory of each corresponding APP in the Django project

Please place your Django static files xxx.js and xxx.css in the PROJECT_ROOT/APP_NAME/static/ directory. It is recommended to add another directory under static and name it APP_NAME, that is, the final template file storage path is PROJECT_ROOT/APP_NAME/static/APP_NAME[/js or /css], which is to avoid overwriting when looking for static files.

- After modifying the static files, manually run the python manage.py collectstatic command to collect static files into the static folder of the root directory.

- settings needs to include the STATIC_ROOT configuration.

```python
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
```

- The framework has configured a globally valid static directory, where all publicly used static resources can be placed.

```python
STATICFILES_DIRS = (
os.path.join(BASE_DIR, 'static'),
)
```

Where BASE_DIR is the project root directory path.

## Celery usage

Celery is a simple, flexible and reliable distributed system that handles a large number of messages and provides the necessary tools to maintain such a system.

It is a task queue focused on real-time processing and also supports task scheduling.

### Open Celery configuration

Modify the configuration in config/default.py:

```python
IS_USE_CELERY = True
```

### Add Celery tasks

Create a tasks.py file under app and add @task tasks:

```python
from celery import task

@task
def mul(x, y):
    return x * y
```
If the @task task function is not in the app/tasks.py file, you need to add the configuration in config/default.py:

```python
CELERY_IMPORTS = (
'testapp.tasks'
)
```

### Start the asynchronous task service celery worker

Execute in the root directory:

```bash
python manage.py celery worker -l info
```

### Start the periodic task service celery beat

Execute in the root directory:

```bash
python manage.py celery beat -l info
```

### Add a periodic task

Enter admin and add a record to the DJCELERY->Periodic_tasks table.

### How to automatically start the celery process when deploying on the platform
Modify the app_desc.yaml file in the project directory and add the following configuration:

```bash
module:
processes:
worker:
command: python manage.py celery worker --concurrency 4 -l info
beat:
command: python manage.py celery beat -l info
```

After deploying the application, you can see the new worker process in the "Process Management" page.

If you want to shut down celery, please follow the steps below:

- Change `IS_USE_CELERY` in the configuration file to False
- Delete the worker and beat processes in the app_desc.yaml file
- Redeploy the application after submitting the code changes

### Adjust the number of celery worker concurrency

- Official description of the CELERYD_CONCURRENCY parameter: [Official Document](https://docs.celeryq.dev/en/latest/userguide/configuration.html#worker-prefetch-multiplier)

- The current celery concurrency set by the development framework is 2. If you need to adjust it, there are 2 ways:

1) Add a variable with the KEY CELERYD_CONCURRENCY to the APP environment variables of the BlueKing platform and set the corresponding value (it is recommended to consult the platform maintenance colleagues before increasing it).

2) Modify the configuration in the APP directly, that is, modify the default value 2 of the following configuration in the config/default.py file to the value you want to set.

```python
CELERYD_CONCURRENCY = os.getenv('BK_CELERYD_CONCURRENCY', 2)
```

### Adjust the heartbeat packet sending time of celery and RabbitMQ
- Official description of the BROKER_HEARTBEAT parameter: [Official Document](https://docs.celeryq.dev/en/latest/userguide/configuration.html#broker-heartbeat)

- The BROKER_HEARTBEAT sending time set by the current development framework is 60, that is, a heartbeat packet is sent every 60 seconds. If you need to adjust it, there are the following methods:

Modify the configuration in the APP directly, that is, add the corresponding configuration in the config/default.py file, and the default configuration of the framework will be overwritten.

```python
# CELERY and RabbitMQ add 60-second heartbeat settings
BROKER_HEARTBEAT = 60
```

## Log usage

- Logging-related configuration methods reuse Django's configuration method: [Official documentation](https://docs.djangoproject.com/en/3.2/topics/logging/)

```python
import logging
logger = logging.getLogger('app') # Normal log
logger_celery = logging.getLogger('celery') # Celery log
logger.error('log your info here.')

# The second method
from blueapps.utils.logger import logger # Normal log
from blueapps.utils.logger import logger_celery # Celery log
logger.error('log your info here.')
```

- Log output path:

The local output path is in the logs directory at the same level as the project root directory directory.

```bash
- PROJCET_ROOT
- logs
    - APP_CODE
        - APP_CODE-celery.log
        - APP_CODE-component.log
        - APP_CODE-django.log
        - APP_CODE-mysql.log
```
- Log level configuration:

The default log level is INFO. To modify it:

1. For all environments, please modify the log level in the corresponding location of config/default.py:

```python

LOG_LEVEL = "DEBUG"

# load logging settings

LOGGING = get_logging_config_dict(locals())

```

2. If you only want to set the log level for a specific environment, uncomment the corresponding code in the corresponding environment configuration file (config/prod.py (only affects the production environment), config/stag.py (only affects the pre-release environment), config/dev.py (only affects the pre-local development environment)) and modify the log level:

```python

# Customize the local environment log level

from blueapps.conf.log import set_log_level # noqa

LOG_LEVEL = "DEBUG"

LOGGING = set_log_level(locals())

```

__Note__: This modification method depends on the blueapps version >= 3.3.1.

The meanings of different configurations are as follows:
1. DEBUG: underlying system information for debugging purposes
2. INFO: general system information
3. WARNING: indicates a minor problem.
4. ERROR: indicates a major problem.
5. CRITICAL: indicates a fatal problem.

## Exception handling

In order to reduce the judgment logic of function calls in the code, the BlueKing development framework proposes that developers should directly throw exceptions at the exception point and handle the exception through the Django middleware feature.

### Usage examples

```python
from blueapps.core.exceptions import ParamValidationError
def your_view_func(request):
  form = your_form(request.POST)
  if not form.is_valid():
    raise ParamValidationError(u'参数验证失败,请确认后重试')
  # do something you want
```
> **Note**: This is just a simple example. We strongly recommend that developers should directly throw exceptions wherever there is an error, rather than returning errors, and let the upper-level logic handle them.

### Introduction to exception types

The BlueKing development framework exception classes are mainly divided into two categories: client exceptions and server exceptions, which correspond to errors caused by client requests and errors caused by backend services, respectively. Developers can choose the exceptions to be thrown based on the scenario that caused the error.

- Namespace where the exception class is located

- blueapps.core.exceptions

- Server-side exception

| Error class | Description | http status code | Return error code | Scenario example |
| ------ | ---- | ----------- | ---------- | -------- |
| DatabaseError | Database exception | 501 | 0000501 | Failed to update database records |
| ApiNetworkError | Network exception causes remote service failure | 503 | 0000503 | Request to third-party interface fails due to network connection problem |
| ApiResultError | Remote service request result exception | 503 | 0000513 | Request to third-party result returns result is false |
| ApiNotAcceptable | Remote service return result format exception | 503 | 0000523 | Third-party interface returns result in xml format, but expected to return json format |

- Client-side exception

| Error class | Description | http Status code | Return error code | Scenario example |
| ------ | ---- | ----------- | ---------- | -------- |
| ParamValidationError | Parameter validation failed | 400 | 0000400 | Expected an integer parameter, the user provided a character parameter |
| ParamRequired | Request parameter missing | 400 | 0000401 | Expected parameter not found |
| RioVerifyError | Login request failed to be detected by the smart gateway | 401 | 0000415 | User login verification |
| BkJwtVerifyError | Login request failed to be detected by JWT | 401 | 0000425 | | User login verification |
| AccessForbidden | Login failed | 403 | 0000413 | User identity verification failed |
| RequestForbidden | Request denied | 403 | 0000423 | User attempted to operate a task for which he has no permission |
| ResourceLock | The requested resource is locked | 403 | 0000433 | The user attempted to operate a locked task |
| ResourceNotFound | The requested resource cannot be found | 404 | 0000404 | The model with the specified ID requested by the user cannot be found |
| MethodError | The request method is not supported | 405 | 0000405 | The request sent by the user is not within the expected range |