
### 请求地址

/api/c/compapi/v2/bk_login/get_batch_users/



### 请求方法

POST


### 功能描述

批量获取用户信息

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段  |  类型 | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_username_list |  array    | 是     | 用户名列表  |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_username_list": ["admin", "test"]
}
```

### 返回结果示例

```python
{
    "result": true,
    "code": 0,
    "message": "OK",
    "data": {
        "admin": {
            "bk_username": "admin",
            "qq": "12345",
            "bk_role": 1,
            "phone": "11111111111",
            "language": "zh-cn",
            "wx_userid": "",
            "email": "11@qq.com",
            "chname": "admin"
            "time_zone": "Asia/Shanghai"
        }
    }
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| bk_username    | string    | 用户名 |
| qq             | string    | 用户QQ |
| language       | string    | 语言 |
| phone          | string    | 手机号 |
| wx_userid      | string    | 企业号用户USERID/公众号用户OPENID |
| email          | string    | 邮箱 |
| chname         | string    | 中文名 |
| time_zone      | string    | 时区 |