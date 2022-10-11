# 资源类型 ResourceType API

### 参数说明

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id | string | 是 | 资源类型 id, 系统下唯一, 只允许小写字母开头、包含小写字母、数字、下划线(_)和连接符(-),最长 32 个字符. |
| name |string | 是 | 资源类型名称，系统下唯一 |
| name_en | string | 是 | 资源类型英文名，国际化时切换到英文版本显示 |
| description |string | 否 | 资源描述 |
| description_en | string | 否 | 资源描述英文，国际化时切换到英文版本显示 |
| parents | Array[Object] | 否 | 资源类型的直接上级，可多个直接上级，可以是自身系统的资源类型或其他系统的资源类型, 可为空列表，不允许重复，数据仅用于权限中心产品上显示|
| provider_config | Object | 是 | 权限中心调用查询资源实例接口的配置文件，与 system.provider_config.host 配合使用 [更多概念说明](./00-Concepts.md) |
| version | int | 否 |  版本号，允许为空，仅仅作为在权限中心上进行 New 的更新提醒  [更多概念说明](./00-Concepts.md)  |

parents 元素参数说明

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system_id | string | 是 | 直接上级资源类型的来源系统 ID |
| id |string | 是 | 直接上级资源类型 ID |

provider_config 内元素 参数：

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| path | string | 是 | 权限中心调用查询资源实例接口的 URL 的 PATH，与 system.provider_config.host 配合使用 |

### 1. 新增 resourceType

限制:
- 一个系统只能创建最多 50 个 resourceType

#### URL

> POST /api/v1/model/systems/{system_id}/resource-types

#### Parameters

| 字段 | 类型 | 是否必须 | 位置 | 描述 |
| :---| :--- | :---|:---|:--- |
| system_id | string | 是 | path | 系统 ID |

#### Request

```json
[
    {
        "id": "biz_set",
        "name": "业务集",
        "name_en": "biz_set",
        "description": "业务集是...",
        "description_en": "biz_set is a ...",
        "parents": [],
        "provider_config": {
            "path": "/api/v1/resources/biz_set/query"
        },
        "version": 1
    },
    {
        "id": "biz",
        "name": "业务",
        "name_en": "biz",
        "description": "业务是...",
        "description_en": "biz is a ...",
        "parents": [
            {"system_id": "bk_cmdb", "id": "biz_set"}            
        ],
        "provider_config": {
            "path": "/api/v1/resources/biz/query"
        },
        "version": 1
    },
    {
        "id": "dir", 
        "name": "目录",
        "name_en": "dir", 
        "description": "目录是...",
        "description_en": "dir is a ...",
        "parents": [
            {"system_id": "bk_cmdb", "id": "biz"}
        ],
        "provider_config": {
            "path": "/api/v1/resources/dir/query"
        },
        "version": 1
    },  
    {
        "id": "set", 
        "name": "集群",
        "name_en": "set", 
        "description": "集群是...",
        "description_en": "set is a ...",
        "parents": [
            {"system_id": "bk_cmdb", "id": "biz"},
            {"system_id": "bk_cmdb", "id": "dir"}
        ],
        "provider_config": {
            "path": "/api/v1/resources/set/query"
        },
        "version": 1
    },
    {
        "id": "module", 
        "name": "模块",
        "name_en": "module", 
        "description": "模块是...",
        "description_en": "module is a ...",
        "parents": [
            {"system_id": "bk_cmdb", "id": "set"}
        ],
        "provider_config": {
            "path": "/api/v1/resources/module/query"
        },
        "version": 1
    },
    {
        "id": "host", 
        "name": "主机",
        "name_en": "host", 
        "description": "主机是...",
        "description_en": "host is a ...",
        "parents": [
            {"system_id": "bk_cmdb", "id": "module"}
        ],
        "provider_config": {
            "path": "/api/v1/resources/host/query"
        },
        "version": 1
    }
]
```

#### Response
```json
{
    "code": 0,
    "message": "",
    "data": {}
}
```

### 2. 修改 resourceType

#### URL

> PUT /api/v1/model/systems/{system_id}/resource-types/{resource_type_id}

#### Parameters

| 字段 | 类型 | 是否必须 | 位置 | 描述 |
| :--- | :--- | :--- |:--- |:--- |
| system_id | string | 是 | path | 系统 ID |
| resource_type_id | string | 是 | path | 资源类型 ID |

#### Request

```json
{
    "name": "业务新",
    "name_en": "biz new",
    "description": "业务新...",
    "description_en": "biz new is ....",
    "provider_config": {
        "path": "/api/v2/resources/biz/query"
    },
    "version": 2
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

### 3. 删除 resourceType

必须同时满足以下两个条件才能成功删除资源类型
1. 该资源类型不作为其他的上级资源，具体遍历所有资源类型的 parents 是否存在该资源类型
2. 该资源类型不作为 Action 的操作对象资源类型，具体遍历所有 Action 的 related_resource_types 是否存在该资源类型

#### URL

批量删除 (需要 Request.Body)

> DELETE /api/v1/model/systems/{system_id}/resource-types

单个删除 (不需要 Request.Body)

> DELETE /api/v1/model/systems/{system_id}/resource-types/{resource_type_id}

#### Parameters

| 字段 | 类型 | 是否必须 | 位置 | 描述 |
| :--- | :---| :--- |:--- |:--- |
| system_id | string | 是 | path | 系统 ID |
| resource_type_id | string | 是 | path | 资源类型 ID |
| check_existence | boolean | 否 | query | 默认会检查 id 存在, 不存在将导致删除失败,  设置 false 不检查 id 是否存在, 直接走删除(`delete from table where id in []`)  |

#### Request

```json
[
    {
        "id": "biz"
    },
    {
        "id": "set"
    }
]
```

#### Response
```json
{
    "code": 0,
    "message": "",
    "data": {}
}
```