# 校验项目名称和项目英文名

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/projects/{validateType}/names/validate

### 资源描述

#### 校验项目名称和项目英文名

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| name | string | 否 | 项目名称或者项目英文名 |  |
| english\_name | string | 否 | 项目ID |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| validateType | string | 是 | 校验的是项目名称或者项目英文名 |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型Boolean](verify-the-project-name-and-the-english-name-of-the-project.md) |

#### 请求样例

```javascript
curl -X GET '[请替换为API地址栏请求地址]?name={name}&amp;english_name={english_name}' \
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

## 数据返回包装模型Boolean

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | boolean | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

