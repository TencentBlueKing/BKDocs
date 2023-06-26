
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/itsm/create_ticket/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

创建单据接口

### 请求参数



#### 接口参数

| 字段        | 类型     | 必选  | 描述                         |
| --------- | ------ | --- | -------------------------- |
| service_id      | int    | 否   | 服务 id |
| creator      | string    | 是   | 单据创建者 |
| fields      | array    | 是   | 提单字段 |
| fast_approval| boolean    | 否   | 是否为单点快速审批单 |
| meta| dict    | 否   | 扩展信息 |

### fields

| 字段                     | 类型    | 必选 | 描述       |
| ---------------------- | ------ | -------- |------|
| key     | string |是| 提单字段唯一标识|
| value | string |是   |  提单字段值|

### meta

| 字段                     | 类型    | 必选 | 描述       |
| ---------------------- | ------ | -------- |------|
| callback_url     | string |否| 回调 url，若有则会触发回调|
| state_processors | object |否   |  节点处理人，若有则单据流转时会按此处理人设置|


### 请求参数示例

```json
{
	"bk_app_secret": "xxxx",
	"bk_app_code": "xxxx",
	"bk_token": "xxxx",
	"service_id": 17,
	"creator": "xxx",
	"fields": [{
		"key": "title",
		"value": "测试内置审批"
	}, {
		"key": "APPROVER",
		"value": "xx,xxx,xxxx"
	}, {
		"key": "APPROVAL_CONTENT",
		"value": "这是一个审批单"
	}],
	"fast_approval": false,
	"meta": {
		"callback_url": "http://***",
		"state_processors": {
			"407": "xxx,xxxx"
		}
	}
}  
```

### 返回结果示例

```json
{
	"result": true,
	"message": "success",
	"code": 0,
	"data": {
		"sn": "NO2019090519542603",
		"id": 101,
		"ticket_url": "http://bk_itsm/#/ticket/detail?id=101"
	}
}

```

### 返回结果参数说明

| 字段      | 类型        | 描述                      |
| ------- | --------- | ----------------------- |
| result  | bool      | 返回结果，true 为成功，false 为失败   |
| code    | int       | 返回码，0 表示成功，其他值表示失败       |
| message | string    | 错误信息                    |
| data    | object | 返回数据 |

### data

| 字段                     | 类型     | 描述       |
| ---------------------- | ------ | -------- |
| sn                     | string | 单号     |
| id                     | int | 单据 ID     |
| ticket_url                     | string | 单据链接     |