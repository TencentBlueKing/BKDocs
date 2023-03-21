# 获取项目下第三方构建机列表

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/environment/thirdPartAgent/nodeList

### 资源描述

#### 获取项目下第三方构建机列表

### 输入参数说明

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | projectId |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | 数据返回包装模型List节点信息\(权限\) |

#### 请求样例

```javascript
curl -X GET '[请替换为API地址栏请求地址]' \
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
  "data" : [ {
    "pipelineRefCount" : 0,
    "nodeHashId" : "String",
    "displayName" : "String",
    "ip" : "String",
    "canEdit" : true,
    "nodeStatus" : "String",
    "nodeType" : "String",
    "osName" : "String",
    "agentStatus" : true,
    "operator" : "String",
    "canUse" : true,
    "bakOperator" : "String",
    "lastBuildTime" : "String",
    "lastModifyUser" : "String",
    "createTime" : "String",
    "lastModifyTime" : "String",
    "name" : "String",
    "bizId" : 0,
    "canDelete" : true,
    "nodeId" : "String",
    "createdUser" : "String",
    "gateway" : "String",
    "agentHashId" : "String"
  } ],
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型List节点信息\(权限\)

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | List&lt;节点信息\(权限\)&gt; | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 节点信息\(权限\)

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| pipelineRefCount | integer | 否 | 流水线Job引用数 |
| nodeHashId | string | 是 | 环境 HashId |
| displayName | string | 否 | 显示名称 |
| ip | string | 是 | IP |
| canEdit | boolean | 否 | 是否可以编辑 |
| nodeStatus | string | 是 | 节点状态 |
| nodeType | string | 是 | 节点类型 |
| osName | string | 否 | 操作系统 |
| agentStatus | boolean | 是 | agent状态 |
| operator | string | 否 | 责任人 |
| canUse | boolean | 否 | 是否可以使用 |
| bakOperator | string | 否 | 备份责任人 |
| lastBuildTime | string | 否 | 流水线Job引用数 |
| lastModifyUser | string | 否 | 最后修改人 |
| createTime | string | 否 | 创建/导入时间 |
| lastModifyTime | string | 否 | 最后修改时间 |
| name | string | 是 | 节点名称 |
| bizId | integer | 否 | 所属业务, 默认-1表示没有绑定业务 |
| canDelete | boolean | 否 | 是否可以删除 |
| nodeId | string | 是 | 节点 Id |
| createdUser | string | 是 | 创建人 |
| gateway | string | 否 | 网关地域 |
| agentHashId | string | 否 | agent hash id |

