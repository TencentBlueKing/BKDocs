### request method

POST


### request address

/api/c/compapi/v2/cc/list_service_template/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query the list of service templates according to the business id, and you can add the service category id for further query

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|----------------------|------------|--------|---------------------|
| bk_biz_id | int | yes | business ID |
| service_category_id | int | No | service category ID |
| search | string | No | Query by service template name, default is empty |
| is_exact | bool | No | Whether to exactly match the service template name, the default is No, used with the search parameter, valid when the search parameter is not empty (v3.9.19) |

#### page

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| start | int | yes | record start position |
| limit | int | yes | limit the number of entries per page, the maximum is 500 |
| sort | string | no | sort field |

### Request parameter example

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "service_category_id": 1,
    "search": "test2",
    "is_exact": true,
    "page": {
        "start": 0,
        "limit": 10,
        "sort": "-name"
    }
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
    "data": {
        "count": 1,
        "info": [
            {
                "bk_biz_id": 1,
                "id": 50,
                "name": "test2",
                "service_category_id": 1,
                "creator": "admin",
                "modifier": "admin",
                "create_time": "2019-09-18T20:31:29.607+08:00",
                "last_time": "2019-09-18T20:31:29.607+08:00",
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
|count|int|total number||
|info|array|return result||

#### info field description

| Field|Type|Description|Description|
|---|---|---|---|
|bk_biz_id|int|business id||
|id|int|Service Template ID||
|name|array|service template name||
|service_category_id|integer|service category ID||
|creator|string|creator||
|modifier|string|Modifier||
|create_time|string|creation time||
|last_time|string|repair time||
|bk_supplier_account|string|Supplier ID||