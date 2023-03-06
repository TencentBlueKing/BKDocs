# 更新流水线设置

### 请求方法/请求路径

#### PUT  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/setting\_update

### 资源描述

#### 更新流水线设置

### 输入参数说明

#### Body参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| body | [PipelineSetting](update-pipeline-settings.md) | 是 | 流水线设置 |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |
| pipelineId | string | 是 | 流水线ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型Boolean](update-pipeline-settings.md) |

#### 请求样例

```javascript
curl -X PUT '[请替换为API地址栏请求地址]' \
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

## PipelineSetting

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| successSubscription | [设置-订阅消息](update-pipeline-settings.md) | 否 | successSubscription |
| runLockType | ENUM\(MULTIPLE, SINGLE, SINGLE\_LOCK, LOCK, \) | 否 | runLockType |
| maxPipelineResNum | integer | 否 | maxPipelineResNum |
| version | integer | 否 | version |
| pipelineId | string | 否 | pipelineId |
| labels | List | 否 | labels |
| pipelineName | string | 否 | pipelineName |
| maxConRunningQueueSize | integer | 否 | maxConRunningQueueSize |
| maxQueueSize | integer | 否 | maxQueueSize |
| hasPermission | boolean | 否 | hasPermission |
| waitQueueTimeMinute | integer | 否 | waitQueueTimeMinute |
| failSubscription | [设置-订阅消息](update-pipeline-settings.md) | 否 | failSubscription |
| buildNumRule | string | 否 | buildNumRule |
| projectId | string | 否 | projectId |
| desc | string | 否 | desc |

## 设置-订阅消息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| types | List | 是 | 通知方式\(email, rtx\) |
| wechatGroupMarkdownFlag | boolean | 否 | 企业微信群通知转为Markdown格式开关 |
| groups | List | 否 | 分组 |
| detailFlag | boolean | 否 | 通知的流水线详情连接开关 |
| users | string | 否 | 通知人员 |
| wechatGroupFlag | boolean | 否 | 企业微信群通知开关 |
| content | string | 否 | 自定义通知内容 |
| wechatGroup | string | 否 | 企业微信群通知群ID |

## 数据返回包装模型Boolean

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | boolean | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

