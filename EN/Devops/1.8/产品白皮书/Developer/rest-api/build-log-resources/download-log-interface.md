# 下载日志接口

## 请求方法/请求路径

### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/logs/download

## 资源描述

### 下载日志接口

## 输入参数说明

### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| tag | string | 否 | 对应element ID |  |
| jobId | string | 否 | 对应jobId |  |
| executeCount | integer | 否 | 执行次数 |  |

### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |
| pipelineId | string | 是 | 流水线ID |  |
| buildId | string | 是 | 构建ID |  |

### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| default | successful operation | parse error |

### 请求样例

```javascript
curl -X GET '[请替换为API地址栏请求地址]?tag={tag}&amp;jobId={jobId}&amp;executeCount={executeCount}' \
-H 'X-DEVOPS-UID:xxx'
```

### HEADER样例

```javascript
accept: application/json
Content-Type: application/json
X-DEVOPS-UID:xxx
```

