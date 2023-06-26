本规范在 [JavaScript Standard Style](https://github.com/standard/standard/blob/master/docs/README-zhcn.md) 的基础上，进行适配。

# 1. 文件

### 1.1【建议】 `JavaScript` 文件使用无 `BOM` 的 `UTF-8` 编码

注解：UTF-8 编码具有更广泛的适应性。BOM 在使用程序或工具处理文件时可能造成不必要的干扰。


# 2. 缩进

### 2.1【强制】使用两个空格代替 tab 做为一个缩进层级

- ✓ good

``` js
if (a) {
  const b = a;
  function foo(c) {
    const d = c;
  }
}
```

- ✗ bad

``` js
if (a) {
    const b = a;
    function foo(c) {
        const d = c;
    }
}
```

### 2.2【强制】switch 下的 case 和 default 必须增加一个缩进层级

- ✓ good

``` js
switch (variable) {
  case '1':
    // do...
    break;

  case '2':
    // do...
    break;

  default:
    // do...

}
```

- ✗ bad

``` js
switch (variable) {
case '1':
  // do...
  break;

case '2':
  // do...
  break;

default:
  // do...

}
```

# 3. 空格

### 3.1【强制】运算符两侧必须有一个空格，一元运算符与操作对象之间不允许有空格

- ✓ good

``` js
const a = !arr.length;

a = b + c;

a ? b : c;

a++;
```

- ✗ bad

```js
const a =!arr.length;

a= b + c;

a? b: c;

a ++;
```

### 3.2【强制】用作代码块起始的左花括号 `{` 前必须有一个空格

- ✓ good

``` js
if (condition) {
}

while (condition) {
}

function funcName() {
}
```

- ✗ bad

```js
if (condition){
}

while (condition){
}

function funcName(){
}
```

### 3.3【强制】`if` / `else` / `for` / `while` / `function` / `switch` / `do` / `try` / `catch` / `finally` 关键字后，必须有一个空格

- ✓ good

```js
if (condition) {
}

while (condition) {
}

(function () {
})();

```

- ✗ bad

```js
if(condition) {
}

while(condition) {
}

(function() {
})();
```

### 3.4【强制】在对象创建时，属性中的 `:` 之后必须有空格，`:` 之前不允许有空格

- ✓ good

``` js
const obj = {
  a: 1,
  b: 2,
  c: 3,
};
```

- ✗ bad

```js
const obj = {
  a : 1,
  b:2,
  c :3,
};
```

### 3.5【强制】函数声明、具名函数表达式、函数调用中，函数名和 `(` 之间不允许有空格

- ✓ good

``` js
function funcName() {
}

const funcName = function funcName() {
};

funcName();
```

- ✗ bad

```js
function funcName () {
}

const funcName = function funcName () {
};

funcName ();
```

### 3.6【强制】 `,` 和 `;` 前不允许有空格

- ✓ good

``` js
callFunc(a, b);
```

- ✗ bad

```js
callFunc(a , b) ;
```

### 3.7【强制】单行声明的数组与对象，如果包含元素，`{}` 和 `[]` 内紧贴括号部分不允许包含空格

解释：

声明包含元素的数组与对象，只有当内部元素的形式较为简单时，才允许写在一行。元素复杂的情况，还是应该换行书写。

- ✓ good

``` js
const arr1 = [];
const arr2 = [1, 2, 3];
const obj1 = {};
const obj2 = {name: 'obj'};
const obj3 = {
  name: 'obj',
  age: 20,
  sex: 1
};
```

- ✗ bad

```js
const arr1 = [ ];
const arr2 = [ 1, 2, 3 ];
const obj1 = { };
const obj2 = { name: 'obj' };
const obj3 = {name: 'obj', age: 20, sex: 1};
```

### 3.8【强制】箭头函数前后必须加空格

- ✓ good

``` js
() => {};
(a) => {};
a => a;
() => {'\n'};
```

- ✗ bad

```js
()=> {};
() =>{};
(a)=> {};
(a) =>{};
a =>a;
a=> a;
()=> {'\n'};
() =>{'\n'};
```

### 3.9【强制】禁止行尾有空格

- ✓ good

```js
const foo = 0;
const baz = 5;
```

- ✗ bad

```js
const foo = 0;//•••••
const baz = 5;//••
```

### 3.10【强制】generator 的 * 前面禁止有空格，后面必须有空格

- ✓ good

```js
function* generator() {}

const anonymous = function* () {};

const shorthand = { * generator() {} };
```

- ✗ bad

```js
function *generator() {}

const anonymous = function *() {};

const shorthand = { *generator() {} };
```

### 3.11【强制】注释的斜线或 * 后必须有空格，用一个空格开始所有的注释

- ✓ good

```js
/* eslint spaced-comment: ["error", "always"] */

// This is a comment with a whitespace at the beginning

/* This is a comment with a whitespace at the beginning */

/**
 * This is a comment with a whitespace at the beginning
 */

/**
This comment has a newline
*/
```

```js
/* eslint spaced-comment: ["error", "always"] */

/**
* I am jsdoc
*/
```

- ✗ bad

```js
/*eslint spaced-comment: ["error", "always"]*/

//This is a comment with no whitespace at the beginning

/*This is a comment with no whitespace at the beginning */
```

```js
/* eslint spaced-comment: ["error", "always", { "block": { "balanced": true } }] */
/* This is a comment with whitespace at the beginning but not the end*/
```

# 4. 分号

### 4.1【强制】语句末尾需要添加分号

- ✓ good

```js
const name = 'ESLint';

object.method = function () {
  // ...
};

const name = 'ESLint';

;(function () {
  // ...
})();

import a from 'a';
;(function () {
  // ...
})();

import b from 'b';
;(function () {
  // ...
})();
```

- ✗ bad

```js
const name = 'ESLint'

object.method = function () {
  // ...
}
```

### 4.2【强制】禁用不必要的分号

- ✓ good

```js
const x = 5;

const foo = function () {
  // code
};

```

- ✗ bad

```js
const x = 5;;

function foo() {
  // code
};
```

# 5. 空行/换行

### 5.1【强制】在函数声明、函数表达式、函数调用、对象创建、数组创建、for 语句等场景中，不允许在 `,` 或 `;` 前换行

- ✓ good

``` js
const obj = {
  a: 1,
  b: 2,
  c: 3
};

foo(
  aVeryVeryLongArgument,
  anotherVeryLongArgument,
  callback
);
```

- ✗ bad

```js
const obj = {
  a: 1
  , b: 2
  , c: 3
};

foo(
  aVeryVeryLongArgument
  , anotherVeryLongArgument
  , callback
);
```

### 5.2【强制】在成员表达式的点之前或之后放置新行

// 默认的选项是对象时，要求点与对象位于同一行

- ✓ good

```js
const foo = object.
property;
const bar = object.property;
```

- ✗ bad

```js
const foo = object
.property;
```

// 默认的选项是属性时，要求点与属性位于同一行

- ✓ good

```js
const foo = object
.property;
const bar = object.property;
```

- ✗ bad

```js
const foo = object.
property;
```

### 5.3【强制】大括号风格要求，one true brace style 将大括号放在控制语句或声明语句同一行的位置，不允许块的开括号和闭括号在同一行
- ✓ good

```js
function foo() {
  return true;
}

function nop() {
  return;
}
```

- ✗ bad

```js
function foo()
{
  return true;
}

function nop() { return }
```

### 5.4【建议】换行时，操作符在前

- ✓ good

```js
foo = 1 + 2;

foo = 1
  + 2;

foo
  = 5;

if (someCondition
  || otherCondition) {
}

answer = everything
  ? 42
  : foo;
```

- ✗ bad

```js
foo = 1 +
  2;

foo =
  5;

if (someCondition ||
  otherCondition) {
}

answer = everything ?
  42 :
  foo;
```

### 5.5【建议】不同行为或逻辑的语句集，使用空行隔开，更易阅读

``` js
// 仅为按逻辑换行的示例，不代表 setStyle 的最优实现
function setStyle(element, property, value) {
  if (element == null) {
    return;
  }

  element.style[property] = value;
}
```

# 6. 其他

### 6.1【强制】禁止使用 var

- ✓ good

```js
let x = 'y';
const CONFIG = {};
```

- ✗ bad

```js
var x = 'y';
var CONFIG = {};
```

### 6.2【强制】 如果一个变量不会被重新赋值，必须使用 `const` 进行声明

- ✓ good

```js
const a = 0;

// it's never initialized.
let a;
console.log(a);

// it's reassigned after initialized.
let a;
a = 0;
a = 1;
console.log(a);
```

- ✗ bad

```js
let a = 3;
console.log(a);

let a;
a = 0;
console.log(a);

// `i` is redefined (not reassigned) on each loop step.
for (let i in [1, 2, 3]) {
  console.log(i);
}

// `a` is redefined (not reassigned) on each loop step.
for (let a of [1, 2, 3]) {
  console.log(a);
}
```

### 6.3【强制】使用 === 和 !== 代替常规的相等运算符 == 和 !=

- ✓ good

```js
a === b
foo === true
bananas !== 1
value === undefined
```

- ✗ bad

```js
a == b
foo == true
bananas != 1
value == undefined
```

### 6.4【强制】使用驼峰命名法（Object key 除外）

- ✓ good

```js
// 包导入
import { no_camelcased as camelCased } from 'external-module';

// 变量定义
const myFavoriteColor = '#112C85';

// 函数定义
function doSomething() {
  // ...
}

// Object key 允许非驼峰命名
const obj = {
  my_pref: 1
};
```

- ✗ bad

```js
// 包导入
import { no_camelcased } from 'external-module';

// 变量定义
const my_favorite_color = '#112C85';

// 函数定义
function do_something() {
  // ...
}

```

### 6.5【强制】生产环境不允许使用 debugger 语句

- ✓ good

```js
function isTruthy(x) {
  return Boolean(x);
}
```

- ✗ bad

```js
function isTruthy(x) {
  debugger;
  return Boolean(x);
}
```

### 6.6【建议】只有一个参数时，箭头函数体可以省略圆括号

- ✓ good

```js
a => {}
```

- ✗ bad

```js
(a) => {}
```

### 6.7【建议】禁止空语句（可在空语句写注释避免），允许空的 catch 语句

- ✓ good

```js
if (foo) {
  // empty
}

while (foo) {
  /* empty */
}

try {
  doSomething();
} catch (ex) {
  // continue regardless of error
}

try {
  doSomething();
} finally {
  /* continue regardless of error */
}
```

- ✗ bad

```js
if (foo) {
}

while (foo) {
}

switch(foo) {
}

try {
  doSomething();
} catch(ex) {

} finally {

}
```

### 6.8【强制】禁止语法错误，此规则会报告指令、HTML 标签、结束标签的属性、无效的结束标签等语法错误

```html
<template>
  <!-- ✗ bad -->
  {{ . }}
  {{ foo bar }}
  <div :class="*abc*" / @click="def(">
    </span>
  </div id="ghi">
</template>
```

### 6.9【强制】禁止在外部作用域中重复声明隐藏变量

```html
<template>
  <!-- ✓ good -->
  <div v-for="i in 5"></div>
  <div v-for="j in 5"></div>

  <!-- ✗ bad -->
  <div>
    <div v-for="k in 5">
      <div v-for="k in 10"></div>
      <div slot-scope="{ k }"></div>
    </div>
  </div>
  <div v-for="l in 5"></div>
</template>

<script>
  export default {
    data () {
      return {
        l: false
      }
    }
  }
</script>
```
