# 模版管理-获取模版列表

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/templates

### 资源描述

#### 模版管理-获取模版列表

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| templateType | string | 否 | 模版类型 |  |
| storeFlag | boolean | 否 | 是否已关联到store |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型TemplateListModel](get-a-list-of-templates.md) |

#### 请求样例

```javascript
curl -X GET '[请替换为API地址栏请求地址]?templateType={templateType}&amp;storeFlag={storeFlag}' \
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
    "models" : [ {
      "templateType" : "String",
      "associatePipelines" : [ {
        "id" : "String"
      } ],
      "hasPermission" : true,
      "name" : "String",
      "templateTypeDesc" : "String",
      "templateId" : "String",
      "versionName" : "String",
      "version" : 0,
      "hasInstance2Upgrade" : true,
      "logoUrl" : "String",
      "storeFlag" : true,
      "associateCodes" : "string"
    } ],
    "hasPermission" : true,
    "count" : 0,
    "projectId" : "String"
  },
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型TemplateListModel

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | [TemplateListModel](get-a-list-of-templates.md) | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## TemplateListModel

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| models | List&lt;[TemplateModel](get-a-list-of-templates.md)&gt; | 否 | models |
| hasPermission | boolean | 否 | hasPermission |
| count | integer | 否 | count |
| projectId | string | 否 | projectId |

## TemplateModel

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| templateType | string | 是 | 模板类型 |
| associatePipelines | List&lt;[流水线模型-ID](get-a-list-of-templates.md)&gt; | 是 | 关联的流水线 |
| hasPermission | boolean | 是 | 是否有模版操作权限 |
| name | string | 是 | 模版名称 |
| templateTypeDesc | string | 是 | 模板类型描述 |
| templateId | string | 是 | 模版ID |
| versionName | string | 是 | 最新版本号 |
| version | integer | 是 | 版本ID |
| hasInstance2Upgrade | boolean | 是 | 是否有可更新实例 |
| logoUrl | string | 是 | 模版logo |
| storeFlag | boolean | 是 | 是否关联到市场 |
| associateCodes | List | 是 | 关联的代码库 |

## 流水线模型-ID

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 流水线ID |

