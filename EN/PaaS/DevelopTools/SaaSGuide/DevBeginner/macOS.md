# Output Hello, World under macOS

Output `Hello, World!` based on `BlueKing Development Framework 2.0`

> Development language: `Python 3.6.X`
>
> Operating system: `macOS`

## Environment preparation

Install Python 3.6.X, prepare database, create application and prepare code repository address, virtual environment (optional)

### Install Python 3.6.X

Download and install [Python 3.6.X](https://www.python.org/downloads/)

### Deploy MySQL

- [Download MySQL from the official website](https://dev.mysql.com/downloads/mysql/)

- Modify user environment variables and MySQL password

```bash
export PATH=$PATH:/Users/{YOUR_USERNAME}/Library/Python/3.7/bin:/usr/local/mysql/bin/
mysqladmin -uroot -p password {new_password}
```

### Create an application

Before creating an application, you need to prepare a code repository (Git/SVN) in advance. `Git` is recommended.

- Create a code repository

For example, `GitHub` or `GitLab`

- Create an application in the Developer Center

Enter `Developer Center` - `Application Creation`, fill in the `git` repository address and account obtained in the previous step, and after successful creation, you will get `Application ID:{APP_CODE}` and `Application TOKEN:{SECRET_KEY}`. These two variables will be used later.

### Prepare virtual environment

- [Modify pip source](https://pip.pypa.io/en/stable/user_guide/#config-file) (domestic mirror)

```bash
vim ~/.pip/pip.conf
```

```bash
[global]
trusted-host = pypi.tuna.tsinghua.edu.cn
index-url = https://pypi.tuna.tsinghua.edu.cn/simple/
```

- Install [pipenv](https://zhuanlan.zhihu.com/p/37581807)

```bash
pip3 install pipenv
```

- Create virtual environment

```bash
pipenv install
```

- Activate virtual environment

```bash
pipenv shell
```

## Initialize development framework

### Download development framework

- Download development framework `http://{PAAS_URL}/guide/newbie/#step3`

`{PAAS_URL}` is the access address of BlueKing PaaS, such as `paas.blueking.com`

- Install the framework dependency package

```bash
pip3 install -r requirements.txt
```

### Configure environment variables

Modify `BK_URL` in config/\_\__init\_\_.py
```bash
BK_URL = os.getenv("BK_PAAS_HOST")
```

Add environment variables

BK_PAAS_HOST=`PaaS_URL`
APP_ID=`APP_CODE`
APP_TOKEN=`SECRET_KEY`(Application TOKEN)

The methods for setting environment variables are different in different development environments. Commonly used ones are:

- [How to set environment variables on Mac](https://apple.stackexchange.com/questions/106778/how-do-i-set-environment-variables-on-os-x)

### Create and initialize the database

Open the `MySQL` command line and execute

```bash
CREATE DATABASE `{APP_CODE}` default charset utf8 COLLATE utf8_general_ci;
```

> If {APP_CODE} contains a hyphen (-), you need to use backticks (`) to translate it, otherwise an error will be reported

> `ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '-blueking' at line 1`

And modify the `DATABASES` configuration item in `config/dev.py`

- Initialize local database (in the project root directory)

```bash
python manage.py migrate
```

### Start local project

- Modify local hosts first

```127.0.0.1 appdev.{PAAS_URL}```

- Start project

```bash
python manage.py runserver appdev.{PAAS_URL}:8000
```

- Local access

Use a browser to access `http://appdev.{PAAS_URL}:8000`, and you can see the development framework

![Development framework homepage](../assets/usage-index.png)

## Hello, World

- Modify view home_application/views.py

```python
from django.http import HttpResponse
def hello(request):
return HttpResponse('Hello World!')
```

- Add route home_application/urls.py

```python
url(r'^$', views.hello),
```

- Re-run `runserver`, or save in `Visio Studio Code` to automatically re-run

![-w964](../assets/15585122671345.jpg)