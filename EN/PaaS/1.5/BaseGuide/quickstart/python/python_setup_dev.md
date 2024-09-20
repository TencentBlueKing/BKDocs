## How to Configure a Local Python Development Environment

## Configuring Local Environment Variables

When an application runs on the Developer Center, it primarily obtains various configuration information through environment variables.

When we develop applications locally, in order to simulate the runtime environment as closely as possible to the platform, we need to set at least the following environment variables:

- `BKPAAS_APP_ID`: bk_app_code, the application ID, can be found on the application's "Basic Information" page.
- `BKPAAS_APP_SECRET`: bk_app_secret, can be found on the application's "Basic Information" page.
- `BKPAAS_MAJOR_VERSION`: "3", indicating deployment on the PaaS3.0 Developer Center.
- `BK_PAAS2_URL`: the address of BlueKing Desktop, can be viewed by clicking `View Built-in Environment Variables` on the environment variables page.
- `BK_COMPONENT_API_URL`: the address of the BlueKing ESB API, can be viewed by clicking `View Built-in Environment Variables` on the environment variables page.
- `BKPAAS_LOGIN_URL`: the address of the BlueKing login service, can be viewed by clicking `View Built-in Environment Variables` on the environment variables page.

Different development environments have different methods for setting environment variables. Common methods include:

- [How to Set Environment Variables on Mac](https://apple.stackexchange.com/questions/106778/how-do-i-set-environment-variables-on-os-x)
- [How to Set Environment Variables on Windows](https://stackoverflow.com/questions/32463212/how-to-set-environment-variables-from-windows?noredirect=1&lq=1)

## Configuring the Development Environment

Before starting application development, your machine needs to have Python and the third-party modules required by the BlueKing application installed.

The method of environment configuration may vary slightly for different operating systems. Please follow the instructions for your operating system.

### 1. Install Python3

Define the Python version used by the project in the `runtime.txt` file (located in the project build directory, defaulting to the root directory if not set, and in the same directory as `requirements.txt`). If this file does not exist, the project will use Python 3.10 when deployed to the Developer Center.

To ensure consistency between local development and the online environment, you can first check all the Python versions supported by the platform in [Documentation: Custom Python Version](../../topics/paas/choose_python_version.md).

Visit the [Python official download page](https://www.python.org/downloads/) to download the Python version you need.

After installation, verify the installation by entering the **python3** command in the command line:

```bash
Python 3.6.8 (default, Jan  8 2020, 18:10:42)
[GCC X]
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

If you need to develop multiple Python projects at the same time, we recommend using [virtualenv](https://virtualenv.pypa.io/en/stable/) for environment management.
You can also try using [poetry](https://github.com/python-poetry/poetry).

### 2. Configure MySQL Database

To maintain consistency with the online application environment, we recommend using MySQL as the development database locally.

Visit the [MySQL official download page](http://dev.mysql.com/downloads/mysql/) to download and install MySQL version 5.7.

### 3. Install Python Third-Party Module Dependencies

Next, you need to install the third-party modules that the BlueKing application depends on. First, enter the source code directory of your BlueKing application, and then execute the command:

```shell
pip install -r requirements.txt
```

This command will install third-party dependencies including Django, PyMySQL / mysqlclient, etc.