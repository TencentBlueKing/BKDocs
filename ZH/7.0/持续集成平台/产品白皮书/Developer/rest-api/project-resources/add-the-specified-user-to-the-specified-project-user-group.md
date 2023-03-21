# 添加指定用户到指定项目用户组

### 请求方法/请求路径

#### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/createUser

### 资源描述

#### 添加指定用户到指定项目用户组

### 输入参数说明

#### Body参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| body | [ProjectCreateUserInfo](add-the-specified-user-to-the-specified-project-user-group.md) | 是 | 添加信息 |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | projectId |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型Boolean](add-the-specified-user-to-the-specified-project-user-group.md) |

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
  "data" : true,
  "message" : "String",
  "status" : 0
}
```

## ProjectCreateUserInfo

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| createUserId | string | 否 | 操作用户 |
| roleId | integer | 否 | 角色Id |
| userIds | List | 否 | 多目标用户id |
| roleName | string | 否 | 角色名称 |

## 数据返回包装模型Boolean

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | boolean | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

