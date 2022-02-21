
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/delete_instance_association/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

根据模型实例关联关系的唯一身份id,删除模型实例之间的关联关系。

### 请求参数



#### 接口参数
| 字段                 |  类型      | 必填	   |  描述          |
|----------------------|------------|--------|-----------------------------|
| id           | int64     | Yes    | 模型实例关联关系的唯一身份id             |

### 请求参数示例

``` json
{
    "id": 1
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "",
    "data": "success"
}

```

### 返回结果参数说明

#### data

| 字段       | 类型     | 描述         |
|------------|----------|--------------|
| result | bool | 请求成功与否。true:请求成功；false请求失败 |
| code | int | 错误编码。 0表示success，>0表示失败错误 |
| message | string | 请求失败返回的错误信息 |
| data | object | 请求返回的数据 |