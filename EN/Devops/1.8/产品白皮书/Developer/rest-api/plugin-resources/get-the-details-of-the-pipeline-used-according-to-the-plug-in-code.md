# 根据插件代码获取使用的流水线详情

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/atoms/{atomCode}/pipelines

### 资源描述

#### 根据插件代码获取使用的流水线详情

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| page | integer | 否 | 第几页 | 1 |
| pageSize | integer | 否 | 每页多少条 | 20 |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| atomCode | string | 是 | 插件代码 |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | 数据返回包装模型分页数据包装模型流水线信息 |

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
      "pipelineName" : "String",
      "deptName" : "String",
      "projectCode" : "String",
      "bgName" : "String",
      "projectName" : "String",
      "pipelineId" : "String",
      "atomVersion" : "String",
      "centerName" : "String"
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

## 数据返回包装模型分页数据包装模型流水线信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | 分页数据包装模型流水线信息 | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 分页数据包装模型流水线信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| records | List&lt;流水线信息&gt; | 是 | 数据 |
| count | integer | 是 | 总记录行数 |
| totalPages | integer | 是 | 总共多少页 |
| pageSize | integer | 是 | 每页多少条 |
| page | integer | 是 | 第几页 |

## 流水线信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| pipelineName | string | 是 | 流水线名称 |
| deptName | string | 否 | 所属部门 |
| projectCode | string | 是 | 项目标识 |
| bgName | string | 否 | 所属BG |
| projectName | string | 否 | 所属项目 |
| pipelineId | string | 是 | 流水线ID |
| atomVersion | string | 否 | 流水线使用的插件版本 |
| centerName | string | 否 | 所属中心 |

