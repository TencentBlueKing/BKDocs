# 获取项目信息

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/projects/{projectId}

### 资源描述

#### 获取项目信息

### 输入参数说明

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID英文名标识 |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型项目-显示模型](get-project-information.md) |

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
  "result" : true,
  "code" : 0,
  "data" : {
    "deptName" : "String",
    "englishName" : "String",
    "projectType" : 0,
    "description" : "String",
    "remark" : "String",
    "project_name" : "String",
    "deployType" : "String",
    "enabled" : true,
    "createdAt" : "String",
    "helmChartEnabled" : true,
    "gray" : true,
    "dataId" : 0,
    "secrecy" : true,
    "projectCode" : "String",
    "project_id" : "String",
    "useBk" : true,
    "enableExternal" : true,
    "extra" : "String",
    "routerTag" : "String",
    "id" : 0,
    "ccAppId" : 0,
    "updatedAt" : "String",
    "approvalStatus" : 0,
    "approver" : "String",
    "pipelineLimit" : 0,
    "centerId" : "String",
    "ccAppName" : "String",
    "creator" : "String",
    "kind" : 0,
    "cc_app_id" : 0,
    "deptId" : "String",
    "approvalTime" : "String",
    "project_code" : "String",
    "relationId" : "String",
    "logoAddr" : "String",
    "bgId" : "String",
    "offlined" : true,
    "hybridCcAppId" : 0,
    "bgName" : "String",
    "projectName" : "String",
    "enableIdc" : true,
    "projectId" : "String",
    "cc_app_name" : "String",
    "hybrid_cc_app_id" : 0,
    "centerName" : "String"
  },
  "requestId" : "String",
  "message" : "String"
}
```

## 数据返回包装模型项目-显示模型

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| result | boolean | 否 | 请求结果 |
| code | integer | 是 | 状态码 |
| data | [项目-显示模型](get-project-information.md) | 否 | 数据 |
| requestId | string | 否 | 请求ID |
| message | string | 否 | 错误信息 |

## 项目-显示模型

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| deptName | string | 否 | 部门名称 |
| englishName | string | 否 | 英文缩写 |
| projectType | integer | 否 | 项目类型 |
| description | string | 否 | 描述 |
| remark | string | 否 | 评论 |
| project\_name | string | 否 | 旧版项目名称\(即将作废，兼容插件中被引用到的旧的字段命名，请用projectName代替\) |
| deployType | string | 否 | 部署类型 |
| enabled | boolean | 否 | 启用 |
| createdAt | string | 否 | 创建时间 |
| helmChartEnabled | boolean | 否 | 是否启用图表激活 |
| gray | boolean | 否 | 是否灰度 |
| dataId | integer | 否 | 数据ID |
| secrecy | boolean | 否 | 是否保密 |
| projectCode | string | 否 | 项目代码 |
| project\_id | string | 否 | 项目ID\(即将作废，兼容插件中被引用到的旧的字段命名，请用projectId代替\) |
| useBk | boolean | 否 | useBK |
| enableExternal | boolean | 否 | 支持构建机访问外网 |
| extra | string | 否 | extra |
| routerTag | string | 否 | 项目路由指向 |
| id | integer | 否 | 主键ID |
| ccAppId | integer | 否 | cc业务ID |
| updatedAt | string | 否 | 修改时间 |
| approvalStatus | integer | 否 | 审批状态 |
| approver | string | 否 | 审批人 |
| pipelineLimit | integer | 否 | 流水线数量上限 |
| centerId | string | 否 | 中心ID |
| ccAppName | string | 否 | cc业务名称 |
| creator | string | 否 | 创建人 |
| kind | integer | 否 | kind |
| cc\_app\_id | integer | 否 | 旧版cc业务ID\(即将作废，兼容插件中被引用到的旧的字段命名，请用ccAppId代替\) |
| deptId | string | 否 | 部门ID |
| approvalTime | string | 否 | 审批时间 |
| project\_code | string | 否 | 旧版项目代码\(即将作废，兼容插件中被引用到的旧的字段命名，请用projectCode代替\) |
| relationId | string | 否 | 关联系统Id |
| logoAddr | string | 否 | logo地址 |
| bgId | string | 否 | 事业群ID |
| offlined | boolean | 否 | 是否离线 |
| hybridCcAppId | integer | 否 | 混合云CC业务ID |
| bgName | string | 否 | 事业群名字 |
| projectName | string | 否 | 项目名称 |
| enableIdc | boolean | 否 | 支持IDC构建机 |
| projectId | string | 否 | 项目ID |
| cc\_app\_name | string | 否 | 旧版cc业务名称\(即将作废，兼容插件中被引用到的旧的字段命名，请用ccAppName代替\) |
| hybrid\_cc\_app\_id | integer | 否 | 混合云CC业务ID\(即将作废，兼容插件中被引用到的旧的字段命名，请用hybridCcAppId代替\) |
| centerName | string | 否 | 中心名称 |

