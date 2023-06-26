# 获取签后IPA文件下载路径

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/sign/ipa/{resignId}/downloadUrl

### 资源描述

#### 获取签后IPA文件下载路径

### 输入参数说明

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| resignId | string | 是 | 签名任务ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型String](get-the-download-path-of-the-signed-ipa-file.md) |

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
  "data" : "String",
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型String

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | string | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

