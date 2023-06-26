# 代码库列表

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/repositories/{projectId}/hasPermissionList

### 资源描述

#### 代码库列表

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| repositoryType | string | 否 | 仓库类型 |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型分页数据包装模型代码库模型-基本信息](code-library-list.md) |

#### 请求样例

```javascript
curl -X GET '[请替换为API地址栏请求地址]?repositoryType={repositoryType}' \
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
      "aliasName" : "String",
      "updatedTime" : 0,
      "repositoryId" : 0,
      "type" : "ENUM",
      "repositoryHashId" : "String",
      "url" : "String"
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

## 数据返回包装模型分页数据包装模型代码库模型-基本信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | [分页数据包装模型代码库模型-基本信息](code-library-list.md) | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 分页数据包装模型代码库模型-基本信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| records | List&lt;[代码库模型-基本信息](code-library-list.md)&gt; | 是 | 数据 |
| count | integer | 是 | 总记录行数 |
| totalPages | integer | 是 | 总共多少页 |
| pageSize | integer | 是 | 每页多少条 |
| page | integer | 是 | 第几页 |

## 代码库模型-基本信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| aliasName | string | 是 | 仓库别名 |
| updatedTime | integer | 是 | 最后更新时间 |
| repositoryId | integer | 否 | 仓库ID |
| type | ENUM\(CODE\_SVN, CODE\_GIT, CODE\_GITLAB, GITHUB, CODE\_TGIT, \) | 是 | 类型 |
| repositoryHashId | string | 否 | 仓库哈希ID |
| url | string | 是 | URL |

