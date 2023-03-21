# 获取流水线的webhook构建日志列表

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/{projectId}/{pipelineId}/webhook/buildLog

### 资源描述

#### 获取流水线的webhook构建日志列表

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| repoName | string | 否 | 仓库名 |  |
| commitId | string | 否 | commitId |  |
| page | integer | 否 | 页码 |  |
| pageSize | integer | 否 | 每页大小 |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 |  |  |
| pipelineId | string | 是 |  |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型SQLPage流水线webhook-触发日志明细](get-the-pipelines-webhook-build-log-list.md) |

#### 请求样例

```javascript
curl -X GET '[请替换为上方API地址栏请求地址]?repoName={repoName}&amp;commitId={commitId}&amp;page={page}&amp;pageSize={pageSize}' \
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
      "codeType" : "String",
      "repoName" : "String",
      "success" : true,
      "triggerResult" : "String",
      "createdTime" : 0,
      "logId" : 0,
      "taskName" : "String",
      "id" : 0,
      "commitId" : "String",
      "projectId" : "String",
      "taskId" : "String",
      "pipelineId" : "String"
    } ],
    "count" : 0
  },
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型SQLPage流水线webhook-触发日志明细

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | [SQLPage流水线webhook-触发日志明细](get-the-pipelines-webhook-build-log-list.md) | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## SQLPage流水线webhook-触发日志明细

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| records | List&lt;[流水线webhook-触发日志明细](get-the-pipelines-webhook-build-log-list.md)&gt; | 否 | records |
| count | integer | 否 | count |

## 流水线webhook-触发日志明细

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| codeType | string | 是 | 代码库类型 |
| repoName | string | 是 | 仓库名 |
| success | boolean | 是 | 是否成功触发 |
| triggerResult | string | 是 | 触发结果,如果触发成功就是buildId,触发不成功就是不成功原因 |
| createdTime | integer | 否 | createdTime |
| logId | integer | 否 | logId |
| taskName | string | 是 | 插件名 |
| id | integer | 否 | id |
| commitId | string | 是 | commitId |
| projectId | string | 是 | 项目ID |
| taskId | string | 是 | 插件ID |
| pipelineId | string | 是 | 流水线ID |

