
### 请求地址

/api/c/compapi/v2/job/get_own_db_account_list/



### 请求方法

GET


### 功能描述

查询用户有权限的 DB 帐号列表

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 | 描述 |
|-----------|------------|--------|------------|
| bk_app_code | string | 是 | 应用 ID |
| bk_app_secret| string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段 | 类型 | 必选 | 描述 |
|----------------------|------------|--------|------------|
| bk_biz_id | int | 是 | 业务 ID |
| start | int | 否 | 默认 0 表示从第 1 条记录开始返回 |
| length | int | 否 | 返回记录数量，不传此参数默认返回全部 |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "start": 0,
    "length": 100
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": [
        {
            "db_account_id": 1000,
            "db_alias": "mysql"
        }
    ]
}
```

### 返回结果参数说明

| 字段 | 类型 | 描述 |
|-----------|-----------|-----------|
| result | bool | 请求成功与否，true:请求成功，false:请求失败 |
| code | string | 组件返回错误编码，0 表示 success，>0 表示失败错误 |
| message | string | 请求失败返回的错误消息 |
| data | object | 请求返回的数据 |

#### data

| 字段 | 类型 | 描述 |
|-----------|-----------|-----------|
| db_account_id | int | db 帐号 ID,主键，执行脚本或作业的接口请求传递参数时用此参数 |
| db_alias | string | 帐号别名 |
