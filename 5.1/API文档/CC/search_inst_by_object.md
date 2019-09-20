
### 请求地址

/api/c/compapi/v2/cc/search_inst_by_object/



### 请求方法

POST


### 功能描述

查询给定模型的实例信息

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
| bk_supplier_account |  string  | 否     | 开发商账号 |
| bk_obj_id           |  string  | 是     | 自定义模型ID，查询区域时为plat |
| fields              |  array   | 否     | 指定查询的字段 |
| condition           |  dict    | 否     | 查询条件 |
| page                |  dict    | 否     | 分页条件 |

#### page

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| start    |  int    | 是     | 记录开始位置 |
| limit    |  int    | 是     | 每页限制条数,最大200 |
| sort     |  string | 否     | 排序字段 |

#### fields参数说明

参数为查询的目标实例对应的模型定义的所有字段


#### condition 参数说明

condition 参数为查询的目标实例对应的模型定义的所有字段

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "bk_obj_id": "plat",
    "fields": [
    ],
    "condition": {
    },
    "page": {
        "start": 0,
        "limit": 10,
        "sort": ""
    }
}
```

### 返回结果示例

```python

{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        "count": 4,
        "info": [
            {
                "bk_cloud_id": 0,
                "bk_cloud_name": "default area",
                "bk_supplier_account": "123456789"
            }
        ]
    }
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| count     | int       | info 集合中元素的数量 |
| info      | array     | 查询的模型的实例集合 |

#### info

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| bk_cloud_id         | int       | 云区域ID |
| bk_cloud_name       | string    | 云区域名 |
| bk_supplier_account | string    | 开发商账号 |