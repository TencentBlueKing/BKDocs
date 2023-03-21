# 获取拦截规则列表

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/quality/rules/list

### 资源描述

#### 获取拦截规则列表

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| page | integer | 否 | 页目 | 1 |
| pageSize | integer | 否 | 每页数目 | 20 |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型分页数据包装模型质量红线-规则简要信息v2](get-the-list-of-blocking-rules.md) |

#### 请求样例

```javascript
curl -X GET '[请替换为API地址栏请求地址]?page={page}&amp;pageSize={pageSize}' \
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
      "pipelineCount" : 0,
      "pipelineExecuteCount" : 0,
      "indicatorList" : [ {
        "cnName" : "String",
        "name" : "String",
        "threshold" : "String",
        "hashId" : "String",
        "operation" : "String"
      } ],
      "enable" : true,
      "permissions" : {
        "canEnable" : true,
        "canEdit" : true,
        "canDelete" : true
      },
      "name" : "String",
      "range" : "ENUM",
      "rangeSummary" : [ {
        "lackElements" : "string",
        "name" : "String",
        "id" : "String",
        "type" : "String"
      } ],
      "interceptTimes" : 0,
      "ruleHashId" : "String",
      "controlPoint" : {
        "cnName" : "String",
        "name" : "String",
        "hashId" : "String"
      },
      "gatewayId" : "String"
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

## 数据返回包装模型分页数据包装模型质量红线-规则简要信息v2

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | [分页数据包装模型质量红线-规则简要信息v2](get-the-list-of-blocking-rules.md) | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 分页数据包装模型质量红线-规则简要信息v2

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| records | List&lt;[质量红线-规则简要信息v2](get-the-list-of-blocking-rules.md)&gt; | 是 | 数据 |
| count | integer | 是 | 总记录行数 |
| totalPages | integer | 是 | 总共多少页 |
| pageSize | integer | 是 | 每页多少条 |
| page | integer | 是 | 第几页 |

## 质量红线-规则简要信息v2

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| pipelineCount | integer | 是 | 流水线个数 |
| pipelineExecuteCount | integer | 是 | 生效流水线执次数 |
| indicatorList | List&lt;[RuleSummaryIndicator](get-the-list-of-blocking-rules.md)&gt; | 是 | 指标列表 |
| enable | boolean | 是 | 是否启用 |
| permissions | [质量红线-规则权限](get-the-list-of-blocking-rules.md) | 是 | 规则权限 |
| name | string | 是 | 规则名称 |
| range | ENUM\(ANY, PART\_BY\_TAG, PART\_BY\_NAME, \) | 是 | 生效范围 |
| rangeSummary | List&lt;[RuleRangeSummary](get-the-list-of-blocking-rules.md)&gt; | 是 | 包含模板和流水线的生效范围（新） |
| interceptTimes | integer | 是 | 拦截次数 |
| ruleHashId | string | 是 | 规则HashId |
| controlPoint | [RuleSummaryControlPoint](get-the-list-of-blocking-rules.md) | 是 | 控制点 |
| gatewayId | string | 是 | 红线ID |

## RuleSummaryIndicator

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| cnName | string | 否 | cnName |
| name | string | 否 | name |
| threshold | string | 否 | threshold |
| hashId | string | 否 | hashId |
| operation | string | 否 | operation |

## 质量红线-规则权限

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| canEnable | boolean | 是 | 是否可停用/启用 |
| canEdit | boolean | 是 | 是否可编辑 |
| canDelete | boolean | 是 | 是否可删除 |

## RuleRangeSummary

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| lackElements | List | 否 | lackElements |
| name | string | 否 | name |
| id | string | 否 | id |
| type | string | 否 | type |

## RuleSummaryControlPoint

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| cnName | string | 否 | cnName |
| name | string | 否 | name |
| hashId | string | 否 | hashId |

