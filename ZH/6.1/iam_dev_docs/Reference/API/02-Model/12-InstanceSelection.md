# 实例视图 InstanceSelection API

### 参数说明

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id | string | 是 | 实例视图 id, 系统下唯一, 只允许小写字母开头、包含小写字母、数字、下划线(_)和连接符(-),最长 32 个字符. |
| name |string | 是 | 实例视图名称，系统下唯一 |
| name_en | string | 是 | 实例视图的英文名，国际化时切换到英文版本显示，系统下唯一 |
|  is_dynamic | bool | 否 | 是否是动态拓扑视图，`默认为false`，[更多概念说明](./00-Concepts.md)  |
| resource_type_chain | Array(Object) | 是 | 资源类型的层级链路 |

resource_type_chain 里的元素 

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system_id | string | 是 | 资源类型的来源系统 ID |
| id |string | 是 | 资源类型 ID |

### 1. 新增 instanceSelection

限制:
- 一个系统只能创建最多 50 个 instanceSelection


#### URL

> POST /api/v1/model/systems/{system_id}/instance-selections

#### Parameters

| 字段 | 类型 | 是否必须 | 位置 | 描述 |
| :--- | :---| :--- |:--- |:--- |
| system_id | string | 是 | path | 系统 ID |

#### Request
```json
[
    {
		"id": "free_host",
		"name": "空闲主机",
		"name_en": "free host",
		"resource_type_chain": [{
			"system_id": "bk_cmdb",
			"id": "host"
		}]
    },
	{
		"id": "biz_topology",
		"name": "业务拓扑",
		"name_en": "biz topology",
		"resource_type_chain": [{
				"system_id": "bk_cmdb",
				"id": "biz"
			},
			{
				"system_id": "bk_cmdb",
				"id": "set"
			},
			{
				"system_id": "bk_cmdb",
				"id": "module"
			},
			{
				"system_id": "bk_cmdb",
				"id": "host"
			}
		]
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

### 2. 修改 instanceSelection

#### URL

> PUT /api/v1/model/systems/{system_id}/instance-selections/{instance_selection_id}

#### Parameters

| 字段 | 类型 | 是否必须 | 位置 | 描述 |
| :--- | :--- | :--- |:---|:--- |
| system_id | string | 是 | path | 系统 ID |
| instance_selection_id | string | 是 | path | 实例视图 ID |

#### Request

```json
{
	"id": "free_host1",
	"name": "空闲主机1",
	"name_en": "free host1",
	"resource_type_chain": [{
		"system_id": "bk_cmdb",
		"id": "host"
	}]
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

### 3. 删除 instanceSelection

必须满足以下条件才能成功删除实例视图:
1. 该实例视图没有被本系统的 Action 关联资源操作引用，具体遍历所有 Action 的 related_resource_types 中的 related_instance_selections 是否存在该实例视图

#### URL

批量删除 (需要 Request.Body)

> DELETE  /api/v1/model/systems/{system_id}/instance-selections

单个删除 (不需要 Request.Body)

> DELETE /api/v1/model/systems/{system_id}/instance-selections/{instance_selection_id}

#### Parameters
|字段 |类型 |是否必须 |位置 |描述 |
| :---| :--- | :---|:---|:---|
| system_id | string | 是 | path | 系统 ID |
| instance_selection_id | string | 是 | path | 实例视图 ID |
|check_existence |boolean |否 |query |默认会检查 id 存在, 不存在将导致删除失败, 设置 false 不检查 id 是否存在, 直接走删除( `delete from table where id in []` ) |

#### Request

```json
[
    {
        "id": "free_host"
    },
    {
        "id": "biz_topology"
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
