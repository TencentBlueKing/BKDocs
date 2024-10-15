### Request method

POST


### request address

/api/c/compapi/v2/cc/create_object_attribute/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Create model properties

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------------------|------------|--------|---------------------------------------------------|
| creator | string | No | the creator of the data |
| description | string | No | Description of the data |
| editable | bool | No | indicates whether the data is editable |
| isonly | bool | No | Indicates uniqueness |
| ispre | bool | No | true: preset field, false: non-built-in field |
| isreadonly | bool | No | true: read only, false: not read only |
| isrequired | bool | No | true: required, false: optional |
| option | string | No |User-defined content, the stored content and format are determined by the caller, taking the number type as an example ({"min":"1","max":"2"})|
| unit | string | No | unit |
| placeholder | string | No | placeholder |
| bk_property_group | string | No | The name of the field column |
| bk_obj_id | string | yes | model ID |
| bk_property_id | string | yes | property ID of the model |
| bk_property_name | string | yes | model property name, used for display |
| bk_property_type | string | Yes | The data type of the defined property field used to store data, and the range of possible values (singlechar, longchar, int, enum, date, time, objuser, singleleasst, multiasst, timezone, bool)|
| bk_asst_obj_id | string | No | If there are other models associated, then this field must be set, otherwise it does not need to be set |

#### bk_property_type

| Logo | Name |
|------------|----------|
| singlechar | short character |
| longchar | long character |
| int | integer |
| enum | enumeration type |
| date | date |
| time | time |
| objuser | user |
| singleasst | single association |
| multiasst | multi-association |
| timezone | time zone |
| bool | Boolean |

### Request parameter example

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "creator": "user",
    "description": "test",
    "editable": true,
    "isonly": false,
    "ispre": false,
    "isreadonly": false,
    "isrequired": false,
    "option": {"min":"1","max":"2"},
    "unit": "1",
    "placeholder": "test",
    "bk_property_group": "default",
    "bk_obj_id": "cc_test_inst",
    "bk_property_id": "cc_test",
    "bk_property_name": "cc_test",
    "bk_property_type": "singlechar",
    "bk_asst_obj_id": "test"
}
```


### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
	"data": {
		"id": 7,
		"bk_supplier_account": "0",
		"bk_obj_id": "cc_test_inst",
		"bk_property_id": "cc_test",
		"bk_property_name": "cc_test",
		"bk_property_group": "default",
		"bk_property_index": 4,
		"unit": "1",
		"placeholder": "test",
		"editable": true,
		"ispre": false,
		"isrequired": false,
		"isreadonly": false,
		"isonly": false,
		"bk_issystem": false,
		"bk_isapi": false,
		"bk_property_type": "singlechar",
		"option": "",
		"description": "test",
		"creator": "user",
		"create_time": "2020-03-25 17:12:08",
		"last_time": "2020-03-25 17:12:08",
		"bk_property_group_name": "default"
	}
}
```

### Return result parameter description
#### response

| Name | Type | Description |
| ------- | ------ | --------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data

| Field | Type | Description |
|---------------------|--------------|-----------------------------------------------------------|
| creator | string | Creator of the data |
| description | string | Data description |
| editable | bool | indicates whether the data is editable |
| isonly | bool | indicates uniqueness |
| ispre | bool | true: preset field, false: non-built-in field |
| isreadonly | bool | true: read only, false: not read only |
| isrequired | bool | true: required, false: optional |
| option | string | User-defined content, the stored content and format are determined by the caller |
| unit | string | unit |
| placeholder | string | placeholder |
| bk_property_group | string | name of the field column |
| bk_obj_id | string | model ID |
| bk_supplier_account | string | Supplier account |
| bk_property_id | string | property ID of the model |
| bk_property_name | string | model property name, used for display |
| bk_property_type | string | The data type of the defined property field used to store data (singlechar, longchar, int, enum, date, time, objuser, singleleasst, multiasst, timezone, bool)|
| bk_asst_obj_id | string | If there are other models associated, then this field must be set, otherwise it does not need to be set |
| bk_biz_id | int | business id of the business custom field |
| bk_asst_obj_id | string | If there are other models associated, then this field must be set, otherwise it does not need to be set |
| bk_property_group_name | string | name of the field column |

#### bk_property_type

| Logo | Name |
|------------|----------|
| singlechar | short character |
| longchar | long character |
| int | integer |
| enum | enumeration type |
| date | date |
| time | time |
| objuser | user |
| singleasst | single association |
| multiasst | multi-association |
| timezone | time zone |
| bool | Boolean |