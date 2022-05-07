
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/batch_create_instance_association/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

 批量创建通用模型实例关联关系(v3.10.2+)

### 请求参数



#### 接口参数

| 参数           | 类型   | 必选 | 描述                     |
| -------------- | ------ | ---- | ------------------------ |
| bk_obj_id      | string | 是   | 源模型 id                 |
| bk_asst_obj_id | string | 是   | 目标模型模型 id           |
| bk_obj_asst_id | string | 是   | 模型之间关系关系的唯一 id |
| details        | array  | 是   | 批量创建关联关系的内容，不能超过 200 个关系        |

#### details

| 参数            | 类型   | 必选 | 描述           |
| --------------- | ------ | ---- | -------------- |
| bk_inst_id      | int | 是   | 源模型实例 id   |
| bk_asst_inst_id | int | 是   | 目标模型实例 id |

#### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_obj_id":"bk_switch",
    "bk_asst_obj_id":"host",
    "bk_obj_asst_id":"bk_switch_belong_host",
    "details":[
        {
            "bk_inst_id":11,
            "bk_asst_inst_id":21
        },
        {
            "bk_inst_id":12,
            "bk_asst_inst_id":22
        }
    ]
}
```

### 返回结果示例

```json
{
    "result":true,
    "code":0,
    "message":"",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data":{
        "success_created":{
            "0":73
        },
        "error_msg":{
            "1":"关联实例不存在"
        }
    }
}
```

### 返回结果参数说明

#### response

| 名称    | 类型   | 描述                                    |
| ------- | ------ | ------------------------------------- |
| result  | bool   | 请求成功与否。true:请求成功；false 请求失败 |
| code    | int    | 错误编码。 0 表示 success，>0 表示失败错误    |
| message | string | 请求失败返回的错误信息                    |
| permission    | object | 权限信息    |
| request_id    | string | 请求链 id    |
| data    | object | 请求返回的数据                           |

#### data

| 字段            | 类型 | 描述                                                     |
| -------------- | ---- | -------------------------------------------------------- |
| success_created | map | key 为实例关联关系在参数 details 数组中的 index，value 为创建成功的实例关联关系 id |
| error_msg       | map | key 为实例关联关系在参数 details 数组中的 index，value 为失败信息          |