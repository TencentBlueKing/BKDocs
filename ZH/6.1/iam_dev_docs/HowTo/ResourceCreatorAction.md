# 新建关联权限方案

## 一、背景&需求

一个新的资源实例产生时，需要其创建者有该实例的某些操作权限

比如一个作业创建时，创建者需要有该作业的编辑、删除和查看权限

## 二、实现方案

1. `接入系统` 注册每种资源产生时对应创建者应该赋予的操作列表，且这数据将作为接入系统规定的创建者默认的权限
2. `接入系统` 在产生新的资源实例时，必须调用`权限中心`API 知会权限中心新实例的产生并带其创建者


### 1. 接入系统 注册的新建关联配置数据结构

> 层级结构是依据资源的层级，后续权限中心将会支持这份配置可由企业全局修改和每个用户自定义

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
config | array(object) | 是 | 新建关联的配置文件，包含了每种资源类型对应的创建时可以对创建者进行授权的 Action
 

config 里的每个元素的字段说明:

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
id | string | 是 | 资源类型的唯一标识
actions | array(object) | 是 | 对应资源被创建时可以对创建者进行授权的 Action 列表
sub_resource_types | array(object) | 否 | 子资源类型相关可授权的 Action 相关配置信息，列表每个元素同 config 列表里的每个元素一样，这是个递归结构
 

actions 里的每个元素的字段说明：

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
id | string | 是 | Action 的唯一标识
required | bool | 是 | 该 Action 是否是必须的，即后续权限中心支持企业和用户修改创建者赋权时，该 Action 能否不被选择授予
 

**required 字段特别说明**

假设资源类型 host 产生时可以对 host_edit 、host_view、host_delete 这 3 个权限授权，且 host_delete 配置 required=true

- 后续权限中心将支持用户和企业自定义这个新建关联的配置时，host_delete 是必选的，无法去除
- 如果用户自定义新建管理的配置是 host 产生时对 host_view、host_delete 这 2 个权限授权（host_edit 和 host_view 由于 required=false，所以是可以配置为不授权的），那么该用户在接入系统新增 host 后，自动拥有 host_view 和 host_delete


#### [样例参考] cmdb 新建关联配置
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
说明：
- 用户新增 biz1 时，则用户将会对 biz1 有 biz_edit、biz_view 以及在 biz1 下 set_create 的权限
- 用户新增 set1 时，则用户将会对 set1 有 set_edit、set_view 以及在 set1 下 module_create 的权限


#### [样例参考] 标准运维新建关联配置

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
### 2. 接入系统在资源新增时，调用权限中心接口

接口需要的数据信息如下：

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
type | string | 是 | 资源类型的唯一标识
id | string | 是 | 资源实例的唯一标识
name | string | 是 | 资源实例的名称
creator | string | 是 | 资源实例的创建者
ancestors | array(object) | 否 | 资源的祖先，非必填，对于资源实例可能存在不同拓扑层级且某些操作需要按照拓扑层级鉴权时，该字段则需要填写，详细说明请看 ancestors 特别说明

ancestors 列表的元素说明

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
type | string | 是 | 祖先资源类型的唯一标识
id | string | 是 | 祖先资源实例的唯一标识


**ancestors 特别说明**

假设接入系统存在资源实例可以属于不同拓扑层级，比如：主机 A 可以在蓝鲸业务的 Web 模块，也可以在蓝鲸业务的 DB 模块下，同时需要限制用户 X 只能在 Web 模块下修改主机相关属性，而不能在 DB 模块下修改主机属性

那么对于修改主机属性这个操作，其鉴权是需要区分拓扑祖先层级的，即 用户 X 能编辑 /biz,bk/module,web/host,A/ 主机属性，所以授权时不能直接授予用户 X 能编辑 host,A 主机属性，否则用户 X 将在 DB 模块和 Web 模块下都可以编辑主机 host,A

对于存在以上的情况的，在资源实例产生时需要给到 ancestors，这样权限中心将会按照拓扑层级来授权，否则将直接授权资源实例(不带拓扑层级)

```json
{
    "type":"xxxxx",
    "id":"xxx",
    "name":"xxxx",
    "creator":"jianan",
    "ancestors":[
        {
            "type":"xxxxxx",
            "id":"yyy"
        }
    ]
}
```