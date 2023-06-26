### 1. HTML 标签的右括号之前必须有相同的间距

```html
<template>
  <!-- ✓ 推荐 -->
  <div>
  <div foo>
  <div foo="bar">
  </div>
  <div />
  <div foo />
  <div foo="bar" />

  <!-- ✗ 不推荐 -->
  <div >
  <div foo >
  <div foo="bar" >
  </div >
  <div/>
  <div foo/>
  <div foo="bar"/>
</template>
```

### 2. HTML 标签必须要有结束标签

```html
< template >
  <!-- ✓ 推荐 -->
  <div></div>
  <p></p>
  <p></p>
  <input>
  <br>

  <!-- ✗ 不推荐 -->
  <div>
  <p>
</ template >
```

### 3. 在`<template>`中强制执行一致的缩进

```html
< template >
   <!-- ✓ 推荐 --> 
  < div id = “ ”
     class = “ ”
     some-attr = “ ”
  />

  <!-- ✗ 不推荐 --> 
  < div  id = “ ”
        class = “ ”
        some-attr = “ ”
  />
</ template >
```

### 4. HTML 属性的引号使用双引号

```html
< template >
   <!-- ✓ 推荐 --> 
  < IMG  SRC = “ ./logo.png ” >

  <!-- ✗ 不推荐 --> 
  < IMG  SRC = ' ./logo.png ' >
  < img  src =。/ logo。png >
</ template >
```

### 5. 删除 html 标签中连续多个不用于缩进的空格

- ✗ 不推荐

```html
<div     class="foo"
    :style =  "bar"         />
  <i
    :class="{
      'fa-angle-up'   : isExpanded,
      'fa-angle-down' : !isExpanded,
    }"
  />
```
- ✓ 推荐
  
```html
  <div
    class="foo"
    :style="bar" />
  <i
    :class="{
      'fa-angle-up' : isExpanded,
      'fa-angle-down' : !isExpanded,
    }"
  />

```

### 6. 属性之间空一格

```html
<!-- ✗ 不推荐 -->
<div id="demo"  class="demo"data-title="demo"></div>

<!-- ✓ 推荐 -->
<div id="demo" class="demo" data-title="demo"></div>

```

