### Request method

POST


### request address

/api/c/compapi/v2/cc/search_object_topo/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query generic model topology by object model's taxonomy ID

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|---------------------------------------------|
| bk_classification_id |string |yes | The classification ID of the object model, which can only be named with English letter sequences |


### Request parameter example

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_classification_id": "test"
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
           "arrows": "to",
           "from": {
               "bk_classification_id": "bk_host_manage",
               "bk_obj_id": "host",
               "bk_obj_name": "host",
               "position": "{\"bk_host_manage\":{\"x\":-357,\"y\":-344},\"lhmtest\":{\"x\":163,\"y\":75}}",
               "bk_supplier_account": "0"
           },
           "label": "switch_to_host",
           "label_name": "",
           "label_type": "",
           "to": {
               "bk_classification_id": "bk_network",
               "bk_obj_id": "bk_switch",
               "bk_obj_name": "switch",
               "position": "{\"bk_network\":{\"x\":-172,\"y\":-160}}",
               "bk_supplier_account": "0"
           }
        }
   ]
}
```

### Return result parameter description
#### response

| Name | Type | Description |
| ------- | ------ | ------------------------------------------ |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data

| Field | Type | Description |
|------------|-----------|------------------------------------|
| arrows | string | value to (one-way) or to,from (two-way) |
| label_name | string | the name of the relationship |
| label | string | Indicates which field the From is associated with the To |
| from | string | The English id of the object model, the originator of the topology relationship |
| to | string | The English ID of the object model, the termination party of the topology relationship |

#### from, to
| Field | Type | Description |
|------------|-----------|------------------------------------|
|bk_classification_id|string|Classification ID/
| bk_obj_id | string | model id |
| bk_obj_name |string | model name |
| bk_supplier_account | string | Supplier account |
| position | json object string | Coordinates for front-end display /