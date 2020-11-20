
### 请求地址

/api/c/compapi/v2/iam/authorization/resource_creator_action_attribute/



### 请求方法

POST


### 功能描述

新建关联资源属性授权接口

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
| system | string | 是 系统唯一标识 |
| type | string | 是 | 资源类型的唯一标识 |
| creator | string | 是 | 资源实例的创建者 |
| attributes | array(object) | 是 |资源属性列表，多个属性之间的权限逻辑是 AND |


#### attributes

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| id | string | 是 | 资源属性的唯一标识 |
| name | string | 是 | 资源属性的名称 |
| values | array(object) | 是 | 资源属性的值，支持多个值，多个值之间的权限逻辑是 OR |


#### values

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| id | string | 是 | 资源属性值的唯一标识 |
| name | string | 是 | 资源属性值的名称 |


### 请求参数示例

```json
{
    "system": "bk_sops",
    "type":"task",
    "creator":"admin",
    "attributes": [
        {
            "id":"owner",
            "name":"任务所属者",
            "values": [
                {
                    "id": "admin",
                    "name": "admin(管理员)"
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
| action | object | creator 被授权对应的 Action |
| policy_id | int | creator 被授权对应的策略 ID |

#### action

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| id    |  string | action id |