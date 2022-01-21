### 功能描述

查询进程操作结果

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| task_id | string | 是 | 内容为进程操作接口返回的任务 ID |

### 请求参数示例

``` json
{
  "task_id": "GSETASK:XXXXXXXXXX"
}
```

### 返回结果示例

```json
{
    "result":true,
    "code":0,
    "message":"success",
    "data":{
        "1:10.0.0.1:gse:proc-test":{
            "error_code":0,
            "error_msg":"success",
            "content":""
        }
    }
}
```

### 返回结果参数说明

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
|result| bool | 返回结果，true 为成功，false 为失败 |
|code|int|返回码，0 表示成功，1000115 表示执行中（需继续轮询），其他值表示失败|
|message|string|返回信息|
|data|dict| 详细结果。错误码为 0，则键值对有效，115 表示正在执行，需要继续查询，其他值表示出错。内容格式见下面说明：<br>`data中key为bk_cloud_id:ip:namespace:name的组合，例如1:10.0.0.1:gse:proc-test，value为对应的结果；`<br>`value为json格式，包含error_code、error_msg、content字段。其中error_code为0，表示成功；为115，表示处理中，需要重试；为其他非0字段表示失败；content字段无确切含义。` |