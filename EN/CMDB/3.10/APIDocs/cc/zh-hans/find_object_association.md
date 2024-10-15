
### Request method

POST


### request address

/api/c/compapi/v2/cc/find_object_association/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query the relationship between instances of the model.

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|--------------------------|
| condition | string map | Yes | query condition |


condition params

| Field | Type | Required | Description |
|---------------------|------------|--------|-------------------------|
| bk_asst_id | string | Yes | The unique id of the model's association type|
| bk_obj_id | string | Yes | source model id|
| bk_asst_id | string | Yes | target model id|


### Request parameter example

``` json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "condition": {
        "bk_asst_id": "belong",
        "bk_obj_id": "bk_switch",
        "bk_asst_obj_id": "bk_host"
    }
}
```

### return result example

```json
{
    "result": true,
    "code": 0,
    "message": "",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": [
        {
           "id": 27,
           "bk_supplier_account": "0",
           "bk_obj_asst_id": "test1_belong_biz",
           "bk_obj_asst_name": "1",
           "bk_obj_id": "test1",
           "bk_asst_obj_id": "biz",
           "bk_asst_id": "belong",
           "mapping": "n:n",
           "on_delete": "none",
           "ispre": null
        }
    ]
}

```


### Return result parameter description
#### response
| Name | Type | Description |
| ------- | ------ | ------------------------------------ |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data

| Field | Type | Description |
|------------|----------|--------------|
| id|int64|identity id of the model relationship|
| bk_obj_asst_id| string| The unique id of the model association.|
| bk_obj_asst_name| string| The alias of the association relationship. |
| bk_asst_id| string| association type id|
| bk_obj_id| string| source model id|
| bk_asst_obj_id| string| target model id|
| mapping| string| The mapping relationship between the source model and the target model association relationship instance, which can be one of the following [1:1, 1:n, n:n] |
| on_delete| string| The action when deleting the relationship, the value is one of the following [none, delete_src, delete_dest], "none" does nothing, "delete_src" deletes the instance of the source model, "delete_dest" deletes the target An instance of the model.|
| bk_supplier_account | string | Supplier account |
| ispre | bool | true: preset field, false: non-built-in field |