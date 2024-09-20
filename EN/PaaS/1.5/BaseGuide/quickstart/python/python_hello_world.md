# Develop Python Applications

This article will introduce how to develop a Django application on the BlueKing Developer Center. After completing the tutorial, you will understand:

- Basic concepts of the BlueKing Developer Center: BlueKing applications, application deployment, etc.
- How to use the development framework
- How to develop a simple BlueKing application

To successfully complete the tutorial, you need:

- Basic understanding of Python syntax
- Basic understanding of the Django web framework

> New to Python? We recommend that you learn the basics of Python before developing applications. [Python Learning Materials](https://www.python.org/doc/)

## Preparations

First, you need to create a BlueKing application by selecting `Python Development Framework` on the 'Application Development - Create Application' page of the BlueKing Developer Center.

After the application is created successfully, clone the development framework code to your local machine according to the instructions on the page.

## Development Environment Configuration

Before starting application development, you need to install Python and the third-party modules required by the BlueKing application on your machine.

The environment configuration method may vary slightly for different operating systems. Please follow the content for your operating system.

### 1. Install Python3

Define the Python version used by the project in the `runtime.txt` file (located in the project build directory, default is the root directory, and at the same level as `requirements.txt`). If there is no such file, the project will use Python 3.10 when deployed to the Developer Center.

To ensure consistency between local development and online environment, you can first check all supported Python versions on the platform at [Document: Custom Python Version](../../topics/paals/choose_python_version.md).

Visit the [Python official download page](https://www.python.org/downloads/) to download the Python version you need.

After installation, verify the installation by entering the **python3** command in the command line:

```bash
Python 3.6.8 (default, Jan 8 2020, 18:10:42)
[GCC X]
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

If you need to develop multiple Python projects at the same time, we recommend using [virtualenv](https://virtualenv.pypa.io/en/stable/) for environment management.
You can also try using [poetry](https://github.com/python-poetry/poetry).

### 2. Configure MySQL Database

To maintain consistency with the online environment of the application, we recommend using MySQL as the development database locally.

Visit the [MySQL official download page](http://dev.mysql.com/downloads/mysql/) to download and install MySQL version 5.7.

### 3. Install Python Third-Party Module Dependencies

Next, you need to install the third-party modules required by the BlueKing application. First, enter the source code directory of your BlueKing application, and then execute the command:

```shell
pip install -r requirements.txt
```

This command will install third-party dependencies including Django, PyMySQL / mysqlclient.

## Configure Environment Variables

When the application runs on the Developer Center, it mainly obtains various configuration information through environment variables.

When we develop applications locally, in order to simulate the same running environment as the platform as much as possible, we need to set at least the following environment variables:

- `BKPAAS_APP_ID`: bk_app_code, application ID, viewable on the application's "Basic Information" page
- `BKPAAS_APP_SECRET`: bk_app_secret, viewable on the application's "Basic Information" page
- `BKPAAS_MAJOR_VERSION`: "3", indicating deployment on PaaS3.0 Developer Center
- `BK_PAAS2_URL`: BlueKing Desktop address, viewable by clicking `View Built-in Environment Variables` on the environment variables page
- `BK_COMPONENT_API_URL`: BlueKing ESB API address, viewable by clicking `View Built-in Environment Variables` on the environment variables page
- `BKPAAS_LOGIN_URL`: BlueKing login service address, viewable by clicking `View Built-in Environment Variables` on the environment variables page

Different development environments have different methods for setting environment variables. Common methods include:

- [How to Set Environment Variables on Mac](https://apple.stackexchange.com/questions/106778/how-do-i-set-environment-variables-on-os-x)
- [How to Set Environment Variables on Windows](https://stackoverflow.com/questions/32463212/how-to-set-environment-variables-from-windows?noredirect=1&lq=1)

If you need to configure multiple sets of environment variables for different SaaS in local development, you can use some project-based environment variable setting schemes. Common methods include:

- [Set Environment Variables in PyCharm](https://stackoverflow.com/questions/42708389/how-to-set-environment-variables-in-pycharm): Run SaaS in PyCharm, and PyCharm will read different environment variable values according to different project configurations.
- [Set Environment Variables in virtualenv Postactive File](https://stackoverflow.com/questions/9554087/setting-an-environment-variable-in-virtualenv): This method requires using different virtual environments for different projects, and the corresponding environment variable values can be automatically loaded each time the virtual environment is activated.

## Configure Project Database Connection

First, please try to execute `python manage.py migrate` in the project directory to initialize the database data. This command may produce the following error messages:

### Error 1: 2003, "Can't connect to MySQL server on '... ..."

This error occurs because Django cannot connect to your MySQL database normally. First, please make sure that your database service is indeed running. Then open `configs/dev.py` and find the following code:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': APP_CODE,
        'USER': 'root',
        'PASSWORD': '',
        'HOST': '127.0.0.1',
        'PORT': '3306',
    },
}
```

Please modify the `USER`, `PASSWORD`, `HOST`, `PORT` in the above configuration to your correct configuration information, and then Django can connect to your database normally.

### Error 2: 1049, "Unknown database '... ..."

This error occurs because you have not created the MySQL database for your application. Please use the mysql client to connect to the database, replace the database name in the following statement with **Application ID**, and then execute:

```sql
mysql> CREATE DATABASE `... ...` default charset utf8 COLLATE utf8_general_ci;
Query OK, 1 row affected (0.01 sec)
```

After solving these problems, execute the `python manage.py migrate` command, and you will see output similar to the following:

```bash
$ python manage.py migrate
Operations to perform:
  Synchronize unmigrated apps: staticfiles, weixin, home_application, messages
  Apply all migrations: app_control, account, sessions, admin, sites, auth, contenttypes
Synchronizing apps without migrations:
  Creating tables...
    Running deferred SQL...
  Installing custom SQL...
Running migrations:
  Rendering model states... DONE
  Applying contenttypes.0001_initial... OK
... ...
```

This means that your database has been successfully initialized!

## Start the Development Server

### Configure hosts

First, you need to configure the hosts file locally and add the following content:

```bash
127.0.0.1 dev.xxx.xxx (Note: Must be on the same first-level domain as the PaaS platform main station)
```

### Start the Project Locally

Execute the following command in the project build directory (default is the root directory):

```python
python manage.py runserver 127.0.0.1:8000
```

Then visit http://dev.xxx.xxx:8000/ in your browser to see the project homepage.

## Develop Your First Hello World Application

- Add `home_application` to INSTALLED_APPS in config/default.py (already added by default)
- Add `url(r'^', include('home_application.urls'))` to urlpatterns in urls.py (already added by default)
- Add the following to home_application/views.py:

```python
from django.http import HttpResponse


def hello(request):
    return HttpResponse('Hello World!')
```

- Modify home_application/urls.py

```python
from django.conf.urls import url
from home_application import views

urlpatterns = [
    url(r'^$', views.hello),
]
```

Run the project again, and "the world is right before your eyes"!

## Publish Application

### Deploy Application

For information on deploying applications, you can read [How to Deploy BlueKing Applications](../../topics/paas/deploy_intro.md).

### Publish to Application Market

Before deploying to the production environment, you need:

- Complete your market information in 'Application Configuration' - 'Application Market'
- Deploy to the production environment

Then you can directly find your application in the application market.