# 重试构建-重试或者跳过失败插件

### 请求方法/请求路径

#### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/retry

### 资源描述

#### 重试构建-重试或者跳过失败插件

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| taskId | string | 否 | 要重试或跳过的插件ID，或者StageId |  |
| failedContainer | boolean | 否 | 仅重试所有失败Job |  |
| skip | boolean | 否 | 跳过失败插件，为true时需要传taskId值（值为stageId则表示跳过Stage下所有失败插件） |  |
| channelCode | string | 否 | 渠道号，默认为BS |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |
| pipelineId | string | 是 | 流水线ID |  |
| buildId | string | 是 | 构建ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型构建模型-ID](retry-the-build.md) |

#### 请求样例

```javascript
curl -X POST '[请替换为API地址栏请求地址]?taskId={taskId}&amp;failedContainer={failedContainer}&amp;skip={skip}&amp;channelCode={channelCode}' \
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

## 数据返回包装模型构建模型-ID

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | [构建模型-ID](retry-the-build.md) | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 构建模型-ID

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 构建ID |

