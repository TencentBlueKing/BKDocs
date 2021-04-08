# 操作组 ActionGroup API

### 参数说明
| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| name |string | 是 | 操作组名称  |
| name_en | string | 是 | 操作组英文名，国际化时切换到英文版本显示 |
| actions | Array(Object) | 否 | 操作列表 |
| sub_groups | Array(Object) | 否 | 下一级操作组 |

注意:

1. 最多`两级`操作组(即第一级`sub_gropus`下的操作组不能有下一级`sub_groups`), 如果嵌套超过两级, 会返回错误 `1901400(more than 2-levels action_group, current only support 2-levels)` 
2. 同一个操作组的`actions`和`sub_groups` 不能同时为空 `1901400(actions and sub_groups can't be empty at the same time)`
3. action 可以挂在一级或二级的`操作组`上, 但是, 同一个 action 只能挂在一个`一级操作组`/`二级操作组`下; 即, action_id 全局 json 内唯一;   `1901400(one action can belong only one group)` 
4. 会校验每一个`action_id`; 必须是系统注册的合法`action_id`; 所以使用接口调用注册或者使用 migration 注册时, `action_id`对应的操作必须先注册, 再更新`action_groups`


### 1. 注册或更新 操作组

#### URL

注册
> POST /api/v1/model/systems/{system_id}/configs/action_groups

更新 (整个列表完全覆盖更新)
> PUT /api/v1/model/systems/{system_id}/configs/action_groups

#### Parameters

| 字段 | 类型 | 是否必须 | 位置 | 描述 |
| :--- | :--- | :--- |:--- |:--- |
| system_id | string | 是 | path | 系统 ID |

#### Request

```json
[
	{
		"name": "管理权限",
		"name_en": "Admin Permissions",
		"actions": [
			{
				"id": "create_biz"
			},
			{
				"id": "delete_biz"
			}
		]
	},
	{
		"name": "运维",
		"name_en": "Devops Permissions",
		"sub_groups": [
			{
				"name": "主机权限",
				"name_en": "Host Permissions",
				"actions": [
					{
						"id": "view_host"
					},
					{
						"id": "create_host"
					}
				]
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