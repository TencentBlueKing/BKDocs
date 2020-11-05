
### 请求地址

/api/c/compapi/v2/monitor_v3/metadata_get_result_table_storage/



### 请求方法

GET


### 功能描述

查询一个结果表的指定存储信息
根据给定的结果表ID，返回这个结果表的具体存储集群信息



#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段           | 类型   | 必选 | 描述        |
| -------------- | ------ | ---- | ----------- |
| result_table_list  | string | 是   | 结果表ID |
| storage_type | string | 是 | 存储类型 | 


#### 请求示例

```json
{
	"result_table_list": "system.cpu",
	"storage_type": "elasticsearch"
}
```

### 返回结果

#### 字段说明

| 字段                | 类型   | 描述     |
| ------------------- | ------ | -------- |
| table_id | int | 结果表ID |
| storage_info | array | 存储集群信息 |

###### 对于storage_info，各个元素内容说明如下
| 字段                | 类型   | 描述     |
| ------------------- | ------ | -------- |
| storage_config | object | 存储集群特性，各个存储下字段不一致 |
| cluster_config | object | 存储集群信息 |
| cluster_type | string | 存储集群类型 |
| auth_info | object | 身份认证信息 | 

#### 结果示例

```json
{
    "message":"OK",
    "code":"0",
    "data":{
        "system.cpu": {
            "table_id": "system.cpu",
    	    "storage_info": [{
                "storage_config": {
                    "index_datetime_format": "%Y%m%h", 
                    "slice_size": 400,
                    "slice_gap": 120,
                    "retention": 30
                },
                "cluster_config": {
                    "domain_name": "service.consul",
                    "port": 1000,
                    "schema": "http",
                    "is_ssl_verify": false,
                    "cluster_id": 1,
                    "cluster_name": "default_es_storage"
                },
                "cluster_type": "elasticsearch",
                "auth_info": {
                    "username": "admin",
                    "password": "password"
                }
    	    }]
        }

    },
    "result":true,
    "request_id":"408233306947415bb1772a86b9536867"
}
```