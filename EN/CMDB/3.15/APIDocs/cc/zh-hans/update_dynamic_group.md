
### request method

POST


### request address

/api/c/compapi/v2/cc/update_dynamic_group/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Update dynamic grouping (V3.9.6)

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_biz_id | int | yes | business ID |
| id | string | yes | primary key ID |
| bk_obj_id | string | No | The target resource object type for dynamic grouping. Currently, it can be host, set. This field and the info field must be provided at the same time when updating the rule |
| info | object | No | General query conditions |
| name | string | no | dynamic group name |

#### info.condition

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_obj_id | string | yes | condition object resource type, info.condition:set,module,host supported by dynamic grouping of host type; info.condition:set supported by dynamic grouping of set type |
| condition | array | yes | query condition |

#### info.condition.condition

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| field | string | is | the field of the object |
| operator | string | is | operator, op value is eq(equal)/ne(not equal)/in(belongs to)/nin(does not belong to) |
| value | object | is | the value corresponding to the field |

### Request parameter example

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
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

### Return result example

```json
{
     "result": true,
     "code": 0,
     "message": "",
     "permission": null,
     "request_id": "e43da4ef221746868dc4c837d36f3807",
     "data": {}
}
```

### Return result parameter description

#### response

| Name | Type | Description |
| ------- | ------ | ------------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |