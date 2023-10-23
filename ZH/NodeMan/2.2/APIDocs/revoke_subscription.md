### 功能描述

终止正在执行的任务

### 请求参数

{{ common_args_desc }}

#### 接口参数

| 字段               | 类型    | <div style="width: 50pt">必选</div> | 描述                         |
| ---------------- | ----- | --------------------------------- | -------------------------- |
| subscription_id  | int   | 是                                 | 订阅ID                       |
| instance_id_list | array | 否                                 | 实例ID列表，见instance_id_list定义 |

##### instance_id_list

由scope内的主机实例信息转换而来，由以下字段拼接，规则：{object_type}|{node_type}|{type}|{id}，示例：1: host|instance|host|1, 2: host|instance|host|127.0.0.1-1-0

| 字段          | 类型     | <div style="width: 50pt">必选</div> | 描述                                                                                  |
| ----------- | ------ | --------------------------------- | ----------------------------------------------------------------------------------- |
| object_type | string | 是                                 | 对象类型，1：host，主机类型  2：service，服务类型                                                    |
| node_type   | string | 是                                 | 节点类别，1: topo，动态实例（拓扑）2: instance，静态实例 3: service_template，服务模板 4: set_template，集群模板 |
| type        | string | 是                                 | 服务类型，1: host 主机 2: bk_obj_id 模板ID                                                   |
| id          | string | 是                                 | 服务实例ID，1： 根据ip，bk_cloud_id，bk_supplier_id和分隔符”-“生成key  2: bk_host_id, 主机Host-ID     |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "admin",
    "bk_token": "xxx",
    "subscription_id": 1,
    "instance_id_list": ["host|instance|host|1"]
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": null
}
```

### 返回结果参数说明

#### response

| 字段      | 类型     | 描述                         |
| ------- | ------ | -------------------------- |
| result  | bool   | 请求成功与否。true:请求成功；false请求失败 |
| code    | int    | 错误编码。 0表示success，>0表示失败错误  |
| message | string | 请求失败返回的错误信息                |
| data    | object | 请求返回的数据                    |
