# 直接鉴权 API v2

## 1. policy auth v2

### 1.1 URL

> POST /api/v2/policy/systems/{system_id}/auth/

### 1.2 Request

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system |path | 是 | 系统唯一标识  |
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

## 2. policy query v2

`说明`: 

`rbac`的表达式是使用`rbac`的权限数据通过表达式转换计算得到, 所以相较于`policy auth v2`的鉴权结果, `policy query v2`返回的表达式可能会有延迟, 预期延迟在30秒~1分钟之间.

实际两个接口同时请求, 鉴权结果可能会不一致; 例如加完权限, 跳往 A 页面鉴权auth有权限, 跳往 B 页面鉴权query无权限, 建议同一个业务操作逻辑的多次鉴权, 建议使用尽量一致的方式(尽量要么都使用auth, 要么都是用query, 不混用)

### 2.1 URL

> POST /api/v2/policy/systems/{system_id}/query/

### 2.2 Request

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system |path | 是 | 系统唯一标识  |
| subject | subject | 是 | 鉴权实体 |
| action | action | 是 | 操作 |
| resources | Array(resource_node) | 是 | 资源实例, 资源类型的顺序必须操作注册时的顺序一致;可以为空列表 |

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
    "subject":
    {
        "type": "user",
        "id": "admin"
    },
    "action": {
        "id": "edit"
    },
    "resources": []
}
```

### 1.3 Response

> Status: 200 OK

```json
{
    "code": 0,
    "message": "ok",
    "data": {  // 条件表达式
        "field": "host.id",
        "op": "any",
        "value": []
    }
}
```
