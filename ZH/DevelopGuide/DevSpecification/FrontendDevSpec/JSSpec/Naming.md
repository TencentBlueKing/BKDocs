### 1.【强制】变量使用 Camel 命名法

``` js
const loadingModules = {};
```

### 2.【强制】常量使用全部字母大写，单词间下划线分隔的命名方式

``` js
const HTML_ENTITY = {};
```

### 3.【强制】函数使用 Camel 命名法

``` js
function stringFormat(source) {
}
```

### 4.【强制】函数的参数使用 Camel 命名法

``` js
function hear(theBells) {
}
```

### 5.【强制】类使用 Pascal 命名法

``` js
function TextNode(options) {
}
```

### 6.【强制】类的方法 / 属性使用 Camel 命名法

``` js
function TextNode(value, engine) {
    this.value = value;
    this.engine = engine;
}

TextNode.prototype.clone = function () {
    return this;
};
```

### 7.【强制】枚举变量使用 Pascal 命名法，枚举的属性使用全部字母大写，单词间下划线分隔的命名方式

``` js
const TargetState = {
    READING: 1,
    READED: 2,
    APPLIED: 3,
    READY: 4
};
```

### 8.【强制】由多个单词组成的缩写词，在命名中，根据当前命名法和出现的位置，所有字母的大小写与首字母的大小写保持一致

``` js
function XMLParser() {
}

function insertHTML(element, html) {
}

const httpRequest = new HTTPRequest();
```

### 9.【强制】类名使用名词

``` js
function Engine(options) {
}
```

### 10.【建议】函数名使用动宾短语

``` js
function getStyle(element) {
}
```

### 11.【建议】boolean 类型的变量使用 is 或 has 开头

``` js
const isReady = false;
const hasMoreCommands = false;
```
