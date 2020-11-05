
### 请求地址

/api/c/compapi/v2/itsm/get_services/



### 请求方法

GET


### 功能描述

服务列表查询，支持根据指定的目录查询服务列表

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段           | 类型     | 必选  | 描述     |
| ------------ | ------ | --- | ------ |
| catalog_id   | int    | 否   | 服务目录id |
| service_type | string | 否   | 服务类型   |
| display_type | string | 否   | 可见范围   |

### 请求参数示例

```json
{
    "bk_app_secret": "xxxx",
    "bk_app_code": "xxxx",
    "bk_token": "xxxx",
    "catalog_id": 12,
    "service_type": "request",
    "display_type": "IAM"
}
```

### 返回结果示例

```json
{
    "message": "success",
    "code": 0,
    "data": [
        {
            "id": 3,
            "name": "test1",
            "desc": "1",
            "service_type": "request"
        },
        {
            "id": 4,
            "name": "test2",
            "desc": "2",
            "service_type": "request"
        }
    ],
    "result": true
}
```

### 返回结果参数说明

| 字段      | 类型     | 描述                    |
| ------- | ------ | --------------------- |
| result  | bool   | 返回结果，true为成功，false为失败 |
| code    | int    | 返回码，0表示成功，其他值表示失败     |
| message | string | 错误信息                  |
| data    | array  | 返回数据                  |

### data

| 字段         | 类型     | 描述    |
| ---------- | ------ | ----- |
| id           | int    | 服务id |
| name         | string | 服务名称 |
| desc         | string | 服务描述 |
| service_type | string | 服务类型 |