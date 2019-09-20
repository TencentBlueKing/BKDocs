
### 请求地址

/api/c/compapi/v2/cc/update_object_topo_graphics/



### 请求方法

POST


### 功能描述

更新拓扑图

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
| scope_type          |  string    | 是     | 图形范围类型,可选global,biz,cls(当前只有global) |
| scope_id            |  string    | 是     | 图形范围类型下的ID,如果为global,则填0   |
| action              |  string    | 是     | 更新方法,可选update,override   |
| data                |  list      | 否     | 更新数据   |

#### data

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| node_type   | string | 是 | 节点类型,可选obj,inst |
| bk_obj_id   | string | 是 | 对象模型的ID |
| bk_inst_id  | int    | 是 | 实例ID |
| position    | dict   | 否 | 节点在图中的位置 |
| ext         | dict   | 否 | 前端扩展字段 |
| bk_obj_icon | string | 否 | 对象模型的图标 |


**注意**：

- scope_type,scope_id 唯一确定一张图

- node_type,bk_obj_id,bk_inst_id 三者唯一确定每张图的一个节点，故必填

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "scope_type": "global",
    "scope_id": 0,
    "action": "update",
    "data": [
        {
            "node_type": "obj",
            "bk_obj_id": "switch",
            "bk_inst_id": 0,
            "position": {
                "x": 100,
                "y": 100
            },
            "ext": {},
            "bk_obj_icon": "icon-cc-switch2"
        }
    ]
}
```

### 返回结果示例

```python

{
    "result": true,
    "code": 0,
    "message": "success",
    "data": "success"
}
```