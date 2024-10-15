### Request method

POST


### Request address

/api/c/compapi/v2/monitor_v3/metadata_modify_cluster_info/


### Common parameters

| Field | Type | Required | Description |
|-----------|------------|--------|------------|
| bk_app_code | string | yes | application ID |
| bk_app_secret| string | Yes | Security key (application TOKEN), which can be obtained through BlueKing Developer Center -> Click on Application ID -> Basic Information |
| bk_token | string | No | Current user login status, bk_token and bk_username must be valid, bk_token can be obtained through Cookie |
| bk_username | string | No | User name of the current user, apply to applications in the login-free verification whitelist, use this field to specify the current user |


### Function description

Query storage cluster configuration
Create a storage cluster configuration based on the given configuration parameters

### Request parameters



#### Interface parameters

| Field | Type | Required | Description |
| -------------- | ------ | ---- | ----------- |
| cluster_id | int | yes | cluster ID |
| cluster_name | string | Yes | Storage cluster name |
| operator | string | is | modifier |
| description | string | No | Store cluster description information |
| auth_info | dict | no | cluster username |
| custom_label | string | no | custom label |
| schema | string | No | Forcefully configure schema, which can be used to configure https and other situations |
| is_ssl_verify | bool | No | Whether to skip SSL\TLS authentication |

**Note**: Whether the above information can be modified mainly depends on whether modifying the parameters will cause the loss of historical data; for example, modifying domain_name requires operation and maintenance intervention, and modification here is not supported.

#### auth_info description
```json
{
   "username": "username",
   "password": "password"
}
```

#### Request example

```json
{
     "bk_app_code": "xxx",
   "bk_app_secret": "xxxxx",
   "bk_token": "xxxx",
     "cluster_id": 1,
"cluster_name": "first_influxdb",
"operator": "admin"
}
```

**Note**: The request can provide `cluster_id` or `cluster_name` to locate the cluster information that needs to be modified; however, the two are mutually exclusive, and `cluster_id` is used first.

### Return results

| Field | Type | Description |
| ---------- | ------ | ---------- |
| result | bool | Whether the request was successful |
| code | int | Returned status code |
| message | string | description information |
| data | dict | data |
| request_id | string | request ID |

#### data field description

| Field | Type | Description |
| ------------------- | ------ | -------- |
| cluster_config | dict | cluster information |
| cluster_type | string | cluster type |
| auth_info | dict | cluster username |

#### cluster_config detailed description

| Parameters | Type | Description |
| ------------- | ------ | ------------------ |
| domain_name | string | Cluster domain name |
| port | int | port |
| schema | string | access protocol |
| is_ssl_verify | bool | Whether SSL verification is strong verification |
| cluster_id | int | cluster ID |
| cluster_name | string | cluster name |
| version | string | Storage cluster version |

#### Example of results

```json
{
     "message":"OK",
     "code":200,
     "data": [{
         "cluster_config": {
             "domain_name": "service.consul",
             "port": 9052,
             "schema": "https",
             "is_ssl_verify": true,
             "cluster_id": 1,
             "cluster_name": "default_influx",
             "version": ""
         },
         "cluster_type": "influxDB",
         "auth_info": {
             "password": "",
             "username": ""
         }
     }],
     "result":true,
     "request_id":"408233306947415bb1772a86b9536867"
}
```