# Python development framework combined with BKUI-CLI Use Guide
## Overall explanation

BlueKing Python development framework 2.0 can support the separation of front and back development after simple configuration adjustment. This article will be divided into two parts to lead the readers to make relevant modifications.
- The first part mainly explains how the backend students should configure the background after the frontend is separated from the frontend, so as to realize the convenient local call of the backend test environment interface verification by the frontend students.
- The second part mainly describes how to merge the frontend and backend code, unify the code into a project warehouse and deploy it to run online.

## Frontend local development joint debugging

   In the [description document](./bkui/bkui.md) of frontend development scaffold（BKUI-CLI）, we can run an independent front-end project. Here we will show how to adjust the front-end project and get through the front-end project and back-end interface.
### Background modification

   After the front end and the back end are separated, we want the front end development to run a test service locally, and then request the interface of the test environment to obtain data for debugging. However, due to the inconsistency between the domain name of the local service and the domain name of the test environment, some browsers will have the feature of blocking cross domain access, resulting in the request failure. Therefore, you need to modify the background configuration to run cross domain access.

   1. Increase CORS dependency

      In the requirements.txt file, add the new component dependency `django-cors-headers==3.0.2` (the specific version can be modified according to the actual situation)
   2. Add CORS configuration

      1. Add middleware configuration

         In the config/default.py file, add the middleware configuration at the position of about 54 lines:

         ```python
         # Custom Middleware
         MIDDLEWARE = ('corsheaders.middleware.CorsMiddleware', ) + MIDDLEWARE
         ```

      2. Add test environment configuration

         In the config/stag.py file, append the following configuration

         ```python
         # White list, please modify the domain name according to the actual configuration in the previous paragraph
         CORS_ORIGIN_WHITELIST = [
             'http://localhost:8080',
         ]
         # Allow cookies to be used across domains
         CORS_ALLOW_CREDENTIALS = True
         ```

         > note：It is strongly recommended that 【do not】add the above configuration in the config / prod.py file. Because the formal environment should not be used as the joint debugging test environment, adding CORS configuration may cause unnecessary security risks.

   After the above modification, the local frontend service can normally access the backend interface.

## Code merge Online

   After the front and back end are developed separately, the code on both sides needs to be merged and deployed to the online environment. Before deployment, we need to modify some parts of the framework.

### Increase the search scope of the homepage

   In the config/default.py file, append the following configuration

   ```python
   TEMPLATES[0]['DIRS'] += (
       os.path.join(BASE_DIR, 'static', 'dist'),
   )
   ```

   > note：
   >
   > 1. It is discussed here that no changes have been made to the TEMPLATES. If there is any adjustment to the TEMPLATES variable, it will be replaced. Please modify according to the actual situation
   > 2. It is expected that the output path of the front-end package file is {root_path}/static/dist. if there is any change, please configure it according to the actual situation. But the file output must be under the {root_path}/static/ path, otherwise the online environment will not find the static resources
### Modify home page to return

   In the home_Application/views.py file, change the home function
   ```python
   def home(request):
       """
       home page
       """
       return render(request, 'index.html')
   ```

### Add frontend static URL configuration

   In the files config/prod.py, config/stag.py and config/dev.py, add the following configuration
   ```python
   BK_STATIC_URL = STATIC_URL + '/dist/'
   ```

   > note：It is expected that the output path of the frontend package file is {root_path}/static/dist. if there is any change, please configure it according to the actual situation.
   In the blueapps/template/context_processors.py file, near line 57, append a key value pair to the context variable
   ```python
    # Static URL configuration with front and back separation
    'BK_STATIC_URL': settings.BK_STATIC_URL
   ```

After the above modifications are completed, the front and rear code can be combined and deployed in the local and online environment.

## FAQ

1. Why does the getuser interface fail?

   A：Please check the development framework version, which is added after 2.2.0.x. However, this interface is only used as a simple connectivity verification and does not affect the function.

2. If the front end uses the history mode, what should I do if I refresh the page and return to 404?

   A：The development framework has prepared a middleware and related configuration for this purpose. Just turn on the middleware (closed by default) and turn on the configuration switch
   1. In the config/default.py file, add the following code
      ```python
      MIDDLEWARE += ('blueapps.middleware.bkui.middlewares.BkuiPageMiddleware', )
      ```

   2. In the config/default.py file, turn on the adapter
      ```python
      IS_BKUI_HISTORY_MODE = True
      ```

   > note：
   >
   > 1. In this mode, the background will change all 404 returns to the home page ('/' path) content
   > 2. 404 page content should be handled in the frontend
