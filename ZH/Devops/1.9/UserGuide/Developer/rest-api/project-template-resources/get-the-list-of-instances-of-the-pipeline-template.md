# 获取流水线模板的实例列表

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/templates/{templateId}/templateInstances

### 资源描述

#### 获取流水线模板的实例列表

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| page | integer | 否 | 第几页 | 1 |
| pageSize | integer | 否 | 每页多少条 | 30 |
| searchKey | string | 否 | 名字搜索的关键字 |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |
| templateId | string | 是 | 模板ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型TemplateInstancePage](get-the-list-of-instances-of-the-pipeline-template.md) |

#### 请求样例

```javascript
curl -X GET '[请替换为API地址栏请求地址]?page={page}&amp;pageSize={pageSize}&amp;searchKey={searchKey}' \
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
    "instances" : [ {
      "pipelineName" : "String",
      "hasPermission" : true,
      "updateTime" : 0,
      "templateId" : "String",
      "versionName" : "String",
      "version" : 0,
      "pipelineId" : "String",
      "status" : "ENUM"
    } ],
    "latestVersion" : {
      "creator" : "String",
      "updateTime" : 0,
      "versionName" : "String",
      "version" : 0
    },
    "count" : 0,
    "pageSize" : 0,
    "page" : 0,
    "templateId" : "String",
    "projectId" : "String"
  },
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型TemplateInstancePage

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | [TemplateInstancePage](get-the-list-of-instances-of-the-pipeline-template.md) | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## TemplateInstancePage

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| instances | List&lt;[TemplatePipeline](get-the-list-of-instances-of-the-pipeline-template.md)&gt; | 否 | instances |
| latestVersion | [TemplateVersion](get-the-list-of-instances-of-the-pipeline-template.md) | 否 | latestVersion |
| count | integer | 否 | count |
| pageSize | integer | 否 | pageSize |
| page | integer | 否 | page |
| templateId | string | 否 | templateId |
| projectId | string | 否 | projectId |

## TemplatePipeline

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| pipelineName | string | 否 | pipelineName |
| hasPermission | boolean | 否 | hasPermission |
| updateTime | integer | 否 | updateTime |
| templateId | string | 否 | templateId |
| versionName | string | 否 | versionName |
| version | integer | 否 | version |
| pipelineId | string | 否 | pipelineId |
| status | ENUM\(PENDING\_UPDATE, UPDATING, UPDATED, \) | 否 | status |

## TemplateVersion

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| creator | string | 否 | creator |
| updateTime | integer | 否 | updateTime |
| versionName | string | 否 | versionName |
| version | integer | 否 | version |

