
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/monitor_v3/delete_alarm_strategy_v2/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

删除策略配置

### 请求参数



#### 接口参数

| 字段      | 类型 | 必选 | 描述           |
| :-------- | ---- | ---- | -------------- |
| bk_biz_id | int  | 是   | 业务 ID         |
| ids       | list | 是   | 告警策略 ID 列表 |


#### 示例数据

```json
{
    "bk_app_code": "xxx",
    "bk_app_secret": "xxxxx",
    "bk_token": "xxxx",
    "bk_biz_id": 7,
    "ids": [49]
}
```

### 响应参数

| 字段    | 类型   | 描述               |
| ------- | ------ | ------------------ |
| result  | bool   | 请求是否成功       |
| code    | int    | 返回的状态码       |
| message | string | 描述信息           |
| data    | list   | 已删除的策略 id 列表 |

#### 示例数据

```json
{
    "result": true,
    "code": 200,
    "message": "OK",
    "data": [
        49
    ]
}
```