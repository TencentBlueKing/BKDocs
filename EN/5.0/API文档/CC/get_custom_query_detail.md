
### 请求地址

/api/c/compapi/v2/cc/get_custom_query_detail/



### 请求方法

GET


### 功能描述

获取自定义api详情

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_supplier_account | string     | 否     | 开发商账号 |
| bk_biz_id |  int     | 是     | 业务ID |
| id        |  string  | 是     | 主键ID |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "bk_biz_id": 1,
    "id": "xxx"
}
```

### 返回结果示例

```python

{
    "result": true,
    "code": 0,
    "message": "",
    "data": {
        "bk_biz_id": 1,
        "name": "api1",
        "id": "bacfet4kd42325venmcg",
        "info": "{\"condition\":[{\"bk_obj_id\":\"biz\",\"condition\":[{\"field\":\"default\",\"operator\":\"$ne\",\"value\":1}],\"fields\":[]},{\"bk_obj_id\":\"set\",\"condition\":[],\"fields\":[]},{\"bk_obj_id\":\"module\",\"condition\":[],\"fields\":[]},{\"bk_obj_id\":\"host\",\"condition\":[{\"field\":\"bk_host_innerip\",\"operator\":\"$eq\",\"value\":\"127.0.0.1\"}],\"fields\":[\"bk_host_innerip\",\"bk_host_outerip\",\"bk_agent_status\"]}]}",
        "create_user": "admin",
        "create_time": "2018-03-27T16:22:43.271+08:00",
        "modify_user": "admin",
        "last_time": "2018-03-27T16:29:26.428+08:00"
    }
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| bk_biz_id    | int          | 业务ID |
| create_time  | string       | 创建时间 |
| create_user  | string       | 创建者 |
| id           | string       | 自定义api主键ID |
| info         | string       | 自定义api信息 |
| last_time    | string       | 更新时间 |
| modify_user  | string       | 修改者 |
| name         | string       | 自定义api命名 |

#### data.info

| 字段      |  类型     |  描述      |
|-----------|------------|--------|------------|
| bk_obj_id |  string   | 对象名,可以为biz,set,module,host,object |
| fields    |  array    | 查询输出字段 |
| condition |  array    | 查询条件 |

#### data.info.condition

| 字段      |  类型     |  描述      |
|-----------|------------|--------|------------|
| field     |  string    | 对象的字段 |
| operator  |  string    | 操作符, $eq为相等，$neq为不等，$in为属于，$nin为不属于 |
| value     |  string    | 字段对应的值 |