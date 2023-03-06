# 获取构建节点信息（扩展接口）

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/environment/projects/{projectId}/nodes/{nodeHashId}/listPipelineRef

### 资源描述

#### 获取构建节点信息（扩展接口）

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| sortBy | string | 是 | 排序字段, pipelineName | lastBuildTime |
| sortDirection | string | 是 | 排序方向, ASC | DESC |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |
| nodeHashId | string | 是 | 节点 hashId |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | 数据返回包装模型List第三方构建机流水线引用信息 |

#### 请求样例

```javascript
curl -X GET '[请替换API地址栏请求地址]?sortBy={sortBy}&amp;sortDirection={sortDirection}' \
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
    "pipelineName" : "String",
    "jobName" : "String",
    "jobId" : "String",
    "agentId" : 0,
    "vmSeqId" : "String",
    "nodeHashId" : "String",
    "nodeId" : 0,
    "projectId" : "String",
    "agentHashId" : "String",
    "pipelineId" : "String",
    "lastBuildTime" : "String"
  } ],
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型List第三方构建机流水线引用信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | List&lt;第三方构建机流水线引用信息&gt; | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 第三方构建机流水线引用信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| pipelineName | string | 是 | 流水线名称 |
| jobName | string | 是 | Job Name |
| jobId | string | 是 | Job ID |
| agentId | integer | 是 | Agent ID |
| vmSeqId | string | 是 | Vm Seq ID |
| nodeHashId | string | 是 | Node Hash ID |
| nodeId | integer | 是 | Node ID |
| projectId | string | 是 | 项目ID |
| agentHashId | string | 是 | Agent Hash ID |
| pipelineId | string | 是 | 流水线ID |
| lastBuildTime | string | 否 | 上次构建时间 |

