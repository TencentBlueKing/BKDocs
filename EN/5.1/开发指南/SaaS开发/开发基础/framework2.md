### Development framework 2.0 instructions.

## 1. Directory structure description.

### 1.1 Project directory structure.

```
- blueapps                    # Python development framework module
- blueking                    # ESB call module
- config                      # Application configuration directory
  - __init__.py               # App RUN_VER（ieod/clouds/qcloud）、APP_CODE and SECRET_KEY Configuration
  - dev.py                    # Local development configuration (shared by development team)
  - default.py                # Global configuration
  - prod.py                   # Production environment configuration
  - stag.py                   # Pre release environment configuration
- home_application            # Django template application example
  - __init__.py
  - admin.py
  - urls.py
  - models.py
  - tests.py
  - views.py
  - templates                 # Django template
    - home_application
      - contact.html          # Contact us home page
      - dev_guide.html        # Development guidelines
      - index_home.html       # Home page
- mako_templates              # Mako template public file
  - base.mako                 # The basic file of Mako template, from which other pages can inherit
- mako_application            # Application example of mako template
  - __init__.py
  - admin.py
  - urls.py
  - models.py
  - tests.py
  - views.py
  - mako_templates            # Template
    - mako_application
      - contact.html          # Contact us home page
      - dev_guide.html        # Development guidelines
      - index_home.html       # Home page
- static                      # Public static file
  - js                        # Public js
    - csrftoken.js            # CSRFTOKEN
    - settings.js             # Exception handling
- templates                   # Public template file
  - admin                     # admin template file
    - base_site.html
    - login.html
  - base.html                 # Django template base file, from which other pages can inherit
- manage.py                   # Django project manage
- requirements.txt            # List of dependent python packages
- settings.py                 # Django project settings
- urls.py                     # Django project primary route url configuration
- wsgi.py                     # WSGI configuration
- runtime.txt                 # Python version configuration file, which points to python version 3.6.2 by default
```


### 1.2 Common configuration description.

- App basic information. 
You can view app basic information in config/\__init\__.py. Please modify： APP_CODE 、SECRET_KEY （For app certification）and BK_URL(url of blueking saas platform). RUN_VER is the paas version of the current app. Please do not modify it.

- App runtime. 
There is a RUN_MODE variable in config/dev.py, config/stag.py and config/prod.py to mark the app runtime (DEVELOP: Local environment, STAGING: Pre release environment, PRODUCT: Formal environment). Please do not modify it.

- Log level and path. 
The default log level of the development framework is INFO. You can modify the LOG_LEVEL variable in config/default.py, which will take effect on all running environments. You can also modify the files config/dev.py, config/stag.py and config/prod.py separately. For details, please refer to "8. Log usage".
You don't need to care about the log path of the online running environment. These development frameworks have been automatically configured for you. The local logs are placed in the logs directory at the same level as the root directory of the project, named after APP_CODE. Among them, {APP_CODE}-django.log is the application log, {APP_CODE}-celery.log is the cellery log, {APP_CODE}-component.log is the component log, {APP_CODE}-mysql.log is the database log.

- Database configuration.
For local database configuration, please modify the databases variable in config/dev.py. for multi-user cooperative development, it is recommended to create a new local_settings.py file in the root directory, configure the DATABASE variable, and ignore local_settings.py in version control. This is good for preventing code conflicts caused by local configuration inconsistency during multi-user cooperative development.


## 2. Construction of development environment(python).

### 2.1 Install python(3.6).

If the python2 version is already installed in the system, you can refer to the python version switch to understand the solution of the coexistence of python3 and python2.


### 2.2 Install Mysql(5.5 Above).


### 2.3 Install setuptools、pip and project dependence.

```bash
pip install -r requirements.txt

```

> Note：Due to the existence of mysqlclient in the dependency, the module has a dependency on the c environment. Developers can refer to [Project Home](https://github.com/PyMySQL/mysqlclient-python#install) Installation instructions.
>
> Pymysql is not used here because the module is compatible [problem](https://github.com/PyMySQL/PyMySQL/issues/790) with django2.2.

### 2.4 Install local development tools.

It is recommended to use pycharm for code development, TortoiseSVN for SVN management and sourcetree for GIT management.


### 2.5 Install celery(Projects requiring background tasks).

celery==3.1.25 and django-celery==3.2.1 are automatically installed when you install project dependencies. At present, cellery supports redis and rabbitmq as message queues of tasks. Redis is recommended.

- mac system redis User Guide：
Installation instructions `brew install redis`；
Boot instruction `redis-server`；
Test whether the redis service starts normally and `redis-cli` attempts to connect to the local redis service.

- Windows redis User Guide：
Download address: https://github.com/MicrosoftArchive/redis/releases.
Click redis-server.exe in the installation directory to start the redis service.

- Configuration item(Modify message queuing configuration in config/dev.py file).

```python
# Celery message queuing settings rabbitmq.
BROKER_URL = 'amqp://guest:guest@localhost:5672//'

# Celery message queuing settings redis.
BROKER_URL = 'redis://localhost:6379/0'
```

> > Note：Because there are compatibility problems with redis-3.0 or later version, when installing redis module, please add version control`redis>=2.10.6,<3`.

### 2.6 Configure hosts.

You need to modify the hosts file locally and add the following：

> **Note**： Domain name should be changed to the domain name of paas platform

```
127.0.0.1 appdev.`{domain_name}`
```


### 2.7 Configure local database.

First, create the database under MySQL command line：

```bash
CREATE DATABASE  `{APP_CODE}` default charset utf8 COLLATE utf8_general_ci; 
```

Then configure the local database account password. You need to find the databases configuration item in config/dev.py, and modify USER and PASSWORD.


### 2.8 Initialize local database.

Execute the following command in the root directory of the project to initialize the local database：

```bash
python manage.py migrate
```

If you encounter an error, please comment out the APP list in INSTALLED_APPS of config/default.py first, and then remove the comment after executing the command.


### 2.9 Startup project.

Start the project by executing the following command in the project root directory：

```bash
python manage.py runserver
```

Then visit appdev.`{domain_name}` in the browser to access the project homepage.

![image-20190505204958140](../assets/usage-index.png)


## 3. new application.


### 3.1 Execute at root django-admin startapp yourappname.


### 3.2 Enter the directory of yourappname and add urls.py.


### 3.3 Write logic code and route configuration code.


### 3.4 Add yourappname to INSTALLED_APPS of config/default.py.


## 4. Define model.


### 4.1 In the new application, model.py defines model.

Official documents： [Django Models](https://docs.djangoproject.com/en/1.11/topics/db/models/)


### 4.2 Generate database change file.

Execute the following command in the root directory of the project：

```bash
python manage.py makemigrations yourappname
```

After successful execution, a database change file will be generated, which is located in the migrations directory of the new app.


### 4.3 Effective database changes.

Execute the following command in the root directory of the project：

```bash
python manage.py migrate yourappname
```

__Note__：Before adding yourappname to the INSTALLED_APPS of config/default.py, execute python manage.py migrate to initialize the database.


## 5. using templates.

The development framework supports two template rendering engines, django and mako. Each App maintains its own template file in django project. The following APP_NAME represents django app name.


### 5.1 How to use django template files (specific syntax is not discussed here).

Please put your django template file xxx.html under the directory `PROJECT_ROOT/APP_NAME/templates/`. It is recommended to add a layer of directory under templates, named APP_NAME, that is, the final template file storage path is `PROJECT_ROOT/APP_NAME/templates/APP_NAME`. This is to avoid overwriting when looking for template files.
Use the render method supported by django native for template rendering.

```python
from django.shortcuts import render

def index(request):
    return render(request, 'APP_NAME/index.html', {})
```

render function takes three arguments：
* First parameter is request object.
* Second parameter is  template path. Starting from the APP templates directory, the corresponding full path here is PROJECT_ROOT/APP_NAME/templates/APP_NAME/index.html. Please do not add' / 'before it, otherwise it will be recognized as an absolute path, and the corresponding template cannot be found.
* Third parameter is the template context passed in to replace the variables in the template.

> Why do I need to add another layer of directory named APP_NAME under the templates directory？
> Assume settings INSTALLED_APPS = ('app1', 'app2')，the project list is as follows
> ```
> PROJCET_ROOT
> |__ app1
> |__ __ templates
> |__ __ __ index.html
> ...
> |__ app2
> |__ __ templates
> |__ __ __ index.html
> ```
>
> When we use the `render(request, 'index.html', {})` statement in app2.views for rendering, the django framework searches template files in the order of INSTALLED_APPS installation by default, which will match to the `app1/templates/index.html` file for rendering, resulting in unexpected results. So we recommend directory design like `PROJECT_ROOT/APP_NAME/templates/APP_NAME`
>


### 5.2 How to use Mako template file.

Mako template files are roughly the same as django template files. The only difference is that Mako template files are placed under the PROJECT_ROOT/APP_NAME/mako_templates/ directory. It is also recommended to add a layer of directory under Mako, named APP_NAME, and the final template file storage path is PROJECT_ROOT/APP_NAME/mako_templates/APP_NAME.

__Note__：For security reasons, it is strongly recommended that users use django templates instead of mako to render to prevent xss attacks.

### 5.3 Template-Context. Template variables provided by platform framework.

The template variables listed here do not need to be passed in by the user when rendering the template. They can be accessed directly in the template file and used directly.

```python
context = {
    'STATIC_URL': settings.STATIC_URL,                    # Local static file access
    'APP_PATH': request.get_full_path(),                  # The current page，It is mainly used for jump of login_required
    'RUN_MODE': settings.RUN_MODE,                        # run mode
    'APP_CODE': settings.APP_CODE,                        # "app_code" registered in blueking system
    'SITE_URL': settings.SITE_URL,                        # URL prefix
    'REMOTE_STATIC_URL': settings.REMOTE_STATIC_URL,      # Remote static resource url
    'STATIC_VERSION': settings.STATIC_VERSION,            # Static resource version number, used to indicate that the browser updates the cache
    'BK_URL': settings.BK_URL,                            # BlueKing platform URL
    'USERNAME': username,                                 # username
    'NICKNAME': nickname,                                 # user nickname
    'AVATAR_URL': avatar_url,                             # user avatar
}
```


## 6. Static resource usage specification.

- Static files are divided by modules and placed in the static directory of each corresponding app in django project.
Please put your django static files xxx.js and xxx.css under the PROJECT_ROOT/APP_NAME/static/ directory. It is recommended to add a layer of directory under static, named APP_NAME, that is, the final template file storage path is PROJECT_ROOT/APP_NAME/static/APP_NAME[/js或者/css]. This is to avoid overwriting when looking for static files.

- After modifying the static file, run the python manage.py collectstatic command manually to collect the static file into the static folder of the root directory.

- Settings need to include STATIC_ROOT configuration.

```python
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
```

- The framework has configured a globally valid static directory where all static resources that are publicly used can be placed.

```python
STATICFILES_DIRS = (
    os.path.join(BASE_DIR, 'static'),
)
```

Where BASE_DIR is the project root path.


## 7. Celery usage.


### 7.1 Open Celery configuration.

Modify the configuration in config/default.py：

```python
IS_USE_CELERY = True
```


### 7.2 Add Celery tasks.

Create tasks.py file under app and add @task task：

```python
from celery import task

@task
def mul(x, y):
    return x * y
```

If the @task task function is not in the app/tasks.py file, you need to add the configuration in config/default.py：

```python
CELERY_IMPORTS = (
    'testapp.tasks2'
)
```


### 7.3 Start the asynchronous task service celery worker.

Execute at root：

```bash
python manage.py celery worker -l info
```


### 7.4 Start the periodic task service celery beat.

Execute at root：

```bash
python manage.py celery beat -l info 
```


### 7.5 Add periodic task.

Enter admin, Add a record to the DJCELERY->Periodic_tasks table.


### 7.6 How to automatically start the celery process during platform deployment.

Modify IS_USE_CELERY = True, And when the SaaS is released during the test, check the use celery task

### 7.7 Adjust the concurrent number of celery worker.

- Official description of CELERYD_CONCURRENCY parameters：

http://docs.celeryproject.org/en/v2.2.4/configuration.html#celeryd-prefetch-multiplier

- At present, the concurrent number of celery set by the development framework is 2. There are two ways to adjust it:

1）In the app environment variable of blueking platform, add the variable with KEY as CELERYD_CONCURRENCY, and set the corresponding value (it is recommended to consult the platform maintenance colleagues before increasing).
2）Directly modify the configuration in app, that is, modify the default value 2 of the following configuration in config/default.py file to the value you want to set.

```python
CELERYD_CONCURRENCY = os.getenv('BK_CELERYD_CONCURRENCY', 2)
```


## 8. Log usage.

- Log related configuration reuse Django configuration.

   https://docs.djangoproject.com/en/1.11/topics/logging/#using-logging

```python
import logging
logger = logging.getLogger('app')       # General journal
logger_celery = logging.getLogger('celery')   # celery log
logger.error('log your info here.')

# The second way
from blueapps.util.logger import logger         # General journal
from blueapps.util.logger import logger_celery  # celery log
logger.error('log your info here.')
```

- Log output path：

The local output path is in the logs directory level with the project root directory.
``` 
- PROJCET_ROOT
- logs
    - APP_CODE
        - APP_CODE-celery.log
        - APP_CODE-component.log
        - APP_CODE-django.log
        - APP_CODE-mysql.log
```

- Log level configuration：

The default log level is INFO. To modify, add the following code in config/default.py or config/prod.py(Only affect the production environment), config/stag.py(Pre release environment only), config/dev.py(Pre local development environment only).

```python
import logging
logger = logging.getLogger('app')
logger.setsetLevel('DEBUG')
logger.setsetLevel('INFO')
logger.setsetLevel('WARNING')
logger.setsetLevel('ERROR')
logger.setsetLevel('CRITICAL')
logger_celery = logging.getLogger('celery')
logger_celery.setsetLevel('DEBUG')
logger_celery.setsetLevel('INFO')
logger_celery.setsetLevel('WARNING')
logger_celery.setsetLevel('ERROR')
logger_celery.setsetLevel('CRITICAL')
```


## 9. Exception handling.

In order to reduce the logic of judging function calls in code, blueking development framework proposes that developers should throw an exception directly at the exception, and handle the exception through the features of Django middleware.


### 9.1 Use sample.

```python
from blueapps.core.exceptions import ArgsMissing
def your_view_func(request):
  form = your_form(request.POST)
  if not form.is_valid():
    raise ArgsValidateFailed('Parameter validation failed, please confirm and try again')
  # do something you want.
```

__Note__：This is just a simple example. We strongly suggest that developers should throw exceptions directly wherever there are errors, instead of returning errors, which should be handled by the upper logic.


### 9.2 Exception type introduction.

BlueKing development framework anomalies are mainly divided into two categories：Client exceptions and server exceptions，Corresponding to errors caused by client requests and background services respectively. The developer can choose the exception to be thrown according to the scenario causing the error.

- Namespace of exception class.

	- blueapps.core.exceptions

- Server exception.

| Error class | Explain | http status code | Return error code | Scenario examples |
| ------ | ---- | ----------- | ---------- | -------- |
| DatabaseError | Database exception  |  501 |  50110 | Failed to update database record |
| ApiNetworkError | Remote service failure caused by network exception | 503 | 50301 | Request for third party interface failed due to network connectivity issues |
| ApiResultError | Remote service request result exception | 503 | 50302 | Request third-party result return result is false |
| ApiNotAcceptable | Remote service returned result format exception | 503 | 50303 | The third-party interface returned the result in XML format, but expected to return JSON format |

- Client exception.

| Error class | Explain | http status code | Return error code | Scenario examples |
|  ------ |  ----  |  -----------  |  ----------  |  --------  |
| ResourceNotFound | Requested resource not found  |  404 |  40400 | A model with a specified ID requested by the user could not be found |
| ArgsValidateFailed | Parameter validation failed | 400 | 40000 | Expecting to provide a character parameter for the shaping parameter |
| ArgsMissing | Request parameter missing | 400 | 40001 | Expected parameter not found |
| AccessForbidden | Login failed | 403 | 40301 | User authentication failed |
| RequestForbidden | Request rejection | 403 | 40320 | User attempted to operate on a task without permission |
| ResourceLock | Request resource locked | 403 | 40330 | User attempted to operate a locked task |
| MethodError | Request method not supported | 405 | 40501 | The request sent by the user is not within the expected range |