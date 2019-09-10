## webpack4 类型项目目录结构

使用 `BKUI-CLI` 初始化后，项目目录结构如下：

```bash
|-- ROOT/               # 项目根目录
    |-- .babelrc        # babel 配置
    |-- .eslintignore   # eslintignore 配置
    |-- .eslintrc.js    # eslint 配置
    |-- .gitignore      # gitignore 配置
    |-- README.md       # 工程的 README
    |-- index-dev.html  # 本地开发使用的 html
    |-- index.html      # 构建部署使用的 html
    |-- package-lock.json # package-lock file
    |-- package.json    # package.json，我们在提供了基本的 doc, dev, build 等 scripts，详细内容请参见文件
    |-- postcss.config.js # postcss 配置文件，我们提供了一些常用的 postcss 插件，详细内容请参见文件
    |-- build/            # 存放打包构建脚本、webpack 插件等等的目录
    |   |-- ajax-middleware.js # ajax mock 的实现
    |   |-- build-dll.js    # webpack 打包 dll
    |   |-- build.js        # webpack build
    |   |-- check-dll.js    # 检测 dll 是否存在，如果不存在，那么会自动打包，方便在 dev 的时候不用每次都打包 dll
    |   |-- check-versions.js   # 检测 node 和 npm 的版本，版本的限制在 package.json 文件中
    |   |-- config.js       # 本地开发以及 webpack 构建时的一些配置
    |   |-- dev-client.js   # webpack-hot-middleware 注入到页面的脚本，在 dev 时，文件改动，会自动刷新浏览器
    |   |-- dev-server.js   # 本地 dev server 的实现
    |   |-- dev.env.js      # 本地开发时的环境配置
    |   |-- prod.env.js     # webpack 构建时的环境配置
    |   |-- replace-css-static-url-plugin.js # webpack 插件，用于替换 asset css 中的 BK_STATIC_URL，__webpack_public_path__ 没法解决 asset 里静态资源的 url
    |   |-- util.js         # build 里的常用方法
    |   |-- webpack.base.conf.js # webpack base 配置，用于 dev 和构建
    |   |-- webpack.dev.conf.js  # webpack dev 配置
    |   |-- webpack.prod.conf.js # webpack 构建配置
    |-- doc/            # 蓝鲸前端开发脚手架的文档工程，这里的细节与实际工程无关，就不详细介绍了，如有兴趣，可自行查看（doc 里的内容不会影响到实际的工程）
    |   ......
    |-- mock/           # mock 数据存放的目录
    |   |-- ajax/       # mock 数据存放的目录
    |       |-- index.js    # index 模块的 mock 数据文件
    |       |-- util.js     # mock 数据存放模块的常用方法
    |-- src/            # 实际项目的源码目录
    |   |-- App.vue     # App 组件
    |   |-- main.js     # 主入口
    |   |-- public-path.js  # __webpack_public_path__ 设置
    |   |-- api/        # 对 axios 封装的目录
    |   |   |-- cached-promise.js # promise 缓存
    |   |   |-- index.js          # axios 封装
    |   |   |-- request-queue.js  # 请求队列
    |   |-- common/     # 项目中常用模块的目录
    |   |   |-- auth.js     # auth
    |   |   |-- bkmagic.js  # bk-magic-vue 组件的引入
    |   |   |-- bus.js      # 全局的 event bus
    |   |   |-- demand-import.js    # 按需引入 bk-magic-vue 的组件
    |   |   |-- fully-import.js     # 全量引入 bk-magic-vue 的组件
    |   |   |-- preload.js  # 页面公共请求即每次切换 router 时都必须要发送的请求
    |   |   |-- util.js     # 项目中的常用方法
    |   |-- components/     # 项目中组件的存放目录
    |   |   |-- auth/       # auth 组件
    |   |   |   |-- index.css   # auth 组件的样式
    |   |   |   |-- index.vue   # auth 组件
    |   |   |-- exception/      # exception 组件
    |   |       |-- index.vue   # exception 组件
    |   |-- css/            # 项目中通用的 css 的存放目录。各个组件的样式通常在组件各自的目录里。
    |   |   |-- app.css     # App.vue 使用的样式
    |   |   |-- reset.css   # 全局 reset 样式
    |   |   |-- variable.css    # 存放 css 变量的样式
    |   |   |-- mixins/     # mixins 存放目录
    |   |       |-- scroll.css  # scroll mixin
    |   |-- images/         # 项目中使用的图片存放目录
    |   |   |-- 403.png     # 403 错误的图片
    |   |   |-- 404.png     # 404 错误的图片
    |   |   |-- 500.png     # 500 错误的图片
    |   |   |-- building.png # 正在建设中的图片
    |   |-- router/         # 项目 router 存放目录
    |   |   |-- index.js    # index router
    |   |-- store/          # 项目 store 存放目录
    |   |   |-- index.js    # store 主模块
    |   |   |-- modules/    # 其他 store 模块存放目录
    |   |       |-- example.js  # example store 模块
    |   |-- views/          # 项目页面组件存放目录
    |       |-- 404.vue     # 404 页面组件
    |       |-- index.vue   # 主入口页面组件，我们在这里多使用了一层 router-view 来承载，方便之后的扩展
    |       |-- example1/   # example1 页面组件存放目录
    |       |   |-- index.css   # example1 页面组件样式
    |       |   |-- index.vue   # example1 页面组件
    |       |-- example2/   # example2 页面组件
    |       |   |-- index.css   # example2 页面组件样式
    |       |   |-- index.vue   # example2 页面组件
    |       |-- example3/   # example3 页面组件
    |           |-- index.css   # example3 页面组件样式
    |           |-- index.vue   # example3 页面组件
    |-- static/             # 静态资源存放目录，通常情况下， 这个目录不会人为去改变
    |   |-- lib-manifest.json   # webpack dll 插件生成的文件，运行 npm run dll 或者 npm run build 会自动生成
    |   |-- lib.bundle.js       # webpack dll 插件生成的文件，运行 npm run dll 或者 npm run build 会自动生成
    |   |-- images/         # 图片静态资源存放目录
    |       |-- favicon.ico # 网站 favicon
```
