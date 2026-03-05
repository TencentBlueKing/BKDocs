
### request method

POST


### request address

/api/c/compapi/v2/cc/search_subscription/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query event subscription

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
|---------------------|------------|--------|-----------------------------|
| page | object | no | pagination parameters |
| condition | object | no | query condition |

####page

| Field | Type | Required | Description |
|-----------|------------|--------|----------------------|
| start | int | yes | record start position |
| limit | int | yes | limit the number of entries per page, the maximum is 200 |
| sort | string | no | sort field |

#### condition

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| subscription_name |string |yes | This is just sample data and needs to be set as a query field |

### Request parameter example

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account":"0",
    "condition":{
        "subscription_name":"name"
    },
    "page":{
        "start":0,
        "limit":10,
        "sort":"HostName"
    }
}
```

### Return result example

```python
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        "count": 1,
        "info": [
            {
                "subscription_id": 1,
                "subscription_name": "mysubscribe",
                "system_name": "SystemName",
                "callback_url": "http://127.0.0.1:8080/callback",
                "confirm_mode": "httpstatus",
                "confirm_pattern": "200",
                "time_out": 10,
                "subscription_form": "hostcreate",
                "operator": "user",
                "bk_supplier_account": "0",
                "last_time": "2017-09-19 16:57:07",
                "statistics": {
                    "total": 30,
                    "failure": 2
                }
            }
        ]
    }
}
```

### Return result parameter description
#### response

| Name | Type | Description |
| ------- | ------ | ------------------------------------- |
| result | bool | Whether the request was successful or not. true: the request succeeded; false the request failed |
| code | int | Error code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| data | object | the data returned by the request |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | the data returned by the request |


#### data
| Field | Type | Description |
|-------|--------------|------------------|
| count | int | number of records |
| info | object array | detailed list of event subscriptions |

####info
| Field | Type | Description |
|--------------------|-----------|----------------------------------------------|
| subscription_id | int | subscription ID |
| subscription_name | string | subscription name |
| system_name | string | system name |
| callback_url | string | callback URL |
| confirm_mode | string | callback success confirmation mode, optional: httpstatus, regular |
| confirm_pattern | string | callback success flag |
| subscription_form | string | subscription form, separated by "," |
| timeout | int | timeout time, unit: second |
| operator | int | The person who updated this data last |
| last_time | int | update time |
| statistics.total | int | total number of pushes |
| statistics.failure | int | push failure count |