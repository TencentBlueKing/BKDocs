## 配置说明

这里给大家介绍一下初始化的工程中几个需要注意的地方

### 1. index.html 配置说明

蓝鲸前端开发脚手架是用来帮助我们构建蓝鲸社区版/企业版 SaaS 应用的，同时它也支持我们构建一般的 web 单页应用。

在初始化的工程里，有 `index-dev.html` 和 `index.html` 两个 html 文件。这两个 html 的差异点如下：

- index.html 用于生产环境，由后端服务器渲染
- index-dev.html 用于本地开发，由本地 devserver 渲染

html 文件中有几个变量（`SITE_URL`, `BK_STATIC_URL`, `REMOTE_STATIC_URL`），配置说明如下：

#### SITE_URL

前端使用的 router mode 是 `history`，因此前端路由需要根据这个变量的值来设置**路由的根路径**以及 **ajax 异步请求地址前缀**。

- 在蓝鲸 SaaS 应用和非蓝鲸 SaaS 应用中，SITE_URL 的作用均是**设置路由的根路径**。

下面看一个简单的例子理解一下（**假设您部署的蓝鲸社区版/企业版对应域名是：http://www.bking.com ，本地开发的地址为 http://local-dev.bking.com**）：

|             | 生产环境 SITE_URL 配置（index.html）| 生产环境访问地址 | 本地开发 SITE_URL 配置（index-dev.html）| 本地开发访问地址 |
|-------------|---------------|---------------|---------------|---------------|
| 蓝鲸 SaaS 应用 | /t/open-v214/（由后端服务注入页面）| http://www.bking.com/t/open-v214/ | /（默认值为：/）| http://local-dev.bking.com |
| 非蓝鲸 SaaS 应用 | /（蓝鲸前端开发脚手架直接生成，非蓝鲸 SaaS 应用通常不会由后端服务注入页面）| http://www.bking.com | /（默认值为：/）|  http://local-dev.bking.com |

##### 如何修改本配置
- **本地开发中，本配置是 `${ROOT}/index-dev.html` 中的 `SITE_URL` 的值，可根据自己的需求修改。**
- **生产环境中，本配置是 `${ROOT}/index.html` 中的 `SITE_URL` 的值，可根据自己的需求修改。**

**蓝鲸 SaaS 应用中，我们建议不要修改 `${ROOT}/index.html` 中 `SITE_URL` 的值，生产环境应该由后端注入到页面中。**


#### BK_STATIC_URL

前端需要根据这个值来确定静态资源的路径（包括默认写在 html 上的 lib.bundle.js 以及 webpack 动态 inject 的 js 和 css）

还是看一个简单的例子（**假设您部署的蓝鲸社区版/企业版对应域名是：http://www.bking.com ，本地开发的地址为 http://local-dev.bking.com**）：

|             | 生产环境 BK_STATIC_URL 配置（index.html）| 生产环境加载静态资源的路径前缀 | 本地开发 BK_STATIC_URL 配置（index-dev.html）| 本地开发加载静态资源的路径前缀 |
|-------------|---------------|---------------|---------------|---------------|
| 蓝鲸 SaaS 应用 | /t/open-v214/static/dist/（由后端服务注入页面）| http://www.bking.com/t/open-v214/static/dist/ | /（默认值为：/）| http://local-dev.bking.com/ |
| 非蓝鲸 SaaS 应用 | /（蓝鲸前端开发脚手架直接生成，非蓝鲸 SaaS 应用通常不会由后端服务注入页面）| http://www.bking.com/ | / （默认值为：/）| http://local-dev.bking.com/|

##### 如何修改本配置

- **本地开发中，本配置是 `${ROOT}/index-dev.html` 中的 `BK_STATIC_URL` 的值，可根据自己的需求修改。**
- **生产环境中，本配置是 `${ROOT}/index.html` 中的 `BK_STATIC_URL` 的值，可根据自己的需求修改。**

**蓝鲸 SaaS 应用中，我们建议不要修改 `${ROOT}/index.html` 中 `BK_STATIC_URL` 的值，生产环境应该由后端注入到页面中。**

#### REMOTE_STATIC_URL

在蓝鲸 SaaS 应用以及非蓝鲸 SaaS 应用中，有时候可能需要引入其他 CDN 的静态资源文件，这个值就是用来设置其他 CDN 的静态资源路径的。生产环境由后端服务注入页面，本地开发环境默认为空。

##### 如何修改本配置

- **本地开发中，本配置是 `${ROOT}/index-dev.html` 中的 `REMOTE_STATIC_URL` 的值，可根据自己的需求修改。**
- **生产环境中，本配置是 `${ROOT}/index.html` 中的 `REMOTE_STATIC_URL` 的值，可根据自己的需求修改。**

**蓝鲸 SaaS 应用中，我们建议不要修改 `${ROOT}/index.html` 中 `REMOTE_STATIC_URL` 的值，生产环境应该由后端注入到页面中。**

### 2. 组件库按需和全量加载的切换

蓝鲸前端开发脚手架集成了我们的 [bk-magic-vue](https://magicbox.bk.tencent.com/components_vue/2.0/example/index.html#/) 组件库。组件库支持按需加载和全量加载，两种方式的写法不同，参见 `${ROOT}/src/common/demand-import.js`（按需加载）和 `${ROOT}/src/common/fully-import.js`（全量加载）。

我们是在 `${ROOT}/src/common/bkmagic.js` 中切换的，需要全量加载，就引入 `fully-import`，需要按需加载就引入 `demand-import`。

### 3. mock 的使用说明

蓝鲸前端开发脚手架提供简单方便的异步请求 mock 功能，通过简单的配置（仅仅只需要添加 url 的参数）来模拟后端的数据返回，有助于前后端分离协作。简单的示例如下（**假设您部署的蓝鲸社区版/企业版对应域名是：http://www.bking.com ，线上 ajax 异步请求的根路径为: http://www.bking.com/api ，获取用户信息的请求为 http://www.bking.com/api/user**）：

- 命令行问答 `AJAX_MOCK_PARAM` 设置为默认值 `mock-file`，如果初始化工程后需要改动，修改 `${ROOT}/build/dev.env.js` 中的 `AJAX_MOCK_PARAM` 值即可
- 同时在 `${ROOT}/mock/ajax` 目录下创建 app 文件夹，文件夹中创建 index 文件，参照文件中已存在内容的写法，判断 invoke 为 getUserInfo 时，返回对应的 mock 数据即可
- mock `http://www.bking.com/api/user` 这个请求，只需在这个请求后加上这段参数即可 `?mock-file=/index&invoke=getUserInfo`；去掉这段参数，就会真正请求后端数据
:::info 如何修改本配置？
本配置是 `${ROOT}/build/dev.env.js` 中的 `AJAX_MOCK_PARAM` 字段，可根据自己的需求修改。

在 `${ROOT}/build/prod.env.js` 也有一个 `AJAX_MOCK_PARAM` 字段，正常来说，生产环境中不会使用 mock 的字段，不过为了防止在打包构建后的文件中直接出现 `AJAX_MOCK_PARAM` 变量，因此在 `${ROOT}/build/prod.env.js` 文件中我们也设置了 `AJAX_MOCK_PARAM` 字段。
:::

### 4. 修改打包构建最终产物的生成目录
通过修改 `${ROOT}/build/config.js` 中的 `build.assetsRoot` 字段，可以更改打包构建最终产物的生成目录。

|             | 默认值 |
|-------------|---------------|
| 蓝鲸 SaaS 应用 | `path.resolve(__dirname, '../../static/dist')`（与当前工程目录同级的 static 目录下的 dist 目录，在当前工程目录外部）|
| 非蓝鲸 SaaS 应用 | `path.resolve(__dirname, '../dist')`（当前工程目录下的 dist 目录，在当前工程目录内部）|
