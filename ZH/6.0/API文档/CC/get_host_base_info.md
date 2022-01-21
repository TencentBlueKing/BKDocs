### 功能描述

获取主机基础信息详情

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code   | string | 是 | 应用 ID     |
| bk_app_secret | string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token      | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username   | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_supplier_account | string     | 否     | 开发商账号 |
| bk_host_id     |  int       | 是     | 主机 ID |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "bk_host_id": 10000
}
```

### 返回结果示例

```json

{
    "result": true,
    "code": 0,
    "message": "",
    "data": [
        {
            "bk_property_id": "bk_host_name",
            "bk_property_name": "host name",
            "bk_property_value": "centos7"
        },
        {
            "bk_property_id": "bk_host_id",
            "bk_property_name": "host ID",
            "bk_property_value": "10000"
        }
    ]
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| bk_property_id    | string     | 属性 id |
| bk_property_name  | string     | 属性名称 |
| bk_property_value | string     | 属性值 |
