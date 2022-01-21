### 功能描述

更新动态分组 (V3.9.6)

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code   | string | 是 | 应用 ID     |
| bk_app_secret | string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token      | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username   | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_biz_id |  int     | 是     | 业务 ID |
| id        |  string  | 是     | 主键 ID |
| bk_obj_id |  string  | 否     | 动态分组的目标资源对象类型, 目前可以为 host,set.更新规则时需同时提供该字段和 info 两个字段 |
| info      |  object  | 否     | 通用查询条件 |
| name      |  string  | 否     | 动态分组名称 |

#### info.condition

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_obj_id |  string   | 是     | 条件对象资源类型, host 类型的动态分组支持的 info.conditon:set,module,host；set 类型的动态分组支持的 info.condition:set |
| condition |  array    | 是     | 查询条件 |

#### info.condition.condition

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| field     |  string    | 是     | 对象的字段 |
| operator  |  string    | 是     | 操作符, op 值为 eq(相等)/ne(不等)/in(属于)/nin(不属于) |
| value     |  object    | 是     | 字段对应的值 |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "id": "XXXXXXXX",
    "bk_obj_id": "host",
    "name": "my-dynamic-group",
    "info": {
    	"condition":[
    		{
    			"bk_obj_id":"set",
    			"condition":[
    				{
    					"field":"default",
    					"operator":"$ne",
    					"value":1
    				}
    			]
    		},
    		{
    			"bk_obj_id":"module",
    			"condition":[
    				{
    					"field":"default",
    					"operator":"$ne",
    					"value":1
    				}
    			]
    		},
    		{
    			"bk_obj_id":"host",
    			"condition":[
    				{
    					"field":"bk_host_innerip",
    					"operator":"$eq",
    					"value":"127.0.0.1"
    				}
    			]
    		}
    	]
    }
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "",
    "data": {}
}
```
