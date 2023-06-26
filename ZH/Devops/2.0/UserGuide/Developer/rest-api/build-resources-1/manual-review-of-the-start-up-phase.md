# 手动审核启动阶段

### 请求方法/请求路径

#### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/stages/{stageId}/manualStart

### 资源描述

#### 手动审核启动阶段

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| cancel | boolean | 否 | 取消执行 |  |

#### Body参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| body | [人工审核-自定义参数](manual-review-of-the-start-up-phase.md) | 否 | 审核请求体 |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |
| pipelineId | string | 是 | 流水线ID |  |
| buildId | string | 是 | 构建ID |  |
| stageId | string | 是 | 阶段ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型Boolean](manual-review-of-the-start-up-phase.md) |

#### 请求样例

```javascript
curl -X POST '[请替换为API地址栏请求地址]?cancel={cancel}' \
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

## 人工审核-自定义参数

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| valueType | ENUM\(STRING, TEXTAREA, BOOLEAN, ENUM, MULTIPLE, \) | 否 | 参数类型 |
| options | List&lt;[人工审核-自定义参数-下拉框列表剑](manual-review-of-the-start-up-phase.md)&gt; | 否 | 下拉框列表 |
| chineseName | string | 否 | 中文名称 |
| value | object | 是 | 参数内容 |
| key | string | 是 | 参数名 |
| required | boolean | 是 | 是否必填 |
| desc | string | 否 | 参数描述 |

## 人工审核-自定义参数-下拉框列表剑

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| value | string | 是 | 参数内容 |
| key | string | 是 | 参数名 |

## 数据返回包装模型Boolean

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | boolean | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

