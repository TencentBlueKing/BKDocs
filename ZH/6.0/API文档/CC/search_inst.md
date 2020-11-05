
### 请求地址

/api/c/compapi/v2/cc/search_inst/



### 请求方法

POST


### 功能描述

根据关联关系实例查询模型实例

- 该接口只适用于自定义层级模型和通用模型实例上，不适用于业务、集群、模块、主机等模型实例

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                |  类型      | 必选   |  描述                       |
|---------------------|------------|--------|-----------------------------|
| bk_obj_id           | string     | 是     | 模型ID                      |
| page                | object     | 是     | 分页参数                    |
| condition           | object     | 否     | 具有关联关系的模型实例查询条件                    |
| fields              | map     | 否     | 指定查询模型实例返回的字段,key为模型ID，value为该查询模型要返回的模型属性字段|

#### page

| 字段      |  类型      | 必选   |  描述                |
|-----------|------------|--------|----------------------|
| start     |  int       | 是     | 记录开始位置         |
| limit     |  int       | 是     | 每页限制条数,最大200 |
| sort      |  string    | 否     | 排序字段             |

#### condition

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| field     |string      |是      | 取值为模型的字段名                                               |
| operator  |string      |是      | 取值为：$regex $eq $ne                                           |
| value     |string      |是      | field配置的模型字段名所对应的值                                  |          


### 请求参数示例

```json
{
    "bk_obj_id": "bk_switch",
    "bk_supplier_account": "0",
    "page": {
        "start": 0,
        "limit": 10,
        "sort": "bk_inst_id"
    },
    "fields": {
        "bk_switch": [
            "bk_asset_id",
            "bk_inst_id",
            "bk_inst_name",
            "bk_obj_id"
        ]
    },
    "condition": {
        "host": [
            {
                "field": "operator",
                "operator": "$regex",
                "value": "admin"
            }
        ]
    }
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "permission": null,
    "data": {
        "count": 2,
        "info": [
            {
                "bk_asset_id": "sw00001",
                "bk_inst_id": 1,
                "bk_inst_name": "sw1",
                "bk_obj_id": "bk_switch"
            },
            {
                "bk_asset_id": "sw00002",
                "bk_inst_id": 2,
                "bk_inst_name": "sw2",
                "bk_obj_id": "bk_switch"
            }
        ]
    }
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述         |
|-----------|-----------|--------------|
| count     | int       | 记录条数     |
| info      | array     | 模型实例实际数据 |