# Python Development Framework Combined with BKUI-CLI Usage Guide

## Overall Description

BlueKing Python Development Framework 2.0 can support front-end and back-end separation development after simple configuration adjustment. This article will be divided into two parts to guide readers to make relevant modifications.

- The first part mainly explains how back-end students should configure the back-end after the front-end and back-end are separated, so that front-end students can conveniently call the back-end test environment interface verification locally.

- The second part mainly explains how to merge the front-end and back-end codes, unify the codes into a project repository and deploy them to online operation.

## Front-end local development joint debugging

In the [Description Document](./bkui/bkui.md) of the front-end development scaffold (BKUI-CLI), we can already run an independent front-end project. Here we will explain how to adjust the front-end project and connect the front-end project and back-end interface.

### Back-end modification

Since the front-end and back-end are separated, we hope that the front-end development will run a test service locally, and then request the test environment interface to obtain data for debugging. However, since the domain name of the local service is inconsistent with the domain name of the test environment, some browsers have the feature of blocking cross-domain access, resulting in request failure. Therefore, it is necessary to modify the background configuration to run cross-domain access.

1. Add CORS dependency

In the requirements.txt file, add a new component dependency `django-cors-headers==3.0.2` (the specific version can be modified according to the actual situation)

2. Add CORS configuration

1. Add middleware configuration

In the config/default.py file, add the middleware configuration around line 54:

```python
# Custom middleware
MIDDLEWARE = ​​('corsheaders.middleware.CorsMiddleware', ) + MIDDLEWARE
```

2. Add test environment configuration

In the config/stag.py file, append the following configuration

```python
# Whitelist, please modify the domain name according to the actual configuration in the previous section
CORS_ORIGIN_WHITELIST = [
'http://localhost:8080',
]
# Allow cross-domain use of cookies
CORS_ALLOW_CREDENTIALS = True
```

> Note: It is strongly recommended not to add the above configuration in the config/prod.py file. Because the official environment should not be used as a joint debugging test environment, adding CORS configuration is likely to cause unnecessary security risks.

After completing the above modifications, the local front-end service can access the back-end interface normally.

## Code merging and launching

After the front-end and back-end are developed separately, the codes on both sides need to be merged and deployed to the online environment. Before deployment, we need to modify some content in the framework.

### Increase the homepage search range

In the config/default.py file, add the following configuration

```python
TEMPLATES[0]['DIRS'] += (
os.path.join(BASE_DIR, 'static', 'dist'),
)
```

> Note:
>
> 1. The discussion here is the case where TEMPLATES is not modified. If there is any adjustment to the TEMPLATES variable, please modify it according to the actual situation
> 2. Here, the output path of the front-end package file is expected to be {root_path}/static/dist. If there is any change, please configure it according to the actual situation. But the file output must be in the {root_path}/static/ path, otherwise the online environment will not be able to find static resources

### Modify the home page return

In the home_application/views.py file, modify the home function to

```python
def home(request):
"""
Home page
"""
return render(request, 'index.html')
```

### Add front-end static URL configuration

In the config/prod.py, config/stag.py, and config/dev.py files, add the following configuration

```python
BK_STATIC_URL = STATIC_URL + 'dist'
```

> Note: The expected output path of the front-end packaged file is {root_path}/static/dist. If there is a change, please configure it according to the actual situation.

In the blueapps/template/context_processors.py file, around line 57, add a key-value pair to the context variable

```python
# Static URL configuration for front-end and back-end separation
'BK_STATIC_URL': settings.BK_STATIC_URL
```

After completing the above modifications, you can merge and deploy the front-end and back-end codes in the local and online environments.

## FAQ

1. Why is the getUser interface invalid?

A: Please check the development framework version. This interface was added in versions after 2.2.0.x. However, this interface is only used as a simple connectivity verification and does not affect the function.

2. If the front-end uses history mode, what should I do if the refresh page returns 404?

A: The development framework has prepared a middleware and related configuration for this purpose. You only need to turn on the middleware (off by default) and turn on the configuration switch.

1. In the config/default.py file, add the following code

```python
MIDDLEWARE += ('blueapps.middleware.bkui.middlewares.BkuiPageMiddleware', )
```

2. In the config/default.py file, turn on the adaptation switch

```python
IS_BKUI_HISTORY_MODE = True
```

> Note:
>
> 1. In this mode, the backend will uniformly change all 404 returns to return the home page ('/' path) content
> 2. 404 page content should be uniformly processed on the front end