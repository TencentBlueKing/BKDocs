
### Request method

POST


### request address

/api/c/compapi/v2/cc/find_module_host_relation/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query the relationship between the host and the module according to the module ID (v3.8.7)

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| ------------- | ------------ | ---- | ---------------------------------------------- |
| bk_biz_id | int | yes | business ID |
| bk_module_ids | array | yes | module ID array, up to 200 |
| module_fields | array | yes | module attribute list, control which fields are in the module that returns the result |
| host_fields | array | yes | host attribute list, control which fields are in the host that returns the result |
| page | object | yes | pagination parameters |

#### page

| Field | Type | Required | Description |
| ----- | ---- | ---- | --------------------- |
| start | int | No | Record start position, default value 0 |
| limit | int | yes | limit the number of entries per page, the maximum is 1000 |

**Note: The host relationship under a module may be split and returned multiple times, and the paging method is sorted by host ID. **

### Request parameter example

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "bk_module_ids": [
        1,
        2,
        3
    ],
    "module_fields": [
        "bk_module_id",
        "bk_module_name"
    ],
    "host_fields": [
        "bk_host_innerip",
        "bk_host_id"
    ],
    "page": {
        "start": 0,
        "limit": 500
    }
}
```

### 返回结果示例

```json
{
  "result": true,
  "code": 0,
  "message": "success",
  "permission": null,
  "request_id": "e43da4ef221746868dc4c837d36f3807",
  "data": {
    "count": 2,
    "relation": [
      {
        "host": {
          "bk_host_id": 1,
          "bk_host_innerip": "127.0.0.1",
        },
        "modules": [
          {
            "bk_module_id": 1,
            "bk_module_name": "m1",
          },
          {
            "bk_module_id": 2,
            "bk_module_name": "m2",
          }
        ]
      },
      {
        "host": {
          "bk_host_id": 2,
          "bk_host_innerip": "127.0.0.2",
        },
        "modules": [
          {
            "bk_module_id": 3,
            "bk_module_name": "m3",
          }
        ]
      }
    ]
  }
}
```

### Return result parameter description

| Name | Type | Description |
| ------- | ------ | ------------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |

Data field description:

| Name | Type | Description |
| -------- | ------------ | ------------------ |
| count | int | number of records |
| relation | array | host and module actual data |


relation field description:

| Name | Type | Description |
| ------- | ------------ | ------------------ |
| host | object | host data |
| modules | array | module information of the host |