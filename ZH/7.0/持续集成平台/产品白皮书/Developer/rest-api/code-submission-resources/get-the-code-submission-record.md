# 获取代码提交记录

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/repositoryCommit

### 资源描述

#### 获取代码提交记录

### 输入参数说明

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |
| pipelineId | string | 是 | 流水线ID |  |
| buildId | string | 是 | buildID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型ListCommitResponse](get-the-code-submission-record.md) |

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
  "data" : [ {
    "elementId" : "String",
    "records" : [ {
      "elementId" : "String",
      "repoId" : "String",
      "committer" : "String",
      "commitTime" : 0,
      "repoName" : "String",
      "commit" : "String",
      "buildId" : "String",
      "comment" : "String",
      "type" : 0,
      "url" : "String",
      "pipelineId" : "String"
    } ],
    "name" : "String"
  } ],
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型ListCommitResponse

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | List&lt;[CommitResponse](get-the-code-submission-record.md)&gt; | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## CommitResponse

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| elementId | string | 否 | elementId |
| records | List&lt;[CommitData](get-the-code-submission-record.md)&gt; | 否 | records |
| name | string | 否 | name |

## CommitData

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| elementId | string | 否 | elementId |
| repoId | string | 否 | repoId |
| committer | string | 否 | committer |
| commitTime | integer | 否 | commitTime |
| repoName | string | 否 | repoName |
| commit | string | 否 | commit |
| buildId | string | 否 | buildId |
| comment | string | 否 | comment |
| type | integer | 否 | type |
| url | string | 否 | url |
| pipelineId | string | 否 | pipelineId |

