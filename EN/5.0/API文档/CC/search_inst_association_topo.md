
### 请求地址

/api/c/compapi/v2/cc/search_inst_association_topo/



### 请求方法

POST


### 功能描述

查询实例关联拓扑

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
|bk_supplier_account  |string|是|无|开发商账号|
|bk_obj_id            |string|是|无|模型ID|
|bk_inst_id           |int|是|无|实例ID|


### 请求参数示例

``` python
{
    "bk_supplier_account":"0",
    "bk_obj_id":"test",
    "bk_inst_id":"test"
}
```


### 返回结果示例

```python

{
    "result": true,
    "code": 0,
    "message": "",
    "data": [
       {
           "curr": {
               "bk_inst_id": 17,
               "bk_inst_name": "192.168.1.1",
               "bk_obj_icon": "icon-cc-host",
               "bk_obj_id": "host",
               "bk_obj_name": "主机",
               "children": [],
               "count": 0
           },
           "next": [
               {
                   "bk_inst_id": 0,
                   "bk_inst_name": "",
                   "bk_obj_icon": "icon-cc-subnet",
                   "bk_obj_id": "plat",
                   "bk_obj_name": "云区域",
                   "children": [
                       {
                           "bk_inst_id": 0,
                           "bk_inst_name": "default area",
                           "bk_obj_icon": "",
                           "bk_obj_id": "plat",
                           "bk_obj_name": "",
                           "id": "0"
                       }
                   ],
                   "count": 1
               }
           ],
           "prev": [
               {
                   "bk_inst_id": 0,
                   "bk_inst_name": "",
                   "bk_obj_icon": "icon-cc-business",
                   "bk_obj_id": "rel",
                   "bk_obj_name": "关联",
                   "children": [
                       {
                           "bk_inst_id": 162,
                           "bk_inst_name": "test1",
                           "bk_obj_icon": "",
                           "bk_obj_id": "rel",
                           "bk_obj_name": ""
                       }
                   ],
                   "count": 1
               }
           ]
       }
   ]
}
```

### 返回结果参数说明

#### data

| 字段      | 类型         | 描述                 |
|-----------|--------------|----------------------|
| curr      | object       | 当前实例节点的信息   |
| next      | object array | 当前节点的子节点集合 |
| prev      | object array | 当前节点的父节点结合 |


#### curr

| 字段         | 类型         | 描述                          |
|--------------|--------------|-------------------------------|
| bk_inst_id   | int          | 实例ID                        |
| bk_inst_name | string       | 实例用于展示的名字            |
| bk_obj_icon  | string       | 模型图标的名字                |
| bk_obj_id    | string       | 模型ID                        |
| bk_obj_name  | string       | 模型用于展示的名字            |
| children     | object array | 本模型下所有被关联的实例的集合|
| count        | int          | children     包含节点的数量   |


#### next

| 字段         | 类型         | 描述                           |
|--------------|--------------|--------------------------------|
| bk_inst_id   | int          | 实例ID|the inst ID             |
| bk_inst_name | string       | 实例用于展示的名字             |
| bk_obj_icon  | string       | 模型图标的名字                 |
| bk_obj_id    | string       | 模型ID                         |
| bk_obj_name  | string       | 模型用于展示的名字             |
| children     | object array | 本模型下所有被关联的实例的集合 |
| count        | int          | children包含节点的数量         |

#### next/children

| 字段         | 类型      | 描述               |
|--------------|-----------|--------------------|
| bk_inst_id   |int        | 实例ID             |
| bk_inst_name |string     | 实例用于展示的名字 |
| bk_obj_icon  |string     | 模型图标的名字     |
| bk_obj_id    |string     | 模型ID             |
| bk_obj_name  |string     | 模型用于展示的名字 |



#### prev

| 字段         | 类型         | 描述                           |
|--------------|--------------|--------------------------------|
| bk_inst_id   | int          | 实例ID|the inst ID             |
| bk_inst_name | string       | 实例用于展示的名字             |
| bk_obj_icon  | string       | 模型图标的名字                 |
| bk_obj_id    | string       | 模型ID                         |
| bk_obj_name  | string       | 模型用于展示的名字             |
| children     | object array | 本模型下所有被关联的实例的集合 |
| count        | int          | children 包含节点的数量        |

#### prev/children 字段说明

| 字段        | 类型   | 描述               |
|-------------|--------|--------------------|
|bk_inst_id   | int    | 实例ID|the inst ID |
|bk_inst_name | string | 实例用于展示的名字 |
|bk_obj_icon  | string | 模型图标的名字     |
|bk_obj_id    | string | 模型ID             |
|bk_obj_name  | string | 模型用于展示的名字 |