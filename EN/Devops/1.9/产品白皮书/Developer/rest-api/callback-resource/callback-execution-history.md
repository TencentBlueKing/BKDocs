# callback回调执行历史记录

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/callbacks/history

### 资源描述

#### callback回调执行历史记录

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| url | string | 是 | 回调url |  |
| event | string | 是 | 事件类型 |  |
| startTime | string | 否 | 开始时间\(yyyy-MM-dd HH:mm:ss格式\) |  |
| endTime | string | 否 | 结束时间\(yyyy-MM-dd HH:mm:ss格式\) |  |
| page | integer | 否 | 第几页 | 1 |
| pageSize | integer | 否 | 每页多少条 | 20 |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | projectId |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型分页数据包装模型项目的流水线回调历史](callback-execution-history.md) |

#### 请求样例

```javascript
curl -X GET '[请替换为API地址栏请求地址]?url={url}&amp;event={event}&amp;startTime={startTime}&amp;endTime={endTime}&amp;page={page}&amp;pageSize={pageSize}' \
-H 'X-DEVOPS-UID:xxx'
```

#### HEADER样例

```javascript
accept: application/json
Content-Type: application/json
X-DEVOPS-UID:xxx
```

### 返回样例-200

```javascript
{
  "data" : {
    "records" : [ {
      "callBackUrl" : "String",
      "responseBody" : "String",
      "responseCode" : 0,
      "errorMsg" : "String",
      "requestHeaders" : [ {
        "name" : "String",
        "value" : "String"
      } ],
      "requestBody" : "String",
      "createdTime" : 0,
      "startTime" : 0,
      "id" : 0,
      "endTime" : 0,
      "projectId" : "String",
      "events" : "String",
      "status" : "String"
    } ],
    "count" : 0,
    "totalPages" : 0,
    "pageSize" : 0,
    "page" : 0
  },
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型分页数据包装模型项目的流水线回调历史

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | [分页数据包装模型项目的流水线回调历史](callback-execution-history.md) | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 分页数据包装模型项目的流水线回调历史

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| records | List&lt;[项目的流水线回调历史](callback-execution-history.md)&gt; | 是 | 数据 |
| count | integer | 是 | 总记录行数 |
| totalPages | integer | 是 | 总共多少页 |
| pageSize | integer | 是 | 每页多少条 |
| page | integer | 是 | 第几页 |

## 项目的流水线回调历史

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| callBackUrl | string | 否 | callBackUrl |
| responseBody | string | 否 | responseBody |
| responseCode | integer | 否 | responseCode |
| errorMsg | string | 否 | errorMsg |
| requestHeaders | List&lt;[CallBackHeader](callback-execution-history.md)&gt; | 否 | requestHeaders |
| requestBody | string | 否 | requestBody |
| createdTime | integer | 否 | createdTime |
| startTime | integer | 否 | startTime |
| id | integer | 否 | id |
| endTime | integer | 否 | endTime |
| projectId | string | 否 | projectId |
| events | string | 否 | events |
| status | string | 否 | status |

## CallBackHeader

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| name | string | 否 | name |
| value | string | 否 | value |

