
### Request method

GET


### request address

/api/c/compapi/v2/cc/search_biz_inst_topo/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Querying the Topology of a Service Instance

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_supplier_account | string | No | Supplier account |
| bk_biz_id | int | yes | business id |
| level | int | No | The hierarchical index of the topology, the index value starts from 0, the default value is 2, when it is set to -1, it will read the complete business instance topology |

### Request parameter example

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "123456789",
    "bk_biz_id": 1,
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
    "data": [
        {
            "bk_inst_id": 2,
            "bk_inst_name": "blueking",
            "bk_obj_id": "biz",
            "bk_obj_name": "business",
            "default": 0,
            "child": [
                {
                    "bk_inst_id": 3,
                    "bk_inst_name": "job",
                    "bk_obj_id": "set",
                    "bk_obj_name": "set",
                    "default": 0,
                    "child": [
                        {
                            "bk_inst_id": 5,
                            "bk_inst_name": "job",
                            "bk_obj_id": "module",
                            "bk_obj_name": "module",
                            "child": []
                        }
                    ]
                }
            ]
        }
    ]
}
```

### Return result parameter description
#### response

| Name | Type | Description |
| ------- | ------ | ---------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| data | object | the data returned by the request |
| permission | object | permission information |
| request_id | string | request chain id |


#### data

| Field | Type | Description |
|-----------|-----------|-----------|
| bk_inst_id | int | instance ID |
| bk_inst_name | string | The name of the instance for display |
| bk_obj_icon | string | the name of the model icon |
| bk_obj_id | string | model ID |
| bk_obj_name | string | The name of the model for display |
| child | array | collection of all instances under the current node |
|default | int | indicates business type |

#### child

| Field | Type | Description |
|-----------|-----------|-----------|
| bk_inst_id | int | instance ID |
| bk_inst_name | string | The name of the instance for display |
| bk_obj_icon | string | the name of the model icon |
| bk_obj_id | string | model ID |
| bk_obj_name | string | The name of the model for display |
| child | array | collection of all instances under the current node |
| default | int | 0 - common cluster, 1 - built-in module collection, default is 0 |