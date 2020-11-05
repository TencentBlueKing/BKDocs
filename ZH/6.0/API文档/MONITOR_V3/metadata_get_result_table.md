
### 请求地址

/api/c/compapi/v2/monitor_v3/metadata_get_result_table/



### 请求方法

GET


### 功能描述

查询一个结果表的信息
根据给定的结果表ID，返回这个结果表的具体信息



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
| table_id  | string | 是   | 结果表ID |


#### 请求示例

```json
{
	"table_id": "system.cpu"
}
```

### 返回结果

#### 字段说明

| 字段                | 类型   | 描述     |
| ------------------- | ------ | -------- |
| table_id | int | 结果表ID |
| table\_name_zh | string | 结果表中文名 |
| is\_custom_table | boolean | 是否自定义结果表 | 
| schema_type | string | 结果表schema配置方案，free(无schema配置), dynamic(动态schema), fixed(固定schema) | 
| default_storage | string | 默认存储方案 | 
| storage_list | array | 所有存储列表，元素为string | 
| creator | string | 创建者 | 
| create_time | string | 创建时间, 格式为【2018-10-10 10:00:00】| 
| last\_modify_user | string | 最后修改者 | 
| last\_modify_time | string | 最后修改时间【2018-10-10 10:00:00】|

#### 结果示例

```json
{
    "message":"OK",
    "code":"0",
    "data":{
    	"table_id": "system.cpu",
    	"table_name_zh": "结果表名",
    	"is_custom_table": false,
    	"scheme_type": "fixed",
    	"default_storage": "influxdb",
    	"storage_list": ["influxdb"],
    	"creator": "username",
    	"create_time": "2018-10-10 10:10:10",
    	"last_modify_user": "username",
    	"last_modify_time": "2018-10-10 10:10:10",
    	"field_list": [{
    		"field_name": "usage",
    		"field_type": "float",
    		"tag": "dimension",
    		"description": "CPU用量"
    		"is_config_by_user": true
    	}],
        "bk_biz_id": 0,
        "label": "OS"
    },
    "result":true,
    "request_id":"408233306947415bb1772a86b9536867"
}
```