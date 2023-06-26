# 获取用户下载链接

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/artifactories/userDownloadUrl

### 资源描述

#### 获取用户下载链接

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| artifactoryType | string | 是 | 版本仓库类型 |  |
| path | string | 是 | 路径 |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | 数据返回包装模型版本仓库-下载信息 |

#### 请求样例

```javascript
curl -X GET '[请替换为上方API地址栏请求地址]?artifactoryType={artifactoryType}&amp;path={path}' \
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
    "url2" : "String",
    "url" : "String"
  },
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型版本仓库-下载信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | 版本仓库-下载信息 | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 版本仓库-下载信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| url2 | string | 否 | 下载链接2 |
| url | string | 是 | 下载链接 |

