
### Request method

POST


### request address

/api/c/compapi/v2/cc/list_biz_hosts_topo/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query the host and topology information under the business according to the business ID, and filter information of clusters, modules and hosts can be added

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| ---------------------- | ------ | ---- | ---- |
| page | object | yes | pagination query condition, the returned host data is sorted by bk_host_id |
| bk_biz_id | int | yes | business id |
| set_property_filter | object | No | Cluster attribute combination query conditions |
| module_property_filter | object | No | Module attribute combination query conditions |
| host_property_filter | object | No | Host attribute combination query conditions |
| fields | array | yes | host attribute list, which controls which fields are in the host that returns the result, which can speed up interface requests and reduce network traffic transmission |

#### set_property_filter
This parameter is a combination of filtering rules of the cluster attribute field, which is used to search for hosts under the cluster according to the cluster attribute field. Combination supports both AND and OR, and can be nested up to 2 levels.
Filtering rules are four-tuple `field`, `operator`, `value`

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| condition | string | No | Combined query conditions|
| rules | array | no | rules |


#### rules
| Name | Type | Required | Default | Description | Description |
| -------- | ------ | ---- | ------ | ------ | -------- |
| field | string | yes | no | field name | |
| operator | string | yes | none | operator | optional values equal,not_equal,in,not_in,less,less_or_equal,greater,greater_or_equal,between,not_between |
| value | - | No | None | Operands | Different operators correspond to different value formats |

Assembly rules can refer to: <https://github.com/Tencent/bk-cmdb/blob/master/src/common/querybuilder/README.md>

#### module_property_filter
This parameter is a combination of filtering rules of the module attribute field, which is used to search for hosts under the module according to the module attribute field. Combination supports both AND and OR, and can be nested up to 2 levels.
Filtering rules are four-tuple `field`, `operator`, `value`

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| condition | string | No | Combined query conditions|
| rules | array | no | rules |


#### rules

| Name | Type | Required | Default | Description | Description |
| -------- | ------ | ---- | ------ | ------ | -------- |
| field | string | yes | no | field name | |
| operator | string | yes | none | operator | optional values equal,not_equal,in,not_in,less,less_or_equal,greater,greater_or_equal,between,not_between |
| value | - | No | None | Operands | Different operators correspond to different value formats |

Assembly rules can refer to: <https://github.com/Tencent/bk-cmdb/blob/master/src/common/querybuilder/README.md>

####host_property_filter
This parameter is a combination of filtering rules for host attribute fields, which is used to search for hosts based on host attribute fields. Combination supports both AND and OR, and can be nested up to 2 levels.
Filtering rules are four-tuple `field`, `operator`, `value`

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| condition | string | No | Combined query conditions|
| rules | array | no | rules |


#### rules

| Name | Type | Required | Default | Description | Description |
| -------- | ------ | ---- | ------ | ------ | ---------------------- |
| field | string | yes | no | field name | field name |
| operator | string | yes | none | operator | optional values equal,not_equal,in,not_in,less,less_or_equal,greater,greater_or_equal,between,not_between |
| value | - | No | None | Operands | Different operators correspond to different value formats |

Assembly rules can refer to: <https://github.com/Tencent/bk-cmdb/blob/master/src/common/querybuilder/README.md>

#### page

| Field | Type | Required | Description |
| ----- | ---- | ---- | -------------------- |
| start | int | yes | record start position |
| limit | int | yes | limit the number of entries per page, the maximum is 500 |



### Request parameter example
```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "bk_supplier_account": "0",
    "page": {
        "start": 0,
        "limit": 10
    },
    "bk_biz_id": 3,
    "fields": [
        "bk_host_id",
        "bk_cloud_id",
        "bk_host_innerip",
        "bk_os_type",
        "bk_mac"
    ],
    "set_property_filter": {
        "condition": "AND",
        "rules": [
            {
                "field": "bk_set_name",
                "operator": "not_equal",
                "value": "test"
            },
            {
                "condition": "OR",
                "rules": [
                    {
                        "field": "bk_set_id",
                        "operator": "in",
                        "value": [
                            1,
                            2,
                            3
                        ]
                    },
                    {
                        "field": "bk_service_status",
                        "operator": "equal",
                        "value": "1"
                    }
                ]
            }
        ]
    },
    "module_property_filter": {
        "condition": "OR",
        "rules": [
            {
                "field": "bk_module_name",
                "operator": "equal",
                "value": "test"
            },
            {
                "condition": "AND",
                "rules": [
                    {
                        "field": "bk_module_id",
                        "operator": "not_in",
                        "value": [
                            1,
                            2,
                            3
                        ]
                    },
                    {
                        "field": "bk_module_type",
                        "operator": "equal",
                        "value": "1"
                    }
                ]
            }
        ]
    },
    "host_property_filter": {
        "condition": "AND",
        "rules": [
            {
                "field": "bk_host_innerip",
                "operator": "equal",
                "value": "127.0.0.1"
            },
            {
                "condition": "OR",
                "rules": [
                    {
                        "field": "bk_os_type",
                        "operator": "not_in",
                        "value": [
                            "3"
                        ]
                    },
                    {
                        "field": "bk_cloud_id",
                        "operator": "equal",
                        "value": 0
                    }
                ]
            }
        ]
    }
}
```

### return result example
```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "permission": null,
    "request_id": "e43da4ef221746868dc4c837d36f3807",
    "data": {
        "count": 3,
        "info": [
            {
                "host": {
                    "bk_cloud_id": 0,
                    "bk_host_id": 1,
                    "bk_host_innerip": "192.168.15.18",
                    "bk_mac": "",
                    "bk_os_type": null
                },
                "topo": [
                    {
                        "bk_set_id": 11,
                        "bk_set_name": "set1",
                        "module": [
                            {
                                "bk_module_id": 56,
                                "bk_module_name": "m1"
                            }
                        ]
                    }
                ]
            },
            {
                "host": {
                    "bk_cloud_id": 0,
                    "bk_host_id": 2,
                    "bk_host_innerip": "192.168.15.4",
                    "bk_mac": "",
                    "bk_os_type": null
                },
                "topo": [
                    {
                        "bk_set_id": 11,
                        "bk_set_name": "set1",
                        "module": [
                            {
                                "bk_module_id": 56,
                                "bk_module_name": "m1"
                            }
                        ]
                    }
                ]
            },
            {
                "host": {
                    "bk_cloud_id": 0,
                    "bk_host_id": 3,
                    "bk_host_innerip": "192.168.15.12",
                    "bk_mac": "",
                    "bk_os_type": null
                },
                "topo": [
                    {
                        "bk_set_id": 10,
                        "bk_set_name": "free machine pool",
                        "module": [
                            {
                                "bk_module_id": 54,
                                "bk_module_name": "idle machine"
                            }
                        ]
                    }
                ]
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


#### data

| Field | Type | Description |
| ----- | ----- | ------------------ |
| count | int | number of records |
| info | array | host data and topology information |

#### data.info
| Field | Type | Description |
| ---- | ----- | ------------ |
| host | dict | actual host data |
| topo | array | host topology information |

#### data.info.host
| Name | Type | Description | Description |
| ---------------- | ------ | ------------- | --------------------------- |
| bk_os_type | string | operating system type | 1:Linux;2:Windows;3:AIX | |
| bk_mac | string | intranet MAC address | | | |
| bk_host_innerip | string | Inner IP | |
| bk_host_id | int | host ID | |
| bk_cloud_id | int | cloud region | |

#### data.info.topo
| Field | Type | Description |
| ----------- | ------ | ------------------------ |
| bk_set_id | int | ID of the cluster to which the host belongs |
| bk_set_name | string | The name of the cluster to which the host belongs |
| module | array | module information of the cluster to which the host belongs |

#### data.info.topo.module
| Field | Type | Description |
| -------------- | ------ | -------- |
| bk_module_id | int | module ID |
| bk_module_name | string | module name |