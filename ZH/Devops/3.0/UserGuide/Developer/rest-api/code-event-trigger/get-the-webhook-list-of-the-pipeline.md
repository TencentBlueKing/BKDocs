# 获取流水线的webhook列表

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/{projectId}/{pipelineId}/webhook

### 资源描述

#### 获取流水线的webhook列表

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| page | integer | 否 | 页码 |  |
| pageSize | integer | 否 | 每页大小 |  |

| X-DEVOPS-UID | string | 是 | userId |  |
| :--- | :--- | :--- | :--- | :--- |


#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 |  |  |
| pipelineId | string | 是 |  |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型ListPipelineWebhook](get-the-webhook-list-of-the-pipeline.md) |

#### 请求样例

```javascript
curl -X GET '[请替换为API地址栏请求地址]?page={page}&amp;pageSize={pageSize}' \
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
  "data" : [ {
    "repoType" : "ENUM",
    "repoName" : "String",
    "repositoryType" : "ENUM",
    "id" : 0,
    "projectName" : "String",
    "projectId" : "String",
    "repoHashId" : "String",
    "taskId" : "String",
    "pipelineId" : "String"
  } ],
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型ListPipelineWebhook

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | List&lt;[PipelineWebhook](get-the-webhook-list-of-the-pipeline.md)&gt; | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## PipelineWebhook

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| repoType | ENUM\(ID, NAME, \) | 否 | repoType |
| repoName | string | 否 | repoName |
| repositoryType | ENUM\(CODE\_SVN, CODE\_GIT, CODE\_GITLAB, GITHUB, CODE\_TGIT, \) | 否 | repositoryType |
| id | integer | 否 | id |
| projectName | string | 否 | projectName |
| projectId | string | 否 | projectId |
| repoHashId | string | 否 | repoHashId |
| taskId | string | 否 | taskId |
| pipelineId | string | 否 | pipelineId |

