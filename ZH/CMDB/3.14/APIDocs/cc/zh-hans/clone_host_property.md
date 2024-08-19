
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/clone_host_property/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

克隆主机属性

### 请求参数



#### 接口参数

| 字段        |  类型   | 必选   |  描述                       |
|-------------|---------|--------|-----------------------------|
| bk_org_ip   | string  | 是     | 源主机内网 ip   |
| bk_dst_ip   | string  | 是     | 目标主机内网 ip |
| bk_org_id   | int  | 是     | 源主机 ID    |
| bk_dst_id   | int  | 是     | 目标主机 ID |
| bk_biz_id   | int     | 是     | 业务 ID                      |
| bk_cloud_id | int     | 否     | 云区域 ID                    |


注： 使用主机内网 IP 进行克隆与使用主机身份 ID 进行克隆，这两种方式只能使用期中的一种，不能混用。

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_biz_id":2,
    "bk_org_ip":"127.0.0.1",
    "bk_dst_ip":"127.0.0.2",
    "bk_cloud_id":0
}
```
或

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_biz_id":2,
    "bk_org_id": 10,
    "bk_dst_id": 11,
    "bk_cloud_id":0
}
```

### 返回结果示例

```python

{
    "result": true,
    "code": 0,
    "message": "",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": null
}
```

#### response

| 名称    | 类型   | 描述                                    |
| ------- | ------ | ------------------------------------- |
| result  | bool   | 请求成功与否。true:请求成功；false 请求失败 |
| code    | int    | 错误编码。 0 表示 success，>0 表示失败错误    |
| message | string | 请求失败返回的错误信息                    |
| permission    | object | 权限信息    |
| request_id    | string | 请求链 id    |
| data    | object | 请求返回的数据                           |