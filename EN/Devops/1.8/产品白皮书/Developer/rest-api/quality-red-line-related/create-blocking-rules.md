# 创建拦截规则

### 请求方法/请求路径

#### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/quality/rules/create

### 资源描述

#### 创建拦截规则

### 输入参数说明

#### Body参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| body | [规则创建请求](create-blocking-rules.md) | 是 | 规则内容 |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型String](create-blocking-rules.md) |

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

## 规则创建请求

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| templateRange | List | 是 | 生效的流水线模板id集合 |
| auditUserList | List | 否 | 审核通知人员 |
| range | List | 是 | 生效的流水线id集合 |
| auditTimeoutMinutes | integer | 否 | 审核超时时间 |
| notifyTypeList | List | 否 | 通知类型 |
| notifyUserList | List | 否 | 通知人员名单 |
| controlPointPosition | string | 是 | 控制点位置 |
| name | string | 是 | 规则名称 |
| notifyGroupList | List | 否 | 通知组名单 |
| operation | ENUM\(END, AUDIT, \) | 是 | 操作类型 |
| indicatorIds | List&lt;[CreateRequestIndicator](create-blocking-rules.md)&gt; | 是 | 指标类型 |
| controlPoint | string | 是 | 控制点 |
| gatewayId | string | 否 | 红线匹配的id |
| desc | string | 是 | 规则描述 |

## CreateRequestIndicator

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| threshold | string | 否 | threshold |
| hashId | string | 否 | hashId |
| operation | string | 否 | operation |

## 数据返回包装模型String

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | string | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

