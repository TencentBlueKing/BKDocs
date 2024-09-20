
### Request method

POST


### request address

/api/c/compapi/v2/cc/search_object_attribute/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Object model attributes can be queried by model id or business id through optional parameters

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|---------------------|------------|--------|----------------------------|
|bk_obj_id | string | no | model ID |
| bk_biz_id | int | No | business id, after setting, the query result includes business custom fields |


### Request parameter example

``` python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_obj_id": "test",
    "bk_biz_id": 2
}
```


### Return result example

```python

{
    "result": true,
    "code": 0,
    "message": "",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": [
       {
           "bk_biz_id": 0,
           "bk_asst_obj_id": "",
           "bk_asst_type": 0,
           "create_time": "2018-03-08T11:30:27.898+08:00",
           "creator": "cc_system",
           "description": "",
           "editable": false,
           "id": 51,
           "isapi": false,
           "isonly": true,
           "ispre": true,
           "isreadonly": false,
           "isrequired": true,
           "last_time": "2018-03-08T11:30:27.898+08:00",
           "bk_obj_id": "process",
           "option": "",
           "placeholder": "",
           "bk_property_group": "default",
           "bk_property_group_name": "basic information",
           "bk_property_id": "bk_process_name",
           "bk_property_index": 0,
           "bk_property_name": "process name",
           "bk_property_type": "singlechar",
           "bk_supplier_account": "0",
           "unit": ""
       },
       {
            "bk_biz_id": 2,
            "id": 7,
            "bk_supplier_account": "0",
            "bk_obj_id": "process",
            "bk_property_id": "biz_custom_field",
            "bk_property_name": "Business custom fields",
            "bk_property_group": "biz_custom_group",
            "bk_property_index": 4,
            "unit": "",
            "placeholder": "",
            "editable": true,
            "ispre": true,
            "isrequired": false,
            "isreadonly": false,
            "isonly": false,
            "bk_issystem": false,
            "bk_isapi": false,
            "bk_property_type": "singlechar",
            "option": "",
            "description": "",
            "creator": "admin",
            "create_time": "2020-03-25 17:12:08",
            "last_time": "2020-03-25 17:12:08",
            "bk_property_group_name": "business custom group"
       }
   ]
}
```

### Return result parameter description
#### response

| Name | Type | Description |
| ------- | ------ | ----------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data

| Field | Type | Description |
|---------------------|--------------|-------------|
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
| create_time | string | creation time |
| last_time | string | update time |
| id | int | id value of query object |

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