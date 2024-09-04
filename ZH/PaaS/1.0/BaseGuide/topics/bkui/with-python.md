# Python 开发框架结合 BKUI-CLI 使用指南

## 整体说明

蓝鲸 Python 开发框架 2.0 可以支持在简单的配置调整后，便可以实现前后端分离开发。本文将会分为两部分，带领读者进行相关的修改。

- 第一部分主要说明前后端分离后，后端同学应如何配置后台，实现前端同学方便的本地调用后台测试环境接口验证。

- 第二部分主要说明如何合并前后端代码，将代码统一到一个项目仓库下并部署到线上运行。

### 后台修改

   由于前后端分离后，我们希望前端开发在本地运行一个测试服务，然后请求测试环境的接口获取数据进行调试。但由于本地服务的域名与测试环境域名不一致，部分浏览器会有阻止跨域访问的特性，导致请求失败。因此需要修改后台配置，运行跨域访问。

   1. 增加 CORS 依赖

      requirements.txt 文件中，增加新的组件依赖 `django-cors-headers==3.0.2` (具体版本，可以按照实际修改)

   2. 增加 CORS 配置

      1. 增加中间件配置

         在 config/default.py 文件中，在 54 行左右的位置，增加中间件的配置:

         ```python
         # 自定义中间件
         MIDDLEWARE = ('corsheaders.middleware.CorsMiddleware', ) + MIDDLEWARE
         ```

      2. 增加测试环境配置

         在 config/stag.py 文件中，追加下列的配置

         ```python
         # 白名单, 域名请按照前段实际配置修改
         CORS_ORIGIN_WHITELIST = [
             'http://localhost:8080',
         ]
         # 允许跨域使用 cookie
         CORS_ALLOW_CREDENTIALS = True
         ```

         > 注意：强烈建议【不要】在 config/prod.py 文件中增加上述的配置。因为正式环境不应该作为联调测试环境，添加 CORS 配置很可能会引起不必要的安全风险。

   完成上述的修改后，本地的前端服务就可以正常的访问后台接口。

## 代码合并上线

   在前后端分别开发完成后，需要将两边的代码合并并部署到线上环境。在部署前，我们需要对框架中的部分内容进行修改。

### 增加首页搜索范围

   在 config/default.py 文件中，追加下列配置

   ```python
   TEMPLATES[0]['DIRS'] += (
       os.path.join(BASE_DIR, 'static', 'dist'),
   )
   ```

   > 注意：
   >
   > 1. 此处讨论是未对 TEMPLATES 做修改的情况，如果有对 TEMPLATES 变量有调整会替换，请按照实际情况修改
   > 2. 此处预计前端打包文件输出路径为 {root_path}/static/dist，如果有变化请按照实际情况配置。但文件输出必须在 {root_path}/static/ 路径下，否则会导致线上环境找不到静态资源

### 修改首页返回

   在 home_application/views.py 文件中，修改 home 函数为

   ```python
   def home(request):
       """
       首页
       """
       return render(request, 'index.html')
   ```

### 增加前端静态 URL 配置

   在 config/prod.py、config/stag.py、config/dev.py 文件中，增加以下配置

   ```python
   BK_STATIC_URL = STATIC_URL + '/dist/'
   ```

   > 注意：此处预计前端打包文件输出路径为 {root_path}/static/dist，如果有变化请按照实际情况配置。

   在 blueapps/template/context_processors.py 文件中，第 57 行附近，对 context 变量追加一个键值对

   ```python
    # 前后端分离的静态 URL 配置
    'BK_STATIC_URL': settings.BK_STATIC_URL
   ```

完成上述的修改后，就可在本地及线上环境合并部署前后端代码。

## FAQ

1. 为什么 getUser 接口失效？

   A：请检查开发框架版本，该接口是在 2.2.0.x 以后的版本加入。但该接口只是作为简单的连通性验证，并不影响功能。

2. 如果前端使用了 history 模式，刷新页面返回 404 怎么办？

   A：开发框架为此准备了一个中间件及相关配置，只需打开中间件（默认关闭）及打开配置开关即可

   1. 在 config/default.py 文件中，增加以下代码

      ```python
      MIDDLEWARE += ('blueapps.middleware.bkui.middlewares.BkuiPageMiddleware', )
      ```

   2. 在 config/default.py 文件中，打开适配开关

      ```python
      IS_BKUI_HISTORY_MODE = True
      ```

   > 注意：
   >
   > 1. 在这种模式下，后台将会将所有 404 的返回统一改为返回首页('/' 路径)内容
   > 2. 404 页面内容，应该统一在前端处理
