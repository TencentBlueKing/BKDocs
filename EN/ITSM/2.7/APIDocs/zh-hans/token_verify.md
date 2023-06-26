
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/itsm/token/verify/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

token 校验接口

### 请求参数



#### 接口参数

| 字段        | 类型     | 必选  | 描述                         |
| --------- | ------ | --- | -------------------------- |
| token      | string    | 是   | itsm 生成加密后的 token |


### 请求参数示例

```json
{  
    "bk_app_secret": "xxxx", 
    "bk_app_code": "xxxx", 
    "bk_token": "xxxx", 
    "token": "PF14MnqZcrqqN7tc4mKDt4YVgzf3sagw3vdyvxSgcohF/qZDan0AC3TzKnlcMx53EFWIku2AY5WOIlU4P97bDw=="
}  
```

### 返回结果示例

```json
{
	"message": "success",
	"code": 0,
	"data": {
		"is_passed": true
	},
    "result": true
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

| 字段     | 类型     | 描述       |
| -------------| ------ | -------- |
| is_passed  | bool | 是否通过     |