### Request method

POST


### request address

/api/c/compapi/v2/cc/list_resource_pool_hosts/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query the hosts in the resource pool

### Request parameters


#### Interface parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| page | dict | no | query condition |
| host_property_filter| object| No| Combination query condition of host property|
| fields | array | yes | host attribute list, which controls which fields are in the host that returns the result, which can speed up interface requests and reduce network traffic transmission |

#### host_property_filter

This parameter is a combination of filtering rules for host attribute fields, which is used to search for hosts based on host attribute fields. Combination supports both AND and OR, and can be nested up to 2 levels.

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| condition | string | no | |
| rules | array | no | rules |

#### rules
Filtering rules are four-tuple `field`, `operator`, `value`

| Name | Type |Required | Default | Description | Description|
| --- | --- | --- |--- | --- | ---|
|field|string|yes|none|field name |field name|
| operator|string|yes|none|operator|optional equal,not_equal,in,not_in,less,less_or_equal,greater,greater_or_equal,between,not_between|
| value| string | No | None | Operands | Different operators correspond to different value formats |

Assembly rules can refer to: <https://github.com/Tencent/bk-cmdb/blob/master/src/common/querybuilder/README.md>



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
    "page": {
        "start": 0,
        "limit": 10,
        "sort": "bk_host_id"
    },
    "fields": [
        "bk_host_id",
        "bk_cloud_id",
        "bk_host_innerip",
        "bk_os_type",
        "bk_mac"
    ],
    "host_property_filter": {
        "condition": "AND",
        "rules": [
        {
            "field": "bk_host_outerip",
            "operator": "equal",
            "value": "127.0.0.1"
        }, {
            "condition": "OR",
            "rules": [{
                "field": "bk_os_type",
                "operator": "not_in",
                "value": ["3"]
            }, {
                "field": "bk_sla",
                "operator": "equal",
                "value": "1"
            }]
        }]
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
        "bk_cloud_id": "0",
        "bk_host_id": 17,
        "bk_host_innerip": "192.168.1.1",
        "bk_mac": "",
        "bk_os_type": "1"
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
| data | array | the data returned by the request |

#### data

| Field | Type | Description |
|-----------|-----------|-----------|
| count | int | number of records |
| info | array | Host actual data |

#### data.info
| Name | Type | Description | Description |
| ---------------- | ------ | ------------- | ----------------------------- |
| bk_os_type | string | operating system type | 1:Linux;2:Windows;3:AIX | |
| bk_mac | string | intranet MAC address | | | |
| bk_host_innerip | string | Inner IP | |
| bk_host_id | int | host ID | |
| bk_cloud_id      | int    | cloud area      |