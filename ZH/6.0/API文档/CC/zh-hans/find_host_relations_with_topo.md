
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/cc/find_host_relations_with_topo/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

根据业务拓扑实例节点，查询该实例节点下的主机关系信息

### 请求参数



#### 接口参数

| 字段                |  类型      | 必选   |  描述                       |
|---------------------|------------|--------|-----------------------------|
| page       |  dict    | 是     | 查询条件 |
| fields    |  array   | 是     | 主机属性列表，控制返回结果的主机里有哪些字段，请按需求填写，可以为bk_biz_id,bk_host_id,bk_module_id,bk_set_id,bk_supplier_account|
| bk_obj_id | string | 是 | 拓扑节点的模型ID，可以是自定义层级模型ID，set，module等，但不能是业务 |
| bk_inst_ids | int array | 是 | 拓扑节点的实例ID，最多支持50个实例节点 |


#### page

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| start    |  int    | 是     | 记录开始位置 |
| limit    |  int    | 是     | 每页限制条数,最大值为500 |
| sort     |  string | 否     | 排序字段 |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "page": {
        "start": 0,
        "limit": 10
    },
    "fields": [
        "bk_module_id",
        "bk_host_id"
    ],
    "bk_obj_id": "province",
    "bk_inst_ids": [10,11]
}
```

### 返回结果示例

```json
{
  "result":true,
  "code":0,
  "message":"success",
  "data":  {
      "count": 1,
      "info": [
          {
              "bk_host_id": 2,
              "bk_module_id": 51
          }
      ]
  }
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| count     | int       | 记录条数 |
| info      | object array     | 主机关系信息 |