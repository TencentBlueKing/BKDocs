
### 请求地址

/api/c/compapi/v2/monitor_v3/metadata_modify_data_id/



### 请求方法

POST


### 功能描述

修改数据源名称



#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段           | 类型   | 必选 | 描述        |
| -------------- | ------ | ---- | ----------- |
| data_name     | string | 是   | 数据源名称 |
| data_id     | int | 是   | 数据源 ID |
| operator | string | 是 | 操作者 |
| source_label | string | 是 | 数据来源标签，例如：数据平台(bk_data)，监控采集器(bk_monitor_collector) |
| type_label | string | 是 | 数据类型标签，例如：时序数据(time_series)，事件数据(event)，日志数据(log) | 

**注意**： 上述的`source_tag`及`data_type`都应该通过`metadata_get_label`接口获取，不应该自行创建 


#### 请求示例

```json
{ 
    "operator": "adminn",
    "data_id": 123,
	"data_name": "basereport",
	"source_label": "bk_monitor_collector",
	"type_label": "time_series"
}
```

### 返回结果

#### 字段说明

| 字段                | 类型   | 描述     |
| ------------------- | ------ | -------- |
| bk\_data_id | int | 结果表 ID |

#### 结果示例

```json
{
    "message":"OK",
    "code":"0",
    "data":{
    	"bk_data_id": 1001,
    	"data_name": "基础数据",
    	"data_description": "基础数据数据源",
    	"mq_cluster_info": {
    		"storage_config": {
	           "topic": "bk_monitor_1001",
	           "partition": 1,
	       },
    		"cluster_config": {
               "domain_name": "kafka.domain.cluster",
               "port": 80,
           },
           "cluster_type": "kafka"
    	},
    	"etl_config": "basereport",
    	"is_custom_source": false,
    	"creator": "username",
    	"create_time": "2018-10-10 10:10:10",
    	"last_modify_user": "username",
    	"last_modify_time": "2018-10-10 10:10:10",
    	"source_label": "bk_monitor_collector",
	    "type_label": "time_series"
    },
    "result":true,
    "request_id":"408233306947415bb1772a86b9536867"
}
```