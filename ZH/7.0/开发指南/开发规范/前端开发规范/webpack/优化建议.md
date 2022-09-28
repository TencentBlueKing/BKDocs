
## 1. 优化构建速度

Webpack 在启动后会根据 Entry 配置的入口出发，递归地解析所依赖的文件。这个过程分为搜索文件和把匹配的文件进行分析、转化的两个过程，因此可以从这两个角度来进行优化配置。

### 1.1 缩小文件的搜索范围

#### 1.1.1 优化 Loader 配置

​    由于 Loader 对文件的转换操作很耗时，所以需要让尽可能少的文件被 Loader 处理。我们可以通过以下 3 方面优化 Loader 配置：

（1）优化正则匹配

（2）通过 cacheDirectory 选项开启缓存

（3）通过 include、exclude 来减少被处理的文件

**优化配置：**

```javascript
{
  // 1、如果项目源码中只有js文件，就不要写成/\.jsx?$/，以提升正则表达式的性能
  test: /\.js$/,
  // 2、babel-loader支持缓存转换出的结果，通过cacheDirectory选项开启
  loader: 'babel-loader?cacheDirectory',
  // 3、只对项目根目录下的src 目录中的文件采用 babel-loader
  include: [resolve('src')]
}
```

#### 1.1.2 优化 resolve.modules 配置

​    resolve.modules 用于配置 Webpack 去哪些目录下寻找第三方模块。resolve.modules 的默认值是［node modules］，含义是先去当前目录的/node modules 目录下去找我们想找的模块，如果没找到，就去上一级目录../node modules 中找，再没有就去../ .. /node modules 中找，以此类推，这和 Node.js 的模块寻找机制很相似。当安装的第三方模块都放在项目根目录的./node modules 目录下时，就没有必要按照默认的方式去一层层地寻找，可以指明存放第三方模块的绝对路径，以减少寻找。

**优化配置：**

```javascript
resolve: {
// 使用绝对路径指明第三方模块存放的位置，以减少搜索步骤
modules: [path.resolve(__dirname,'node_modules')]
}
```

#### 1.1.3 优化 resolve.alias 配置

​    resolve.alias 配置项通过别名来将原导入路径映射成一个新的导入路径。

**项目中的配置使用：**

```javascript
alias: {
  '@': resolve('src'),
},
// 通过以上的配置，引用src底下的common.js文件，就可以直接这么写
import common from '@/common.js';

```

#### 1.1.4 优化 resolve.extensions 配置 

默认值：`extensions:['.js', '.json']`,当导入语句没带文件后缀时，Webpack 会根据 extensions 定义的后缀列表进行文件查找，所以：

- 列表值尽量少
- 频率高的文件类型的后缀写在前面
- 源码中的导入语句尽可能的写上文件后缀，如`require(./data)`要写成`require(./data.json)`

#### 1.1.5 优化 resolve.noParse 配置

​    noParse 配置项可以让 Webpack 忽略对部分没采用模块化的文件的递归解析和处理，这样做的好处是能提高构建性能。原因是一些库如 jQuery、ChartJS 庞大又没有采用模块化标准，让 Webpack 去解析这些文件既耗时又没有意义。 noParse 是可选的配置项，类型需要是 RegExp 、[RegExp]、function 中的一种。

例如，若想要忽略 jQuery 、ChartJS 

**则优化配置如下：**

```javascript
// 使用正则表达式 
noParse: /jquerylchartjs/ 
// 使用函数，从 Webpack3.0.0开始支持 
noParse: (content)=> { 
// 返回true或false 
return /jquery|chartjs/.test(content); 
}
```



### 1.2 使用 HappyPack 开启多进程 Loader 转换

在整个构建流程中，最耗时的就是 Loader 对文件的转换操作了，而运行在 Node.js 之上的 Webpack 是单线程模型的，也就是只能一个一个文件进行处理，不能并行处理。HappyPack 可以将任务分解给多个子进程，最后将结果发给主进程。JS 是单线程模型，只能通过这种多进程的方式提高性能。

HappyPack 使用如下：

```javascript
（1）HappyPack插件安装：
    $ npm i -D happypack
（2）webpack.base.conf.js 文件对module.rules进行配置
    module: {
     rules: [
      {
        test: /\.js$/,
        // 将对.js 文件的处理转交给 id 为 babel 的HappyPack实例
          use:['happypack/loader?id=babel'],
          include: [resolve('src'), resolve('test'),   
            resolve('node_modules/webpack-dev-server/client')],
        // 排除第三方插件
          exclude:path.resolve(__dirname,'node_modules'),
        },
        {
          test: /\.vue$/,
          use: ['happypack/loader?id=vue'],
        },
      ]
    },
（3）webpack.prod.conf.js 文件进行配置    
		const HappyPack = require('happypack');
    // 构造出共享进程池，在进程池中包含5个子进程
    const HappyPackThreadPool = HappyPack.ThreadPool({size:5});
    plugins: [
       new HappyPack({
         // 用唯一的标识符id，来代表当前的HappyPack是用来处理一类特定的文件
         id:'vue',
         loaders:[
           {
             loader:'vue-loader',
             options: vueLoaderConfig
           }
         ],
         threadPool: HappyPackThreadPool,
       }),

       new HappyPack({
         // 用唯一的标识符id，来代表当前的HappyPack是用来处理一类特定的文件
         id:'babel',
         // 如何处理.js文件，用法和Loader配置中一样
         loaders:['babel-loader?cacheDirectory'],
         threadPool: HappyPackThreadPool,
       }),
    ]
```

除了 id 和 loaders，HappyPack 还支持这三个参数：`threads、verbose、threadpool`，threadpool 代表共享进程池，即多个 HappyPack 实例都用同个进程池中的子进程处理任务，以防资源占用过多。

### 1.3 使用 ParallelUglifyPlugin 开启多进程压缩 JS 文件

使用 UglifyJS 插件压缩 JS 代码时，需要先将代码解析成 Object 表示的 AST（抽象语法树），再去应用各种规则去分析和处理 AST，所以这个过程计算量大耗时较多。ParallelUglifyPlugin 可以开启多个子进程，每个子进程使用 UglifyJS 压缩代码，可以并行执行，能显著缩短压缩时间。

使用也很简单，把原来的 UglifyJS 插件换成本插件即可，使用如下：

```javascript
npm i -D webpack-parallel-uglify-plugin

// webpack.config.json
const ParallelUglifyPlugin = require('wbepack-parallel-uglify-plugin');
//...
plugins: [
    new ParallelUglifyPlugin({
        uglifyJS:{
            //...这里放uglifyJS的参数
        },
        //...其他ParallelUglifyPlugin的参数，设置cacheDir可以开启缓存，加快构建速度
    })
]
```

## 2. 优化开发体验

### 2.1 使用自动刷新 

 借助自动化的手段，在监听到本地源码文件发生变化时，自动重新构建出可运行的代码后再控制浏览器刷新。

 **项目中自动刷新的配置：**

```javascript
devServer: {
  watchOptions: {
    // 不监听的文件或文件夹，支持正则匹配
    ignored: /node_modules/,
    // 监听到变化后等300ms再去执行动作
    aggregateTimeout: 300,
    // 默认每秒询问1000次
    poll: 1000
  }
}
```

**相关优化措施：** 

（1）配置忽略一些不监听的一些文件，如：node_modules。 

（2）`watchOptions.aggregateTirneout` 的值越大性能越好，因为这能降低重新构建的频率。

（3）`watchOptions.poll` 的值越小越好，因为这能降低检查的频率。

### 2.2 开启模块热替换 

DevServer 支持模块热替换( Hot Module Replacement )，可在不刷新整个网页的情况下做到超灵敏实时预览。

原理是在一个源码发生变化时，只需重新编译发生变化的模块，再用新输出的模块替换掉浏览器中对应的旧模块。

模块热替换技术在很大程度上提升了开发效率和体验 。 

**模块热替换的配置：**

```javascript
devServer: {
  hot: true,
},
plugins: [
  new webpack.HotModuleReplacementPlugin(),
// 显示被替换模块的名称
  new webpack.NamedModulesPlugin(), // HMR shows correct file names
]
```



## 3. 优化输出质量

### 3.1 压缩文件体积

#### 3.1.1 减少冗余代码

 `babel-plugin-transform-runtime` 是 Babel 官方提供的一个插件，作用是减少冗余的代码。 

 Babel 在将 ES6 代码转换成 ES5 代码时，通常需要一些由 ES5 编写的辅助函数来完成新语法的实现，例如在转换 class extent 语法时会在转换后的 ES5 代码里注入 extent 辅助函数用于实现继承。

`babel-plugin-transform-runtime`会将相关辅助函数进行替换成导入语句，从而减小 babel 编译出来的代码的文件大小。

#### 3.1.2 压缩代码-JS、ES、CSS

**压缩 JS：Webpack 内置 UglifyJS 插件、ParallelUglifyPlugin**

会分析 JS 代码语法树，理解代码的含义，从而做到去掉无效代码、去掉日志输入代码、缩短变量名等优化。常用配置参数如下：

```javascript
const UglifyJSPlugin = require('webpack/lib/optimize/UglifyJsPlugin');
//...
plugins: [
    new UglifyJSPlugin({
        compress: {
            warnings: false,  //删除无用代码时不输出警告
            drop_console: true,  //删除所有console语句，可以兼容IE
            collapse_vars: true,  //内嵌已定义但只使用一次的变量
            reduce_vars: true,  //提取使用多次但没定义的静态值到变量
        },
        output: {
            beautify: false, //最紧凑的输出，不保留空格和制表符
            comments: false, //删除所有注释
        }
    })
]
```

使用`webpack --optimize-minimize` 启动 webpack，可以注入默认配置的 UglifyJSPlugin

**压缩 ES6：第三方 UglifyJS 插件**

随着越来越多的浏览器支持直接执行 ES6 代码，应尽可能的运行原生 ES6，这样比起转换后的 ES5 代码，代码量更少，且 ES6 代码性能更好。直接运行 ES6 代码时，也需要代码压缩，第三方的 uglify-webpack-plugin 提供了压缩 ES6 代码的功能：

```javascript
npm i -D uglify-webpack-plugin@beta //要使用最新版本的插件
//webpack.config.json
const UglifyESPlugin = require('uglify-webpack-plugin');
//...
plugins:[
    new UglifyESPlugin({
        uglifyOptions: {  //比UglifyJS多嵌套一层
            compress: {
                warnings: false,
                drop_console: true,
                collapse_vars: true,
                reduce_vars: true
            },
            output: {
                beautify: false,
                comments: false
            }
        }
    })
]
```

另外要防止 babel-loader 转换 ES6 代码，要在.babelrc 中去掉 babel-preset-env，因为正是 babel-preset-env 负责把 ES6 转换为 ES5。

**压缩 CSS：css-loader?minimize、PurifyCSSPlugin**

cssnano 基于 PostCSS，不仅是删掉空格，还能理解代码含义，例如把`color:#ff0000` 转换成 `color:red`，css-loader 内置了 cssnano，只需要使用 `css-loader?minimize` 就可以开启 cssnano 压缩。

另外一种压缩 CSS 的方式是使用[PurifyCSSPlugin](https://github.com/webpack-contrib/purifycss-webpack)，需要配合 `extract-text-webpack-plugin` 使用，它主要的作用是可以去除没有用到的 CSS 代码，类似 JS 的 Tree Shaking。

#### 3.1.3 区分环境--减小生产环境代码体积

代码运行环境分为开发环境和生产环境，代码需要根据不同环境做不同的操作，区分环境之后可以使输出的生产环境的代码体积减小。Webpack 中使用 DefinePlugin 插件来定义配置文件适用的环境。

```javascript
const DefinePlugin = require('webpack/lib/DefinePlugin');
//...
plugins:[
    new DefinePlugin({
        'process.env': {
            NODE_ENV: JSON.stringify('production')
        }
    })
]
```

注意，`JSON.stringify('production')` 的原因是，环境变量值需要一个双引号包裹的字符串，而 stringify 后的值是`'"production"'`

然后就可以在源码中使用定义的环境：

```javascript
if(process.env.NODE_ENV === 'production'){
    console.log('你在生产环境')
    doSth();
}else{
    console.log('你在开发环境')
    doSthElse();
}
```

当代码中使用了 process 时，Webpack 会自动打包进 process 模块的代码以支持非 Node.js 的运行环境，这个模块的作用是模拟 Node.js 中的 process，以支持`process.env.NODE_ENV === 'production'` 语句。

#### 3.1.4 使用 Tree Shaking 剔除 JS 死代码

Tree Shaking 可以剔除用不上的死代码，它依赖 ES6 的 import、export 的模块化语法，适合用于 Lodash、utils.js 等工具类较分散的文件。**它正常工作的前提是代码必须采用 ES6 的模块化语法**。

**启用 Tree Shaking：**

- 修改.babelrc 以保留 ES6 模块化语句：

```javascript
{
    "presets": [
        [
            "env", 
            { "module": false },   //关闭Babel的模块转换功能，保留ES6模块化语法
        ]
    ]
}
```

- 启动 webpack 时带上 --display-used-exports 可以在 shell 打印出关于代码剔除的提示

- 使用 UglifyJSPlugin，或者启动时使用--optimize-minimize

- 在使用第三方库时，需要配置 `resolve.mainFields: ['jsnext:main', 'main']` 以指明解析第三方库代码时，采用 ES6 模块化的代码入口



### 3.2 加速网络请求

#### 3.2.1 按需加载代码 

通过 vue 写的单页应用时，可能会有很多的路由引入。当打包构建的时候，javascript 包会变得非常大，影响加载。如果我们能把不同路由对应的组件分割成不同的代码块，然后当路由被访问的时候才加载对应的组件，这样就更加高效了。这样会大大提高首屏显示的速度，但是可能其他的页面的速度就会降下来。 

**项目中路由按需加载（懒加载）的配置：**

```javascript
const Foo = () => import('./Foo.vue')
const router = new VueRouter({
  routes: [
    { path: '/foo', component: Foo }
  ]
})
```

#### 3.2.2、提取公共代码 

  如果每个页面的代码都将这些公共的部分包含进去，则会造成以下问题 ： 

 • 相同的资源被重复加载，浪费用户的流量和服务器的成本。

 • 每个页面需要加载的资源太大，导致网页首屏加载缓慢，影响用户体验。 

​    如果将多个页面的公共代码抽离成单独的文件，就能优化以上问题 。Webpack 内置了专门用于提取多个 Chunk 中的公共部分的插件 CommonsChunkPlugin。 

**项目中 CommonsChunkPlugin 的配置：**

```javascript
// 所有在 package.json 里面依赖的包，都会被打包进 vendor.js 这个文件中。
new webpack.optimize.CommonsChunkPlugin({
  name: 'vendor',
  minChunks: function(module, count) {
    return (
      module.resource &&
      /\.js$/.test(module.resource) &&
      module.resource.indexOf(
        path.join(__dirname, '../node_modules')
      ) === 0
    );
  }
}),
// 抽取出代码模块的映射关系
new webpack.optimize.CommonsChunkPlugin({
  name: 'manifest',
  chunks: ['vendor']
})
```

#### 3.2.3 使用 CDN 加速静态资源加载

- **HTML 文件：放在自己的服务器上且关闭缓存，不接入 CDN**
- **静态的 JS、CSS、图片等资源：开启 CDN 和缓存，同时文件名带上由内容计算出的 Hash 值，这样只要内容变化 hash 就会变化，文件名就会变化，就会被重新下载而不论缓存时间多长。**

**总之，构建需要满足以下几点：**

- 静态资源导入的 URL 要变成指向 CDN 服务的绝对路径的 URL
- 静态资源的文件名需要带上根据内容计算出的 Hash 值
- 不同类型资源放在不同域名的 CDN 上

**配置：**

```javascript
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const {WebPlugin} = require('web-webpack-plugin');
//...
output:{
 filename: '[name]_[chunkhash:8].js',
 path: path.resolve(__dirname, 'dist'),
 publicPatch: '//js.cdn.com/id/', //指定存放JS文件的CDN地址
},
module:{
 rules:[{
     test: /\.css/,
     use: ExtractTextPlugin.extract({
         use: ['css-loader?minimize'],
         publicPatch: '//img.cdn.com/id/', //指定css文件中导入的图片等资源存放的cdn地址
     }),
 },{
    test: /\.png/,
    use: ['file-loader?name=[name]_[hash:8].[ext]'], //为输出的PNG文件名加上Hash值 
 }]
},
plugins:[
  new WebPlugin({
     template: './template.html',
     filename: 'index.html',
     stylePublicPath: '//css.cdn.com/id/', //指定存放CSS文件的CDN地址
  }),
 new ExtractTextPlugin({
     filename:`[name]_[contenthash:8].css`, //为输出的CSS文件加上Hash
 })
]
```

## 4. 其他小建议

1、配置 babel-loader 时，`use: [‘babel-loader?cacheDirectory’]` cacheDirectory 用于缓存 babel 的编译结果，加快重新编译的速度。另外注意排除 node_modules 文件夹，因为文件都使用了 ES5 的语法，没必要再使用 Babel 转换。

2、配置 externals，排除因为已使用`<script>`标签引入而不用打包的代码，noParse 是排除没使用模块化语句的代码。

3、配置 performance 参数可以输出文件的性能检查配置。

4、配置 profile：true，是否捕捉 Webpack 构建的性能信息，用于分析是什么原因导致构建性能不佳。

5、配置 cache：true，是否启用缓存来提升构建速度。

6、可以使用 url-loader 把小图片转换成 base64 嵌入到 JS 或 CSS 中，减少加载次数。

7、通过 imagemin-webpack-plugin 压缩图片，通过 webpack-spritesmith 制作雪碧图。

8、开发环境下将 devtool 设置为 cheap-module-eval-source-map，因为生成这种 source map 的速度最快，能加速构建。在生产环境下将 devtool 设置为 hidden-source-map