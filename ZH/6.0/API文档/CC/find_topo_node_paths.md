
### 请求地址

/api/c/compapi/v2/cc/find_topo_node_paths/



### 请求方法

POST


### 功能描述

该接口用于根据业务拓扑层级中的某个节点实例(包括自定义节层级实例)，查询该节点的父层级一直到业务顶点的路径信息。(v3.9.1)

**注意**
该接口有缓存，缓存更新的最长时间为 5 分钟。

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_biz_id  | int  | 是     | 业务 ID |
| bk_nodes  | object array  | 是     | 要查询的业务拓扑实例节点信息列表, 最大查询数量为 1000 |


#### bk_nodes 字段说明

| 字段  | 类型   | 必选 | 描述                  |
| ----- | ------ | ---- | --------------------- |
| bk_obj_id | string    | 是   | 业务拓扑节点模型名称，如 biz,set,module 及自定义层级模型名       |
| bk_inst_id | int64    | 是   | 该业务拓扑节点的实例 ID |

### 请求参数示例

```json
{
    "bk_nodes": [
        {
            "bk_obj_id": "set",
            "bk_inst_id": 11
        },
        {
            "bk_obj_id": "module",
            "bk_inst_id": 60
        },
        {
            "bk_obj_id": "province",
            "bk_inst_id": 3
        }
    ]
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "permission": null,
    "data": [
        {
            "bk_obj_id": "set",
            "bk_inst_id": 11,
            "bk_inst_name": "gz",
            "bk_paths": [
                [
                    {
                        "bk_obj_id": "biz",
                        "bk_inst_id": 3,
                        "bk_inst_name": "demo"
                    },
                    {
                        "bk_obj_id": "province",
                        "bk_inst_id": 3,
                        "bk_inst_name": "sz"
                    }
                ]
            ]
        },
        {
            "bk_obj_id": "module",
            "bk_inst_id": 60,
            "bk_inst_name": "m2",
            "bk_paths": [
                [
                    {
                        "bk_obj_id": "biz",
                        "bk_inst_id": 3,
                        "bk_inst_name": "demo"
                    },
                    {
                        "bk_obj_id": "province",
                        "bk_inst_id": 3,
                        "bk_inst_name": "sz"
                    },
                    {
                        "bk_obj_id": "set",
                        "bk_inst_id": 12,
                        "bk_inst_name": "set1"
                    }
                ]
            ]
        },
        {
            "bk_obj_id": "province",
            "bk_inst_id": 3,
            "bk_inst_name": "sz",
            "bk_paths": [
                [
                    {
                        "bk_obj_id": "biz",
                        "bk_inst_id": 3,
                        "bk_inst_name": "demo"
                    }
                ]
            ]
        }
    ]
}
```

### 返回结果参数说明

#### data 说明
| 字段      |  类型      |  描述      |
|-----------|------------|------------|
| bk_obj_id | string   | 业务拓扑节点模型名称，如 biz,set,module 及自定义层级模型名       |
| bk_inst_id | int64   | 该业务拓扑节点的实例 ID |
| bk_paths | object array| 该节点的层级信息，即从业务到该节点的父节点的层级信息 |

#### bk_paths 说明
| 字段      |  类型      |  描述      |
|-----------|------------|------------|
| bk_obj_id | string   | 节点类型       |
| bk_inst_id | int64   | 节点实例 ID |
| bk_inst_name | string   | 节点实例名称 |