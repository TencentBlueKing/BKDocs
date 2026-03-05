
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/search_dynamic_group/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

查询动态分组列表 (V3.9.6)

### 请求参数



#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_biz_id |  int     | 是     | 业务 ID |
| condition |  object    | 否     | 查询条件，condition 字段为自定义查询的属性字段, 可以是 create_user, modify_user, name |
| disable_counter |  bool | 否     | 是否返回总记录条数，默认返回 |
| page     |  object   | 是     | 分页设置 |

#### page

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| start     |  int     | 是     | 记录开始位置 |
| limit     |  int     | 是     | 每页限制条数,最大 200 |
| sort      |  string  | 否     | 检索排序， 默认按照创建时间排序 |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "disable_counter": true,
    "condition": {
        "name": "my-dynamic-group"
    },
    "page":{
        "start": 0,
        "limit": 200
    }
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": {
        "count": 0,
        "info": [
            {
                "bk_biz_id": 1,
                "id": "XXXXXXXX",
                "name": "my-dynamic-group",
                "bk_obj_id": "host",
                "info": {
                    "condition":[
                			{
                				"bk_obj_id":"set",
                				"condition":[
                					{
                						"field":"default",
                						"operator":"$ne",
                						"value":1
                					}
                				]
                			},
                			{
                				"bk_obj_id":"module",
                				"condition":[
                					{
                						"field":"default",
                						"operator":"$ne",
                						"value":1
                					}
                				]
                			},
                			{
                				"bk_obj_id":"host",
                				"condition":[
                					{
                						"field":"bk_host_innerip",
                						"operator":"$eq",
                						"value":"127.0.0.1"
                					}
                				]
                			}
                    ]
                },
                "name": "test",
                "bk_obj_id": "host",
                "id": "1111",
                "create_user": "admin",
                "create_time": "2018-03-27T16:22:43.271+08:00",
                "modify_user": "admin",
                "last_time": "2018-03-27T16:29:26.428+08:00"
            }
        ]
    }
}
```

### 返回结果参数
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

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| count     | int | 当前规则能匹配到的总记录条数（用于调用者进行预分页，实际单次请求返回数量以及数据是否全部拉取完毕以 JSON Array 解析数量为准） |
| info      | array        | 自定义查询数据 |

#### data.info

| 字段      | 类型       | 描述      |
|-----------|------------|-----------|
| bk_biz_id    | int     | 业务 ID |
| id           | string  | 动态分组主键 ID |
| name         | string  | 动态分组命名 |
| bk_obj_id    | string  | 动态分组的目标资源对象类型,目前可以为 host,set |
| info         | object  | 动态分组信息 |
| last_time    | string  | 更新时间 |
| modify_user  | string  | 修改者 |
| create_time  | string  | 创建时间 |
| create_user  | string  | 创建者 |

#### data.info.info.condition

| 字段      |  类型     |  描述      |
|-----------|-----------|------------|
| bk_obj_id |  string   | 对象名,可以为 set,module,host |
| condition |  array    | 查询条件 |

#### data.info.info.condition.condition

| 字段      |  类型     |  描述      |
|-----------|------------|---------------|
| field     |  string    | 对象的字段 |
| operator  |  string    | 操作符, op 值为 eq(相等)/ne(不等)/in(属于)/nin(不属于)/like(模糊匹配) |
| value     |  object    | 字段对应的值 |