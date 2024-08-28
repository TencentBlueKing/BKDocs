### 1. 推荐采用竖向排版方式，便于选择器的寻找和阅读

```html
.king-class1 .itm{
    height:17px;
    line-height:17px;
    font-size:12px;
}

/* 这是一个有嵌套定义的选择器 */
@media all and (max-width:600px) {
    .king-class1 .itm {
        height:17px;
        line-height:17px;
        font-size:12px;
    }
    .king-class2 .itm {
        width:100px;
        overflow:hidden;
    }
}
```

### 2. 省略值为 0 时的单位
为节省不必要的字节同时也使阅读方便，我们将 0px、0em、0%等值缩写为 0。

```html
.king-tree-box {
    margin:0 10px;
    background-position:50% 0;
}
```

### 3. 使用单引号
省略 url 引用中的引号，其他需要引号的地方使用单引号

```html
.magic-box {
    background:url(bg.png);
}
.magic-box:after {
    content:'.';
}
``` 

### 4. 根据属性的重要性按顺序书写

只遵循横向顺序即可，先显示定位布局类属性，后盒模型等自身属性，最后是文本类及修饰类属性

- 私有在前，标准在后
先写带有浏览器私有标志的，后写 W3C 标准的

```html
.magic-box {
    -webkit-box-shadow:0 0 0 #000;
    -moz-box-shadow:0 0 0 #000;
    box-shadow:0 0 0 #000;
}
```

### 1.【强制】使用垂直排版

``` css
/* ✗ 不推荐 */
.demo {width: 100px; height: 100px; color: #666;}

/* ✓ 推荐 */
.demo {
    width: 100px; 
    height: 100px; 
    color: #666;
}
```

### 2.【强制】选择器和左`{`之间空一格，属性和值之间空一格

``` css
/* ✗ 不推荐 */
.demo{
    width:100px; 
    height:100px; 
    color:#666;
}

/* ✓ 推荐 */
.demo {
    width: 100px; 
    height: 100px; 
    color: #666;
}
```

### 3. 【强制】组合选择器不要在一行

``` css
/* ✗ 不推荐 */
.table>tbody>tr>td,.table>tbody>tr>th,.table>tfoot>tr>td,.table>tfoot>tr>th,.table>thead>tr>td{
    vertical-align: middle;
}

/* ✓ 推荐 */
.table>tbody>tr>td,
.table>tbody>tr>th,
.table>tfoot>tr>td,
.table>tfoot>tr>th,
.table>thead>tr>td {
    vertical-align: middle;
}
```