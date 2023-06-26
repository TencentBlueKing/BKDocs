# 资源的拓扑说明

> 此文档向接入系统说明资源的拓扑在权限中心如何表示, 以及接入系统实现 SDK 时如何转换

### 示例

系统: cmdb
资源类型: host
资源实例: 192.168.1.1
资源的拓扑层级:

1. 业务-蓝鲸 -> 集群-深圳 -> 模块-paas
2. 业务集-蓝鲸管控 -> 模块-paas

该资源拥有 2 个不同链路的拓扑层级

### 权限中心的表达

```json
{
    "system": "bk_cmdb",
    "type": "host",
    "id": "192.168.1.1",
    "attribute": {
        "_bk_iam_path_": [
            "/biz,bk/set,sz/module,paas/", # 对应于示例的第一个拓扑
            "/bizset,bk_mc/module,paas/"  # 对应于示例的第二个拓扑
        ]
    }
}
```

权限中系统内对与资源的拓扑表示为资源的`_bk_iam_path_`属性, 可以有多个

### 推荐的做法

```json
[
    [
        {
           "type": "biz",
            "type_name": "业务",
            "id": "bk",
            "name": "蓝鲸"
        },
        {
           "type": "set",
            "type_name": "集群",
            "id": "sz",
            "name": "深圳"
        },
        {
           "type": "module",
            "type_name": "模块",
            "id": "paas",
            "name": "paas"
        }
    ],
    [
        {
           "type": "bizset",
            "type_name": "业务集",
            "id": "bk_mc",
            "name": "蓝鲸管控"
        },
        {
           "type": "module",
            "type_name": "模块",
            "id": "paas",
            "name": "paas"
        }
    ]
]
```

接入系统在表示资源的拓扑时使用以上结构, 对接权限中心时通过 SDK 的转换函数转换成权限中心需要的`_bk_iam_path_`字符串表达