# API 插件开发

API 插件可以帮助接入系统开发者在 BKFlow 上实现自己的业务需求拓展。

接入系统开发者只需开发满足 API 统一协议的接口并注册到蓝鲸 APIGW，在完成【uniform_api】空间配置后，即可在 BKFlow 批量注册对应的 API 插件，接入系统用户可以直接与这些插件进行表单交互并执行这些插件。配合上 BKFlow 自带的流程执行能力，接入系统的用户可以轻松配置出符合自己业务需求的自动化工作流。

## API 统一协议

在 BKFlow 中，统一 API 的调用逻辑被统一封装到同一个插件【API插件】中，插件通过从遵循协议的接口中拉取元数据，可以动态地将接口调用所需的参数渲染为表单，供接入系统的用户更加直观方便地填写，效果如下：

![uniform_api_selection](assets/uniform_api_selection.png)
![unfiform_api_demo](assets/uniform_api_demo.png)


因为需要获取接口的描述数据，所以如果接入系统希望使用【API插件】，需要提供以下几个元数据接口，并注册到 BKFlow 的对应空间配置下：
1. category api：用于获取接口分类信息
2. list meta api：用于获取接口列表数据
3. detail meta api：用于获取接口详情的元数据
  
category api 和 list meta api 用于获取接口列表，每个具体的接口可以映射成一个插件。

detail meta api 用于获取具体接口的元数据，通过插件表单。

![uniform_apis](assets/uniform_apis.png)

当用户打开插件的配置面版时，交互顺序如下:
``` mermaid
sequenceDiagram 
    actor user1
    participant b as BKFlow
    participant a as META APIS
    
    user1->>+b: open the config panel of uniform api plugin
    b->>+a: call category api
    a->>-b: return category list
    b->>-user1: show category list
    user1->>+b: select a category
    b->>+a: call list meta api with selected category
    a->>-b: return api list
    b->>-user1: show api list
    user1->>+b: select an api
    b->>+a: call detail meta api with selected api
    a->>-b: return api detail meta
    b->>-user1: render the form with api detail meta
    
    Note over user1, a: A user configs uniform api plugin
```

下面，我们分别来介绍上述三种接口的协议。

### category api

对于category api，接口需要全量返回分类，该接口的输入输出：

1. 输入：GET 方法，形如 category_api/?scope_value=xx&scope_type=xx，其中，scope_value 和 scope_type 是当前流程对应字段的值，代表该流程在接入系统中所属的空间（如项目或业务），接入系统可以依据这两个参数返回对应空间下的接口分类信息。
2. 输出：接口返回标准三段结构，result为 True 时展示接口列表，False 时展示错误提示。
``` json
{
  "result": true,
  "message": "",
  "data": [
    {"name": "c1", "key": "c1"},
    {"name": "c2", "key": "c2"}
  ]
}
```

### list meta api
对于list meta api，需要提供api id 和对应的detail mata api地址，接口支持分页，该接口输入输出：

1. 输入：GET方法，分页参数采用limit + offset的协议，需要支持根据 scope_type、scope_value 和 分类进行过滤，形如：list_mata_api/?limit=50&offset=0&scope_type=xx&scope_value=xxx&category=xxx。
2. 输出：接口返回标准三段结构，result为True时展示接口列表，False时展示错误提示
``` json
{
  "result": true,
  "message": "",
  "data": [
    {
      "id": "api1",
      "meta_url": "xxxx/api1",  // 对应的 detail meta api
      "name": "api1",
      "category": "xxx"
    }
  ]
}
```

### detail meta api
基于选中的api，BKFlow 会从detail meta api中获取接口的详细信息，接口的输入输出：
1. 输入：GET方法
2. 输出：接口返回标准三段结构，result为True时展示接口列表，False时展示错误提示

``` json
{
  "result": true,
  "message": "",
  "data": {
    "id": "api1",
    "name": "api1",
    "url": "https://{some apigw host}/xxxx", // 执行时实际调用的 api
    "methods": [
      "GET"
    ],
    "inputs": [
      {
        "key": "xxx",
        "name": "xxx",
        "desc": "xxxx",
        "required": true,
        "type": "string",  // 可选，描述字段类型，如果没有form_type会基于该字段尝试映射对应的表单
        "form_type": "input",  // 可选，默认输入框
        "options": ["a", "b"],  // 可选，当type为list或者form_type为checkout/select等表单时
        "default": "abc"  // 可选
      }
    ],
    "outputs": [
      {
        "key": "xxx",
        "name": "xxx",
        "desc": "xxx",
        "type": "string"  // 可选，默认文本输出
      }
    ]
  }
}
```
- 基于inputs和outputs字段，动态进行表单生成
	- 字段类型(type)与表单类型映射关系：
		- string -> 输入框
		- list -> checkbox，需要提供options字段
		- int -> 整数输入框
		- bool -> switcher
- 基于methods字段，允许的请求方法
- 如果需要在输入表单中增加表格，需要指定 form_type 为 table，同时在字段下增加 table 描述字段，描述如下：

``` json
{
  "table": {
    "meta": {
      "read_only": false,
      "import": false,
      "export": false
    },
    "fields": [
      {
        "key": "xxx",
        "name": "xxx",
        "desc": "xxxx",  // 可选
        "required": true,
        "type": "string",  // 可选，描述字段类型，如果没有form_type会基于该字段尝试映射对应的表单
        "form_type": "input",  // 可选，默认输入框，不能为 table
        "options": ["a", "b"],  // 可选，当type为list或者
        "default": "abc"  // 可选
      }
    ]
  }
}
```

下面是一个合法的 meta 接口返回的完整协议，主要展示各种表单项的定义方式：

``` json
{
  "result": true,
  "message": "",
  "data": {
    "id": "api2",
    "name": "api2",
    "url": "https://{some apigw host}/xxxx", // 执行时实际调用的 api
    "methods": [
      "GET"
    ],
    "inputs": [
      {
        "key": "string_field",
        "name": "string_field",
        "required": true,
        "type": "string",
        "default": "default_value"
      },
      {
        "key": "textarea_field",
        "name": "textarea_field",
        "required": true,
        "type": "string",
        "form_type": "textarea",
        "default": "default_value"
      },
      {
        "key": "int_field",
        "name": "int_field",
        "required": true,
        "type": "int"
      },
      {
        "key": "bool_field",
        "name": "bool_field",
        "required": true,
        "type": "bool"
      },
      {
        "key": "list_field",
        "name": "list_field",
        "required": true,
        "type": "list",
        "options": [
          "a",
          "b",
          "c"
        ]
      },
      {
        "key": "select_field_1",
        "name": "select_field_2",
        "required": true,
        "type": "string",
        "options": [
          "a",
          "b",
          "c"
        ]
      },
      {
        "key": "select_field_2",
        "name": "select_field_2",
        "type": "string",
        "options": [
          {
            "text": "abc",
            "value": "ddd"
          },
          {
            "text": "def",
            "value": "aaa"
          }
        ]
      },
      {
        "key": "table_field",
        "name": "table_field",
        "required": true,
        "type": "list",
        "form_type": "table",
        "table": {
          "fields": [
            {
              "key": "string_field",
              "name": "string_field",
              "required": true,
              "type": "string",
              "default": "default_value"
            },
            {
              "key": "textarea_field",
              "name": "textarea_field",
              "required": true,
              "type": "string",
              "form_type": "textarea",
              "default": "default_value"
            },
            {
              "key": "select_field_1",
              "name": "select_field_2",
              "required": true,
              "type": "string",
              "options": [
                "a",
                "b",
                "c"
              ]
            },
            {
              "key": "select_field_2",
              "name": "select_field_2",
              "type": "string",
              "options": [
                {
                  "text": "abc",
                  "value": "ddd"
                },
                {
                  "text": "def",
                  "value": "aaa"
                }
              ]
            }
          ]
        }
      }
    ]
  }
}
```

## 让 API 插件支持请求后轮询

**背景**

部分功能可能无法通过单次 API 调用完成，比如 Job 任务通过单次 API 调用只能完成触发操作，触发后流程节点会继续往下流转，无法等待任务完成和根据任务执行状态来控制流程执行。

为了满足该场景，API 插件支持在调用后进行轮询 (polling) 调用，并根据轮询结果来控制节点的状态和执行逻辑。

**样例**

这里以一个接入方 (Access Platform) 提供 API 接口并调用 Job 平台任务为例：

``` mermaid
sequenceDiagram 
    participant a as BKFlow
    participant b as Access Platform
    participant c as Job
    
    Note over a, c: request API to trigger job task execution
    a->>b: trigger a task (request url in meta api)
    b->>c: create and start a task in job
    c->>b: task_tag
    b->>a: task_tag
    
    Note over a, c: request polling API for task status
    a->>b: request polling url with task_tag
    b->>c: request job task status with task_tag
    c->>b: job task status
    b->>b: mapping job task status to node status
    b->>a: node status
    a->>a: check if next polling is needed with node status tags in meta
```

**操作**

作为接入方，如果希望提供的 API 接口支持轮询，需要：
1. API 默认 url 接口返回可以作为 `task_tag` 标识的字段
2. 提供对应的轮询接口 polling_url，接口接收 `task_tag` 请求参数作为需要查询状态的任务标识
3. 在 detail meta api 中声明对应的协议字段，包括轮询接口地址、`task_tag` 标识、节点状态流转判断标识等

下面是一个定义了轮询配置的示例（此处省略其他无关字段)：
``` json
// detail meta api response
{
    "url": "{{api_url}}",  // 触发任务的 url
    "methods": ["POST"],
    "polling": {
        "url": "{{polling_url}}",  // 状态的轮询接口，必须接收 get 方法，需要接收参数 task_tag，形如 url/?task_tag={task_tag_key}
        "task_tag_key": "task_tag",  // {{api_url}} API 响应中可以用来作为任务标识的字段，执行过程中会用对应字段的值填入后进行请求，如果响应存在多级字段，可以通过 `.` 进行拼接，如 data.task_tag
        "success_tag": {"key": "status", "value": "success"},  // polling_url 响应中用于识别状态成功的 key 和 value（value 只支持字符串和数字类型)
        "fail_tag": {"key": "status", "value": "fail"},  // polling_url 响应中用于识别状态失败的 key 和 value（value 只支持字符串和数字类型)
        "running_tag": {"key": "status", "value": "running"}  // polling_url 响应中用于识别状态运行中的 key 和 value（value 只支持字符串和数字类型)
    },
    ...
}

// {{api_url}} api response
{
   "task_tag": 1234
}

// {{polling_url}} api response
{
    "status": "success",
}
```

## 让 API 插件支持请求后回调

**背景**

部分功能可能无法通过单次 API 调用完成，比如 Job 任务通过单次 API 调用只能完成触发操作，触发后流程节点会继续往下流转，无法等待任务完成和根据任务执行状态来控制流程执行。

为了满足该场景，API 插件支持被调用方进行回调，来告知 API 插件任务已执行完成。

**样例**

这里以一个接入系统 (Access Platform) 提供 API 接口并调用 Job 平台任务为例：

``` mermaid
sequenceDiagram 
    participant a as BKFlow
    participant b as Access Platform
    participant c as Job
    
    Note over a, c: request API to trigger job task execution
    a->>b: trigger a task (request url in meta api) with node_id
    b->>c: create and start a task in job
    
    Note over a, c: callback when job finished
    c->>b: job task finished callback
    b->>a: node_callback with node_id and data
```

**操作**

作为接入方，如果希望提供的 API 接口支持回调，需要：
1. 获取任务触发时的 node_id 参数，并记录
2. 进行任务触发和执行，并通过轮询或回调监听任务状态
3. 当任务执行完成后，通过 bkflow operate_task_node 接口，通过 node_id 和 data 参数进行回调

下面是一个定义了回调配置的示例（省略其他无关字段)：
``` json
// detail meta api response
{
  "result": true,
  "data": {
      "url": "{{api_url}}",  // 触发任务的 url
      "methods": ["POST"],
      "callback": {
          "success_tag": {"key": "status", "value": "success"},  // polling_url 响应中用于识别状态成功的 key 和 value（value 只支持字符串和数字类型)
          "fail_tag": {"key": "status", "value": "fail"},  // polling_url 响应中用于识别状态失败的 key 和 value（value 只支持字符串和数字类型)
      },
      ...
  },
  "message": ""
}

// callback request data
{
    "status": "success",
}

```
