### Request method

POST


### request address

/api/c/compapi/v2/cc/search_inst_asst_object_inst_base_info/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query the basic information of an instance-associated model instance

### Request parameters




#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| fields | array | No | Specifies the field to query. The parameter is any attribute of the business. If you do not fill in the field information, the system will return all the fields of the business |
| condition | object | no | query condition|
| page | object | no | pagination condition |

#### condition

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_obj_id | string | yes | instance model ID |
| bk_inst_id| int | is | instance ID |
|association_obj_id|string| is | the model ID of the association object, and returns the basic data of the instance associated with the bk_inst_id instance of the association_obj_id model (bk_inst_id, bk_inst_name)|
|is_target_object| bool | No |bk_obj_id is the target model, the default is false, the source model in the association relationship, otherwise it is the target model|

#### page

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| start | int | No | Record start position, default value 0|
| limit | int | No | limit the number of items per page, the default value is 20, the maximum is 200 |


### Request parameter example

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "condition": {
        "bk_obj_id":"bk_switch", 
		"bk_inst_id":12, 
		"association_obj_id":"host", 
		"is_target_object":true 
    },
    "page": {
        "start": 0,
        "limit": 10
    }
}
```

### Return result example

```python

{
    "result": true,
    "code": 0,
    "message": "success",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": {
        "count": 4,
        "info": [
            {
                "bk_inst_id": 1,
                "bk_inst_name": "127.0.0.3"
            }
        ]
    }
}
```

### Return result parameter description
#### response

| Name | Type | Description |
| ------- | ------ | ---------------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data

| Name | Type | Description |
|---|---|---|
| count| int| number of records |
| info| object array | The model ID of the associated object, the instance basic data of the instance associated model (bk_inst_id, bk_inst_name) |
| page| object|page information|

#### data.info field description
| Name | Type | Description |
|---|---|---|
| bk_inst_id | int | instance ID |
| bk_inst_name | string | instance name |

##### data.info.bk_inst_id, data.info.bk_inst_name field description

Values corresponding to different models bk_inst_id, bk_inst_name

| model | bk_inst_id | bk_inst_name |
|---|---|---|
|Business | bk_biz_id | bk_biz_name|
|cluster | bk_set_id | bk_set_name|
|module | bk_module_id | bk_module_name|
|process | bk_process_id | bk_process_name|
|host | bk_host_id | bk_host_inner_ip|
|General model | bk_inst_id | bk_inst_name|