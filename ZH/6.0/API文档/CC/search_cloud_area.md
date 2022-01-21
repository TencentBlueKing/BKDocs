### 功能描述

查询云区域

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code   | string | 是 | 应用 ID     |
| bk_app_secret | string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token      | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username   | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                 |  类型      | 必选   |  描述       |
|----------------------|------------|--------|-------------|
|condition|object|否|查询条件|
|bk_cloud_id|int|否|云区域 ID|
|bk_cloud_name|string|否|云区域名称|
| page| object| 是|分页信息|



#### page 字段说明

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
|start|int|否|获取数据偏移位置|
|limit|int|是|过去数据条数限制，建议 为 200|


### 请求参数示例

``` python
{
    "condition": {
        "bk_cloud_id": 12,
        "bk_cloud_name" "aws",
    },
    "page":{
        "start":0,
        "limit":10
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
    "count": 10,
    "info": [
         {
            "bk_cloud_id": 0,
            "bk_cloud_name": "aws",
            "bk_supplier_account": "0",
            "create_time": "2019-05-20T14:59:48.354+08:00",
            "last_time": "2019-05-20T14:59:48.354+08:00"
        },
        .....
    ]
   
  }
}
```

### 返回结果参数说明

#### data

| 名称  | 类型  | 说明 |
|---|---|---|---|
| count| int| 记录条数 |
| info| object array |  查询到的云区域列表信息 |

#### data.info 字段说明
| 名称  | 类型  | 说明 |
|---|---|---|---|
| bk_cloud_id | int | 云区域 ID |
| bk_cloud_name | string  | 云区域名字 | 
| create_time | string | 创建时间 |
| last_time | string | 最后修改时间 | 



