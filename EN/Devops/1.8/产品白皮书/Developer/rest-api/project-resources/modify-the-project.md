# 修改项目

### 请求方法/请求路径

#### PUT  /ms/openapi/api/apigw/v3/projects/{projectId}

### 资源描述

#### 修改项目

### 输入参数说明

#### Body参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| body | [项目-修改模型](modify-the-project.md) | 是 | 项目信息 |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型Boolean](modify-the-project.md) |

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

## 项目-修改模型

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| centerId | integer | 否 | 中心ID |
| deptName | string | 否 | 部门名称 |
| englishName | string | 否 | 英文缩写 |
| ccAppName | string | 否 | cc app name |
| kind | integer | 否 | 容器选择， 0 是不选， 1 是k8s, 2 是mesos |
| projectType | integer | 否 | 项目类型 |
| deptId | integer | 否 | 部门ID |
| description | string | 否 | 描述 |
| bgId | integer | 否 | 事业群ID |
| secrecy | boolean | 否 | 是否保密 |
| bgName | string | 否 | 事业群名字 |
| projectName | string | 否 | 项目名称 |
| ccAppId | integer | 否 | cc app id |
| centerName | string | 否 | 中心名称 |

## 数据返回包装模型Boolean

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | boolean | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

