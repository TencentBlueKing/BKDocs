
### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/import_uptime_check_node/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Import dial test node

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| --------- | ---- | ---- | -------- |
| conf_list | list | yes | node list |

#### Task list --conf_list

| Field | Type | Required | Description |
| ----------- | ---- | ---- | ----------- |
| target_conf | dict | Yes | Node delivers configuration |
| node_conf | dict | yes | node basic configuration |

##### Node delivers configuration--target_conf

| Field | Type | Required | Description |
| ----------- | ---- | ---- | -------- |
| ip | str | yes | IP |
| bk_cloud_id | int | yes | cloud zone ID |
| bk_biz_id | int | yes | business id |

##### Basic node configuration--node_conf

| Field | Type | Required | Description |
| --------------- | ---- | ---- | ------------------------------------- |
| is_common | bool | No | Whether it is a common node, default false |
| name | str | yes | node name |
| location | dict | yes | the region where the node is located |
| carrieroperator | str | Yes | Operator, maximum length 50 (Intranet, China Unicom, China Mobile, others) |

###### Node location--node_conf.location

| Field | Type | Required | Description |
| ------- | ---- | ---- | ---- |
| country | str | is | country |
| city | str | is | city |

#### Request parameter example
```json
{
    "bk_app_code": "xxx",
    "bk_app_secret": "xxxxx",
    "bk_token": "xxxx",
    "conf_list":[{
        "node_conf": {
            "carrieroperator": "内网",
            "location": {
                "country": "中国",
                "city": "广东"
            },
            "name": "中国广东内网",
            "is_common": false
        },
        "target_conf": {
            "bk_biz_id": 2,
            "bk_cloud_id": 0,
            "ip": "x.x.x.x"
        }
    },{
        "node_conf": {
            "carrieroperator": "内网",
            "location": {
                "country": "中国",
                "city": "广东"
            },
            "name": "中国广东内网",
            "is_common": false
        },
        "target_conf": {
            "bk_biz_id": 2,
            "bk_cloud_id": 0,
            "ip": "x.x.x.x"
        }
    }]}
```

### Return results

| Field | Type | Description |
| ------- | ------ | ----------------------------------- |
| result | bool | Return the result, true means success, false means failure |
| code | int | Return code, 200 indicates success, other values indicate failure |
| message | string | error message |
| data | list | results |

#### data field description

| Field | Type | Description |
| ------- | ------ | ----------------------------------- |
failed | dict | Import failure related information |
success | dict | Import success related information |

##### Import failure related information--data.failed

| Field | Type | Description |
| ------- | ------ | ----------------------------------- |
total | int | Number of failed imports |
detail | list | Import failure details |

###### Import failure details--data.failed.detail

| Field | Type | Description |
| ------- | ------ | ----------------------------------- |
| target_conf | dict | Node delivery configuration |
| error_mes | str | Reason for import failure |

##### Information related to successful import--data.success

| Field | Type | Description |
| ------- | ------ | ----------------------------------- |
| total | int | Number of successful imports |
| detail | list | Import success details |

###### Information related to successful import--data.success.datail

| Field | Type | Description |
| ------- | ------ | ----------------------------------- |
| target_conf | dict | Node delivery configuration |
| node_id | int | successfully imported node id |

#### Return result example

```json
{
    "message": "OK",
    "code": 200,
    "data": {
        "failed": {
            "total": 1,
            "detail": [
                "target_conf": {
                    "bk_biz_id": 2,
                    "ip": "x.x.x.x",
                    "bk_cloud_id": 0
                },
            	"error_mes": "业务下不存在该主机"
            ]
    	},
        "success": {
            "total": 2,
            "detail": [
                {
                    "target_conf": {
                        "bk_biz_id": 2,
                        "ip": "x.x.x.x",
                        "bk_cloud_id": 0
                    },
                    "node_id": 30
                },
                {
                    "target_conf": {
                        "bk_biz_id": 2,
                        "ip": "x.x.x.x",
                        "bk_cloud_id": 0
                    },
                    "node_id": 31
                }
            ]
        }
    },
    "result": true
}
```