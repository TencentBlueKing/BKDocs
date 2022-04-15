注意：命名可以使用 class 选择器，也可以使用 id 选择器。但希望尽量使用 class 选择器

### 1. 使用语义化命名，尽量不使用表现化的或没有语义的命名

``` css
/* ✓ 推荐 */
.magic-search-box{}
.king-btn{}
/* ✗ 不推荐 */
.text-left{}
.green-text{}
.abc{}

```

### 2. 命名统一使用`-`来连接

``` css
/* ✓ 推荐 */
.magic-header .magic-footer .magic

/* ✗ 不推荐 */
.magic_header .magic_footer .magicHeader .magicFooter

```

### 3. 命名统一添加前缀
使用前缀是让类名容易识别，同时避免和其它组件冲突。因为引用的 UI 库很多，如 bootstrap、kendoui，后面会接入更多 UI 库和组件，所以在 css 命名的时候能尽量使用前缀。

``` css
/* ✓ 推荐 */
.magic-header .magic-content
/* 表格 table1为模块名 */
.king-table1-title .king-table1-header .king-table1-footer
/* ✗ 不推荐 */
.item-grid .item-table
```

### 4. 相同语义的不同类命名

- 方法：直接加数字或字母区分即可（如：.magic-list、.magic-list2、.magic-list3 等，都是列表模块，但是是完全不一样的模块）。
- 扩展类必须和其基类同时使用于同一个节点：class="g-xxx g-xxx-1" class="m-xxx m-xxx-1" class="u-yyy u-yyy-1" class="xxx xxx-yyy"。

```html
.magic-logo2、.magic-logo3、.ling-btn、.ling-btn2
``` 

### 5. CSS 的分类，主要包括以下类型

- 布局样式（layout）：将页面分割为几个大块，通常有头部、主体、主栏、侧栏、尾部等！
- 模块样式（common）：通常是一个语义化的可以重复使用的较大的整体！比如导航、登录、注册、各种列表、评论、搜索等！
- 元件样式（unit）：通常是一个不可再分的较为小巧的个体，常被重复用于各种模块中！比如按钮、输入框、loading、图标等
- 辅助样式（fun）：将一原子样式独立出来，如清浮动，字体大小、padding、margin

``` css

/* 布局样式 */
.magic-header,.magic-footer a{
    background:url(images/sprite.png) no-repeat;
}
.king-table1-header{}
.king-form2-group{}

/* 模块样式 */
.magic-common-search{}
.king-common-nav{}

/* 元件样式 */
.magic-unit-btn{}
.magic-unit-loading{}

.king-table2-btn{}
.king-table2-loading{}

.king-fun-fl{float: left;}

```

