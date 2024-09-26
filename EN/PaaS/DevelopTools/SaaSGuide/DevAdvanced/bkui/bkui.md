# Introduction to BlueKing Front-end Development Scaffolding (BKUI-CLI)

Welcome to use BlueKing Front-end Development Scaffolding [BKUI-CLI](https://www.npmjs.com/package/@blueking/cli), which is a scaffolding tool for building BlueKing system front-end engineering with one click based on [Vue.js](https://vuejs.org/), including basic engineering capabilities (technology selection, structure construction, logic division, construction performance optimization), basic mock services, BlueKing front-end/design specifications (code management, style unification), [bk-magic-vue component library](https://magicbox.bk.tencent.com/components_vue/2.0/example/index.html#/), BlueKing front-end general logic, best practices and development examples, etc., which can help you build BlueKing SaaS more conveniently and quickly based on the front-end and back-end separation and collaboration model.

In the project initialized with the BlueKing front-end development scaffolding, the latest technologies are combined, including [Vue.js 2.x](https://cn.vuejs.org/), [Vue Router 3.x](https://router.vuejs.org/zh/), [Vuex 3.x](https://vuex.vuejs.org/zh/guide/), [webpack 4.32.x](https://webpack.js.org/), [@babel 7.4.x](https://babeljs.io/), etc. At the same time, the best practices in our daily development process are integrated, including basic build performance optimization, mock requests, common components, code specifications, ajax encapsulation, etc., aiming to allow users to concentrate on developing business logic without being distracted by other things in the project.

For use in conjunction with the BlueKing SaaS development framework, please refer to the [Guide to Use with BKUI](../BKUI.md).

## Installation and Usage

### Installation

`BKUI-CLI` has been published to [npm](https://www.npmjs.com/package/@blueking/cli). You can install `BKUI-CLI` by executing the following command in any directory.

```bash
npm install -g @blueking/cli
```

### Usage

After `BKUI-CLI` is installed globally, you can enter the `bkui` global command.

```bash
bkui init test
```

### Help

Add `-h` or `--help` parameter `[options]` after each command `<command>` of `BKUI-CLI` to display the help of the current command.

**Next, we will introduce each command and parameter of `BKUI-CLI` in detail**

## bkui -h command

Input `bkui -h` or `bkui --help` in the command line will output the help information of `BKUI-CLI`.

```bash
$ bkui -h
$ bkui --help
```

## bkui init command

`bkui init` is one of the important commands of `BKUI-CLI`. From the previous chapters, we know that any command with `-h` or `--help` parameters will output the help information of the current command.

Entering bkui init <projectName> in the command line will execute the logic of generating the project

During the execution of the `bkui init` command, several questions will be asked to the user in the form of interactive questions and answers, and the answers will be obtained as parameters for initializing the project, and finally the front-end project will be generated

## Front-end local development and production build
### Local development
1. Create a new `${ROOT}/.bk.local.env` file
2. Fill in BK_LOGIN_URL = 'Fill in the login address'
3. Fill in BK_APP_HOST = '127.0.0.0', pay attention to the domain name written to the cookie after login
4. Execute `npm run dev` in the root directory
5. Configure the host and open the address where the domain name is configured in BK_APP_HOST

### Production build
Execute `npm run build` in the root directory

## Front-end project engineering introduction

### bin directory
There are 2 hook files in the bin directory, which can be executed before and after the project is built in the developer center

### mock-server Directory
The front-end framework provides mock services, which can be written in mock-server.

### paas-server directory
This directory uses express to start the web service. After deployment in the developer center, paas-server will be used to start the web service. This service will handle the logic of unified login, see paas-server -> middleware -> user.js file for details

### src directory
This directory writes vue-related code, including vue, vue-router, vue-store, pinia, api and other capabilities. For detailed writing syntax, please refer to the official document

### static directory
If some resources in the project are not involved in the package build, they can be placed in this file. When using this file in the project, use the format of `/file name`.

### types directory
The ts project will have this directory, where global ts files are stored

### .babelrc file
Write babel related configuration here, generally do not need to be changed

### .bk.local.env
Write variables in dev mode here, which has the highest priority in dev mode.

### .bk.development.env
Write variables in dev mode here, with priority second only to .bk.local.env

### .bk.env
Write variables here, which are effective in all modes, with the lowest priority

### .bk.production.env
Write variables in production mode here, with priority higher than .bk.env

### .bk.stag.env
Write variables in production mode here, and only valid in the pre-release environment of the developer center, with priority higher than .bk.env and .bk.production.env

## Configuration instructions
Configuration files are written uniformly in the .env file.
1. The variable name needs to start with `BK_`, and the value in the environment variable can be used in the form of `BK_XXX = $XXX`
2. Defined variables can be used in the front-end project using `process.env.BK_XXX`

### index.html Configuration instructions

The BlueKing front-end development scaffolding is used to help us build BlueKing SaaS applications, and it also supports us to build general web single-page applications.

There are several variables in the html file (`SITE_URL`, `BK_STATIC_URL`), and the configuration instructions are as follows:

#### SITE_URL

The router mode used in the front-end is `history`, so the front-end routing needs to set the **root path of the routing** and the **ajax asynchronous request address prefix** according to the value of this variable.

- In both BlueKing SaaS applications and non-BlueKing SaaS applications, the role of SITE_URL is **to set the root path of the routing**.

Let's take a look at a simple example to understand (**Assume that the domain name of the BlueKing you deployed is: http://www.bking.com, and the local development address is http://local-dev.bking.com**):

| | Production environment SITE_URL configuration (index.html) | Production environment access address | Local development SITE_URL configuration (index-dev.html) | Local development access address |
|-------------|---------------|---------------|---------------|---------------|
| BlueKing SaaS application | /t/open-v214/ (page injected by backend service) | http://www.bking.com/t/open-v214/ | / (default value: /) | http://local-dev.bking.com |
| Non-BlueKing SaaS application | / (BlueKing front-end development scaffolding is directly generated, non-BlueKing SaaS applications are usually not injected by backend services) | http://www.bking.com | / (Default value: /) | http://local-dev.bking.com |

**In BlueKing SaaS applications, we recommend not to modify the value of `SITE_URL` in `${ROOT}/index.html`. The production environment should be injected into the page by the backend. **

#### BK_STATIC_URL

The front end needs to determine the path of static resources based on this value (including lib.bundle.js written on HTML by default and js and css dynamically injected by webpack)

Let's take a look at a simple example (**assuming that the domain name of the BlueKing you deployed is: http://www.bking.com, and the address for local development is http://local-dev.bking.com**):

| | Production environment BK_STATIC_URL configuration (index.html) | Path prefix for loading static resources in the production environment | Local development BK_STATIC_URL configuration (index-dev.html) | Path prefix for loading static resources in local development |
|-------------|---------------|---------------|---------------|---------------|
| BlueKing SaaS application | /t/open-v214/static/dist/ (injected into the page by the backend service)| http://www.bking.com/t/open-v214/static/dist/ | / (Default value: /) | http://local-dev.bking.com/ |
| Non-BlueKing SaaS applications | / (BlueKing front-end development scaffolding is directly generated, non-BlueKing SaaS applications are usually not injected into the page by the backend service) | http://www.bking.com/ | / (Default value: /) | http://local-dev.bking.com/|

**In BlueKing SaaS applications, we recommend not to modify the value of `BK_STATIC_URL` in `${ROOT}/index.html`. The production environment should be injected into the page by the backend. **

### Switch between on-demand and full loading of component libraries

The BlueKing front-end development scaffolding integrates our [bk-magic-vue](https://magicbox.bk.tencent.com/components_vue/2.0/example/index.html#/) component library. The component library supports on-demand loading and full loading. The two methods are written differently. See `${ROOT}/src/common/demand-import.js` (on-demand loading) and `${ROOT}/src/common/fully-import.js` (full loading).

We switch in `${ROOT}/src/common/bkmagic.js`. If you need full loading, introduce `fully-import`, and if you need on-demand loading, introduce `demand-import`.

## Front-end build configuration instructions
You can write build-related configurations in `${ROOT}/bk.config.js`. The complete configuration is as follows:
```js
{
  assetsDir: 'static',
  outputAssetsDirName: 'static',
  outputDir: 'dist',
  publicPath: '/',
  host: '127.0.0.1',
  port: 8080,
  filenameHashing: true,
  cache: true,
  https: false,
  open: false,
  runtimeCompiler: true,
  typescript: false,
  tsconfig: './tsconfig.json',
  forkTsChecker: false,
  bundleAnalysis: false,
  parseNodeModules: false,
  replaceStatic: false,
  parallel: true,
  customEnv: '',
  target: 'web',
  libraryTarget: 'umd',
  libraryName: 'MyLibrary',
  splitChunk: true,
  splitCss: true,
  clean: true,
  copy: [{
    from: './static',
    to: './dist/static',
  }],
  resource: {
    main: {
      entry: './src/main',
      html: {
        filename: 'index.html',
        template: './index.html',
      },
    },
  },
  configureWebpack: {},
  chainWebpack: config => config,
}
```
### assetsDir
The name of the static resource directory used by the project

### outputAssetsDirName
The name of the static resource directory output after building

### outputDir
Build output directory

### publicPath
webpack's publicPath configuration

### host
The host used for local development

### port
The port used for local development

### filenameHashing
Whether to use hash for the built file

### cache
Whether to use cache, it is recommended to enable it, which can greatly improve development efficiency

### https
Whether to enable https. After opening, local development can use https, without additional certificate configuration

### open
When starting local development, whether to automatically open the browser

### typescript
Is it a ts project

### tsconfig
tsconfig address

### forkTsChecker
Whether to enable independent process type checking

### bundleAnalysis
Whether to analyze the build file

### parseNodeModules
Whether to build the files in node_modules

### replaceStatic
Whether to replace the static resource address

### parallel
Whether to enable multi-process building, you can fill in bool or number

### customEnv
Custom variable file address, you can load custom variables

### target
You can fill in web, library

### libraryTarget
webpack libraryTarget

### libraryName
Build library name

### splitChunk
Whether to automatically split the build file

### splitCss
Whether to build css into a separate file

### clean
Whether to clear the directory before each build

### copy
Copy file configuration

### resource
Configuration for html and entry mounting

### configureWebpack
Can be a function or an object. All configurations except loader or plugin can be written here

### chainWebpack
Write a function here, the parameter is chain, and the modified chain needs to be returned. Use the form of chain to modify all configurations of webpack