# 根据环境的hashId获取指定项目指定环境下节点列表\(不校验权限\)

### 请求方法/请求路径

#### POST  /ms/openapi/api/apigw/v3/environment/projects/{projectId}/nodes/listRawByEnvHashIds

### 资源描述

#### 根据环境的hashId获取指定项目指定环境下节点列表\(不校验权限\)

### 输入参数说明

#### Body参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| body | array | 是 | 节点 hashIds |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | 数据返回包装模型MapStringList节点信息\(权限\) |

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
  "data" : {
    "string" : "string"
  },
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型MapStringList节点信息\(权限\)

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | object | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

