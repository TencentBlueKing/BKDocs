
### 请求地址

/api/c/compapi/v2/cc/search_object_topo_graphics/



### 请求方法

POST


### 功能描述

查询拓扑图

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
|scope_type |string|是|图形范围类型,可选global,biz,cls(当前只有global)|
|scope_id |string|是|图形范围类型下的ID,如果为global,则填0|


### 请求参数示例

``` python
{
    "scope_type": "global",
    "scope_id": "0"
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
           "node_type": "obj",
           "bk_obj_id": "switch",
           "bk_inst_id": 0,
           "node_name": "switch",
           "position": {
               "x": 100,
               "y": 100
           },
           "ext": {},
           "bk_obj_icon": "icon-cc-switch2",
           "scope_type": "global",
           "scope_id": "",
           "bk_biz_id": 1,
           "bk_supplier_account": "0",
           "assts": [
               {
                   "bk_asst_type": "singleasst",
                   "node_type": "obj",
                   "bk_obj_id": "host",
                   "bk_inst_id": 0,
                   "bk_object_att_id": "host_id",
                   "lable": {}
               }
           ]
       }
    ]
}
```

### 返回结果参数说明

#### data

| 字段                | 类型     | 描述                  |
|---------------------|----------|-----------------------|
| node_type           | string   | 节点类型,可选obj,inst |
| bk_obj_id           | string   | 对象模型的ID          |
| bk_inst_id          | int      | 实例ID                |
| node_name           | string   | 节点名,当node_type为obj时是模型名称,当node_type为inst时是实例名称|
| position            | string   | 节点在图中的位置      |
| ext                 | object   | 前端扩展字段          |
| bk_obj_icon         | string   | 对象模型的图标        |
| scope_type          | string   | 图形范围类型,可选global,biz,cls(当前只有global)|
| scope_id            | string   | 图形范围类型下的ID,如果为global,则填0          |
| bk_biz_id           | int      | 业务id                                         |
| bk_supplier_account | string   | 开发商账号                                     |
| assts               | array    | 关联节点                                        |

#### assts

| 字段             | 类型   | 描述                  |
|------------------|--------|-----------------------|
| bk_asst_type     | string | 关联类型              |
| node_type        | string | 节点类型,可选obj,inst |
| bk_obj_id        | string | 对象模型的ID          |
| bk_inst_id       | int    | 实例ID                |
| bk_object_att_id | string | 关联的属性            |
| lable            | obj ect| 标签,扩展字段,未启用  |