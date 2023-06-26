# 新建关联批量资源授权接口

### 接口基本说明
* 背景：
    - 接入系统上某个资源实例被创建时，对应的创建者应该需要赋予依赖该实例的相关权限
        - 比如一个作业创建时，创建者需要有该作业的编辑、删除和查看权限


* 流程:
    - 1. **用户**在**接入系统**上产生资源实例
    - 2. **接入系统**请求 API,  **权限中心**根据 [新建关联](../02-Model/19-ResourceCreatorAction.md) 配置对应创建者进行授权


* 接口描述： 
    - 接入系统根据资源实例创建，对创建者进行相关授权，`支持批量资源实例`


**`特别注意`** : 
  - 涉及到资源实例授权，权限中心有限制规则：`1个人拥有1个操作 + 1个资源类型`的实例权限最大数量：`10000`个 。(`触发后, 授权接口报错/用户无法继续增加实例权限`)
  - [大规模实例级权限限制具体说明和对应处理方案](../../../Explanation/06-LargeScaleInstances.md)

-------

#### URL

ESB API

> POST /api/c/compapi/v2/iam/authorization/batch_resource_creator_action/

APIGateway2.0 API

> POST /api/v1/open/authorization/batch_resource_creator_action/

> `特别说明`: [ESB API 与 APIGateway2.0 API 说明](../01-Overview/01-BackendAPIvsESBAPI.md)

#### Parameters

* 通用参数

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
|bk_app_code|string|是|应用 ID|
|bk_app_secret|string|是|安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取|
|bk_token|string|否|当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取|
|bk_username|string|否|当前用户用户名，仅仅在 ESB 里配置免登录态验证白名单中的应用，才可以用此字段指定当前用户|

* 接口参数

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system | string | 是 | 系统唯一标识 |
| type  | string | 是 | 资源类型的唯一标识 |
| creator | string | 是 | 资源实例的创建者 |
| instances | array(object) | 是 | 批量资源实例，`最多20个` |

instances 列表的元素说明

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id | string | 是 | 资源实例的唯一标识 |
| name | string | 是 | 资源实例的名称 |
| ancestors | array(object) | 否 | 资源的祖先，非必填，对于资源实例可能存在不同拓扑层级且某些操作需要按照拓扑层级鉴权时，该字段则需要填写，详细说明请看 **ancestors 特别说明** |

ancestors 列表的元素说明

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system | string | 是 | 系统唯一标识 |
| type | string | 是 | 祖先资源类型的唯一标识 |
| id | string | 是 | 祖先资源实例的唯一标识 |

**`ancestors特别说明`**

假设接入系统存在资源实例可以属于不同拓扑层级，比如：主机 A 可以在蓝鲸业务的 Web 模块，也可以在蓝鲸业务的 DB 模块下，同时需要限制用户 X 只能在 Web 模块下修改主机相关属性，而不能在 DB 模块下修改主机属性

那么对于修改主机属性这个操作，其鉴权是需要区分拓扑祖先层级的，即 用户 X 能编辑 /biz,bk/module,web/host,A/ 主机属性，所以授权时不能直接授予用户 X 能编辑 host,A 主机属性，否则用户 X 将在 DB 模块和 Web 模块下都可以编辑主机 host,A

对于存在以上的情况的，在资源实例产生时需要给到 ancestors，这样权限中心将会按照拓扑层级来授权，否则将直接授权资源实例(不带拓扑层级)


#### Request

- 无 ancestors

```json
{
    "system": "bk_job",
    "type":"job",
    "creator":"admin",
    "instances": [
    	{
            "id":"job1",
            "name":"第一个作业",
        },
    	{
            "id":"job2",
            "name":"第二个作业",
        },
    	{
            "id":"job3",
            "name":"第三个作业",
        }
    ]
}
```
- 有 ancestors

```json
{
    "system": "bk_sops",
    "type":"mini_app",
    "creator":"admin",
    "instances": [
        {
            "id":"mini_app1",
            "name":"第一个轻应用",
            "ancestors":[
                {
                    "system": "bk_sops",
                    "type":"project",
                    "id":"project1"
                }
            ]            
        },
        {
            "id":"mini_app2",
            "name":"第二个轻应用",
            "ancestors":[
                {
                    "system": "bk_sops",
                    "type":"project",
                    "id":"project2"
                }
            ]            
        }
    ]
}
```


#### Response

data 数组元素

| 字段 | 类型 | 描述 |
|:---|:---|:---|
|action|object| creator 被授权对应的 Action |
|policy_id|int| creator 被授权对应的策略 ID |

action

| 字段 |  类型 |  描述 |
|:---|:---|:---|
|id|string| 操作 ID |



> Status: 200 OK

```json
{
  "data": [  // 表示creator被授权对应的Action和策略ID列表
    {
        "action": {
            "id": "edit"
        },
        "policy_id": 1
    },
    {
        "action": {
            "id": "list"
        },
        "policy_id": 2
    },
    {
        "action": {
            "id": "delete"
        },
        "policy_id": 3
    },
    {
        "action": {
            "id": "view"
        },
        "policy_id": 4
    }
  ],
  "result": true,
  "code": 0,
  "message": "OK"
}
```
