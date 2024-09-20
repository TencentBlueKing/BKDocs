
### Request method

POST


### request address

/api/c/compapi/v2/cc/find_instassociation_with_inst/


### General parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | The security key (application TOKEN), which can be obtained through the BlueKing Zhiyun Developer Center -> click on the application ID -> basic information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | Username of the current user, which is an application in the whitelist of the application-free login authentication, use this field to specify the current user |


### Function Description

Query the relationship between model instances, and optionally return the details of the source model instance and the target model instance (v3.10.11+)

### Request parameters



#### Interface parameters

| parameter | type | required | description |
| --------- | ---- | ---- | -------- |
| condition | map | is | query parameter |
| page | map | yes | pagination condition |

**condition**

| parameter | type | required | description |
| :---------- | ----- | ---- | ------------------------------------ |
| asst_filter | map | yes | query association filter |
| asst_fields | array | No | The content that needs to be returned by the association relationship, return all if not filled |
| src_fields | array | No | The attributes that need to be returned from the source model, return all if not filled |
| dst_fields | array | No | The attributes that the target model needs to return, return all if not filled |
| src_detail | bool | No | If not filled, the default is false, and the instance details of the source model will not be returned |
| dst_detail | bool | No | If not filled, the default is false, and the instance details of the target model will not be returned |

**asst_filter**

This parameter is a combination of filter rules for association relationship attribute fields, and is used to search for association relationships based on association relationship attributes. Combination supports both AND and OR, and can be nested up to 2 levels. Filtering rules are four-tuple `field`, `operator`, `value`

| parameter | type | required | description |
| --------- | ------ | ---- | ---------------------------- |
| condition | string | yes | combination of query conditions, AND or OR |
| rule | array | is | a set containing all query conditions |

**rule**

| parameter | type | required | description |
| -------- | ------ | ---- | ----------------------------------------------------------- |
| field | string | is | the field in the query condition, for example: bk_obj_id, bk_asst_obj_id, bk_inst_id |
| operator | string | yes | the query mode in the query condition, equal, in, nin, etc. |
| value | string | yes | the value corresponding to the query condition |

Assembly rules can refer to: https://github.com/Tencent/bk-cmdb/blob/master/src/common/querybuilder/README.md

**page**

| parameter | type | required | description |
| ----- | ------ | ---- | -------------------- |
| start | int | no | record start position |
| limit | int | yes | limit the number of entries per page, the maximum is 200 |
| sort | string | no | sort field |

**The pagination object is an association relationship**

#### Request parameter example
```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "xxx",
    "bk_token": "xxx",
    "condition": {
        "asst_filter": {
            "condition": "AND",
            "rules": [
                {
                    "field": "bk_obj_id",
                    "operator": "equal",
                    "value": "bk_switch"
                },
                {
                    "field": "bk_inst_id",
                    "operator": "equal",
                    "value": 1
                },
                {
                    "field": "bk_asst_obj_id",
                    "operator": "equal",
                    "value": "host"
                }
            ]
        },
        "src_fields": [
            "bk_inst_id",
            "bk_inst_name"
        ],
        "dst_fields": [
            "bk_host_innerip"
        ],
        "src_detail": true,
        "dst_detail": true
    },
    "page": {
        "start": 0,
        "limit": 20,
        "sort": "-bk_asst_inst_id"
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
        "association": [
            {
                "id": 3,
                "bk_inst_id": 1,
                "bk_obj_id": "bk_switch",
                "bk_asst_inst_id": 3,
                "bk_asst_obj_id": "host",
                "bk_obj_asst_id": "bk_switch_connect_host",
                "bk_asst_id": "connect"
            },
            {
                "id": 2,
                "bk_inst_id": 1,
                "bk_obj_id": "bk_switch",
                "bk_asst_inst_id": 2,
                "bk_asst_obj_id": "host",
                "bk_obj_asst_id": "bk_switch_connect_host",
                "bk_asst_id": "connect"
            },
            {
                "id": 1,
                "bk_inst_id": 1,
                "bk_obj_id": "bk_switch",
                "bk_asst_inst_id": 1,
                "bk_asst_obj_id": "host",
                "bk_obj_asst_id": "bk_switch_connect_host",
                "bk_asst_id": "connect"
            }
        ],
        "src": [
            {
                "bk_inst_id": 1,
                "bk_inst_name": "s1"
            }
        ],
        "dst": [
            {
                "bk_host_innerip": "10.11.11.1"
            },
            {
                "bk_host_innerip": "10.11.11.2"
            },
            {
                "bk_host_innerip": "10.11.11.3"
            }
        ]
    }
}
```

### Return result parameter description

#### response

| Field | Type | Description |
| ------------------- | ----- | ---------- |
| result | bool | Whether the request was successful or not. true: the request was successful; false: the request failed |
| code | int | Wrong code. 0 means success, >0 means failure error |
| message | string | The error message returned by the request failure |
| permission | object | permission information |
| request_id | string | request chain id |
| data | object | request result |

#### data

| Field | Type | Description |
| ----------- | ----- | ------------------------------------- |
| association | array | The details of the queried association relationship, sorted by the page sorting parameters |
| src | array | details of the source model instance |
| dst | array | details of the target model instance |

##### association

| Name | Type | Description |
| --------------- | ------ | ------------------------ |
| id | int64 | association id |
| bk_inst_id | int64 | source model instance id |
| bk_obj_id | string | id of the source model of the relationship |
| bk_asst_inst_id | int64 | id of the target model of the association |
| bk_asst_obj_id | string | target model instance id |
| bk_obj_asst_id | string | automatically generated model association relationship id |
| bk_asst_id | string | relation name |

##### src

| Name | Type | Description |
| ------------ | ------ | ------ |
| bk_inst_name | string | instance name |
| bk_inst_id | int | instance id |

##### dst

| Name | Type | Description |
| ---------------- | ------ | ---------- |
| bk_host_inner_ip | string | host internal network ip |