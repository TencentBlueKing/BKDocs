# 获取拦截记录

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/quality/intercepts/list

### 资源描述

#### 获取拦截记录

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| pipelineId | string | 否 | 流水线ID |  |
| ruleHashId | string | 否 | 规则ID |  |
| interceptResult | string | 否 | 状态 |  |
| startTime | integer | 否 | 开始时间 |  |
| endTime | integer | 否 | 截止时间 |  |
| page | integer | 否 | 页号 | 1 |
| pageSize | integer | 否 | 页数 | 20 |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型分页数据包装模型质量红线-拦截记录](obtain-interception-records.md) |

#### 请求样例

```javascript
curl -X GET '[请替换为API地址栏请求地址]?pipelineId={pipelineId}&amp;ruleHashId={ruleHashId}&amp;interceptResult={interceptResult}&amp;startTime={startTime}&amp;endTime={endTime}&amp;page={page}&amp;pageSize={pageSize}' \
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
    "records" : [ {
      "checkTimes" : 0,
      "num" : 0,
      "buildId" : "String",
      "remark" : "String",
      "buildNo" : "String",
      "hashId" : "String",
      "pipelineId" : "String",
      "pipelineName" : "String",
      "pipelineIsDelete" : true,
      "interceptList" : [ {
        "indicatorId" : "String",
        "indicatorName" : "String",
        "indicatorType" : "String",
        "pass" : true,
        "actualValue" : "String",
        "logPrompt" : "String",
        "detail" : "String",
        "operation" : "ENUM",
        "value" : "String",
        "controlPoint" : "String"
      } ],
      "interceptResult" : "ENUM",
      "ruleName" : "String",
      "ruleHashId" : "String",
      "timestamp" : 0
    } ],
    "count" : 0,
    "totalPages" : 0,
    "pageSize" : 0,
    "page" : 0
  },
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型分页数据包装模型质量红线-拦截记录

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | [分页数据包装模型质量红线-拦截记录](obtain-interception-records.md) | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 分页数据包装模型质量红线-拦截记录

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| records | List&lt;[质量红线-拦截记录](obtain-interception-records.md)&gt; | 是 | 数据 |
| count | integer | 是 | 总记录行数 |
| totalPages | integer | 是 | 总共多少页 |
| pageSize | integer | 是 | 每页多少条 |
| page | integer | 是 | 第几页 |

## 质量红线-拦截记录

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| checkTimes | integer | 是 | 检查次数 |
| num | integer | 是 | 项目里的序号 |
| buildId | string | 是 | 构建ID |
| remark | string | 是 | 描述 |
| buildNo | string | 是 | 构建号 |
| hashId | string | 是 | hashId |
| pipelineId | string | 是 | 流水线ID |
| pipelineName | string | 是 | 流水线名称 |
| pipelineIsDelete | boolean | 是 | 流水线是否已删除 |
| interceptList | List&lt;[质量红线-拦截规则拦截记录](obtain-interception-records.md)&gt; | 是 | 描述列表 |
| interceptResult | ENUM\(PASS, FAIL, \) | 是 | 拦截结果 |
| ruleName | string | 是 | 规则名称 |
| ruleHashId | string | 是 | 规则HashId |
| timestamp | integer | 是 | 时间戳\(秒\) |

## 质量红线-拦截规则拦截记录

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| indicatorId | string | 是 | 指标ID |
| indicatorName | string | 是 | 指标名称 |
| indicatorType | string | 否 | 指标插件类型 |
| pass | boolean | 是 | 是否通过 |
| actualValue | string | 是 | 实际值 |
| logPrompt | string | 否 | 指标日志输出详情 |
| detail | string | 是 | 指标详情 |
| operation | ENUM\(GT, GE, LT, LE, EQ, \) | 是 | 关系 |
| value | string | 是 | 阈值值大小 |
| controlPoint | string | 是 | 控制点 |

