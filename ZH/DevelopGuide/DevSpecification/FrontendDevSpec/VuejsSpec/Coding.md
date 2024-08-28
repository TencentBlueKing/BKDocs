# Vue 官方编码风格建议
https://cn.vuejs.org/v2/style-guide/index.html

### 1. Vue 模板中，必须使用带连字符的属性
- ✗ 不推荐

```html
<template>
  <MyComponent myProp="prop" />
</template>
``` 

- ✓ 推荐
  
```html
<template>
  <MyComponent my-prop="prop" />
</template>
```

### 2. Vue 的模板中，大括号内必须使用空格

规则与`block-spacing`类似，这里举 block-spacing 的例子

- ✗ 不推荐

```js
function foo() {return true;}
if (foo) { bar = 0;}
function baz() {let i = 0;
    return i;
}
```

- ✓ 推荐
  
```js
function foo() { return true; }
if (foo) { bar = 0; }
```

### 3. Vue 模板中使用 brace 风格代码

brace 风格代码，前花括号放在同一行，后花括号放在下一行，且不允许函数全部写在一行内

> 此规范与 brace-style 相同，只是适用于 Vue 的 templete 中

- ✗ 不推荐
```js
function foo()
{
  return true;
}

if (foo)
{
  bar();
}

function nop() { return; }

``` 

- ✓ 推荐
  
```js
function foo() {
  return true;
}

if (foo) {
  bar();
}

if (foo) {
  bar();
} else {
  baz();
}

try {
  somethingRisky();
} catch(e) {
  handleError();
}

// when there are no braces, there are no problems
if (foo) bar();
else if (baz) boom();
```

### 4. 禁止使用拖尾逗号

> 此规范与 comma-dangle 相同，只是适用于 Vue 的 templete 中

- ✗ 不推荐

```js
var foo = {
    bar: "baz",
    qux: "quux",
};

var arr = [1,2,];

foo({
  bar: "baz",
  qux: "quux",
});
``` 

- ✓ 推荐
  
```js
var foo = {
    bar: "baz",
    qux: "quux"
};

var arr = [1,2];

foo({
  bar: "baz",
  qux: "quux"
});
```

### 5. vue 文件 template 中允许 eslint-disable eslint-enable 

这个主要为了支持在 vue 的 template 中，提供`eslint-disable`功能
> 行内注释启用/禁用某些规则，配置为 1 即允许
    'vue/comment-directive': 1,

使用样例, 注释的下一行即不受 eslint 的检查

```html
<template>
  <!-- eslint-disable-next-line vue/max-attributes-per-line -->
  <div a="1" b="2" c="3" d="4">
  </div>
</template>
```

### 6. 组件标签使用统一的命名规范

// 驼峰表示
```js
<template>
  <!-- ✓ GOOD -->
  <CoolComponent />
  
  <!-- ✗ BAD -->
  <cool-component />
  <coolComponent />
  <Cool-component />

  <!-- ignore -->
  <UnregisteredComponent />
  <unregistered-component />

  <registered-in-kebab-case />
  <registeredInCamelCase />
</template>
<script>
export default {
  components: {
    CoolComponent,
    'registered-in-kebab-case': VueComponent1,
    'registeredInCamelCase': VueComponent2
  }
}
</script>
```

// 短横线表示
```js
<template>
  <!-- ✓ GOOD -->
  <cool-component />

  <!-- ✗ BAD -->
  <CoolComponent />
  <coolComponent />
  <Cool-component />

  <!-- ignore -->
  <unregistered-component />
  <UnregisteredComponent />
</template>
<script>
export default {
  components: {
    CoolComponent
  }
}
</script>
```

### 7. 在 vue 模板中，对象键(key)与值(value)之间的空格

- ✗ 不推荐

```js
var obj = { "foo": 42 };
var obj = { "foo":42 };
```
- ✓ 推荐
  
```js
var obj = { "foo": 42 };
```

### 8. vue 模板的关键字空格
比如`if()...else{}`的空格

要求关键字前后都必须有空格，推荐格式如下：
```js
if (foo) {
    //...
} else if (bar) {
    //...
} else {
    //...
}
```

### 9. 计算属性中不允许有异步方法

示例
```js
<script>
export default {
  computed: {
    /* ✓ GOOD */
    foo () {
      var bar = 0
      try {
        bar = bar / this.a
      } catch (e) {
        return 0
      } finally {
        return bar
      }
    },

    /* ✗ BAD */
    pro () {
      return Promise.all([new Promise((resolve, reject) => {})])
    },
    foo1: async function () {
      return await someFunc()
    },
    bar () {
      return fetch(url).then(response => {})
    },
    tim () {
      setTimeout(() => { }, 0)
    },
    inter () {
      setInterval(() => { }, 0)
    },
    anim () {
      requestAnimationFrame(() => {})
    }
  }
}
</script>
```


### 10. 不允许同时使用`v-if`和`v-for`

在需要的场景下，`v-if`应该写在外层的 wrapper 元素上

- ✗ 不推荐

```html
<TodoItem
    v-if="complete"
    v-for="todo in todos"
    :todo="todo"
  />
```
- ✓ 推荐
  
```js
  <ul v-if="shown">
    <TodoItem
      v-for="todo in todos"
      :todo="todo"
    />
  </ul>
```

### 11. 禁止属性重复命名
- ✗ 不推荐

```js
<script>
export default {
  props: {
    foo: String
  },
  computed: {
    foo: {
      get () {}
    }
  },
  data: {
    foo: null
  },
  methods: {
    foo () {}
  }
}
</script>
```


### 12. 禁止 html 元素中出现重复的属性

- ✗ 不推荐

```html
<MyComponent :foo="abc" foo="def" />
  <MyComponent foo="abc" :foo="def" />
  <MyComponent foo="abc" foo="def" />
  <MyComponent :foo.a="abc" :foo.b="def" />
  <MyComponent class="abc" class="def" />
```
- ✓ 推荐
  
```html
<MyComponent :foo="abc" />
  <MyComponent foo="abc" />
  <MyComponent class="abc" :class="def" />

```

### 13. vue 模板中禁止结构中出现{}或[]
> 此条规则等待 merge
- ✗ 不推荐

```js
var {a: {}} = foo;
var {a: []} = foo;
```
- ✓ 推荐
  
```js
var {a = {}} = foo;
var {a = []} = foo;
function foo({a = {}}) {}
function foo({a = []}) {}

```


### 14. 禁止使用保留字

```html
<script>
/* ✗ BAD */
export default {
  props: {
    $el: String
  },
  computed: {
    $on: {
      get () {}
    }
  },
  data: {
    _foo: null
  },
  methods: {
    $nextTick () {}
  }
}
</script>
```

### 15. 禁止使用特定的语法

```html
<template>
  <!-- ✔ GOOD -->
  <div> {{ foo }} </div>
  <div> {{ foo.bar }} </div>

  <!-- ✘ BAD -->
  <div> {{ foo() }} </div>
  <div> {{ foo.bar() }} </div>
  <div> {{ foo().bar }} </div>
</template>
```


### 16. vue 的 data 属性必须是函数

```js
<script>
/* ✓ GOOD */
Vue.component('some-comp', {
  data: function () {
    return {
      foo: 'bar'
    }
  }
})

export default {
  data () {
    return {
      foo: 'bar'
    }
  }
}
</script>

<script>
/* ✗ BAD */
Vue.component('some-comp', {
  data: {
    foo: 'bar'
  }
})

export default {
  data: {
    foo: 'bar'
  }
}
</script>
```

### 17. vue 模板的属性里，" = " 两端禁止空格

```js
<template>
  <!-- ✗ BAD -->
  <div class = "item"></div>
  <!-- ✓ GOOD -->
  <div class="item"></div>
</template>
```
### 18. 禁止在 textarea 标签内插值，应该使用 v-model

```html
<template>
  <!-- ✓ GOOD -->
  <textarea v-model="message" />

  <!-- ✗ BAD -->
  <textarea>{{ message }}</textarea>
</template>
```

### 19. 禁止 components 中声明的组件在 template 中没有使用

```html
<!-- ✓ GOOD -->
<template>
  <div>
    <h2>Lorem ipsum</h2>
    <the-modal>
      <component is="TheInput" />
    </the-modal>
  </div>
</template>

<script>
  import TheModal from 'components/TheModal.vue'
  import TheInput from 'components/TheInput.vue'

  export default {
    components: {
      TheModal,
      TheInput
    }
  }
</script>

<!-- ✗ BAD -->
<template>
  <div>
    <h2>Lorem ipsum</h2>
    <TheModal />
  </div>
</template>

<script>
  import TheButton from 'components/TheButton.vue'
  import TheModal from 'components/TheModal.vue'

  export default {
    components: {
      TheButton, // Unused component
      'the-modal': TheModal // Unused component
    }
  }
</script>
```

### 20. 禁止在 v-for 指令或 scope 属性作用范围里使用未经定义的变量

```html
<template>
  <!-- ✓ GOOD -->
  <ol v-for="i in 5">
    <li>{{ i }}</li>
  </ol>

  <!-- ✗ BAD -->
  <ol v-for="i in 5">
    <li>{{ item }}</li>
  </ol>
</template>
```

### 21. 禁止使用 v-html，防止 xss 攻击

```html
<template>
  <!-- ✓ GOOD -->
  <div>{{ someHTML }}</div>

  <!-- ✗ BAD -->
  <div v-html="someHTML"></div>
</template>
```
### 22. vue 官方推荐的属性顺序

```js
<script>
/* ✓ GOOD */
export default {
  name: 'app',
  props: {
    propA: Number
  },
  data () {
    return {
      msg: 'Welcome to Your Vue.js App'
    }
  }
}
</script>

<script>
/* ✗ BAD */
export default {
  name: 'app',
  data () {
    return {
      msg: 'Welcome to Your Vue.js App'
    }
  },
  props: {
    propA: Number
  }
}
</script>
```

### 23. vue 组件的 props 属性应该使用驼峰命名

```js
<script>
export default {
  props: {
    /* ✓ GOOD */
    greetingText: String,

    /* ✗ BAD */
    'greeting-text': String,
    greeting_text: String
  }
}
</script>
```

### 24. vue 的 component 元素必须要有 is 属性

```html
<template>
  <!-- ✓ GOOD -->
  <component :is="type"/>
  <component v-bind:is="type"/>

  <!-- ✗ BAD -->
  <component/>
  <component is="type"/>
</template>
```

### 25. vue 的 props 的 type 必须为构造函数，不能为字符串

```html
<script>
export default {
  props: {
    /* ✓ GOOD */
    myProp: Number,
    anotherProp: [Number, String],
    myFieldWithBadType: {
      type: Object,
      default: function() {
        return {}
      },
    },
    myOtherFieldWithBadType: {
      type: Number,
      default: 1,
    },
    /* ✗ BAD */
    myProp: "Number",
    anotherProp: ["Number", "String"],
    myFieldWithBadType: {
      type: "Object",
      default: function() {
        return {}
      },
    },
    myOtherFieldWithBadType: {
      type: "Number",
      default: 1,
    },
  }
}
</script>
```

### 26. props 属性必须定义类型

```html
<script>
/* ✓ GOOD */
Vue.component('foo', {
  props: {
    // Without options, just type reference
    foo: String,
    // With options with type field
    bar: {
      type: String,
      required: true,
    },
    // With options without type field but with validator field
    baz: {
      required: true,
      validator: function (value) {
        return (
          value === null ||
          Array.isArray(value) && value.length > 0
        )
      }
    }
  }
})

/* ✗ BAD */
Vue.component('bar', {
  props: ['foo']
})

Vue.component('baz', {
  props: {
    foo: {},
  }
})
</script>
```

### 27. render 函数必须要有返回值

```html
<script>
export default {
  /* ✓ GOOD */
  render (h) {
    return h('div', 'hello')
  }
}
</script>
<script>
export default {
  /* ✗ BAD */
  render (h) {
    if (foo) {
      return h('div', 'hello')
    }
  }
}
</script>
```


### 28.  v-for 指令必须要有 key 属性

```html
<template>
  <!-- ✓ GOOD -->
  <div
    v-for="todo in todos"
    :key="todo.id"
  />
  <!-- ✗ BAD -->
  <div v-for="todo in todos"/>
</template>
```

### 29.  计算属性必须要有返回值

```html
<script>
export default {
  computed: {
    /* ✓ GOOD */
    foo () {
      if (this.bar) {
        return this.baz
      } else {
        return this.baf
      }
    },
    bar: function () {
      return false
    },
    /* ✗ BAD */
    baz () {
      if (this.baf) {
        return this.baf
      }
    },
    baf: function () {}
  }
}
</script>
```
### 30. 不允许在 template 中使用 this

```html
<template>
  <!-- ✓ GOOD -->
  <a :href="url">
    {{ text }}
  </a>
  
  <!-- ✗ BAD -->
  <a :href="this.url">
    {{ this.text }}
  </a>
</template>
```

### 31.  v-on 指令的写法，限制简写

```html
<template>
  <!-- ✓ GOOD -->
  <div @click="foo"/>

  <!-- ✗ BAD -->
  <div v-on:click="foo"/>
</template>
```