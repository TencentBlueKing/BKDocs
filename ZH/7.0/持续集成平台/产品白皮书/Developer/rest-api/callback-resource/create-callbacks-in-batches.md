# 批量创建callback回调

### 请求方法/请求路径

#### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/callbacks/batch

### 资源描述

#### 批量创建callback回调

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| url | string | 是 | url |  |
| region | string | 是 | region |  |
| event | string | 是 | event |  |
| secretToken | string | 否 | secretToken |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | projectId |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型项目的流水线回调创建结果](create-callbacks-in-batches.md) |

#### 请求样例

```javascript
curl -X POST '[请替换为API地址栏请求地址]?url={url}&amp;region={region}&amp;event={event}&amp;secretToken={secretToken}' \
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
    "successEvents" : "string",
    "failureEvents" : {
      "string" : "string"
    }
  },
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型项目的流水线回调创建结果

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | [项目的流水线回调创建结果](create-callbacks-in-batches.md) | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 项目的流水线回调创建结果

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| successEvents | List | 否 | successEvents |
| failureEvents | object | 否 | failureEvents |

