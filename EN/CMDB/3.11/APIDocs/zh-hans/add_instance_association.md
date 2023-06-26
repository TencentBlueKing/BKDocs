
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/add_instance_association/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

新增模型实例之间的关联关系.

### 请求参数



#### 接口参数

| 字段                 |  类型      | 是否必填	   |  描述          |
|----------------------|------------|--------|-----------------------------|
| bk_obj_asst_id           | string     | Yes     | 模型之间关联关系的唯一 id|
| bk_inst_id           | int64     | Yes     | 源模型实例 id|
| bk_asst_inst_id           | int64     | Yes     | 目标模型实例 id|
| metadata           | object     | Yes    | meta data             |


metadata params

| 字段                 |  类型      | 是否必填	   |  描述         |
|---------------------|------------|--------|-----------------------------|
| label           | string map     | Yes     |标签信息 |


label params

| 字段                 |  类型      | 是否必填	   |  描述         |
|---------------------|------------|--------|-----------------------------|
| bk_biz_id           | string      | Yes     | 业务 id |

### 请求参数示例

``` json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_obj_asst_id": "bk_switch_belong_bk_host",
    "bk_inst_id": 11,
    "bk_asst_inst_id": 21,
    "metadata":{
        "label":{
            "bk_biz_id":"1"
        }
    }
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "",
    "data": {
        "id": 1038
    },
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
}

```

### 返回结果参数说明

#### response

| 名称    | 类型   | 描述                                    |
| ------- | ------ | ------------------------------------- |
| result  | bool   | 请求成功与否。true:请求成功；false 请求失败 |
| code    | int    | 错误编码。 0 表示 success，>0 表示失败错误    |
| message | string | 请求失败返回的错误信息                    |
| data    | object | 请求返回的数据                           |
| permission    | object | 权限信息    |
| request_id    | string | 请求链 id    |

#### data

| 字段       | 类型     | 描述         |
|------------|----------|--------------|
|id|int64|新增的实例关联关系身份 id|