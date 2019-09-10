## 一、代码规范

### 1.编码规范 {#coding}

#### 1.1命名规则

类的基础命名方式：“项目英文简写-当前页-页面内容块”如“.ijobs-index-box”。

Id 的基础命名方式：语义化，并使用下滑杠连接，如步骤名称可命名为‘#step_name’。

Javascript 变量命名方式：按照变量类型的首个字母为前缀，使用驼峰命名法；

|类型	|变量名前缀|
|--|--|
|Array 数组|	a|
|Boolean 布尔|	b|
|Float 浮点	|l|
|Function 函数	|f|
|Integer(int) 整型|	n|
|Object 对象|	o|
|Regular Expression 正则	|r|
|String 字符串	|s|

例子：
```
    var aName = ['zhangsan','lizi','zhaowu'];  //Array 数组
    var oBtn = window.document.getElementById('btn');  //Object 对象
    function fnName(){};  //Function 函数
    var nAge = 25;  //Integer(int) 整型
    var sWebURL="www.wangyingran.com";  //String 字符串
```
### 2.代码提交规范 {#submit}

每次代码提交必须有备注说明，注明本次提交做了哪些修改

commit 分类：

- bugfix: -------- 线上功能 bug

- sprintfix: ----- 未上线代码修改 （功能模块未上线部分 bug）

- minor: --------- 不重要的修改（换行，拼写错误等）

- feature: ----- 新功能说明

### 3.前端代码注释 {#annotation}

#### 3.1 HTML 注释
```
     <!-- 容器 -->
     <div class=“container”>
     ...
     <!-- 用户名 -->
     <div id=“user_name”>
     ...
     </div>
     <!-- /用户名 -->
     ...
     </div>
     <!-- /容器 -->
```
#### 3.2 CSS 注释

内容比较少是可以只在顶部加注释，内容比较多时在尾部加结束标签“/* 注释内容 end */”
```
     /* 新建任务 start */
     .new-task{}
     /* 新建任务名 */
     .task-name{color:#333;}
     /* 新建任务时间 */
     .task-created-time{background:url(img/clock.png)
     no-repeat;}
     /* 新建任务 end */
```
#### 3.3 JS 注释

JS 注释同上，函数如果有参数，建议简单备注一下参数的内容和类型。

### 4.文件或包的引用{#reference}

(1)**【必须】** 前端页面：在页面中引用 CSS 和 JS、或配置 url 路径时，必须使用“绝对路径”，而不要使用‘../’，‘./’等相对路径的引用方式。

(2)发布上线之前，需要检查相应的环境是否存在引用的静态资源，不同环境之间不能交叉引用。

(3)在页面中引用开发者编写的静态文件时，需要在资源路径后面增加版本号。

如：
```
     <link rel="stylesheet" href="${STATIC_URL}index.css?v=${STATIC_VERSION}">
     <script src="${STATIC_URL}index.js?v=${STATIC_VERSION}"></script>
```
发布上线前，需检查静态文件是否有改动。若有改动，则需要更新 settings 中 STATIC_VERSION 的值，以避免用户加载缓存的旧版本静态文件。
