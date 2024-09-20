# How to Conduct Frontend and Backend Separation Development

## Overview

For the frontend, we take the BlueKing application frontend development framework as an example, implemented using Node.js + Vue.js. The frontend serves as the default access entry for the application and is placed in the **default** module.

For the backend, we take the BlueKing application development framework as an example, providing a Python + Django REST API service, placed in the **backend-api** module.

The source code repositories and enhanced services bound to the frontend and backend modules are isolated, allowing for independent development and deployment of the frontend and backend modules.

## Creating Frontend and Backend Modules

### Creating an Application

First, we create a Node.js application in the BlueKing Developer Center and initialize the code with the `BlueKing Application Frontend Development Framework`. After successful creation, on the module management page, we can see the newly created Node.js application placed in the default **default** module.

After the application is successfully deployed, we can access a purely frontend application. The user information interface is provided by the frontend module. Next, we will create a backend module to provide this API service.

### Creating a Backend Module

On the 'Module Configuration' page, click `Add Module` to create a backend Python module and initialize the code with the `BlueKing Development Framework` (for regular applications, you can click `Add Module` in the module dropdown list).

After the backend **backend-api** module is successfully deployed, you can access the default user interface provided by the framework: `account/get_user_info/`.

### Modify User Information to Backend API

Modify the frontend module code to call the API of the backend module, achieving frontend and backend separation:

- In the _build/stag.env.js_ file, set **AJAX_URL_PREFIX** to the domain of the backend module: `http://stag-dot-backend-api-dot-{your-appid}.example.com`

- In _src/store/index.js_, modify the interface for obtaining user information to call the API of the backend module

**Note**: This example modifies the staging environment configuration. You can modify the local development configuration in *build/dev.env.js* and the production environment configuration in _build/prod.env.js_.

After making the modifications, you can run the frontend module locally according to the steps in the `README.md` file in the frontend module, or redeploy the frontend module in the development center.

## Cross-Origin Configuration for Backend Modules

Since the frontend and backend modules are deployed independently, there will be cross-origin issues if accessed via independent domains. Some browsers have features that block cross-origin access, leading to request failures. Therefore, it is necessary to modify the backend configuration to allow cross-origin access.

- Frontend module domain: `stag-dot-{your-appid}.bkapps.example.com`
- Backend module domain: `stag-dot-backend-api-dot-{your-appid}.bkapps.example.com`

The specific configuration is as follows:

1. Add the CORS dependency package to `requirements.txt`. You can refer to the [django-cors-headers history](https://github.com/adamchainz/django-cors-headers/blob/master/HISTORY.rst) for package versions.

- For Python2, it is recommended to use `django-cors-headers==3.0.2`
- For Python3, it is recommended to use the latest version

2. Add CORS configuration in `config/default.py`

For more CORS configuration, refer to the [official documentation](https://github.com/adamchainz/django-cors-headers)

```bash
# Please add your custom APP here
INSTALLED_APPS += (
    'home_application',
    'mako_application',
    # Add cross-origin configuration
    'corsheaders',
)

# Custom middleware
MIDDLEWARE = (
    # CorsMiddleware should be placed as early as possible
    # Especially before any middleware that can generate a response, such as Django's CommonMiddleware
    'corsheaders.middleware.CorsMiddleware',
) + MIDDLEWARE

# Configure CORS whitelist
CORS_ORIGIN_WHITELIST = [
    'http://your-domain-1:<your-port>',
    ...
    'https://your-domain-n:<your-port>',
]

# If you are not sure about the specific domains to append, you can first configure the following regex whitelist, but it is recommended to accurately configure the relevant domains in a production environment
CORS_ORIGIN_REGEX_WHITELIST = [
    r"http://.*\.com",
]

# Add Access-Control-Allow-Credentials to the response, allowing cross-origin use of cookies
CORS_ALLOW_CREDENTIALS = True

# For applications that have enabled independent subdomains (new applications are enabled by default), you need to write the CSRF_TOKEN under the root domain, otherwise the frontend project cannot obtain the corresponding cookies
CSRF_COOKIE_DOMAIN = ".example.com"
```

After modifying the backend module, redeploy it in the Developer Center. We can then access the application normally.

The default access address of the application is the address of the main module, so we access the frontend module's domain in the browser; the frontend module accesses the API provided by the backend module.