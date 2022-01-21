### 功能描述

新建凭据

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                        |  类型      | 必选   |  描述       |
|----------------------------|------------|--------|------------|
| bk_biz_id                  |  long      | 是     | 业务 ID     |
| name                       |  string    | 是     | 凭据名称 |
| type                       |  string    | 是     | 凭据类型，取值可为 ACCESS_KEY_SECRET_KEY,PASSWORD,USERNAME_PASSWORD,SECRET_KEY |
| description                |  string    | 否     | 凭据描述 |
| credential_access_key      |  string    | 否     | 凭据类型为 ACCESS_KEY_SECRET_KEY 时填写 |
| credential_secret_key      |  string    | 否     | 凭据类型为 ACCESS_KEY_SECRET_KEY/SECRET_KEY 时填写 |
| credential_username        |  string    | 否     | 凭据类型为 USERNAME_PASSWORD 时填写 |
| credential_password        |  string    | 否     | 凭据类型为 USERNAME_PASSWORD/PASSWORD 时填写 |


### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "name": "testCredential",
    "type": "USERNAME_PASSWORD",
    "description": "This is a test credential",
    "credential_username": "admin",
    "credential_password": "password"
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        "id": "06644309e10e4068b3c7b32799668210"
    }
}
```

### 返回结果参数说明

#### data

| 字段      | 类型    |字段是否一定存在  | 描述      |
|-----------|-------|---------------|---------|
| id        | string |是             | 凭据 ID |
