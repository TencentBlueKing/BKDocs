
### 请求地址

/api/c/compapi/v2/iam/authorization/batch_resource_creator_action/



### 请求方法

POST


### 功能描述

新建关联批量资源授权接口

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
| system | string | 是 系统唯一标识 |
| type | string | 是 | 资源类型的唯一标识 |
| creator | string | 是 | 资源实例的创建者 |
| instances | array(object) | 是 | 批量资源实例，最多1000个 |



#### instances
| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| id | string | 是 | 资源实例的唯一标识 |
| name | string  是 | 资源实例的名称 |
| ancestors | array(object) | 否 | 资源的祖先，非必填，对于资源实例可能存在不同拓扑层级且某些操作需要按照拓扑层级鉴权时，该字段则需要填写 |


#### ancestors

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| system | string | 是 | 系统唯一标识 |
| type | string | 是 | 祖先资源类型的唯一标识 |
| id | string | 是 | 祖先资源实例的唯一标识 |


### 请求参数示例

- 无ancestors
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

- 有ancestors
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

### 返回结果示例

```json
{
  "data": [
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

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| action | object | creator被授权对应的Action |
| policy_id | int | creator被授权对应的策略ID |

#### action

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| id    |  string | action id |