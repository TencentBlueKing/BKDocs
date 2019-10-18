# 第一章 代码规范

## 1. JS 编码规范

本编码规范在 [JavaScript Standard Style](https://github.com/standard/standard/blob/master/docs/README-zhcn.md) 的基础上，根据蓝鲸开发人员的开发习惯进行了适配。

### 1.1 细则

#### 生产环境不允许使用 debugger 语句

- ✗ 错误

```js
function isTruthy(x) {
    debugger
    return Boolean(x)
}
```

- ✓ 正确

```js
function isTruthy(x) {
    return Boolean(x)
}
```

#### 不允许出现空代码块

- ✗ 错误

```js
if (foo) {
}

while (foo) {
}
```

- ✓ 正确

```js
if (foo) {
    // empty
}

while (foo) {
    /* empty */
}
```


#### 禁止在语句后面使用分号

- ✗ 错误

```js
var name = "ESLint";

object.method = function() {
    // ...
};

```

- ✓ 正确

```js
var name = "ESLint"

object.method = function() {
    // ...
}
```

#### 函数定义圆括号前要有一个空格

- ✗ 错误

```js
function foo() {
    // ...
}

var bar = function() {
    // ...
};

var bar = function foo() {
    // ...
};

class Foo {
    constructor() {
        // ...
    }
}

var foo = {
    bar() {
        // ...
    }
};

var foo = async() => 1

```

- ✓ 正确

```js
function foo () {
    // ...
}

var bar = function () {
    // ...
};

var bar = function foo () {
    // ...
};

class Foo {
    constructor () {
        // ...
    }
}

var foo = {
    bar () {
        // ...
    }
};

var foo = async () => 1

```

#### 语句末尾不能出现空白字符（空白行除外）

#### 禁止使用拖尾逗号

- ✗ 错误

```js
var foo = {
    bar: "baz",
    qux: "quux",
}
```

- ✓ 正确

```js
var foo = {
    bar: "baz",
    qux: "quux"
}
```

#### 键值对的冒号前不允许有空格，冒号后必须有空格

- ✗ 错误

```js
var obj = {
    "foo" : 42,
    "bar" :32
}

```

- ✓ 正确

```js
var obj = {
    "foo": 42,
    "bar": 32
}
```

#### 关键字前后必须保留空格

- ✗ 错误

```js
if(foo){
    //...
}else if(bar) {
    //...
}else{
    //...
}

```

- ✓ 正确

```js
if (foo) {
    //...
} else if (bar) {
    //...
} else {
    //...
}
```

#### 操作符前后必须保留空格

- ✗ 错误

```js
a+b

a+ b

a +b

a?b:c

const a={b:1};

var {a=0}=bar;

function foo(a=0) { }
```

- ✓ 正确

```js
a + b

a       + b

a ? b : c

const a = {b:1};

var {a = 0} = bar;

function foo(a = 0) { }
```

#### 注释前面必须保留空格

- ✗ 错误

```js
//This is a comment with no whitespace at the beginning

/*This is a comment with no whitespace at the beginning */
```

- ✓ 正确

```js
// This is a comment with a whitespace at the beginning

/* This is a comment with a whitespace at the beginning */
```

#### 除需要转义的情况外，字符串统一使用单引号

- ✗ 错误

```js
console.log("hello there")
```

- ✓ 正确

```js
console.log('hello there')

// 字符串中含有单引号字符，则可以使用双引号
$("<div class='box'>")
```

#### 始终使用 `===` 替代 `==`

例外： `obj == null` 可以用来检查 `null || undefined`

- ✗ 错误

```js
if (name == 'John')
if (name != 'John')
```

- ✓ 正确

```js
if (name === 'John')
if (name !== 'John')
```


#### 使用驼峰命名法（Object key 除外）

- ✗ 错误

```js
// 包导入
import { no_camelcased } from "external-module"

// 变量定义
var my_favorite_color = "#112C85";

// 函数定义
function do_something() {
    // ...
}

```

- ✓ 正确

```js
// 包导入
import { no_camelcased as camelCased } from "external-module"

// 变量定义
var myFavoriteColor = "#112C85";

// 函数定义
function doSomething() {
    // ...
}

// Object key 允许非驼峰命名
var obj = {
    my_pref: 1
}
```

#### 【建议】缩进使用4个空格

- ✗ 错误

```js
if (a) {
  var b = a
  function foo(c) {
    var d = c
  }
}

```

- ✓ 正确

```js
if (a) {
    var b = a
    function foo(c) {
        var d = c
    }
}

```

### 1.2 配置

以上代码规范均可通过配置 [eslint](https://eslint.org/) 进行静态检查和自动修复


## 2. 代码提交规范

### 2.1 代码自检

为保证代码质量，在提交代码前，必须对代码完成以下检查

#### 2.1.1 HTML

1. 不允许存在用于页面调试的文本

2. 不允许存在无用的注释代码段

#### 2.1.2 JavaScript

1.  不允许存在调试语句，如 debugger，console.log 等

2.  不允许存在无用的注释代码段

### 2.2 提交备注

每次代码提交必须有备注说明，注明本次提交做了哪些修改

**commit 分类**

`bugfix` - 线上功能 bug  
`sprintfix` - 未上线代码修改 （功能模块未上线部分 bug）  
`minor` - 不重要的修改（换行，拼写错误等）  
`feature` - 新功能说明


## 3. 前端代码注释

### 3.1 HTML 注释
```html
<!-- 容器 -->
<div class="container">
    ...
    <!-- 用户名 -->
    <div id="user_name">
    ...
    </div>
    <!-- /用户名 -->
    ...
</div>
<!-- /容器 -->
```

### 3.2 CSS 注释

内容比较少是可以只在顶部加注释，内容比较多时在尾部加结束标签 `/* 注释内容 end */`
```css
/* 新建任务 start */

.new-task{}

/* 新建任务名 */
.task-name{color:\#333;}

/* 新建任务时间 */
.task-created-time{background:url(img/clock.png) no-repeat;}

/* 新建任务 end */
```

### 3.3 JavaScript 注释

JavaScript注释注释同上，函数如果有参数，建议简单备注一下参数的内容和类型。


## 4. 文件或包的引用

1. 前端页面：在页面中引用 css 和 js、或配置 url 路径时，必须使用“绝对路径”，而不要使用 `../`，`./` 等相对路径的引用方式

2. 发布上线之前，需要检查相应的环境是否存在引用的静态资源，不同环境之间不能交叉引用。

3. 在页面中引用开发者编写的静态文件时，需要在资源路径后面增加版本号。如：

    `<link rel="stylesheet" href="${STATIC_URL}index.css?v=${STATIC_VERSION}">`

    `<script src="${STATIC_URL}index.js?v=${STATIC_VERSION}"></script>`

    发布上线前，需检查静态文件是否有改动。若有改动，则需要更新 settings 中 `STATIC_VERSION` 的值，以避免用户加载缓存的旧版本静态文件。
