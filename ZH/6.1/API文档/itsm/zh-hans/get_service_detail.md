
### 请求方法

GET


### 请求地址

/api/c/compapi/v2/itsm/get_service_detail/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

服务详情查询，支持根据指定的服务 ID 查询服务详情

### 请求参数



#### 接口参数

| 字段         | 类型  | 必选  | 描述   |
| ---------- | --- | --- | ---- |
| service_id | int | 是   | 服务 id，从`服务列表查询`中的`data["id"]`字段获取 |

### 请求参数示例

```json
{  
    "bk_app_secret": "xxxx", 
    "bk_app_code": "xxxx", 
    "bk_token": "xxxx", 
    "service_id": 1
}  
```

### 返回结果示例

```json
{
    "message": "success",
    "code": 0,
    "data": {
        "service_id": 5,
        "workflow_id": 15,
        "name": "test3",
        "service_type": "event",
        "desc": "",
        "fields": [
            {
                "id": 1,
                "key": "title",
                "type": "STRING",
                "name": "标题",
                "desc": "请输入标题",
                "choice": [],
                "validate_type": "REQUIRE",
                "regex": "",
                "meta": {}
            },
            {
                "id": 96,
                "key": "CESHILEIXING",
                "type": "SELECT",
                "name": "测试类型",
                "desc": "",
                "choice": [
                    {
                        "name": "变更",
                        "key": "BIANGENG"
                    },
                    {
                        "name": "请求",
                        "key": "QINGQIU"
                    }
                ],
                "validate_type": "REQUIRE",
                "regex": "EMPTY",
                "meta": {}
            },
            {
                "id": 97,
                "key": "ZIDINGYIBIAOGE",
                "type": "CUSTOMTABLE",
                "name": "自定义表格",
                "desc": "",
                "choice": [],
                "validate_type": "REQUIRE",
                "regex": "EMPTY",
                "meta": {
                    "columns": [
                        {
                            "choice": [],
                            "display": "input",
                            "key": "TEST",
                            "name": "test"
                        },
                        {
                            "choice": [
                                {
                                    "name": "a",
                                    "key": "A"
                                },
                                {
                                    "name": "b",
                                    "key": "B"
                                }
                            ],
                            "display": "select",
                            "key": "TEST2",
                            "name": "test2"
                        }
                    ]
                }
            }
        ]
    },
    "result": true
}
```

### 返回结果参数说明

| 字段      | 类型        | 描述                                          |
| ------- | --------- | ------------------------------------------- |
| result  | bool      | 返回结果，true 为成功，false 为失败                       |
| code    | int       | 返回码，0 表示成功，其他值表示失败                           |
| message | string    | 错误信息                                        |
| data    | object    | 返回数据 |

### data

| 字段           | 类型     | 描述   |
| ------------ | ------ | ---- |
| service_id   | int    | 服务 id |
| workflow_id  | int    | 服务流程 id |
| name         | string | 服务名称 |
| service_type | string | 服务类型 |
| desc         | string | 服务描述 |
| fields       | array  | 提单字段 |

### fields

| 字段            | 类型     | 描述      |
| ------------- | ------ | ------- |
| id            | int    | 字段 id    |
| key           | string | 字段唯一标识  |
| type          | string | 字段类型    |
| name          | string | 字段名称    |
| desc          | string | 字段描述    |
| choice        | array  | 选项      |
| validate_type | string | 校验规则    |
| regex         | string | 正则校验规则  |
| meta          | object   | 自定义表格格式 |

### type（字段类型）

| 类型 Key            | 类型     |
| ------------- | ------ |
| STRING            | 单行文本    |
| STRING  |  单行文本|
| TEXT  |  多行文本|
| INT  |  数字|
| DATE  |  日期|
| DATETIME  |  时间|
| DATETIMERANGE  |  时间间隔|
| TABLE  |  表格|
| SELECT  |  单选下拉框|
| MULTISELECT  |  多选下拉框|
| CHECKBOX  |  复选框|
| RADIO  |  单选框|
| MEMBERS  |  多选人员选择|
| RICHTEXT  |  富文本|
| FILE  |  附件上传|
| CUSTOMTABLE  |  自定义表格|
| TREESELECT  |  树形选择|
| CASCADE  |  级联|

### meta

| 字段      | 类型    | 描述  |
| ------- | ----- | --- |
| columns | array | 列   |

### columns

| 字段      | 类型     | 描述   |
| ------- | ------ | ---- |
| choice  | array  | 选项   |
| display | string | 展现形式 |
| key     | string | 唯一标识 |
| name    | string | 名字   |