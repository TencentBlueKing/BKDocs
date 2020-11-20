
### 请求地址

/api/c/compapi/v2/cc/list_service_template/



### 请求方法

POST


### 功能描述

根据业务 id 查询服务模板列表,可加上服务分类 id 进一步查询

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                 |  类型      | 必选	   |  描述                 |
|----------------------|------------|--------|-----------------------|
| bk_biz_id           | int    | 是   | 业务 ID         |
| service_category_id         | int  | 否   | 服务分类 ID |


### 请求参数示例

```python
{
  "bk_biz_id": 1,
  "service_category_id": 1,
  "page": {
    "start": 0,
    "limit": 10,
    "sort": "-name"
  }
}
```

### 返回结果示例

```python
{
  "result": true,
  "code": 0,
  "message": "success",
  "permission": null,
  "data": {
    "count": 2,
    "info": [
      {
        "bk_biz_id": 1,
        "id": 51,
        "name": "test3",
        "service_category_id": 1,
        "creator": "admin",
        "modifier": "admin",
        "create_time": "2019-09-18T20:31:34.627+08:00",
        "last_time": "2019-09-18T20:31:34.627+08:00",
        "bk_supplier_account": "0"
      },
      {
	"bk_biz_id": 1,
        "id": 50,
        "name": "test2",
        "service_category_id": 1,
        "creator": "admin",
        "modifier": "admin",
        "create_time": "2019-09-18T20:31:29.607+08:00",
        "last_time": "2019-09-18T20:31:29.607+08:00",
        "bk_supplier_account": "0"
      }
    ]
  }
}
```

### 返回结果参数说明

#### response

| 名称  | 类型  | 描述 |
|---|---|---|
| result | bool | 请求成功与否。true:请求成功；false 请求失败 |
| code | int | 错误编码。 0 表示 success，>0 表示失败错误 |
| message | string | 请求失败返回的错误信息 |
| data | object | 请求返回的数据 |

#### data 字段说明

| 字段|类型|说明|描述|
|---|---|---|---|
|count|integer|总数||
|info|array|返回结果||

#### info 字段说明

| 字段|类型|说明|Description|
|---|---|---|---|
|id|integer|服务模板 ID||
|name|array|服务模板名称||
|service_category_id|integer|服务分类 ID||