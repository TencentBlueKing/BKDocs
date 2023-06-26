### 功能描述

查询业务下云区域的proxy集合信息

### 请求参数

{{ common_args_desc }}

#### 接口参数

| 字段        | 类型  | <div style="width: 50pt">必选</div> | 描述   |
| --------- | --- | --------------------------------- | ---- |
| bk_biz_id | int | 是                                 | 业务ID |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "admin",
    "bk_token": "xxx",
    "bk_biz_id": 1
}
```

### 返回结果示例

```json
{
  "result": true,
  "data": [
    {
      "bk_cloud_id": 0,
      "bk_addressing": "0",
      "inner_ip": "127.0.0.1",
      "inner_ipv6": "",
      "outer_ip": "",
      "outer_ipv6": "",
      "login_ip": "127.0.0.2",
      "data_ip": "",
      "bk_biz_id": 1
    },
    {
      "bk_cloud_id": 0,
      "bk_addressing": "0",
      "inner_ip": "127.0.0.3",
      "inner_ipv6": "",
      "outer_ip": "",
      "outer_ipv6": "",
      "login_ip": "127.0.0.4",
      "data_ip": "",
      "bk_biz_id": 1
    }
  ],
  "code": 0,
  "message": ""
}
```

### 返回结果参数说明

#### response

| 字段      | 类型           | 描述                         |
| ------- | ------------ | -------------------------- |
| result  | bool         | 请求成功与否。true:请求成功；false请求失败 |
| code    | int          | 错误编码。 0表示success，>0表示失败错误  |
| message | string       | 请求失败返回的错误信息                |
| data    | array | 请求返回的数据，见data定义            |

#### data

| 字段            | 类型     | <div style="width: 50pt">必选</div> | 描述                   |
| ------------- | ------ | --------------------------------- | -------------------- |
| bk_cloud_id   | int    | 是                                 | 云区域ID                |
| bk_addressing | int    | 是                                 | 寻址方式，1: 0，静态 2: 1，动态 |
| inner_ip      | string | 是                                 | 主机内网IPV4地址           |
| inner_ipv6    | string | 否                                 | 主机内网IPV6地址           |
| outer_ip      | string | 否                                 | 主机外网IPV4地址           |
| outer_ipv6    | string | 否                                 | 主机外网IPV6地址           |
| login_ip      | string | 否                                 | 登录IP                 |
| data_ip       | string | 否                                 | 数据IP                 |
| bk_biz_id     | int    | 是                                 | 业务ID                 |
