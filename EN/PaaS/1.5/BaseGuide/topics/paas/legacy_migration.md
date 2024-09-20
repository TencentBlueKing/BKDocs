# Migration Guide from PaaS 2.0 to PaaS 3.0

The application migration provides a complete mechanism that supports seamless migration of applications from an older version of the `PaaS` platform to a new cluster. During this process, the system will automatically create relevant information for the old application and apply for resources.

What users need to handle is to verify the service in the new version environment after successful deployment, confirming that the service is normal (including: web pages/celery scheduled tasks/celery asynchronous tasks/calling backend services/involving authorized service access), etc. After confirming that everything is normal, click to confirm the migration, and the desktop entry will switch to the new version service.

## How to Migrate Applications from PaaS 2.0

PaaS 3.0 provides a [one-click migration] feature that can quickly migrate old applications with one click and supports rolling back at any time. One-click migration transfers the basic information and environment variables of the application to PaaS 3.0, and you still need to manually deploy the application in the PaaS 3.0 Developer Center after modifying the code according to the guidelines below.

## Code Changes Required for Migration of Old Applications

### 1. Modifications to blueapps

First, confirm the Django version used by the application, which can be viewed in the `requirements.txt` file in the code repository. Please follow the guidelines according to the Django version:

#### Django 2.x

For Django versions 2.x and above, it is recommended not to maintain the content of blueapps in the project repository but to reference it directly through the pypi package.

1. Delete the `blueapps` folder in the code repository

2. Add blueapps and gunicorn to the project's `requirements.txt` file and remove uWSGI

```
# paas3.0 requirement
blueapps==4.4.2
gunicorn==19.6.0
```

3. Add a `runtime.txt` file to the project build directory (default is the root directory if not set), which defines the Python version as 3.6.12

```
python-3.6.12
```

#### Django 1.11.x

1. Download the [blueapps4.2.2](https://pypi.org/project/blueapps/4.2.2/) package and replace the following three files in the `blueapps` directory in the code repository:

```
blueapps/account/sites/open/conf.py
blueapps/conf/__init__.py
blueapps/patch/settings_open_saas.py
```

2. Add gunicorn to the project's `requirements.txt` file and remove uWSGI

```
# uWSGI==2.0.13.1

# paas3.0 requirement
gunicorn==19.6.0
```

3. Add a `runtime.txt` file to the project build directory (default is the root directory if not set), which defines the Python version as 2.7.18

```
python-2.7.18
```

### 2. Modifications to blueking

1. Delete the `blueking` folder in your code repository

2. Download the latest [Python Development Framework](../../../../../DevelopGuide/7.0/DevTools.md) package from the official website

3. Place the `app_desc.yaml` file and `blueking` folder from the downloaded framework\_\*.tar.gz development framework package into the build directory of your code (default is the root directory if not set)

### 3. Configuration Modifications

1. Add the following content to the `config/__init__.py` file

```
# SaaS Application ID
APP_CODE = os.getenv("BKPAAS_APP_ID")
# SaaS Security Key, please do not disclose this key
SECRET_KEY = os.getenv("BKPAAS_APP_SECRET")
# PAAS Platform URL
BK_URL = os.getenv("BKPAAS_URL")
# ESB API Access URL
BK_COMPONENT_API_URL = os.getenv("BK_COMPONENT_API_URL")
```

2. Confirm whether there are definitions for services such as Mysql and Redis in the `config/stag.py` and `config/prod.py` files

- The information for DATABASES has already been defined in the development framework and can be directly deleted from these two files, or changed to the following environment variables

```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': os.environ.get('MYSQL_NAME'),
        'USER': os.environ.get('MYSQL_USER'),
        'PASSWORD': os.environ.get('MYSQL_PASSWORD'),
        'HOST': os.environ.get('MYSQL_HOST'),
        'PORT': os.environ.get('MYSQL_PORT'),
    }
}
```

- Redis needs to be modified to use the following environment variables

```
REDIS_HOST = os.environ.get('REDIS_HOST')
REDIS_PORT = int(os.environ.get('REDIS_PORT'))
REDIS_PASSWORD = os.environ.get('REDIS_PASSWORD')
```

3. Search the entire text for uses of `BK_URL` and modify as follows if used:

- For calling ESB APIs, such as {BK_URL}/api/c/compapi, it needs to be modified to use BK_COMPONENT_API_URL
- For concatenating login addresses, such as BK_URL + "/login/", replace it with the environment variable BKPAAS_LOGIN_URL
- For concatenating desktop addresses, such as BK_URL + "/console/", replace it with the environment variable BKPAAS_CONSOLE_URL

### References

1. For modifications to Django 2.x applications, please refer to: [https://github.com/unixhot/opsany-bastion/pull/2/files](https://github.com/unixhot/opsany-bastion/pull/2/files)

2. For modifications to Django 1.11.x applications, please refer to the repository: [https://github.com/jiayuan929/bk-framework-v2/pull/1/files](https://github.com/jiayuan929/bk-framework-v2/pull/1/files)

## What's Changed in the New Developer Center?

### Changes in Environment Variables

Due to the updates and iterations of the BlueKing PaaS platform, the built-in environment variables have also been changed accordingly.

1. The following new environments have been added

| Variable Name               | Description                                                                                                     |
| -------------------- | -------------------------------------------------------------------------------------------------------- |
| BKPAAS_MAJOR_VERSION | BKPAAS_MAJOR_VERSION=3 indicates deployment in the PaaS3.0 Developer Center                                                     |
| BK_PAAS2_URL         | PaaS2.0 platform access address, same as PaaS2.0's BK_PAAS_HOST, where the console, login, and esb addresses are all concatenated by this value |
| BK_LOGIN_URL         | Unified login service access address, equivalent to BK_PAAS_HOST + "/login/"                                                    |
| BKPAAS_LOGIN_URL     | Unified login service access address, equivalent to BK_PAAS_HOST + "/login/"                                                    |
| BKPAAS_CONSOLE_URL   | BlueKing desktop access address, equivalent to BKPAAS_INNER_HOST + "/console/"                                                |
| BK_COMPONENT_API_URL | ESB API access url                                                                                         |

1. The values of the following environment variables have changed

| Variable Name               | PaaS2.0 Developer Center | PaaS3.0 Developer Center | Explanation                       |
| -------------------- | ------------------ | ------------------ | -------------------------- |
| BKPAAS_ENGINE_REGION | open               | default            | The log platform loads configuration based on this value |

3. The keys of the following environment variables have changed

Note: In PaaS2.0, `BK_PAAS_HOST` is used as the domain name for the ESB API, which must be changed to `BK_COMPONENT_API_URL` in PaaS3.0

| PaaS2.0 Developer Center | PaaS3.0 Developer Center                                                                             | Explanation                                   |
| ------------------ | ---------------------------------------------------------------------------------------------- | -------------------------------------- |
| APP_ID             | BKPAAS_APP_ID                                                                                  | bk_app_code                            |
| APP_TOKEN          | BKPAAS_APP_SECRET                                                                              | bk_app_secret                          |
| BK_PAAS_HOST       | BK_PAAS2_URL                                                                                   | PaaS2.0 platform access address (platform entry)       |
| BK_PAAS_INNER_HOST | BK_PAAS2_URL                                                                                   | PaaS2.0 platform internal network access address               |
| DB_TYPE            | None                                                                                             | Database type                             |
| DB_HOST            | MYSQL_HOST                                                                                     | Database address                             |
| DB_PORT            | MYSQL_PORT                                                                                     | Database port                             |
| DB_NAME            | MYSQL_USER                                                                                     | Database name                             |
| DB_USERNAME        | MYSQL_NAME                                                                                     | Database user                             |
| DB_PASSWORD        | MYSQL_PASSWORD                                                                                 | Database password                             |
| BK_BROKER_URL      | f'amqp://{RABBITMQ_USER}:{RABBITMQ_PASSWORD}@{RABBITMQ_HOST}:{RABBITMQ_PORT}/{RABBITMQ_VHOST}' | Use RabbitMQ as the celery backend message queue |

For a list of built-in environment variables, please refer to [Built-in Environment Variables Explanation](./builtin_configvars.md)

### Changes in Access Entry Addresses

Before application migration, all applications within the platform's internal version used the desktop domain as the root domain. After application migration, the access entry for platform applications has changed. The v3 platform provides two types of built-in access addresses, which can be viewed in 'APP Engine - Access Entry'.

- **Independent Subpath**, using the mounted subpath to distinguish the access entry for each application
- **Independent Subdomain**, using the root domain provided by the platform, distinguishing the access entry for each application with a second-level domain

In PaaS2.0, applications that used `{BK_PAAS_HOST}/o/{APPID}` to concatenate the access address of other applications need to change to service discovery configuration in PaaS3.0.

#### Service Discovery Configuration (svc_discovery)

To use this feature, developers need to create a configuration file named `app_desc.yml` in the root directory of the application and then fill in the configuration information that meets the format requirements. Based on these configuration information, developers can achieve custom market configurations, add environment variables, and other functions.

> PaaS3.0 S-mart applications also use the `app_desc.yml` file to describe the configuration of BlueKing applications.

Developers can configure dependent services and other related information for the application's service discovery through this field.

- `bk_saas`: (array[string]) A list of other BlueKing application app codes that the application depends on. After this item is configured, the platform will inject the access addresses of all applications in the list into the environment variables after the application is deployed.

For example, if the application uses the following configuration:

```yaml
svc_discovery:
  bk_sa as:
    - "bk-iam"
    - "bk-user"
```

After the application is deployed, it can read the access addresses of the `bk-iam` and `bk-user` applications through the environment variable named `BKPAAS_SERVICE_ADDRESSES_BKSAAS`.

The value of this environment variable is a base64-encoded Json object, with the object format being:

```json
{
  // {bk_app_code}: {address}
  "bk-iam": "http://bk-iam.example.com",
  "bk-user": "http://bkapps.example.com/bk-user/"
}
```

> Note: Regardless of whether the applications listed in the `bk_saas` dependency application list have been deployed on the platform, the platform will write the access addresses of the dependent applications to the environment variables. These addresses are generated by the platform according to rules and may take some time to provide normal services. Therefore, developers need to handle the situation where the dependent application services are unavailable when writing business code.

**Appendix: How to Get and Parse the Value of `BKPAAS_SERVICE_ADDRESSES_BKSAAS` Using Python**

```python
# Only applicable to Python3
>>> import json
>>> import base64
>>> import os
>>> value = os.environ['BKPAAS_SERVICE_ADDRESSES_BKSA️AS']
>>> decoded_value = json.loads(base64.b64decode(value).decode('utf-8'))
>>> decode_value
{'bk-iam': ...}
```

### Application Startup Method

In the PaaS2.0 Developer Center, all applications are fixed to start with uwsgi. This approach has several drawbacks:

- The startup method is not flexible. For example, some high-performance applications are more suitable for using gunicorn
- It can only support Celery as an auxiliary process and is helpless in the face of personalized needs.

Therefore, PaaS3.0 adopts the application description file `app_desc.yaml` method, giving users the ability to customize process types and custom process startup methods. If you want to learn more about application processes and related content, please read [Application Processes](./process_procfile.md).

### Usage of RabbitMQ and Other Services

The PaaS3.0 Developer Center provides pluggable multiple enhanced services, including RabbitMQ, object storage, etc. If you need to use Celery for background tasks, you need to manually enable RabbitMQ in the enhanced services.

It is worth noting that enabling it only adds a binding relationship, and the actual resources will be applied for during the deployment of the corresponding environment.

### Other Issues

1. PaaS2.0 handled operations such as django migrate, which can be processed in PaaS3.0 by generating [Pre-release Commands](./release_hooks.md);
2. PaaS2.0 automatically proxies static resource files of applications through Nginx, which is not supported in PaaS3.0. Related Smart applications need to add whitenoise middleware to re-package;
3. S-mart applications may switch between encrypted and non-encrypted versions when uploading, causing build failures. Disabling virtualenv caching in slug-pilot can solve this issue.