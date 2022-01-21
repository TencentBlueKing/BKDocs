
### 请求地址

/api/c/compapi/v2/cc/update_custom_query/



### 请求方法

POST


### 功能描述

更新自定义查询

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_supplier_account | string     | 否     | 开发商账号 |
| bk_biz_id |  int     | 是     | 业务 ID |
| id        |  string  | 是     | 主键 ID |
| info      |  string  | 否     | 通用查询条件 |
| name      |  string  | 否     | 收藏的名称 |

#### info

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_obj_id |  string   | 否     | 对象名,可以为 biz,set,module,host,object |
| fields    |  array    | 否     | 查询输出字段 |
| condition |  array    | 否     | 查询条件 |

#### info.condition.condition

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| field     |  string    | 否     | 对象的字段 |
| operator  |  string    | 否     | 操作符, $eq 为相等，$ne 为不等，$in 为属于，$nin 为不属于 |
| value     |  string    | 否     | 字段对应的值 |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "bk_biz_id": 1,
    "id": "xxx",
    "info": "{\"condition\":[{\"bk_obj_id\":\"biz\",\"condition\":[{\"field\":\"default\",\"operator\":\"$ne\",\"value\":1}],\"fields\":[]},{\"bk_obj_id\":\"set\",\"condition\":[],\"fields\":[]},{\"bk_obj_id\":\"module\",\"condition\":[],\"fields\":[]},{\"bk_obj_id\":\"host\",\"condition\":[{\"field\":\"bk_host_innerip\",\"operator\":\"$eq\",\"value\":\"127.0.0.1\"}],\"fields\":[\"bk_host_innerip\",\"bk_host_outerip\",\"bk_agent_status\"]}]}",
    "name": "api1"
}
```

### 返回结果示例

```json

{
    "result": true,
    "code": 0,
    "message": "",
    "data": {}
}
```