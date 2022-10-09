# 新建关联配置 ResourceCreatorAction API

### 参数说明

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| config | array(object) | 是 | 新建关联的配置文件，包含了每种资源类型对应的创建时可以对创建者进行授权的 Action |

config 里的每个元素的字段说明:

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id | string | 是 | 资源类型的唯一标识 |
| actions | array(object) | 是 | 对应资源被创建时可以对创建者进行授权的 Action 列表 |
| sub_resource_types | array(object) | 否 |子资源类型相关可授权的 Action 相关配置信息，列表每个元素同 config 列表里的每个元素一样，这是个递归结构|

actions 里的每个元素的字段说明：

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id | string | 是 | Action 的唯一标识 |
| required | bool | 是 | 该 Action 是否是必须的，即后续权限中心支持企业和用户修改创建者赋权时，该 Action 能否不被选择授予 |

**`required 字段特别说明`**

> 假设资源类型 host 产生时可以对 host_edit 、host_view、host_delete 这 3 个权限授权，且 host_delete 配置 required=true

- 后续权限中心将支持用户和企业自定义这个新建关联的配置时，host_delete 是必选的，无法去除

- 如果用户自定义新建管理的配置是 host 产生时对 host_view、host_delete 这 2 个权限授权（host_edit 和 host_view 由于 required=false，所以是可以配置为不授权的），那么该用户在接入系统新增 host 后，自动拥有 host_view 和 host_delete


`注意:`
1. 层级结构是依据资源的层级
2. 后续权限中心将会支持这份配置可由企业全局修改和每个用户自定义


### 1. 注册或更新 新建关联配置

#### URL

注册

> POST /api/v1/model/systems/{system_id}/configs/resource_creator_actions

更新 (整个列表完全覆盖更新)

> PUT /api/v1/model/systems/{system_id}/configs/resource_creator_actions


#### Parameters

| 字段 | 类型 | 是否必须 | 位置 | 描述 |
| :--- | :--- | :--- |:--- |:--- |
| system_id | string | 是 | path | 系统 ID |

#### Request
- [样例] cmdb 可能的新建关联配置
```json
{
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
```

- [样例] 标准运维新建关联配置
```json
{
    "config":[
        {
            "id":"project",
            "actions":[
                {
                    "id":"project_fast_create_task",
                    "required":false
                },
                {
                    "id":"flow_create",
                    "required":false
                },
                {
                    "id":"project_edit",
                    "required":false
                },
                {
                    "id":"project_view",
                    "required":false
                }
            ],
            "sub_resource_types":[
                {
                    "id":"common_flow",
                    "actions":[
                        {
                            "id":"common_flow_view",
                            "required":false
                        },
                        {
                            "id":"common_flow_edit",
                            "required":false
                        },
                        {
                            "id":"common_flow_delete",
                            "required":false
                        }
                    ]
                },
                {
                    "id":"flow",
                    "actions":[
                        {
                            "id":"flow_create_periodic_task",
                            "required":false
                        },
                        {
                            "id":"flow_create_mini_app",
                            "required":false
                        },
                        {
                            "id":"flow_create_task",
                            "required":false
                        },
                        {
                            "id":"flow_delete",
                            "required":false
                        },
                        {
                            "id":"flow_edit",
                            "required":false
                        },
                        {
                            "id":"flow_view",
                            "required":false
                        }
                    ]
                },
                {
                    "id":"mini_app",
                    "actions":[
                        {
                            "id":"mini_app_create_task",
                            "required":false
                        },
                        {
                            "id":"mini_app_delete",
                            "required":false
                        },
                        {
                            "id":"mini_app_edit",
                            "required":false
                        },
                        {
                            "id":"mini_app_view",
                            "required":false
                        }
                    ]
                },
                {
                    "id":"periodic_task",
                    "actions":[
                        {
                            "id":"periodic_task_view",
                            "required":false
                        },
                        {
                            "id":"periodic_task_edit",
                            "required":false
                        },
                        {
                            "id":"periodic_task_delete",
                            "required":false
                        }
                    ]
                },
                {
                    "id":"task",
                    "actions":[
                        {
                            "id":"task_view",
                            "required":false
                        },
                        {
                            "id":"task_edit",
                            "required":false
                        },
                        {
                            "id":"task_operate",
                            "required":false
                        },
                        {
                            "id":"task_claim",
                            "required":false
                        },
                        {
                            "id":"task_delete",
                            "required":false
                        },
                        {
                            "id":"task_clone",
                            "required":false
                        }
                    ]
                }
            ]
        }
    ]
}
```

#### Response

```json
{
    "code": 0,
    "message": "",
    "data": {}
}
```