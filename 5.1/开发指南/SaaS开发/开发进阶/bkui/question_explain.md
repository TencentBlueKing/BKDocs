## bkui init 命令行问题说明

> 蓝鲸前端开发脚手架是为了让开发者基于前后端分离协作的模式更方便、更快速的构建蓝鲸 SaaS。构建完整的蓝鲸 SaaS 应用，需要前后端协作。因此命令行问答交互中有几个问题例如 `AJAX_URL_PREFIX`, `LOGIN_URL`, `USER_INFO_URL` 需要和后端一起协商指定。

> 为了让前后端分离协作模式可行，这几个设置默认均为本地模拟地址（即 `http://localhost`），这么做一来可以使前端页面功能开发可以相对独立完成，二来当后端接口准备好之后，前端仅需要修改代码中对应的配置，即可进行功能联调。

### 1. Generate project in current directory?
是否在当前目录下初始化项目，**直接在当前目录下运行 `bkui init` 并且当前目录为空时会出现这个问题**。

### 2. The current directory is not empty. Continue?
是否在当前目录下初始化项目，**直接在当前目录下运行 `bkui init` 并且当前目录不为空时会出现这个问题**。

### 3. Target directory exists. Will create a new directory and add the `.bak` suffix to the existing directory. Continue?
是否在已存在的目录里初始化项目，**运行 `bkui init DIRECTORY_NAME` 并且 `DIRECTORY_NAME` 已经存在时会出现这个问题**，继续之后，会给已存在的目录添加一个时间戳后缀，同时新建 `DIRECTORY_NAME` 目录，并在 `DIRECTORY_NAME` 新目录里初始化项目。

### 4. Is it a SaaS Application?
是否是蓝鲸 SaaS 应用，默认为是。**蓝鲸前端开发脚手架除了可以构建蓝鲸 SaaS 应用，也支持构建 Web 单页应用**。

### 5. Project name
项目名称，默认为 `bkui init` 中设置的 `DIRECTORY_NAME`，如果没有 `DIRECTORY_NAME` 参数，那么就是当前目录的名称。

### 6. Project description
项目描述，默认为 `Project description` 字符串。

### 7. Author
作者，默认会取你工程下的 `git config --get user.name` 以及 `git config --get user.email` 以 `name <email>` 显示。如果当前工程下没有，那么会取全局 `git` 的配置。如果全局 `git` 没有获取到，那么 `name` 会被设置为 `os.hostname()` 即操作系统的主机名，`email` 会被设置为 `''`。

### 8. PostCSS or Scss
css 的处理引擎，目前仅支持 `postcss`。

> [postcss](https://postcss.org/) 是一个用 js 工具和插件转换 css 代码的工具，这些插件可以支持使用变量，混入(mixin)，转换未来的 css 语法，内联图片等操作。相对于 scss，我们更推荐使用 postcss，因为 postcss 是利用 js 来转换 css 代码，基于 js 写的插件理论上来说可以完成任何操作，没有限制，只要能够想到，基本上都可以利用 js 来实现，而且 postcss 不会对 css 代码做任何修改，它只是为插件提供接口，方便他们完成各自的功能。如果需要结合 webpack 使用 scss，参见 [postcss-loader](https://webpack.js.org/loaders/postcss-loader/)。

### 9. LOCAL_DOC_URL
`bkui init` 初始化项目时，会在项目中自带一个文档示例工程，这个参数就是设置文档示例工程的本地访问 URL，默认为 `http://localhost`，如果需要自己设置，请输入绝对地址。**（文档示例工程不会对实际的工程产生任何影响，打包构建时也不会把文档示例工程的内容打入到实际工程中）**。
> 文档示例工程只是本地运行，因此不会涉及到线上部署，通常使用默认设置 `http://localhost` 即可。如果需要把文档部署到线上，可运行 `npm run build:doc` 打包构建文档示例工程，然后自行部署。

##### 如何修改本配置

- **本配置是 `${ROOT}/doc/build/config.js` 中的 `localDocUrl` 字段，可根据自己的需求修改。**

### 10. LOCAL_DOC_PORT
文档示例工程的本地访问端口，默认为 `8081`。

##### 如何修改本配置

- **本配置是 `${ROOT}/doc/build/config.js` 中的 `localDocPort` 字段，可根据自己的需求修改。**

### 11. LOCAL_DEV_URL
本地开发的地址，默认值为 `http://localhost`，如果需要自己设置，请输入绝对地址（本配置与线上部署无关）。
> 我们推荐将 `LOCAL_DEV_URL` 设置为与您部署的蓝鲸社区版/企业版或非蓝鲸 SaaS 应用的线上域名一致，只是加上一个 `local-dev` 的子级前缀。

> 例如假设您部署的蓝鲸社区版/企业版对应域名是：`http://www.bking.com`，那么 `LOCAL_DEV_URL` 就设置为 `http://local-dev.bking.com`，然后配置 host，`127.0.0.1 local-dev.bking.com`，就可用 `http://local-dev.bking.com:${LOCAL_DOC_PORT}` 来进行本地开发了。

##### 如何修改本配置

- **本配置是 `${ROOT}/build/dev.env.js` 中的 `LOCAL_DEV_URL` 字段，可根据自己的需求修改。**

### 12. LOCAL_DEV_PORT
本地开发的端口，默认值为 `8080`。

##### 如何修改本配置

- **本配置是 `${ROOT}/build/dev.env.js` 中的 `LOCAL_DEV_PORT` 字段，可根据自己的需求修改。**

### 13. AJAX_URL_PREFIX
ajax 请求地址前缀，我们通过这个配置来拼接出 ajax 请求的前缀，设置为 `axios` 的 `baseURL`，如果需要自己设置，请输入绝对地址。通常情况下，这个值需要与后端协商指定。

**蓝鲸 SaaS 应用和非蓝鲸 SaaS 应用 ajax 请求前缀：**

- 蓝鲸 SaaS 应用
  - 此配置默认值为 `http://localhost:8080`（`${LOCAL_DEV_URL}:${LOCAL_DEV_PORT}`）
  - ajax 完整的请求地址前缀就是 `AJAX_URL_PREFIX`
- 非蓝鲸 SaaS 应用
  - 此配置默认值为 `http://localhost:8080/api`（`${LOCAL_DEV_URL}:${LOCAL_DEV_PORT}/api`）
  - ajax 完整的请求地址前缀就是 `AJAX_URL_PREFIX`

##### 如何修改本配置

- **本地开发中，本配置是 `${ROOT}/build/dev.env.js` 中的 `AJAX_URL_PREFIX` 字段，可根据自己的需求修改。**
- **生产环境中，本配置是 `${ROOT}/build/prod.env.js` 中的 `AJAX_URL_PREFIX` 字段，可根据自己的需求修改。打包构建时，我们通常会把 `${ROOT}/build/prod.env.js` 中的 `AJAX_URL_PREFIX` 字段设置为 `''`，这么做的原因是，让 ajax 异步请求地址前缀直接和浏览器访问路径的域名信息一致。**

### 14. AJAX_MOCK_PARAM
我们集成了简单方便的 `mock` 功能，任何请求，只要在 url 参数中带有 `AJAX_MOCK_PARAM` 的值表示的 url 参数，那么就会进入 `mock` 的逻辑。这个 url 参数的值为 `/a/b/c` 这样的路径，对应的就是 `${ROOT}/mock/ajax` 文件夹下的文件，同时还有一个 `invoke` 参数，表示这个文件里的方法名。`AJAX_MOCK_PARAM` 的默认值为 `mock-file`。

示例如下：

- 本参数设置为 `mock-file`，url 线上的请求为 `/app/project/list`
- 需要 mock 这个请求，只需要将 url 设置为 `/app/project/list?mock-file=/app/project&invoke=list`
- 同时在 `${ROOT}/mock/ajax` 下创建 app 文件夹，文件夹中创建 project 文件，文件中判断 invoke 为 list 时，返回对应的 mock 数据即可
- 本地开发过程中，`AJAX_MOCK_PARAM` 有变化时，那么修改 `${ROOT}/build/dev.env.js` 文件中 `AJAX_MOCK_PARAM` 的值，然后重启本地 devserver 即可。

##### 如何修改本配置

- **本配置是 `${ROOT}/build/dev.env.js` 中的 `AJAX_MOCK_PARAM` 字段，可根据自己的需求修改。**
- **在 `${ROOT}/build/prod.env.js` 也有一个 `AJAX_MOCK_PARAM` 字段，正常来说，生产环境中不会使用 mock 的字段，不过为了防止在打包构建后的文件中直接出现 `AJAX_MOCK_PARAM` 变量，因此在 `${ROOT}/build/prod.env.js` 文件中我们也设置了 `AJAX_MOCK_PARAM` 字段。**

### 15. LOGIN_URL（构建非蓝鲸 SaaS 应用时才会有此配置）
登录的地址，默认值为 `${LOCAL_DEV_URL}:${LOCAL_DEV_PORT}/login`，如果需要自己设置，请输入绝对地址。在有登录逻辑的应用中，当**刷新页面**检测到未登录时，页面会自动跳转到这个值所表示的登录页面去。通常情况下，这个值需要与后端协商指定。

示例如下（**假设您本地开发的地址为 http://local-dev.bking.com**）：

| 生产环境配置 | 本地开发配置 |
|---------------|---------------|
|http://www.bking.com/login （与后端协商指定，然后在命令行问答中设置）| http://local-dev.bking.com:8080/login （由 `LOCAL_DEV_URL`, `LOCAL_DEV_PORT` 共同决定） |

- 如果初始化项目的时候还没有确定 `LOGIN_URL`，直接使用默认值即可，当确定了 `LOGIN_URL` 之后，只需要修改 `${ROOT}/build/prod.env.js` 文件中 `LOGIN_URL` 的值即可。
- 本地开发我们一般很少会涉及到登录的逻辑（检测登录逻辑主要是后端验证）。如果我们在本地开发中需要对登录逻辑做一些验证，可以通过 mock httpStatusCode 为 401 来实现。此时，可以通过修改 `${ROOT}/build/dev.env.js` 文件中 `LOGIN_URL` 的值来改变本地开发的登录地址。

##### 如何修改本配置

- **本配置是 `${ROOT}/build/dev.env.js` 中的 `LOGIN_URL` 字段，可根据自己的需求修改。**

### 16. USER_INFO_URL
这个配置表示获取用户信息的接口，我们通过这个接口来判断当前用户是否登录，如果需要自己设置，请输入绝对地址。通常情况下，这个值需要与后端协商指定。

- 蓝鲸 SaaS 应用
  - 此配置默认值为 `account/get_user_info/`
  - 通过 index.html（线上）或 index-dev.html（本地开发） 中的 [SITE_URL](config-explain.md#siteurl) 拼出完整的获取用户信息异步接口。
  - 示例工程中，这个配置使用的是本地的 mock 接口，如需在本地开发时从后端获取异步数据，只需要把 index-dev.html 中的 [SITE_URL](config-explain.md#siteurl) 改成后端提供的地址即可。
- 非蓝鲸 SaaS 应用
  - 此配置默认值为 `user`
  - 本地开发时，通过 [AJAX_URL_PREFIX](#13-ajaxurlprefix) 拼出完整的获取用户信息异步接口。
  - 示例工程中，这个配置使用的是本地的 mock 接口，如需在本地开发时从后端获取异步数据，修改 `${ROOT}/build/dev.env.js` 中的 `AJAX_URL_PREFIX` 值，然后重启本地 devserver 即可。
- 如需修改此配置的值，修改 `${ROOT}/build/dev.env.js` 和 `${ROOT}/build/prod.env.js` 中的 `USER_INFO_URL` 值，然后重启本地 devserver 即可。

##### 如何修改本配置

- **本地开发中，本配置是 `${ROOT}/build/dev.env.js` 中的 `USER_INFO_URL` 字段，可根据自己的需求修改。**
- **生产环境中，本配置是 `${ROOT}/build/prod.env.js` 中的 `USER_INFO_URL` 字段，可根据自己的需求修改。**
- **在后端接口准备后好之后，我们推荐无论是本地开发或者打包构建，即在 `${ROOT}/build/dev.env.js` 和 `${ROOT}/build/prod.env.js` 两个文件中，这个字段的配置都是一致的。**
