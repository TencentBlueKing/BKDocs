# 清理文件托管任务

### 请求方法/请求路径

#### PUT  /ms/openapi/api/apigw/v3/artifactory/fileTask/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/tasks/{taskId}/clear

### 资源描述

#### 清理文件托管任务

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
| 200 | successful operation | 数据返回包装模型Boolean |

#### 请求样例

```javascript
curl -X PUT '[请替换为上方API地址栏请求地址]' \
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
  "data" : true,
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型Boolean

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | boolean | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

