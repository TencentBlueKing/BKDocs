
### 请求地址

/api/c/compapi/v2/monitor_v3/switch_alarm_strategy/



### 请求方法

POST


### 功能描述

开关告警策略

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段       | 类型   | 必选 | 描述       |
| :--------- | ------ | ---- | ---------- |
| ids        | list   | 是   | 策略 ID 列表 |
| is_enabled | string | 是   | 是否开启   |

### 响应参数

| 字段       | 类型    | 描述       |
| :--------- | ------ | ---------- |
| ids | list | 存在的策略 ID 列表 |