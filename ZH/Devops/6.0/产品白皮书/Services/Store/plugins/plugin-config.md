# 插件配置规范

## 一、说明

* 每个插件都有一个名为 task.json 的描述文件  输入字段、输出字段以及启动命令，均由开发者在 task.json 中描述
* 描述输入字段，目的是让用户在编排流水线时，可以配置自定义的参数值，
* 描述输出字段，目的是让用户在编排流水线时，了解插件输出，以便在下游步骤中使用
* 描述启动命令，目的是让 bkci 知道如何启动插件执行
* 描述文件（task.json）存放在插件代码库根目录下
* 描述文件（task.json）内容格式为json

## 二、task.json数据结构详解

### 整体结构如下

```text
{
    "atomCode": "",     # 插件唯一标识，由英文字母组成，与插件初始化时指定的标识一致
    "execution": {      # 执行命令入口相关

    },
    "inputGroups": [    # 输入字段分组，可选，设置后，可按组展示输入字段，支持按组展开收起

    ],
    "input": {          # 插件输入字段定义

    },
    "output": {         # 插件输出字段定义

    }
}
```

### 各配置项详解

#### atomCode <a id="atomcode"></a>

* 插件唯一标识，由英文字母组成，与插件初始化时指定的标识一致
* 值格式为字符串

#### execution <a id="execution"></a>

* 执行命令入口相关配置
* 值格式为对象
* 值对象包括如下属性：

| 属性名 | 属性说明 | 格式 | 备注 |
| :--- | :--- | :--- | :--- |
| packagePath | 发布包中插件执行包的相对路径 | 字符串 | 必填，包括执行包包名，执行时，下载发布包解压后，将根据此项配置找到执行包 |
| language | 开发语言 | 字符串 | 必填，如python、java等，和插件初始化时指定的语言一致 |
| demands | 执行依赖 | 数组 | 非必填 |
| target | 执行入口 | 字符串 | 必填，一般为一个命令行可执行的命令 |

#### inputGroups <a id="inputgroups"></a>

* 输入字段分组，可选，设置后，可按组展示输入字段，支持按组展开收起
* 值格式为数组
* 可设置多个分组，每个分组使用一个对象来描述，包括如下属性：

| 属性名 | 属性说明 | 格式 | 备注 |
| :--- | :--- | :--- | :--- |
| name | 分组名称 | 字符串 | 必填，配置在输入字段的groupName中，标识该字段属于哪个分组 |
| label | 分组标识 | 字符串 | 必填，用户直接看到的分组名称 |
| isExpanded | 是否展开 | 布尔 | 必填，是否默认展开分组 |

#### input <a id="input"></a>

* 输入字段定义
* 值格式为对象
* 可配置一个或多个输入字段
* 每个输入字段的英文标识为key，value为对象

**系统支持如下UI组件**

| 组件type | 组件名称 | 备注 | 执行时插件后台获取到的值说明 |
| :--- | :--- | :--- | :--- |
| vuex-input | 单行文本框 |  | 字符串 |
| vuex-textarea | 多行文本框 |  | 字符串 |
| atom-ace-editor | 代码编辑框 |  | 字符串 |
| selector | 下拉框 | 只能选择，不能输入 | 字符串 |
| select-input | 可输入下拉框 | 输入的值可以是下拉列表中没有的值（包括变量），选中后框里看到是的id | 字符串 |
| devops-select | 可输入下拉框 | 输入的值只能是变量，选中后框里看到是name | 字符串 |
| atom-checkbox-list | 复选框列表 |  | 字符串，如：\[ "id1", "id2" \] |
| atom-checkbox | 复选框（布尔） |  | 字符串 |
| enum-input | 单选 |  | 字符串 |
| cron-timer | 时间选择器 |  | 字符串 |
| time-picker | 日期选择器 |  | 字符串 |
| user-input | 人名选择器 |  | 字符串 |
| tips | 提示信息 | 支持动态预览用户输入的参数，支持超链接 | 字符串 |
| parameter | 不定参数列表 | 参数列表支持从接口获取 | 字符串 |
| dynamic-parameter | 不定参数列表 | 支持从接口获取，支持每行多列，支持动态增删 | 字符串 |

若以上组件不满足需求，请联系 bkci 客服。

**每个输入字段配置支持如下公共属性**

| 属性名 | 属性说明 | 配置格式 | 备注 |
| :--- | :--- | :--- | :--- |
| label | 中文名 | 字符串 | 用于展示，允许为空（与其他字段组合的场景） |
| type | 组件类型 | 字符串 | 必填，平台提供常用的输入组件，根据不同组件有不同展现 |
| default | 默认值 | 根据不同组件默认值格式不一样 | 非必填 |
| placeholder | placeholder | 字符串 | 非必填 |
| groupName | 所属组 | 字符串 | 非必填，inputGroups 中定义的 name |
| desc | 字段说明 | 字符串 | 非必填，字段说明，支持\r\n换行 |
| required | 是否必填 | 布尔 | 非必填 |
| disabled | 是否可编辑 | 布尔 | 非必填 |
| hidden | 是否隐藏 | 布尔 | 非必填 |
| isSensitive | 是否敏感 | 布尔 | 非必填，敏感信息在日志中不会展示明文 |
| rely | 根据条件显示/隐藏当前字段 | 对象 | 非必填 |
| rule | 值有效性限制 | 对象 | 非必填<br/>支持如下属性：<br/>alpha: 只允许英文字符，布尔，true/false <br/>numeric: 只允许数字，布尔，true/false <br/>alpha_dash: 可以包含英文、数字、下划线、中划线，布尔，true/ false <br/>alpha_num: 可以包含英文和数字，布尔，true/false<br/>max: 字符串最大长度, int <br/>min: 字符串最小长度, int <br/>regex: 正则表达式字符串 |


**rule 配置示例：**
```json
// 只允许填写字母，且字符串长度为3-7
"rule": {
    "min": 3,
    "max": 7,
    "alpha": true
}

// 正则匹配以数字开头的字符串
"rule": { "regex": "^[0-9]" }
```

**针对不同type的组件，有个性化的属性**

**1、单行文本框：type=vuex-input**

* 组件属性：
  * inputType：当输入的字符串希望展示成\*\*\*\*\*\*方式时使用，值为 password
* 示例：
  * 配置

    ```text
    "fieldName": {
        "label": "密码输入框",
        "type": "vuex-input",
        "inputType": "password",
        "desc": "XXX"
    }
    ```

**2、复选框（布尔）：type = atom-checkbox**

* 组件属性：
  * text：此时label可设置为空，对应值为true/false
* 示例：
  * 配置

    ```text
    "fieldName": {
        "label": "",
        "default": true,
        "type": "atom-checkbox",
        "text": "是否需要Rebuild",
        "desc": "XXX"
    }
    ```

**3、下拉框/可输入下拉框：type = selector/select-input/devops-select**

* 组件属性：
  * optionsConf：下拉框属性配置

    ```text
    "optionsConf": {          # type=selector/select-input/devops-select组件配置
        "searchable": false,  # 是否可搜索
        "multiple": false,    # 是否为多选
        "url": "",            # bkci 服务链接，或者接入蓝鲸网关的API链接
                                链接中支持变量，使用{变量名}的方式引用，可以是当前task.json中的字段，也可以是几个内置变量，如projectId、pipelineId、buildId
        "dataPath": "",       # 选项列表数据所在的、API返回体json中的路径，没有此字段则默认为data， 示例：data.detail.list。配合url使用
        "paramId": "",        # url返回规范中，用于下拉列表选项key的字段名，配合url使用
        "paramName": "",      # url返回规范中，用于下拉列表选项label的字段名，配合url使用
        "hasAddItem": true,   # 是否有新增按钮（只在type=selector时生效）
        "itemText": "文案",   # 新增按钮文字描述（只在type=selector时生效）
        "itemTargetUrl": "跳转url"    # 点击新增按钮的跳转地址（只在type=selector时生效）
    }
    ```

    * bkci服务链接，可以使用浏览器开发者助手抓取，常用的链接如下：
      * 凭证： /ticket/api/user/credentials/{projectId}/hasPermissionList?permission=USE&page=1&pageSize=100&credentialTypes=USERNAME\_PASSWORD
        * credentialTypes 取值参见[CredentialType](https://github.com/Tencent/bk-ci/blob/master/src/backend/ci/core/ticket/api-ticket/src/main/kotlin/com/tencent/devops/ticket/pojo/enums/CredentialType.kt)
      * 代码库：/repository/api/user/repositories/{projectId}/hasPermissionList?permission=USE&repositoryType=CODE\_GIT&page=1&pageSize=5000
        * repositoryType 取值参见[ScmType](https://github.com/Tencent/bk-ci/blob/master/src/backend/ci/core/common/common-api/src/main/kotlin/com/tencent/devops/common/api/enums/ScmType.kt)
      * 节点：/environment/api/user/envnode/{projectId}/listUsableServerNodes?page=1&pageSize=100

  * options：下拉框列表项定义

    ```text
    "options": [              # type=selector/select-input组件选项列表
        {  
            "id": "",         # 选项ID
            "name": "",       # 选项名称
            "desc": "",       # 选项说明
            "disabled": false # 是否可选
        }
    ]
    ```

**4、单选： type = enum-input**

* 组件属性：

  * list

  ```text
  "list": [                 # type=enum-input组件选项列表
        {
            "label": "",
            "value": ""
        }
    ]
  ```

**5、日期选择器：type=time-picker**

* 组件属性：
  * startDate：时间戳，毫秒，开始日期
  * endDate：时间戳，毫秒，结束日期
  * showTime：布尔，是否显示时间

**6、提示信息：tips**

* 组件属性：
  * tipStr：提示信息内容模版
  * 支持{}引用当前插件的其他变量
  * 支持插入超链接
* 示例：
  * 配置示例：

    ```text
    "tipTest": {
         "label": "",
         "type": "tips",
         "tipStr": "这是个XXX系统，欢迎体验。[点击查看](http://www.baidu.com)"
    }
    ```

**7、不定参数列表：parameter**

* 组件属性：
  * paramType：数据从链接动态获取或者从定义列表中获取，可选值为：url、list
  * url：paramType=url时配置链接
  * urlQuery: 值为对象，url的参数设置 如：{"param1": "","param2": ""} param1、param2可以是当前插件的其他参数，执行时会自动替换值
  * parameters：参数列表，可定义一个或多个参数 每个参数包含如下属性

    | 属性名 | 属性说明 | 格式 | 备注 |
    | :--- | :--- | :--- | :--- |
    | id | 该行唯一标识 | 字符串 | 该行唯一标识 |
    | key | key的值 | 字符串 | 该行参数的key |
    | keyType | key的类型 | 字符串 | 可选值为input、select |
    | keyListType | key数据源类型 | 字符串 | keyType=select时有效，可选值为url、list |
    | keyUrl |  | 字符串 | keyListType=url时生效 |
    | keyList |  | 列表 | keyListType=list时生效， 示例： \[ { id: 'id', name: 'name' } \]， id为key的具体值 |
    | keyDisable | 是否可编辑 | 布尔 | true、false |
    | keyMultiple | 是否可多选 | 布尔 | true、false |
    | value | value的值 | 字符串 | 该行参数的value |
    | valueType | value的类型 | 字符串 | 可选值为input、select |
    | valueListType | value数据源类型 | 字符串 | valueType=select时有效，可选值为url、list |
    | valueUrl |  | 字符串 | valueListType=url时生效 |
    | valueList |  | 列表 | valueListType=list时生效， 示例： \[ { id: 'id', name: 'name' } \]， id为value的具体值 |
    | valueDisable | 是否可编辑 | 布尔 | true、false |
    | valueMultiple | 是否可多选 | 布尔 | true、false |

**8、复选框列表： type=atom-checkbox-list**

* 组件属性：
  * list

    ```text
    "list":[
    {
        "id":"php"
        "name":"php"
        "disabled":true
        "desc":"php是世界上最好的语言"
    }]
    ```

**9、代码编辑框：atom-ace-editor**

* 组件属性：
  * bashConf
  * lang

    ```text
    "bashConf": {
        "url": "XXX",  # 已接入蓝鲸网关的第三方链接
        "dataPath": "" # 如 data.name
    },
    "lang": "sh"       # 目前支持高亮语法 json|python|sh|text|powershell|batchfile
    ```

**10、人名选择器：user-input**

* 组件属性：
  * inputType：可输入的数据类型，可选值为email 、rtx 、all

    ```text
    "receiver2": {
        "label": "收件人,支持邮件组",
        "type": "company-staff-input",
        "inputType": "all",
        "desc": "可以填写公司任意用户，包括邮件组"
    }
    ```

11、**动态参数组件：dynamic-parameter**

* 组件属性

```text
"params":{
  "label": "动态参数",
  "type": "dynamic-parameter",
  "required": false,
  "desc": "动态参数组件",
  "param": {
    "paramType": "url", // parameters是从url获取还是直接取列表的值，可以是url或者list
    "url": "XXXX",      // paramType是url的时候从接口取值，url中的{test}可被替换为当前插件中的值或浏览器url中的参数
    "dataPath": "",     // 接口返回值，取数的路径，默认为 data.records
    "parameters": [     // paramType是list的时候从这里取值
        {
            "id": "parameterId", //该行的唯一标识，必填
            "paramModels": [
                {
                    "id": "233",     // 该模型的唯一标识，必填
                    "label": "testLabel",
                    "type": "input", // 可以是input或者select
                    "listType": "url", // 获取列表方式，可以是url或者list
                    "isMultiple": false, // select是否多选
                    "list": [ { "id": "id", "name": "name" } ], // type是select起作用，需要有id和name字段
                    "url": '', // type是select且listType是url起作用
                    "dataPath": "",     // 接口返回值，取数的路径，默认为 data.records
                    "disabled": false, // 控制是否可编辑
                    "value": "abc=" // 值，可做为初始化的默认值
                }
            ]
        }
    ]
  }
}
```

执行时传给插件后台的数据示例：

\[{"id":"parameterId","values":\[{"id":123,"value":"3d029fbe08c011e99792fa163e50f2b5,${{abc}}"},{"id":1233,"value":"ab"},{"id":1235,"value":"id"}\]}\]

12、**简化版动态参数组件：dynamic-parameter-simple**

* 组件属性

| 属性名	| 属性说明	| 必填	| 格式	| 备注 | 
| :--- | :--- | :--- | :--- | :--- |
| rowAttributes[N].id	| 该属性的唯一ID, | 必填| 	是| 	String	| 
| rowAttributes[N].type	| 可选项: ["input", "select"]	| 是| 	String| 	当使用"select"时，需带有rowAttributes[N].options项| 
| rowAttributes[N].options| 	在页面上的下拉框选项| 	当rowAttributes[N].type为"select", 则为是| 	Array Of Instance Option	| 
| rowAttributes[N].options[M].name| 	在页面上的显示值| 	当rowAttributes[N].type为"select", 则为是	| String	| 
| rowAttributes[N].options[M].id	| 实际选取的值	| 当rowAttributes[N].type为"select", 则为是	| String	| 

* 配置示例
```
{
  "input": {
    "input_dynamic_parameter_simple": {
      "label": "动态参数(简易版)",
      "type": "dynamic-parameter-simple",
      "parameters": [
        {
          "rowAttributes": [
            {
              "id": "ip",               # 该属性的唯一ID, 必填
              "label": "IP",
              "type": "input",          # 可选值:["input", "select"], 如使用"input", 则"options"不填写
              "placeholder": "IP",
              "desc": "IP信息",
              "default": "8.8.8.8"
            },
            {
              "id": "protocol_port",
              "label": "协议\\端口",
              "type": "select",         # 可选值:["input", "select"], 如使用"select", 则必须带有"options"项
              "options": [              # 当type为"select"时, 则必须填写
                {
                  "id": "80",           # 实际选取的值
                  "name": "HTTP\\80"    # 在页面上的显示值
                },
                {
                  "id": "443",          # 实际选取的值
                  "name": "HTTPS\\443"  # 在页面上的显示值
                }
              ],
              "desc": "协议\\端口"
            }
          ]
        }
      ],
      "desc": "动态参数(简易版)输入示例"
    }
  }
}

```

#### 支持的特性

* 根据条件显示/隐藏当前字段
* 配置示例：

```text
"rely": {                 # 根据条件显示/隐藏当前字段配置
    "operation": "AND",   # 多条件间与/或，可选项： AND/OR
    "expression": [       # 条件list
        {
            "key": "",    # 条件字段名
            "value": Any  # 条件字段值
        }
    ]
}
```

### output <a id="output"></a>

#### 输出字段定义

* 值格式为对象
* 可配置一个或多个输出字段
* 每个输出字段的英文标识为key，value为对象
* 每个输出字段定义包含如下属性：

| 属性名 | 属性说明 | 格式 | 备注 |
| :--- | :--- | :--- | :--- |
| type | 输出字段的类型 | 字符串 | 必填。支持如下三类： string：字符串 artifact：产出文件，系统将自动归档到仓库 report: 自定义报告html，系统将自动存储，渲染在产出物报告界面 |
| description | 描述 | 字符串 | 非必填，说明 |
| isSensitive | 是否敏感 | 布尔 | 非必填，是否为敏感信息 |

## 三、 输入组件配置示例

* vuex-input

```text
"fieldName": {
    "label": "版本号",
    "type": "vuex-input",
    "desc": "三级版本号，例：1.0.1",
    "required": true
}
```

* 人名选择器

```text
"fieldName": {
    "label": "收件人",
    "type": "user-input",
    "desc": "只能填写当前项目成员"
}
```

* atom-checkbox

```text
"fieldName": {
    "label": "",
    "type": "atom-checkbox",
    "text": "是否需要Rebuild",
    "desc": "XXX"
}
```

* selector/select-input/devops-select
  * 选项列表在task.json中配置

    ```text
    "fieldName":{
        "label": "输入字段名",
        "type": "selector",
        "options":[
            {
                "id":"video",
                "name":"视频"
            },
            {
                "id":"website",
                "name":"网站"
            }
        ]
    }
    ```

  * 选项列表从接口获取
    * 配置规范： 由optionsConf的url、paramId、paramName、dataPath来指定

      ```text
      "optionsConf": {
            "url": "",         # 获取选项列表数据的API链接
            "dataPath": "",    # 选项列表数据所在的、API返回体json中的路径，没有此字段则默认为data， 示例：data.detail.list
            "paramId": "",     # 每个选项数据的id字段名
            "paramName": ""    # 每个选项数据的name字段名
        }
      ```

      * url支持两类：
        * bkci 内置的服务
        * 接入蓝鲸网关的第三方API
      * url返回规范： 返回json格式数据

        * status：操作是否成功， 0 成功，非0 失败
        * data：选项列表数据。支持指定所在路径，如data.detail.list
        * data中的选项ID和选项名称字段命名不强制，和配置中的paramId、paramName对应即可
        * message：当status非0时，错误信息

        ```text
        {
            "status": 0,
            "data": [
                {
                    "optionId": "",
                    "optionName": ""
                }
            ]
        }
        ```

      * 配置示例

      ```text
      "fieldName":{
            "label": "输入字段名",
            "type": "selector",
            "optionsConf": {
                "url": "http://xxx-test.com/prod/testnet",
                "paramId": "optionId",
                "paramName": "optionName"
            }
        }
      ```
* atom-checkbox-list 复选框列表

```text
"fieldName":{
    "label": "复选框列表",
    "type": "atom-checkbox-list",
    "list": [
        {
            "id": "php",
            "name": "php",
            "disabled": true,
            "desc": "php是世界上最好的语言"
        },
        {
            "id": "python",
            "name": "python",
            "disabled": false,
            "desc": "python是世界上最好的语言"
        }
    ]
}
```

* time-picker 日期选择器

```text
"fieldName":{
    "label": "日期选择",
    "type": "time-picker",
    "startDate": 1559555765,
    "endDate": 1577894399000,
    "showTime": false
}
```

* tips 提示信息

```text
"tipTest": {
      "label": "",
      "type": "tips",
      "tipStr": "这是个XXX系统，欢迎体验。[点击查看](http://www.baidu.com)"
}
```

* parameter 不定参数列表

```text
"params":{
  "label": "子流水线参数",
  "type": "parameter",
  "required": false,
  "desc": "带入子流水线的运行参数",
  "param": {
    "paramType": "url",                                // parameters是从url获取还是直接取列表的值，可以是url或者list
    "url": "XXXX",                                     // paramType是url的时候从接口取值
    "urlQuery":{
      "projectId": "","subPip": ""
    },
    "parameters": [                                    // paramType是list的时候从这里取值
      {
        "id": "parameterId",                           // 该行的唯一标识
        "key": "abc",
        "keyDisable": false,                           // 控制是否可编辑
        "keyType": "input",                            // 可以是input或者select
        "keyListType": "url",                          // 获取列表方式，可以是url或者list
        "keyUrl": "",                                  // type是select起作用
        "keyList": [ { "id": "id", "name": "name" } ], // type是select起作用，需要有id和name字段
        "keyMultiple": false,                          // select是否多选
        "value": "ddd",
        "valueDisable": false,
        "valueType": "input",                          // 可以是input或者select
        "valueListType": "url",                        // 获取列表方式，可以是url或者list
        "valueUrl": "",                                // type是select起作用
        "valueList": [ { "id": "id", "name": "name" }  ], // type是select起作用
        "valueMultiple: false                             // select是否多选
      }
    ]
  }
}
```

* enum-input 单选radio

```text
"fieldName_1":{
    "label": "radio",
    "type": "enum-input",
    "list": [
        {
            "value": "php",
            "label": "php"
        },
        {
            "value": "python",
            "label": "python"
        }
    ]
}
```

## 四、字段根据条件显示/隐藏配置

* 由输入字段定义中的rely属性来指定，rely有两个属性：
  * operation：多条件之间的关系，与、或、非
  * expression：条件表达式
* operation 字段支持三个值：
  * AND
  * OR
  * NOT
* 支持完全匹配，此时expression属性为：
  * key：字段英文名
  * value：字段值
* 支持正则，此时expression属性为：
  * key：字段英文名
  * regex： 正则表达式
* 示例：

当字段inputField\_1值为true，且inputField\_2值以.apk结尾时显示当前字段，否则隐藏当前字段

```text
"fieldName":{
    ...
    "rely": {
        "operation": "AND",
        "expression": [
            {
                "key": "inputField_1",
                "value": true
            },
            {
                "key": "inputField_2",
                "regex": ".*\\.apk$"
            }
        ]
    }
    ...
}
```

