
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/search_inst_association_topo/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

查询实例关联拓扑

### 请求参数



#### 接口参数

| 字段                | 类型   | 必选 | 描述 |
| ------------------- | ------ | ---- | ---- |
| bk_obj_id           | string | 是   | 模型 id   |
| bk_inst_id          | int    | 是   | 实例 id   |


### 请求参数示例

``` python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_obj_id":"test",
    "bk_inst_id":1
}
```


### 返回结果示例

```python
{
    "result": true,
    "code": 0,
    "data": [
        {
            "id": "",
            "bk_obj_id": "biz",
            "bk_obj_icon": "icon-cc-business",
            "bk_inst_id": 0,
            "bk_obj_name": "business",
            "bk_inst_name": "",
            "asso_id": 0,
            "count": 1,
            "children": [
                {
                    "id": "6",
                    "bk_obj_id": "biz",
                    "bk_obj_icon": "icon-cc-business",
                    "bk_inst_id": 6,
                    "bk_obj_name": "business",
                    "bk_inst_name": "",
                    "asso_id": 558
                }
            ]
        }
    ],
    "message": "success",
    "permission": null,
    "request_id": "94c85fdf6a9341e18750a44d6e18c127"
}
```

### 返回结果参数说明
#### response

| 名称    | 类型   | 描述                                       |
| ------- | ------ | ------------------------------------------ |
| result  | bool   | 请求成功与否。true:请求成功；false 请求失败 |
| code    | int    | 错误编码。 0 表示 success，>0 表示失败错误    |
| message | string | 请求失败返回的错误信息                     |
| permission    | object | 权限信息    |
| request_id    | string | 请求链 id    |
| data    | object | 请求返回的数据                             |

#### data

| 字段         | 类型         | 描述                           |
| ------------ | ------------ | ------------------------------ |
| bk_inst_id   | int          | 实例 ID                         |
| bk_inst_name | string       | 实例用于展示的名字             |
| bk_obj_icon  | string       | 模型图标的名字                 |
| bk_obj_id    | string       | 模型 ID                         |
| bk_obj_name  | string       | 模型用于展示的名字             |
| children     | object array | 本模型下所有被关联的实例的集合 |
| count        | int          | children 包含节点的数量        |

#### children

| 字段        | 类型   | 描述               |
|-------------|--------|--------------------|
|bk_inst_id   | int    | 实例 ID            |
|bk_inst_name | string | 实例用于展示的名字 |
|bk_obj_icon  | string | 模型图标的名字     |
|bk_obj_id    | string | 模型 ID             |
|bk_obj_name  | string | 模型用于展示的名字 |
|asso_id  | string | 关联 id |