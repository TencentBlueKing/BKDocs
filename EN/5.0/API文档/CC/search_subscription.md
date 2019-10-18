
### 请求地址

/api/c/compapi/v2/cc/search_subscription/



### 请求方法

POST


### 功能描述

查询订阅

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

    无

### 请求参数示例

```python
{
    "bk_supplier_account":"0",
    "bk_biz_id":0,
    "condition":{
        "subscription_name":"name"
    },
    "page":{
        "start":0,
        "limit":10,
        "sort":"HostName"
    }
}
```

### 返回结果示例

```python

{
    "result": true,
    "code": 0,
    "message": "",
    "data":[
   		{
   			"subscription_id":1,
   			"subscription_name":"mysubscribe",
   			"system_name":"SystemName",
   			"callback_url":"http://127.0.0.1:8080/callback",
   			"confirm_mode":"httpstatus",
   			"confirm_pattern":"200",
   			"subscription_form":"hostcreate",
   			"timeout":10,
   			"last_time": "2017-09-19 16:57:07",
   			"operator": "user",
   			"statistics": {
   				"total": 30,
   				"failure": 2
   			}
   		}
    ]
}
```

### 返回结果参数说明

#### data

| 字段                 | 类型      | 描述                                       |
|----------------------|-----------|--------------------------------------------|
| subscription_id      | int       | 订阅ID                                     |
| subscription_name    | string    | 订阅名                                     |
| system_name          | string    | 系统名称                                   |
| callback_url         | string    | 回调地址                                   |
| confirm_mode         | string    | 回调成功确认模式，可选:httpstatus，regular |
| confirm_pattern      | string    | 回调成功标志                               |
| subscription_form    | string    | 订阅单，用","分隔                          |
| timeout              | int       | 超时时间，单位：秒                         |
| operator             | int       | 本条数据的最后更新人员                     |
| last_time            | int       | 更新时间                                   |
| statistics.total     | int       | 推送总数                                   |
| statistics.failure   | int       | 推送失败数                                 |