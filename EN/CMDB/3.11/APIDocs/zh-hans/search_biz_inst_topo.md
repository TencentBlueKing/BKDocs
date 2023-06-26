
### 请求方法

GET


### 请求地址

/api/c/compapi/v2/cc/search_biz_inst_topo/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

查询业务实例拓扑

### 请求参数



#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_supplier_account |  string  | 否     | 开发商账号 |
| bk_biz_id           |  int     | 是     | 业务 id |
| level               |  int     | 否     | 拓扑的层级索引，索引取值从 0 开始，默认值为 2，当设置为 -1 的时候会读取完整的业务实例拓扑 |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "bk_biz_id": 1,
}
```

### 返回结果示例

```python
{
    "result": true,
    "code": 0,
    "message": "success",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": [
        {
            "bk_inst_id": 2,
            "bk_inst_name": "blueking",
            "bk_obj_id": "biz",
            "bk_obj_name": "business",
            "default": 0,
            "child": [
                {
                    "bk_inst_id": 3,
                    "bk_inst_name": "job",
                    "bk_obj_id": "set",
                    "bk_obj_name": "set",
                    "default": 0,
                    "child": [
                        {
                            "bk_inst_id": 5,
                            "bk_inst_name": "job",
                            "bk_obj_id": "module",
                            "bk_obj_name": "module",
                            "child": []
                        }
                    ]
                }
            ]
        }
    ]
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

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| bk_inst_id    | int       | 实例 ID |
| bk_inst_name  | string    | 实例用于展示的名字 |
| bk_obj_icon   | string    | 模型图标的名字 |
| bk_obj_id     | string    | 模型 ID |
| bk_obj_name   | string    | 模型用于展示的名字 |
| child         | array     | 当前节点下的所有实例的集合 |
|default | int | 表示业务类型 |

#### child

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| bk_inst_id    | int       | 实例 ID |
| bk_inst_name  | string    | 实例用于展示的名字 |
| bk_obj_icon   | string    | 模型图标的名字 |
| bk_obj_id     | string    | 模型 ID |
| bk_obj_name   | string    | 模型用于展示的名字 |
| child         | array     | 当前节点下的所有实例的集合 |
| default             |  int     | 0-普通集群，1-内置模块集合，默认为 0 |