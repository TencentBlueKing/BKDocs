# BlueKing Django Development Framework Combined with Vue.js Framework Project

## Preface

Before reading this tutorial, we assume that you already have some Django and Vue basics, and have installed npm and Vue on your computer, because we will use them to initialize a Vue project next.

Of course, if you know little about Vue, then we strongly recommend that you read the Vue official documentation before reading this tutorial:

[Vue official documentation](https://cn.vuejs.org/v2/guide/)

In the following content, we will start with the development framework and complete our goal of separating the front-end and back-end of the Django development framework and Vue step by step.

At the same time, we will also try to mark the problems and solutions that you may encounter in the process of practice.

If you have prepared these, then let's get started.

Note: The environment description when writing this tutorial:

> Operating system: Windwos 10
>
> Python version: 3.6.5
>
> Development framework version: 3.2.7.88
>
> Vue version: @vue/cli 4.4.1

## Notes

The address http://dev.paas-class.bktencent.com:8080 that appears in this article is a local test address. You can flexibly modify it according to your PaaS address.

## Development framework preparation

Before separating the front-end and back-end, we must first prepare our back-end environment and write a very simple back-end interface, which will accept a Get or Post request and return the following json string:

```json
{"hello": "world"}
```

First, we need to initialize our BlueKing development framework so that it can run normally. Then we need to add a route to the `home_application/views.py` file, `/hello`

Of course, home_application is not mandatory. If you want, you can define the function corresponding to `/hello` anywhere, as long as we access the `/hello` route through a specific url, it can return the string we need.

Here is the code:

```python
# views.py

def hello(request):
return JsonResponse({"hello": "world"})

# urls.py
urlpatterns = (
url(r'^$', views.home),
url(r'^dev-guide/$', views.dev_guide),
url(r'^contact/$', views.contact),
url(r'^hello/$', views.hello),
)
```

Of course, we strive to make everything simple enough, **when we solve key issues such as cross-domain, crsf**, it means you can add any complex processing logic based on the current one.

Now let's visit the `hello` route we just created from the browser, enter the URL: http://dev.paas-class.bktencent.com:8000/hello/ and press Enter.

Very good, the browser correctly displays `{"hello": "world"}`. If there are other problems, you may need to check whether your local configuration is correct.

At this point, a simple preparation of our development framework is completed. Of course, this is only the first step. When we encounter problems such as cross-domain and csrf, it means that we still need to add additional configuration to the development framework.

## Front-end Vue project preparation

It is very simple to create a new Vue project. We only need to enter in the command line:

```bash
vue create projectname
```

> Note: projectname is the name of the project you want to create.

After some simple configuration, we can create a standard Vue project locally. Let's open the project directory and enter in the command line:

```bash
npm run serve
```

When the console outputs:

```bash
App running at:
- Local: http://localhost:8080/
- Network: http://192.168.255.10:8080/

Note that the development build is not optimized.
To create a production build, run npm run build.
```

This means that our Vue project has been initialized successfully. Now let's enter in the browser: http://localhost:8080/ to see if our Vue project is really started successfully:

![Vue](../assets/Vue.png)

Nice, everything is surprisingly smooth.

Of course, up to now, our front-end and back-end separation has just begun, because now our Vue project and our development framework are like two strangers, without any intersection.
In order to connect our Vue project with the Django development framework, we need to write a request function in Vue, which will request our `/hello` interface.
If successful, our Vue project should receive the `{"hello": "world"}` data returned by the backend.

### Install axios library

In order for our Vue project to have the ability to initiate requests to the backend, we need to install the axios library, which we will use and use it to write a simple Post request.

Installation:

```shell
npm install --save axios vue-axios
```

Add the following configuration to the src/main.js file of the vue project:

```js
import Vue from 'vue'
import App from './App.vue'
import axios from 'axios'
import VueAxios from 'vue-axios'
Vue.use(VueAxios, axios)
Vue.config.productionTip = false
axios.defaults.baseURL = 'http://dev.paas-class.bktencent.com:8000/' // prefix for axios to initiate requests

new Vue({
render: h => h(App)
}).$mount('#app')
```

Then let's open the src/components/HelloWorld.vue file and add the following content:

```js
<script>
export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  mounted () {
    this.test()
  },
  methods: {
    test: function () {
      this.axios({
        url: '/hello/',
        method: 'post',
        responseType: 'json' // 默认的
      }).then(res => {
        var jsondata = JSON.parse(JSON.stringify(res.data))
        console.log(jsondata)
      })
    }
  }
}
</script>
```
This code means that when our HelloWorld.vue interface is initialized, our test method will be called, and test will send a Post request to the backend route of `/hello/`. And the content returned by the backend will be printed to the console.

Now let's restart our Vue project and visit http://localhost:8080/ in the browser, and remember to open `f12` so that we can see the details of the request.

Obviously, everything started to become less smooth, our request failed, and the console ruthlessly output the following information:

```js
localhost/:1 Access to XMLHttpRequest at 'http://dev.paas-class.bktencent.com:8000/test/' from origin 'http://localhost:8080' has been blocked by CORS policy: No 'Access-Control-Allow-Origin' header is present on the requested resource.
```

This is a typical cross-domain problem, so let's solve it next.

## Solve cross-domain problems

First, we need to install Python dependencies for solving cross-domain problems in our background framework:

``````bash
pip install django-cors-middleware
``````

As we can see from the name, we now need to add our corresponding middleware configuration to the configuration. Add the following configuration to the `/config/default.py` file:

```python
# Add corsheaders as our django app
INSTALLED_APPS += ( # noqa
'home_application',
'mako_application',
'corsheaders',
)

# Add custom middleware
MIDDLEWARE += ( # noqa
'corsheaders.middleware.CorsMiddleware',
)
```

Then we need to append the following configuration to the `config/stag.py` file;

```python
# Whitelist, Please modify the domain name according to the actual configuration in the previous section
CORS_ORIGIN_WHITELIST = [
'http://localhost:8080',
]
# Allow cross-domain use of cookies
CORS_ALLOW_CREDENTIALS = True
```

Then it is a very, very, very important step. Add our cross-domain configuration to the setting.py file in the project root directory:

```python
# Enable cross-domain permission in the local development environment
if ENVIRONMENT == 'dev':
# Add cross-domain ignore
    CORS_ALLOW_CREDENTIALS = True
    CORS_ORIGIN_ALLOW_ALL = True
    CORS_ORIGIN_WHITELIST = [
        'http://localhost:8080',
    ]

    CORS_ALLOW_METHODS = (
        'DELETE',
        'GET',
        'OPTIONS',
        'PATCH',
        'POST',
        'PUT',
        'VIEW',
    )

    CORS_ALLOW_HEADERS = (
        'accept',
        'accept-encoding',
        'authorization',
        'content-type',
        'dnt',
        'origin',
        'user-agent',
        'x-csrftoken',
        'x-requested-with',
    )
```
Let's refresh our front-end project, Nice! The cross-domain problem has been solved, and the previous error has disappeared, but a new problem has arisen. Our hello request still failed and a new error has appeared:

```txt
POST http://dev.paas-class.bktencent.com:8000/hello/ 403 (Forbidden)
```

## Solve the 403 csrf token authentication problem

As we all know, in order to prevent `CRSF` attacks, Django requires each of our Post requests to carry a crsftoken to verify the identity.

Of course, if you are not afraid of CSRF attacks, you can simply and roughly comment out the CSRF middleware. If you can't solve the problem, then solve the person who found the problem first. Of course, there is no problem.

But we strongly recommend that you do not do this, because most of the time, CSRF is very necessary for a web application.

In Django applications, csrftoken is hidden in the cookies of our applications. As long as we get the cookie and parse the csrftoken value, and then bring it with each request, it is perfect. However, we know that we can only share cookies under the same domain name, and now the access address of our Vue project is http://localhost:8080/, and the access address of the backend is http://dev.paas-class.bktencent.com:8000, so in order to get our cookies, we need to change the strategy, that is, change our front-end access address to: http://dev.paas-class.bktencent.com:8080. After that, we just need to add the relevant configuration in our Vue project `/src/main.js`:

```js
import Vue from 'vue'
import App from './App.vue'
import axios from 'axios'
import VueAxios from 'vue-axios'
Vue.config.productionTip = false
Vue.use(VueAxios,axios);
// Here is the added part
function getCsrftokenByCookie () {
    const cookie = document.cookie.split(';')
    // Get csrftoken
    let csrftoken = ''
    for (const i in cookie) {
        if (cookie[i].indexOf('csrftoken') !== -1) {
            csrftoken = cookie[i].split('=')[1]
        }
    }
    return csrftoken
}
// Each request header carries our X-CSRFToken information
axios.defaults.headers.common['X-CSRFToken'] = getCsrftokenByCookie();
axios.defaults.withCredentials = true;
Vue.config.productionTip = false
axios.defaults.baseURL = 'http://dev.paas-class.bktencent.com:8000/'

new Vue({
  render: h => h(App),
}).$mount('#app')

```
Now let's visit http://dev.paas-class.bktencent.com:8080 in the browser, and find out, amazing! Our hello request was successful.

Of course, you may also face failure and see the words `Invalid Host header`

Fortunately, it is easy to solve. We only need to create a vue.config.js project file in the root directory of our Vue project and add the following configuration:

```js
module.exports = {
devServer: {
disableHostCheck: true,
}
}
```

Restart our Vue project and find that everything has returned to normal. The console prints out the words hello world as expected.

Now we have solved the two core problems in the separation of front-end and back-end, cross-domain and 403 authentication, which means that you can now do whatever you want,
such as writing an interface, returning the current user information, etc., these will no longer be a problem, because now the front-end can request the back-end interface at will and get the information returned by the back-end interface.

Everything should be over here, but it's not. We still need to do the last step. But the good news is that compared with the previous cross-domain and csrf problems, the problems we encounter later are quite simple.

Because we will eventually deploy the application to the BlueKing pass platform, which means we need to merge our Vue project into our development framework.

## Vue project and development framework package deployment

First, we need to compile our Vue project into static files and execute:

```bash
npm run build
```

After that, we will see that the dist folder is generated in the root directory of our project. Here are the static files packaged in our vue project. Copy the dist folder directly to the `static` folder in the root directory of our BlueKing development framework.

After that, we need to rewrite our Django static path and point our static files to the dist folder under our static folder.

Append the following configuration in the `config/default.py` file:

```python
TEMPLATES[0]['DIRS'] += (
os.path.join(BASE_DIR, 'static', 'dist'),
)
```

Note that if you use vue-router and `history` routing mode in your front-end Vue project, you need to modify the `IS_BKUI_HISTORY_MODE` field in `config/default.py` to `True`.

Then add in: `config/stag.py` \ `config/prod.py`

```python
BK_STATIC_URL = STATIC_URL + 'dist/'
```

The last step: Change our homepage path to index.html

```python
def home(request):
"""
Homepage
"""
return render(request, 'index.html')
```

## Solve the 404 problem of static resources

After that, we visited our backend project, http://dev.paas-class.bktencent.com:8000, and found a blank page. When we opened the console, we found that all our static files were 404.

![Vue404](../assets/Vue404.png)

Let's click in and see what the addresses of these static file requests are:

```python
http://dev.paas-class.bktencent.com:8000/css/app.775a4d94.css
```

Well, our static files are clearly in the static/dist folder, so this request will definitely not be able to request them, so our correct static resource reference path should be:

```python
http://dev.paas-class.bktencent.com:8000/static/dist/css/app.775a4d94.css
```

Now that we understand the cause of the problem, we need to find out how to configure our static resource reference path?

Remember our `vue.config.js`, yes, it is this, we only need to add the following configuration every time `before packaging and deployment`:

```python
module.exports = {
devServer: {
disableHostCheck: true,
},
publicPath: '/static/dist/'
}
```

That's it, why must it be before packaging and deployment? Because when you develop a Vue project locally, if you also add the publicPath configuration, then when you visit http://dev.paas-class.bktencent.com:8080
the resource path of the Vue project will have problems, so you must add this configuration before deployment, and then run build.

Recompile our Vue project, click on the index.html file in the dist file, and we find that all static resource path references have been correctly modified to: /static/dist/
```html
<!DOCTYPE html>
<html lang=en>
	<head>
		<meta charset=utf-8>
		<meta http-equiv=X-UA-Compatible content="IE=edge">
		<meta name=viewport content="width=device-width,initial-scale=1">
		<link rel=icon href=/static/dist/favicon.ico> <title>vuetest</title>
		<link href=/static/dist/css/app.775a4d94.css rel=preload as=style>
		<link href=/static/dist/js/app.6101c35b.js rel=preload as=script>
		<link href=/static/dist/js/chunk-vendors.9c9ac966.js rel=preload as=script>
		<link href=/static/dist/css/app.775a4d94.css rel=stylesheet>
	</head>
	<body><noscript><strong>We're sorry but vuetest doesn't work properly without JavaScript enabled. Please enable it to
				continue.</strong></noscript>
		<div id=app></div>
		<script src=/static/dist/js/chunk-vendors.9c9ac966.js> </script> <script src=/static/dist/js/app.6101c35b.js> </script>
		 </body> </html>
```
Copy our dist file again to the static directory of our BlueKing development framework. Be careful not to forget to delete the previous one first.

Then open the browser to visit http://dev.paas-class.bktencent.com:8080, and find that everything is ok.

## Summary

In this article, we start with a very simple interface example, reproduce and solve the common problems we encounter in the actual front-end and back-end separation process. Although the example is simple,
the principle is the same. After solving these problems, what we have left is to concentrate on writing our business logic.
If you find other problems that we have not noticed during use, welcome everyone to actively feedback, we will try to keep our article up to date.

So, start your journey of front-end and back-end separation!