# 创建项目

### 请求方法/请求路径

#### POST  /ms/openapi/api/apigw/v3/projects

### 资源描述

#### 创建项目

### 输入参数说明

#### Body参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| body | [项目-新增模型](create-project.md) | 是 | 项目信息 |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |


#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型Boolean](create-project.md) |

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

## 项目-新增模型

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| englishName | string | 否 | 英文缩写 |
| deptName | string | 否 | 二级部门名称 |
| centerId | integer | 否 | 三级部门ID |
| secrecy | boolean | 否 | 是否保密 |
| kind | integer | 否 | kind |
| projectType | integer | 否 | 项目类型 |
| deptId | integer | 否 | 二级部门ID |
| description | string | 否 | 描述 |
| bgName | string | 否 | 一级部门名字 |
| projectName | string | 否 | 项目名称 |
| bgId | integer | 否 | 一级部门ID |
| centerName | string | 否 | 三级部门名称 |

## 数据返回包装模型Boolean

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | boolean | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

