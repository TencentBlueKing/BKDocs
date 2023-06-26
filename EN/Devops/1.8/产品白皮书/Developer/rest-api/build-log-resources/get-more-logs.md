# 获取更多日志

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/logs/more

### 资源描述

#### 获取更多日志

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| debug | boolean | 否 | 是否包含调试日志 |  |
| num | integer | 否 | 日志行数 |  |
| fromStart | boolean | 否 | 是否正序输出 |  |
| start | integer | 是 | 起始行号 |  |
| end | integer | 是 | 结尾行号 |  |
| tag | string | 否 | 对应elementId |  |
| jobId | string | 否 | 对应jobId |  |
| executeCount | integer | 否 | 执行次数 |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |
| pipelineId | string | 是 | 流水线ID |  |
| buildId | string | 是 | 构建ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型日志查询模型](get-more-logs.md) |

#### 请求样例

```javascript
curl -X GET '[请替换为API地址栏请求地址]?debug={debug}&amp;num={num}&amp;fromStart={fromStart}&amp;start={start}&amp;end={end}&amp;tag={tag}&amp;jobId={jobId}&amp;executeCount={executeCount}' \
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
    "timeUsed" : 0,
    "hasMore" : true,
    "subTags" : "string",
    "buildId" : "String",
    "finished" : true,
    "logs" : [ {
      "subTag" : "String",
      "jobId" : "String",
      "lineNo" : 0,
      "tag" : "String",
      "message" : "String",
      "priority" : "String",
      "executeCount" : 0,
      "timestamp" : 0
    } ],
    "status" : 0
  },
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型日志查询模型

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | [日志查询模型](get-more-logs.md) | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 日志查询模型

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| timeUsed | integer | 否 | 所用时间 |
| hasMore | boolean | 否 | 是否有后续日志 |
| subTags | List | 是 | 日志子tag列表 |
| buildId | string | 是 | 构建ID |
| finished | boolean | 是 | 是否结束 |
| logs | List&lt;[日志模型](get-more-logs.md)&gt; | 是 | 日志列表 |
| status | integer | 否 | 日志查询状态 |

## 日志模型

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| subTag | string | 是 | 日志子tag |
| jobId | string | 是 | 日志jobId |
| lineNo | integer | 是 | 日志行号 |
| tag | string | 是 | 日志tag |
| message | string | 是 | 日志消息体 |
| priority | string | 是 | 日志权重级 |
| executeCount | integer | 是 | 日志执行次数 |
| timestamp | integer | 是 | 日志时间戳 |

