# 编辑关联代码库

### 请求方法/请求路径

#### PUT  /ms/openapi/api/apigw/v3/repositories/{projectId}/{repositoryHashId}

### 资源描述

#### 编辑关联代码库

### 输入参数说明

#### Body参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| body | [代码库模型-多态基类](edit-the-associated-code-base.md) | 是 | 代码库模型 |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |
| repositoryHashId | string | 是 | 代码库哈希ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型Boolean](edit-the-associated-code-base.md) |

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

## 代码库模型-多态基类

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| startPrefix | string | 否 | startPrefix |
| aliasName | string | 否 | aliasName |
| formatURL | string | 否 | formatURL |
| legal | boolean | 否 | legal |
| credentialId | string | 否 | credentialId |
| userName | string | 否 | userName |
| projectName | string | 否 | projectName |
| projectId | string | 否 | projectId |
| url | string | 否 | url |
| repoHashId | string | 否 | repoHashId |

## 数据返回包装模型Boolean

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | boolean | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

