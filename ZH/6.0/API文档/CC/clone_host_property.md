### 功能描述

克隆主机属性

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code   | string | 是 | 应用 ID     |
| bk_app_secret | string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token      | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username   | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段        |  类型   | 必选   |  描述                       |
|-------------|---------|--------|-----------------------------|
| bk_org_ip   | string  | 是     | 源主机内网 ip   |
| bk_dst_ip   | string  | 是     | 目标主机内网 ip |
| bk_org_id   | int  | 是     | 源主机身份 ID    |
| bk_dst_id   | int  | 是     | 目标主机身份 ID |
| bk_biz_id   | int     | 是     | 业务 ID                      |
| bk_cloud_id | int     | 否     | 云区域 ID                    |


注： 使用主机内网 IP 进行克隆与使用主机身份 ID 进行克隆，这两种方式只能使用期中的一种，不能混用。

### 请求参数示例

```json
{
    "bk_biz_id":2,
    "bk_org_ip":"127.0.0.1",
    "bk_dst_ip":"127.0.0.2",
    "bk_cloud_id":0
}
```
或

```json
{
    "bk_biz_id":2,
    "bk_org_id": 10,
    "bk_dst_id": 11,
    "bk_cloud_id":0
}
```

### 返回结果示例

```json

{
    "result": true,
    "code": 0,
    "message": "",
    "data": null
}
```
