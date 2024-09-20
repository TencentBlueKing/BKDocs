
### Request method

POST


### request address

/api/c/compapi/v2/cc/search_cloud_area/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query cloud region

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|-----------|
|condition|object|No|Query condition|
| page| object| is |page information|


#### condition
| Field | Type | Required | Description |
|----------------------|------------|--------|-----------|
|bk_cloud_id|int|no|cloud zone ID|
|bk_cloud_name|string|No|Cloud region name|

#### page field description

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
|start|int|No|Get data offset position|
|limit|int| is the limit on the number of data in the past, it is recommended to be 200|


### Request parameter example

``` python
{

    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "condition": {
        "bk_cloud_id": 12,
        "bk_cloud_name" "aws",
    },
    "page":{
        "start":0,
        "limit":10
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
    "count": 10,
    "info": [
         {
            "bk_cloud_id": 0,
            "bk_cloud_name": "aws",
            "bk_supplier_account": "0",
            "create_time": "2019-05-20T14:59:48.354+08:00",
            "last_time": "2019-05-20T14:59:48.354+08:00"
        },
        .....
    ]

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

| Name | Type | Description |
|---|---|---|
| count| int| number of records |
| info| array | List information of the queried cloud regions |

#### data.info field description
| Name | Type | Description |
|---|---|---|
| bk_cloud_id | int | cloud zone ID |
| bk_cloud_name | string | cloud zone name |
| create_time | string | creation time |
| last_time | string | Last modification time |