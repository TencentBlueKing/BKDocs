# 通用查询 Common Query API

### 1. 查询系统注册的信息

#### URL

> GET /api/v1/model/systems/{system_id}/query

#### Parameters

| 字段 | 类型 | 是否必须 | 位置 | 描述 |
| :--- | :--- | :--- |:--- |:--- |
| system_id | string | 是 | path | 系统 ID |
| fields |string |否 |query | 需要查询的信息类型，枚举值：base_info(基础信息), resource_types(资源类型)，actions(操作)，action_groups (操作组), instance_selections(实例视图), resource_creator_actions(新建关联配置), common_actions(常用操作) 多个以英文逗号分隔，空值时查询所有注册的信息 |

#### Request

```json
fields=base_info,resource_types,actions,action_groups,instance_selections,resource_creator_actions
```
#### Response
说明：
- 返回的信息数据结构与注册时的数据结构一致

```json
{
    "code": 0,
    "message": "",
    "data": {
        // 基础信息
        "base_info": {
            "id": "bk_cmdb",
            "name": "配置平台",
            "name_en": "CMDB",
            "description": "配置平台是...",
            "description_en": "CMDB is...",
            "clients": "bk_cmdb,cmdb",
            "provider_config": {
                "host": "http://cmdb.service.consul",
                "auth": "basic"
            }
        },
        // 资源类型
        "resource_types": [
            {
                "id": "host", 
                "name": "主机",
                "name_en": "host", 
                "description": "主机是...",
                "description_en": "host is...", 
                "parents": [
                    {"system_id": "bk_cmdb", "id": "module"}
                ],
                "provider_config": {
                    "path": "/api/v1/resources/host/query"
                }
                "version": 1
           }, 
           {
                "id": "biz",
                "name": "业务",
                "name_en": "biz",
                "description": "业务是...",
                "description_en": "biz is...",
                "parents": [
                    {"system_id": "bk_cmdb", "id": "biz_set"}            
                ],
                "provider_config": {
                    "path": "/api/v1/resources/biz_set/query"
                }
                "version": 1
            }
        ],
        // 操作
        "actions": [
            {
                "id": "host_edit",
                "name": "主机编辑New",
                "name_en": "host_edit",
                "description": "主机编辑New是...",
                "description_en": "host_edit is...",
                "type": "",
                "related_resource_types": [
                    {
                        "system_id": "bk_cmdb",
                        "id": "host",
                        "name_alias":  "服务器",
                        "name_alias_en": "server",
                        "instance_selections": [
                            {
                                "name": "资源池主机",
                                "name_en": "free host",
                                "resource_type_chain": [{"system_id": "bk_cmdb", "id": "host"}]
                            }, 
                            {
                                "name": "业务拓扑",
                                "name_en": "biz topology",
                                "resource_type_chain": [{"system_id": "bk_cmdb", "id": "biz"}, {"system_id": "bk_cmdb", "id": "set"}, {"system_id": "bk_cmdb", "id": "module"}, {"system_id": "bk_cmdb", "id": "host"}]
                            },
                            {
                                "name": "业务集拓扑",
                                "name_en": "biz set topology"
                                "resource_type_chain": [{"system_id": "bk_cmdb", "id": "biz_set"}, {"system_id": "bk_cmdb", "id": "set"}, {"system_id": "bk_cmdb", "id": "module"}, {"system_id": "bk_cmdb", "id": "host"}]
                            }
                        ]
                    }
                ],
                "version": 1,
            }
        ],
        // 实例视图
        "instance_selections": [
            {
                "id": "view1",
                "name": "实例选择11",
                "name_en": "view11",
                "resource_type_chain": [
                    {
                        "id": "bbbdd",
                        "system_id": "aaacc"
                    }
                ]
            }
        ],
        "resource_creator_actions": {
            "config":[
                {
                    "id":"biz",
                    "actions":[
                        {
                            "id":"biz_edit",
                            "required":false
                        },
                        {
                            "id":"biz_view",
                            "required":true
                        },
                        {
                            "id":"set_create",
                            "required":false
                        }
                    ],
                    "sub_resource_types":[
                        {
                            "id":"set",
                            "actions":[
                                {
                                    "id":"set_edit",
                                    "required":false
                                },
                                {
                                    "id":"set_view",
                                    "required":false
                                },
                                {
                                    "id":"module_create",
                                    "required":false
                                }
                            ],
                            "sub_resource_types":[
                                {
                                    "id":"module",
                                    "actions":[
                                        {
                                            "id":"module_edit",
                                            "required":false
                                        },
                                        {
                                            "id":"module_view",
                                            "required":false
                                        },
                                        {
                                            "id":"host_create",
                                            "required":false
                                        }
                                    ],
                                    "sub_resource_types":[
                                        {
                                            "id":"host",
                                            "actions":[
                                                {
                                                    "id":"host_edit",
                                                    "required":false
                                                },
                                                {
                                                    "id":"host_view",
                                                    "required":false
                                                }
                                            ]
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    }
}
```