### 请求地址

/api/c/compapi/v2/bk_login/get_batch_users_platform_role/

### 请求方法

POST

### 功能描述

批量获取用户各平台角色信息

### 请求参数

#### 通用参数

| 字段 | 类型 | 必选 | 描述 |
|--------------|--------|----|------------|
| bk_app_code  | string | 是 | 应用 ID     |
| bk_app_secret| string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段 | 类型 | 必选 | 描述 |
|------------------|--------|----|-----------|
| bk_username_list | array  | 是 | 用户名列表 |
| bk_token         | string | 否 | 登录票据   |

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
            "bkdata": [
                1
            ],
            "job": [
                2
            ]
        }
    }
}
```

### 返回结果参数说明

| 字段    | 类型    | 描述      |
|---------|--------|-----------|
| result  | bool   | 请求成功与否，true:请求成功，false:请求失败 |
| code    | string | 组件返回错误编码，0 表示 success，>0表示失败错误 |
| message | string | 请求返回的消息 |
| data    | object | 请求返回的数据 |

#### data

| 字段            | 类型    | 描述    |
|-----------------|--------|--------|
| key1            | string | 用户名  |
| key1.key2       | string | 产品代号 |
| key1.key2.value | list   | 用户角色，0：普通用户，1：超级管理员，2：开发者，3：职能化用户，4：审计员 |
