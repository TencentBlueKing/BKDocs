# 直接鉴权 API

> 中大型系统/平台类系统不要使用这个接口

注意:

- 这个 API 是给非 SDK 接入/无跨系统资源依赖的小型系统/脚本/后台任务使用的.
- 如果是普通接入系统(非脚本/定时任务等)，建议使用多语言 SDK 进行处理
- 使用直接鉴权 API，需要提供完整的信息，所有计算会在服务端完成，此时会同其他所有系统共用计算资源，性能可能不及本地 sdk 计算(本地 sdk 还可以做缓存等行为提升性能)
- 获取某个用户有某个权限的资源列表无法通过此 API 实现; 需要通过策略查询接口查询得到策略，解析表达式后，转换成自身存储的查询条件
- 该接口耗费服务端资源较大，后续会进行流控/熔断/服务降级

## 1. policy auth

### 1.1 URL

> POST /api/v1/policy/auth

### 1.2 Request

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system |string | 是 | 系统唯一标识  |
| subject | string | 是 | subject |
| action | object | 是 | 操作 |
| resources | Array(resource_node) | 是 | 资源实例, 资源类型的顺序必须操作注册时的顺序一致 |

action

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id    |  字符串  | 是   | 操作 ID |

subject

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type    |  字符串  | 是   | 授权对象类型, 当前只支持 user |
| id    |  字符串  | 是   | 授权对象 ID |

resource_node

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system |  字符串  | 是   | 资源系统 ID |
| type |  字符串  | 是   | 资源类型 ID |
| id | 字符串 | 是 | 资源实例 ID |
| attribute | 对象 | 是 | 资源属性 |

```json
{
	"system": "bk_job",
	"subject": {
		"type": "user",
		"id": "admin"
	},
	"action": {
		"id": "execute"
	},
	"resources": [{   // 资源类型的顺序必须操作注册时的顺序一致, 否则会导致鉴权失败!
		"system": "bk_job",
		"type": "job",
		"id": "ping",
		"attribute": {  // 资源的属性值可能有多个, 目前支持string/int/boolean, 以及路径stringList
			"os": "linux",
			"_bk_iam_path_": ["/biz,1/set,2/"],
			"is_ready": true,
			"area_id": 200
		}
	}, {
		"system": "bk_cmdb",
		"type": "host",
		"id": "192.168.1.1",
		"attribute": {} // 外部资源的属性由iam负责查询属性, 接入方不需要传入
	}]
}
```

### 1.3 Response

Response 字段说明, 表格

> Status: 200 OK

```json
{
    "code": 0,
    "message": "ok",
    "data": {
        "allowed": true
    }
}
```

## 2. policy auth by resources

鉴权场景: 查看一个 `用户` 有没有 100 台 `资源A` 的 `编辑`  权限
限制: resources_list 最大能传 100 个资源

### 2.1 URL

> POST /api/v1/policy/auth_by_resources

### 2.2 Request

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system |string | 是 | 系统唯一标识  |
| subject | string | 是 | subject |
| action | object | 是 | 操作 |
| resources_list | Array(resources) | 是 | 资源实例列表, 资源类型的顺序必须操作注册时的顺序一致 |

action

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id    |  字符串  | 是   | 操作 ID |

subject

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type    |  字符串  | 是   | 授权对象类型, 当前只支持 user |
| id    |  字符串  | 是   | 授权对象 ID |

resources

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| resources |  Array(resource_node)  | 是   | 一个资源 |

resource_node

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system |  字符串  | 是   | 资源系统 ID |
| type |  字符串  | 是   | 资源类型 ID |
| id | 字符串 | 是 | 资源实例 ID |
| attribute | 对象 | 是 | 资源属性 |

```json
{
	"system": "bk_job",
	"subject": {
		"type": "user",
		"id": "admin"
	},
	"action": {
		"id": "execute"
	},
	"resources_list": [
		[{   // 第一个资源
			"system": "bk_job",
			"type": "job",
			"id": "ping",
			"attribute": {
				"os": "linux",
				"_bk_iam_path_": ["/biz,1/set,2/"],
				"is_ready": true,
				"area_id": 200
			}
		}, {
			"system": "bk_cmdb",
			"type": "host",
			"id": "192.168.1.1",
			"attribute": {}
		}],
		[{    // 第二个资源
			"system": "bk_job",
			"type": "job",
			"id": "ping2",
			"attribute": {
				"os": "linux",
				"_bk_iam_path_": ["/biz,1/set,2/"],
				"is_ready": true,
				"area_id": 200
			}
		}, {
			"system": "bk_cmdb",
			"type": "host2",
			"id": "192.168.2.2",
			"attribute": {}
		}]
	]
}
```

### 2.3 Response

Response 字段说明, 表格

> Status: 200 OK

```json
{
    "code": 0,
    "message": "ok",
    "data": {
        "bk_job,job,ping/bk_cmdb,host,192.168.1.1": false,
        "bk_job,job,ping2/bk_cmdb,host2,192.168.2.2": false
    }
}
```

## 3. policy auth by actions

鉴权场景: 查看一个`用户`有没有`资源A`的`查看`/`编辑`/`删除`权限
限制: actions 最大能传 10 个操作

### 3.1 URL

> POST /api/v1/policy/auth_by_actions

### 3.2 Request

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system |string | 是 | 系统唯一标识  |
| subject | string | 是 | subject |
| actions | Array(action) | 是 | 操作 |
| resources | Array(resource_node) | 是 | 资源实例, 资源类型的顺序必须操作注册时的顺序一致 |

action

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id    |  字符串  | 是   | 操作 ID |

subject

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type    |  字符串  | 是   | 授权对象类型, 当前只支持 user |
| id    |  字符串  | 是   | 授权对象 ID |

resource_node

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system |  字符串  | 是   | 资源系统 ID |
| type |  字符串  | 是   | 资源类型 ID |
| id | 字符串 | 是 | 资源实例 ID |
| attribute | 对象 | 是 | 资源属性 |

```json
{
	"system": "bk_job",
	"subject": {
		"type": "user",
		"id": "admin"
	},
	"actions": [{
		"id": "execute"
	}, {
		"id": "view"
	}],
	"resources": [{   // 资源类型的顺序必须操作注册时的顺序一致, 否则会导致鉴权失败!
		"system": "bk_job",
		"type": "job",
		"id": "ping",
		"attribute": {  // 资源的属性值可能有多个, 目前支持string/int/boolean, 以及路径stringList
			"os": "linux",
			"_bk_iam_path_": ["/biz,1/set,2/"],
			"is_ready": true,
			"area_id": 200
		}
	}, {
		"system": "bk_cmdb",
		"type": "host",
		"id": "192.168.1.1",
		"attribute": {}  // 外部资源的属性由iam负责查询属性, 接入方不需要传入
	}]
}
```

### 3.3 Response

> Status: 200 OK

```json
{
    "code": 0,
    "message": "ok",
    "data": {
        "execute": true,
        "view": false
    }
}
```
