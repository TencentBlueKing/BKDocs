
### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/metadata_create_cluster_info/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Create a storage cluster configuration
Create a storage cluster configuration based on the given configuration parameters

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| cluster_name | string | Yes | Storage cluster name |
| cluster_type | string | Yes | Storage cluster type, currently supports influxDB, kafka, redis, elasticsearch |
| domain_name | string | Yes | Storage cluster domain name (IP can be filled in) |
| port | int | yes | storage cluster port |
| operator | string | is | creator |
| description | string | No | Store cluster description information |
| auth_info | dict | no | cluster authentication information |
| version | string | No | Cluster version information |
| custom_label | string | no | custom label |
| schema | string | No | Forcefully configure schema, which can be used to configure https and other situations |
| is_ssl_verify | bool | No | Whether to skip SSL\TLS authentication |

#### Request example

```json
{
    "bk_app_code": "xxx",
    "bk_app_secret": "xxxxx",
    "bk_token": "xxxx",
    "cluster_name": "first_influxdb",
    "cluster_type": "influxDB",
    "domain_name": "influxdb.service.consul",
    "operator": "admin",
    "auth_info": {
        "username": "username",
        "password": "password"
    },
    "port": 9052,
    "description": "描述信息"
}
```

### Return results

| Field | Type | Description |
| ---------- | ------ | ---------- |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | dict | data |
| request_id | string | request id |

#### data field description

| Field | Type | Description |
| ------------------- | ------ | -------- |
| cluster_id | int | cluster ID |

#### Example of results

```json
{
    "message":"OK",
    "code":200,
    "data":{
    	"cluster_id": 1001
    },
    "result":true,
    "request_id":"408233306947415bb1772a86b9536867"
}
```