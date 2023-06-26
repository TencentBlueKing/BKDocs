# 获取用户有权限使用的环境列表

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/environment/projects/{projectId}/envs/listUsableServerEnvs

### 资源描述

#### 获取用户有权限使用的环境列表

### 输入参数说明

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | 数据返回包装模型List环境信息\(权限\) |

#### 请求样例

```javascript
curl -X GET '[请替换API地址栏请求地址]' \
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
    "updatedTime" : 0,
    "canEdit" : true,
    "envVars" : [ {
      "name" : "String",
      "secure" : true,
      "value" : "String"
    } ],
    "updatedUser" : "String",
    "canUse" : true,
    "envType" : "String",
    "name" : "String",
    "createdTime" : 0,
    "nodeCount" : 0,
    "canDelete" : true,
    "envHashId" : "String",
    "createdUser" : "String",
    "desc" : "String"
  } ],
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型List环境信息\(权限\)

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | List&lt;环境信息\(权限\)&gt; | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 环境信息\(权限\)

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| updatedTime | integer | 是 | 更新时间 |
| canEdit | boolean | 否 | 是否可以编辑 |
| envVars | List&lt;环境变量&gt; | 是 | 环境变量 |
| updatedUser | string | 是 | 更新人 |
| canUse | boolean | 否 | 是否可以使用 |
| envType | string | 是 | 环境类型（开发环境{DEV} |
| name | string | 是 | 环境名称 |
| createdTime | integer | 是 | 创建时间 |
| nodeCount | integer | 否 | 节点数量 |
| canDelete | boolean | 否 | 是否可以删除 |
| envHashId | string | 是 | 环境 HashId |
| createdUser | string | 是 | 创建人 |
| desc | string | 是 | 环境描述 |

## 环境变量

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| name | string | 是 | 变量名 |
| secure | boolean | 是 | 是否安全变量 |
| value | string | 是 | 变量值 |

