# 获取凭据

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/credentials/{credentialId}

### 资源描述

#### 获取凭据

### 输入参数说明

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |
| credentialId | string | 是 | 凭据ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型凭据-凭据内容和权限](get-credentials.md) |

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
  "data" : {
    "credentialType" : "ENUM",
    "updatedTime" : 0,
    "credentialRemark" : "String",
    "permissions" : {
      "view" : true,
      "edit" : true,
      "delete" : true
    },
    "credentialId" : "String",
    "updateUser" : "String",
    "v1" : "String",
    "credentialName" : "String",
    "v2" : "String",
    "v3" : "String",
    "v4" : "String"
  },
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型凭据-凭据内容和权限

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | [凭据-凭据内容和权限](get-credentials.md) | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 凭据-凭据内容和权限

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| credentialType | ENUM\(PASSWORD, ACCESSTOKEN, USERNAME\_PASSWORD, SECRETKEY, APPID\_SECRETKEY, SSH\_PRIVATEKEY, TOKEN\_SSH\_PRIVATEKEY, TOKEN\_USERNAME\_PASSWORD, COS\_APPID\_SECRETID\_SECRETKEY\_REGION, MULTI\_LINE\_PASSWORD, \) | 是 | 凭据类型 |
| updatedTime | integer | 是 | 最后更新时间 |
| credentialRemark | string | 否 | 凭据描述 |
| permissions | [凭证-凭证权限](get-credentials.md) | 是 | 权限 |
| credentialId | string | 是 | 凭据ID |
| updateUser | string | 是 | 最后更新者 |
| v1 | string | 是 | 凭据内容 |
| credentialName | string | 是 | 凭据名称 |
| v2 | string | 是 | 凭据内容 |
| v3 | string | 是 | 凭据内容 |
| v4 | string | 是 | 凭据内容 |

## 凭证-凭证权限

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| view | boolean | 是 | 查看权限 |
| edit | boolean | 是 | 编辑权限 |
| delete | boolean | 是 | 删除权限 |

