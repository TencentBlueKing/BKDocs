
### request method

POST


### request address

/api/c/compapi/v2/cc/update_biz_custom_field/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Update business custom model properties

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|---------------------|---------|--------|-------------------------------------------|
| id | int | yes | the record id of the target data |
| bk_biz_id | int | yes | business id |
| description | string | No | Description of the data |
| isonly | bool | No | Indicates uniqueness |
| isreadonly | bool | No | Indicates whether it is read-only |
| isrequired | bool | no | indicates whether it is required |
| bk_property_group | string | No | The name of the field column |
| option | object | No | User-defined content, the stored content and format are determined by the caller, taking digital content as an example ({"min":1,"max":2})|
| bk_property_name | string | No | Model property name, used for display |
| bk_property_type | string | No | The data type of the defined property field used to store data (singlechar, longchar, int, enum, date, time, objuser, singleasst, multiasst, timezone, bool)|
| unit | string | no | unit |
| placeholder | string | no | placeholder |
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
    "id":1,
    "bk_biz_id": 2,
    "description":"test",
    "placeholder":"test",
    "unit":"1",
    "isonly":false,
    "isreadonly":false,
    "isrequired":false,
    "bk_property_group":"default",
    "option":{"min":1,"max":4},
    "bk_property_name":"aaa",
    "bk_property_type":"int",
    "bk_asst_obj_id":"0"
}
```

### Return result example

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": null
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
| data | object | the data returned by the request   |