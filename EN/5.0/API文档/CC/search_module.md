
### 请求地址

/api/c/compapi/v2/cc/search_module/



### 请求方法

POST


### 功能描述

查询模块

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
| bk_biz_id      |  int     | 是     | 业务id |
| bk_set_id      |  int     | 是     | 集群ID |
| fields         |  array   | 是     | 查询字段，字段来自于模块定义的属性字段 |
| condition      |  dict    | 是     | 查询条件，字段来自于模块定义的属性字段 |
| page           |  dict    | 是     | 分页条件 |

#### page

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| start    |  int    | 是     | 记录开始位置 |
| limit    |  int    | 是     | 每页限制条数 |
| sort     |  string | 否     | 排序字段 |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "fields": [
        "bk_module_name"
    ],
    "condition": {
        "bk_module_name": "test"
    },
    "page": {
        "start": 0,
        "limit": 10
    }
}
```

### 返回结果示例

```python

{
    "result": true,
    "code": 0,
    "message": "",
    "data": {
        "count": 2,
        "info": [
            {
                "bk_module_name": "cc_service"
            },
            {
                "bk_module_name": "cmdb"
            }
        ]
    }
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| count     | int       | 数据数量 |
| info      | array     | 结果集，其中，所有字段均为模块定义的属性字段 |