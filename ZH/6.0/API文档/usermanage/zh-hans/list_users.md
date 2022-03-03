
### 请求方法

GET


### 请求地址

/api/c/compapi/v2/usermanage/list_users/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述 

获取用户列表

### 请求参数




#### 接口参数 

| 字段      |  类型      | 必须   |  描述      |
|-----------|------------|--------|------------|
| lookup_field | 字符串 | 否 | 查找字段, 默认值为 'username' |
| page | 整数 | 否 | 页码 |
| page_size | 整数 | 否 | 每页结果数量 |
| fields | 字符串 | 否 | 返回值字段, 例如"username,id" |
| exact_lookups | 字符串 | 否 | 精确查找内容列表, 例如"jack,pony" |
| fuzzy_lookups | 字符串 | 否 | 模糊查找内容列表, 例如"jack,pony" |


### 请求参数示例

``` json
{
  "bk_app_code": "xxx",
  "bk_app_secret": "xxx",
  "bk_token": "xxx",
  "bk_username": "xxx",
  "lookup_field": "username",
  "page": 1,
  "page_size": 0,
  "fields": "username,id",
  "exact_lookups": "jack,pony",
  "fuzzy_lookups": "jack,pony"
}
```

### 返回结果示例

仅示意，请以实际请求结果为准
```json
{
    "message": "Success",
    "code": 0,
    "data": [{
      "id":1,
      "username":"admin",
      "password_valid_days":-1,
      "departments":[{
        "id":1,
        "name":"总公司",
        "order":1,
        "full_name":"总公司"
      }],
      "extras":{
        "date":null,
        "gender":"1",
        "level":"1",
        "dingding":null
      },
      "leader":[{
        "id":1335,
        "username":"foo",
        "display_name":"foo"
      }],
      "last_login_time":"2021-12-23T20:43:25.164441Z",
      "create_time":"2020-10-23T10:48:42.155327Z",
      "update_time":"2021-11-29T20:11:44.922731Z",
      "qq":"",
      "email":"admin@test.com",
      "telephone":"13111112222",
      "wx_userid":"",
      "wx_openid":"",
      "code":null,
      "domain":"default.local",
      "category_id":1,
      "display_name":"admin",
      "logo":"null",
      "status":"NORMAL",
      "staff_status":"IN",
      "password_update_time":"2021-10-12T11:03:36.713819Z",
      "position":0,
      "time_zone":"Asia/Shanghai",
      "language":"zh-cn",
      "country_code":"86",
      "iso_code":"CN",
      "enabled":true,
      "type":"",
      "role":1
    }],
    "result": true
}
```

### 返回结果参数说明

| 字段      | 类型     | 描述      |
|-----------|-----------|-----------|
|result| bool | 返回结果，true为成功，false为失败 |
|code|int|返回码，0表示成功，其他值表示失败|
|message|string|错误信息|
|data| array| 结果，根据请求参数动态返回，可以参考上述返回结果示例 |