### Request method

POST


### request address

/api/c/compapi/v2/cc/list_service_instance/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query the list of service instances according to the business id, or add module id and other information to query

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|---- -------------------|
| bk_biz_id | int | yes | business id |
| bk_module_id | int | no | module ID |
| selectors | int | No | label filter function, operator optional values: `=`,`!=`,`exists`,`!`,`in`,`notin`|
| page | object | No | pagination parameters |
| search_key | string | No | name filter parameter |

#### page

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| start | int | yes | record start position |
| limit | int | yes | limit the number of entries per page, the maximum is 500 |

### Request parameter example

```python

{
  "bk_app_code": "esb_test",
  "bk_app_secret": "xxx",
  "bk_username": "xxx",
  "bk_token": "xxx",
  "bk_biz_id": 1,
  "page": {
    "start": 0,
    "limit": 1
  },
  "bk_module_id": 56,
  "search_key": "",
  "selectors": [{
    "key": "key1",
    "operator": "notin",
    "values": ["value1"]
  },{
    "key": "key1",
    "operator": "in",
    "values": ["value1", "value2"]
  }]
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
    "count": 1,
    "info": [
      {
        "bk_biz_id": 1,
        "id": 72,
        "name": "t1",
        "bk_host_id": 26,
        "bk_module_id": 62,
        "creator": "admin",
        "modifier": "admin",
        "create_time": "2019-06-20T22:46:00.69+08:00",
        "last_time": "2019-06-20T22:46:00.69+08:00",
        "bk_supplier_account": "0"
      }
    ]
  }
}
```

### Return result parameter description

#### response

| Name | Type | Description |
|---|---|---|
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

#### data field description

| Field|Type|Description|Description|
|---|---|---|---|
|count|integer|total number||
|info|array|return result||

#### info field description

| Field|Type|Description|
|---|---|---|
|id|int|service instance ID|
|name|string|service instance name|
|bk_biz_id|int|Business ID|
|bk_module_id|int|module ID|
|bk_host_id|int|host ID|
| creator | string | The creator of this data |
| modifier | string | The person who modified this data last |
| create_time | string | creation time |
| last_time | string | update time |
| bk_supplier_account | string | Supplier account |