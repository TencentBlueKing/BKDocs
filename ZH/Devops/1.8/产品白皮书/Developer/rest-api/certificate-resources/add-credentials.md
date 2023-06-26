# 新增凭据

### 请求方法/请求路径

#### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/credentials

### 资源描述

#### 新增凭据

### 输入参数说明

#### Body参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| body | [凭据-创建时内容](add-credentials.md) | 是 | 凭据 |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型Boolean](add-credentials.md) |

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

## 凭据-创建时内容

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| credentialType | ENUM\(PASSWORD, ACCESSTOKEN, USERNAME\_PASSWORD, SECRETKEY, APPID\_SECRETKEY, SSH\_PRIVATEKEY, TOKEN\_SSH\_PRIVATEKEY, TOKEN\_USERNAME\_PASSWORD, COS\_APPID\_SECRETID\_SECRETKEY\_REGION, MULTI\_LINE\_PASSWORD, \) | 是 | 凭据类型 |
| credentialRemark | string | 否 | 凭据描述 |
| credentialId | string | 是 | 凭据ID |
| v1 | string | 是 | 凭据内容 |
| credentialName | string | 是 | 凭据名称 |
| v2 | string | 是 | 凭据内容 |
| v3 | string | 是 | 凭据内容 |
| v4 | string | 是 | 凭据内容 |

## 数据返回包装模型Boolean

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | boolean | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

