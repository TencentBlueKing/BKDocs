# Development Framework 2.0 Advanced Use

## Login Module

### Login Exemption

Currently, all view accesses require login authentication. Users can exempt some view login restrictions, mainly for providing external APIs.

```python
from blueapps.account.decorators import login_exempt

@login_exempt
def myview(request):
return "hello world"
```

## User Model acquisition & usage

### Get User Model

You can get User Model through `from blueapps.account import get_user_model`

### User method attribute description

- username

User unique identifier, such as QQ number

- nickname

User name for front-end display, such as QQ nickname

- avatar_url

User avatar URL

- get_full_name

Full user name for front-end display, such as QQ nickname

### User extended attribute description

- get_property(key)

User obtains horizontal extended attributes

```python
from blueapps.account import get_user_model

user = get_user_model().objects.get(username=xxx)
user.get_property(key)
```

- set_property(key,value)

User sets horizontal extension properties

```python
from blueapps.account import get_user_model

user = get_user_model().objects.get(username=xxx)
user.set_property(key, value)
```

### Use User as a foreign key in the template

```python
from django.conf import settings
from django.db import models

class SomeModel(models.Model):
person = models.ForeignKey(settings.AUTH_USER_MODEL, verbose_name=u"User")
```

### Django APP Administrator Settings

[Administrator Settings](../DevBasics/SAAS_ADMIN.md)

## Configuration modification guide

### settings Main configuration

__Note__: Do not modify settings.py. Please modify the configuration items in the files under the config directory.

Among them, if you modify the config/default.py configuration item, it will take effect on all running environments (official environment, pre-release environment, local environment);
Modifying the config/prod.py configuration item will only take effect on the official environment;
Modifying the config/stag.py configuration item will only take effect on the pre-release environment;
Modifying the config/dev.py configuration item will only take effect on the local development environment;
When multiple people are developing, in order to avoid the configurations in config/dev.py affecting each other, each developer can add a local_settings.py file in the project root directory to add different local development configurations for each developer, such as DATABASES, and ignore the local_settings.py file when submitting code.

- Customize Django APP

Please modify INSTALLED_APPS in config/default.py

- Customize middleware

Please modify MIDDLEWARE in config/default.py

- Customize database

If it is not necessary, please do not overwrite the default database. For the official environment and pre-release environment, modify config/prod.py and config/stag.py respectively, and use the DATABASES.update() method.
For the local environment, please modify DATABASES in config/dev.py.

- Customize log level

The default log level is INFO. To modify it:

1. For all log levels in all environments, modify the log level in the corresponding location of config/default.py:

```python

LOG_LEVEL = "DEBUG"

# load logging settings

LOGGING = get_logging_config_dict(locals())

```

2. If you only want to set the log level for a specific environment, uncomment the corresponding code in the corresponding environment configuration file (config/prod.py (only affects the production environment), config/stag.py (only affects the pre-release environment), config/dev.py (only affects the pre-local development environment)) and modify the log level:

```python

# Customize local environment log level

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

- Update static resource version number

Modify STATIC_VERSION in config/default.py.

- Add celery task

Add celery task module to CELERY_IMPORTS in config/default.py.

- Initialize administrator list

Please modify INIT_SUPERUSER in config/default.py. The people in the list will have administrator privileges for pre-release and official environments. Please modify before the first test and launch. Subsequent modifications will not take effect.

- Customize other configurations supported by Django

Please add the required configuration directly in config/default.py to override the default value.

### Using settings

In a Django app, you can use settings by importing the django.conf.settings object. For example:

```python
from django.conf import settings

if settings.DEBUG:
# Do something
```

__NOTE__: django.conf.settings is not a module - it's an object. So you can't import each individual setting

```python
from django.conf.settings import DEBUG # This won't work.
```

__NOTE__: Your code should not import from config.default.py or other settings files. django.conf.settings abstracts away the concept of default settings and site-specific settings; it presents a single interface. It also decouples your code from where your settings live.

## Custom middleware

- default.py is configured as follows

```python
MIDDLEWARE += (
# Your middleware
)
```

__Note__: Starting from Django 1.10, the middleware configuration item uses __`MIDDLEWARE`__. The MIDDLEWARE_CLASSES configuration item used by versions below 1.10 will no longer be supported after Django 2.0.

- midlleware development

Use the MIDDLEWARE configuration item to develop your middleware.

```python
from django.utils.deprecation import MiddlewareMixin

class MyCustomMiddleware(MiddlewareMixin):
# The methods supported by the middleware remain unchanged
def process_request(request):
...
def process_view(request, callback, callback_args, callback_kwargs):
...
def process_template_response(request, response):
...
def process_response(request, response):
...
def process_exception(request, exception):
...
```

__Note__: Your middleware class must inherit Django's MiddlewareMixin, and your middleware should try not to override the `__call__` and `__init__` methods, refer to the [official documentation](https://docs.djangoproject.com/en/3.2/topics/http/middleware/).

## Public methods

### blueapps.utils.logger

Provide commonly used logger, logger_celery

```python
from blueapps.util.logger import logger # Normal log
from blueapps.util.logger import logger_celery # Celery log
logger.error('log your info here.')
```