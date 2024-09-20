# 数据统计 - 自定义事件统计简介

## 简介

“自定义事件统计”是蓝鲸平台提供的一个应用数据统计功能。

该功能通过在应用页面代码内嵌入 JavaScript 脚本来更加灵活的统计用户访问行为。

## 如何接入自定义事件

### 引用 analysis_pro.js 脚本

将**analysis_pro.js**添加到网站代码中并初始化，详情请参考[如何接入网站浏览统计](./pa_introduction.md)

### 元素埋点

这里以一个站点需要统计用户使用搜索功能频率为例

在相应的元素使用**bk-trace**属性配置参数来进行埋点，具体代码如下

```html
<input bk-trace="{id: '输入框', action: '用户输入', trigger: 'focus', category: '用户管理'}" />

<bk-button bk-trace="{id: '用户搜索按钮', action: '点击', category: '用户管理'}">搜索</bk-button>
```

参数说明：

| 参数 | 说明 | 可选值 | 默认值 |
|------|------|------|------|
| category | 事件分类 | - | - |
| id | 事件 id | - | - |
| trigger | 事件触发，多个触发可用空格分隔 | click、dblclick、focus、mouseup、mousedown | click |
| action | 事件操作 | - | - |

**整体的配置思路是：在哪个分类下有哪个元素通过哪种触发方式来产生什么操作**

**analysis_pro**会在初始化后对页面 DOM 进行动态监听，将带有**bk-trace**属性元素进行用户行为监听并自动上报定义的参数，你也可以在初始化的时候通过**traceKey**自定义要监听的元素标识，代码如下：

``` html
<!-- BK Analytics 把以下代码放在最后 -->
<script src="/static_api/v3/analysis_pro.js"></script>
<script>
  BKANALYSIS.init({
      traceKey: 'project-trace' // 默认为bk-trace
  })
</script> 
<!-- End BK Analytics -->
```

## 看不到统计数据这么办

如果你确认应用已经嵌入了上面的统计脚本并已经在元素上埋好点，但在统计数据页面看不到任何数据变化，请联系@蓝鲸助手。
