
### 请求方法

GET


### 请求地址

/api/c/compapi/v2/itsm/get_ticket_logs/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

单据日志查询，支持根据单号查询单据的处日志

### 请求参数



#### 接口参数

| 字段        | 类型     | 必选  | 描述                         |
| --------- | ------ | --- | -------------------------- |
| sn        | string | 是   | 单号                       |

### 请求参数示例

```json
{  
    "bk_app_secret": "xxxx", 
    "bk_app_code": "xxxx", 
    "bk_token": "xxxx", 
    "sn": "NO2019090XXXXXXXX"
}  
```

### 返回结果示例

```json
{
    "message": "success",
    "code": 0,
    "data": {
        "sn": "NO2019090414050083",
        "title": "xxxxx",
        "create_at": "2019-09-04 14:05:00",
        "creator": "xxx(xxx)",
        "logs": [{
						"operator": "xxxx",
						"message": "流程开始",
						"source": "WEB",
						"operate_at": "2019-08-09 00:41:02"
					}, {
						"operator": "xxxx",
						"message": "xxxx(xxxx) 处理节点【提单】(提交)",
						"source": "WEB",
						"operate_at": "2019-08-09 00:43:43"
					}, {
						"operator": "xxxx",
						"message": "xxxx(xxxx) 处理节点【审批】(通过)",
						"source": "WEB",
						"operate_at": "2019-08-10 16:39:14"
					}, {
						"operator": "xxxx",
						"message": "xxxx(xxxx) 处理节点【总监审批】(通过)",
						"source": "WEB",
						"operate_at": "2019-08-10 20:35:45"
					}, {
						"operator": "xxxx",
						"message": "xxxx(xxxx) 处理节点【账号创建】(通过)",
						"source": "API",
						"operate_at": "2019-08-15 10:20:09"
					}, {
						"operator": "xxxx",
						"message": "单据流程结束",
						"source": "SYS",
						"operate_at": "2019-08-15 10:20:09"
					}
        ]
    },
    "result": true
}
```

### 返回结果参数说明

| 字段      | 类型        | 描述                      |
| ------- | --------- | ----------------------- |
| result  | bool      | 返回结果，true为成功，false为失败   |
| code    | int       | 返回码，0表示成功，其他值表示失败       |
| message | string    | 错误信息                    |
| data    | object    | 返回数据 |

### data

| 字段                     | 类型     | 描述       |
| ---------------------- | ------ | -------- |
| sn                     | string | 单据sn     |
| title                  | string | 单据标题     |
| create_at              | string | 创建时间     |
| creator                | string | 提单人      |
| logs              | array    | 日志信息列表    |

### logs

| 字段              | 类型         | 描述         |
| --------------- | ---------- | ---------- |
| operator              | string        | 处理人       |
| message        | string     | 处理信息     |
| operate_at            | string     | 处理时间       |
| source            | string     | 处理途径，包含：WEB（页面操作）/MOBILE（手机端操作）/API（接口操作）/SYS（系统操作）       |