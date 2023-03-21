# 创建文件托管任务

### 请求方法/请求路径

#### POST  /ms/openapi/api/apigw/v3/artifactory/fileTask/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/create

### 资源描述

#### 创建文件托管任务

### 输入参数说明

#### Body参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| body | 创建文件托管任务请求 | 是 | taskId |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | projectId |  |
| pipelineId | string | 是 | pipelineId |  |
| buildId | string | 是 | buildId |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | 数据返回包装模型String |

#### 请求样例

```javascript
curl -X POST '[请替换为API地址栏请求地址]' \
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
  "data" : "String",
  "message" : "String",
  "status" : 0
}
```

## 创建文件托管任务请求

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| path | string | 是 | 文件路径 |
| fileType | ENUM\(BK\_ARCHIVE, BK\_CUSTOM, BK\_REPORT, BK\_PLUGIN\_FE, \) | 是 | 文件类型 |

## 数据返回包装模型String

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | string | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

