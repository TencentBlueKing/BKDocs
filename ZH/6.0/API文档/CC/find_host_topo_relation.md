### 功能描述

获取主机与拓扑的关系

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code   | string | 是 | 应用 ID     |
| bk_app_secret | string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token      | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username   | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
 bk_biz_id| int| 是|业务 ID|
| bk_set_ids|array | 否| 集群 ID 列表，最多 200 条|
| bk_module_ids|array | 否| 模块 ID 列表，最多 500 条| 
| bk_host_ids|array | 否| 主机 ID 列表，最多 500 条| 
| page| object| 是|分页信息|

#### page 字段说明

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
|start|int|否|获取数据偏移位置|
|limit|int|是|过去数据条数限制，建议 为 200|

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "page":{
        "start":0,
        "limit":10
    },
    "bk_biz_id":2,
    "bk_set_ids": [1, 2],
    "bk_module_ids": [23, 24],
    "bk_host_ids": [25, 26]
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
    "count": 10,
    "info": [
        {
        "bk_biz_id": 3,
        "bk_host_id": 5,
        "bk_module_id": 54,
        "bk_set_id": 10,
        "bk_supplier_account": "0"
        },
        .....
    ]
}
```



### 返回结果参数说明


#### data 字段说明

| 名称  | 类型  | 说明 |
|---|---|---|
| count| int| 记录条数 |
| info| object array |  业务下主机与集群，模块，集群的数据详情列表 |


#### data.info 字段说明
| 名称  | 类型  | 说明 |
|---|---|---|
| bk_biz_id | int | 业务 ID |
| bk_set_id | int | 集群 ID |
| bk_module_id | int | 模块 ID |
| bk_host_id | int | 主机 ID |
