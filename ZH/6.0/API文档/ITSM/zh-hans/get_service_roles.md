
### 请求方法

GET


### 请求地址

/api/c/compapi/v2/itsm/get_service_roles/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

获取服务角色

### 请求参数



#### 接口参数

| 字段        | 类型     | 必选  | 描述                         |
| --------- | ------ | --- | -------------------------- |
| service_id | string    | 是   | 服务id，从`服务列表查询`中的`data["id"]`字段获取 |
| ticket_creator     | string    | 否   | 提单人，实例化leader和提单人本身时使用 |


### 请求参数示例

```json
{  
    "bk_app_secret": "xxxx", 
    "bk_app_code": "xxxx", 
    "bk_token": "xxxx",
    "service_id": 1,
    "ticket_creator": "admin"
}  
```

### 返回结果示例

```json
{
	"message": "success",
	"code": 0,
	"data": [{
			"id": 92580,
			"name": "节点1",
			"processors_type": "GENERAL",
			"processors": "xx",
			"sign_type": "or"
		},
		{
			"id": 92581,
			"name": "节点2",
			"processors_type": "IAM",
			"processors": "分级管理员",
			"sign_type": "or"
		},
		{
			"id": 92582,
			"name": "节点3",
			"processors_type": "PERSON",
			"processors": "xxx",
			"sign_type": "and"
		}
	],
	"result": true
}

```

### 返回结果参数说明

| 字段      | 类型        | 描述                      |
| ------- | --------- | ----------------------- |
| result  | bool      | 返回结果，true为成功，false为失败   |
| code    | int       | 返回码，0表示成功，其他值表示失败       |
| message | string    | 错误信息                    |
| data    | list | 返回数据 |

### data

| 字段      | 类型        | 描述                      |
| ------- | --------- | ----------------------- |
| id  | int      | 节点id   |
| name  | string      | 节点id   |
| processors_type  | string      | 处理人类型   |
| processors  | string      | 处理人，多个用","分割   |
| sign_type  | string      |会签类型，“or”为或签，任意一人通过即为通过，“and”为多签，全部审批人通过才算通过 |