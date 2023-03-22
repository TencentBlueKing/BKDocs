# 查询文件托管任务状态

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/artifactory/fileTask/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/tasks/{taskId}/status

### 资源描述

#### 查询文件托管任务状态

### 输入参数说明

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | projectId |  |
| pipelineId | string | 是 | pipelineId |  |
| buildId | string | 是 | buildId |  |
| taskId | string | 是 | taskId |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | 数据返回包装模型版本仓库-文件托管任务信息 |

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
    "path" : "String",
    "ip" : "String",
    "id" : "String",
    "status" : 0
  },
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型版本仓库-文件托管任务信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | 版本仓库-文件托管任务信息 | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 版本仓库-文件托管任务信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| path | string | 是 | 文件绝对路径 |
| ip | string | 是 | 文件所在机器IP |
| id | string | 是 | 任务Id |
| status | integer | 是 | 任务状态 |

