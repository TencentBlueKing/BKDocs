# 获取所有种类流水线模板列表

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/templates/allTemplates

### 资源描述

#### 获取所有种类流水线模板列表

### 输入参数说明

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | projectId |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型OptionalTemplateList](get-a-list-of-all-kinds-of-pipeline-templates.md) |

#### 请求样例

```javascript
curl -X GET '[请替换为API地址栏请求地址]' \
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
    "templates" : {
      "string" : "string"
    },
    "count" : 0,
    "pageSize" : 0,
    "page" : 0
  },
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型OptionalTemplateList

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | [OptionalTemplateList](get-a-list-of-all-kinds-of-pipeline-templates.md) | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## OptionalTemplateList

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| templates | object | 否 | templates |
| count | integer | 否 | count |
| pageSize | integer | 否 | pageSize |
| page | integer | 否 | page |

