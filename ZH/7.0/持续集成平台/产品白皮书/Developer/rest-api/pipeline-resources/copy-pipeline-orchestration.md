# 复制流水线编排

### 请求方法/请求路径

#### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/copy

### 资源描述

#### 复制流水线编排

### 输入参数说明

#### Body参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| body | [流水线-COPY创建信息](copy-pipeline-orchestration.md) | 是 | 流水线COPY |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |
| pipelineId | string | 是 | 流水线模型 |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型流水线模型-ID](copy-pipeline-orchestration.md) |

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
  "data" : {
    "id" : "String"
  },
  "message" : "String",
  "status" : 0
}
```

## 流水线-COPY创建信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| name | string | 是 | 名称 |
| hasCollect | boolean | 否 | 是否收藏 |
| desc | string | 否 | 描述 |
| group | string | 否 | 分组名称 |

## 数据返回包装模型流水线模型-ID

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | [流水线模型-ID](copy-pipeline-orchestration.md) | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 流水线模型-ID

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 流水线ID |

