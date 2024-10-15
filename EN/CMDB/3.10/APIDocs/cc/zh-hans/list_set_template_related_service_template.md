
### Request method

GET


### request address

/api/c/compapi/v2/cc/list_set_template_related_service_template/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

According to the business id and cluster template id, get the service template list of a cluster template under the specified business

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|---------------------|------------|--------|--------------------------|
| set_template_id | int | yes | cluster template ID |
| bk_biz_id | int | yes | business ID |

### Request parameter example

```json
{
  "bk_app_code": "esb_test",
  "bk_app_secret": "xxx",
  "bk_username": "xxx",
  "bk_token": "xxx",
  "set_template_id": 1,
  "bk_biz_id": 3
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
    "data": [
        {
            "bk_biz_id": 3,
            "id": 48,
            "name": "sm1",
            "service_category_id": 2,
            "creator": "admin",
            "modifier": "admin",
            "create_time": "2020-05-15T14:14:57.691Z",
            "last_time": "2020-05-15T14:14:57.691Z",
            "bk_supplier_account": "0"
        },
        {
            "bk_biz_id": 3,
            "id": 49,
            "name": "sm2",
            "": 16,
            "creator": "admin",
            "modifier": "admin",
            "create_time": "2020-05-15T14:19:09.813Z",
            "last_time": "2020-05-15T14:19:09.813Z",
            "bk_supplier_account": "0"
        }
    ]
}
```

### Return result parameter description

| Name | Type | Description |
|---|---|---|
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | array| request returned data |

Data field description:

| Name | Type | Description |
|---|---|---|
| bk_biz_id | int | business ID |
| id | int | service template ID |
| name | string | service template name |
| service_category_id | int | service category ID |
| creator | string | creator |
| modifier | string | Last Modifier |
| create_time | string | creation time |
| last_time | string | update time |
| bk_supplier_account | string | Supplier account |