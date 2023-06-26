
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/monitor_v3/metadata_modify_result_table/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

修改一个结果表的配置
根据给定的数据源 ID，返回这个结果表的具体信息

### 请求参数



#### 接口参数

| 字段           | 类型   | 必选 | 描述        |
| -------------- | ------ | ---- | ----------- |
| table_id  | string | 是   | 结果表 ID |
| operator | string | 是 | 操作者 |
| field_list | list | 否 | 全量的字段列表 |
| table_name_zh | string | 否 | 结果表中文名 |
| default_storage | string | 否 | 结果表默认存储类型 |
| label | string | 是 | 结果表标签，此处记录的是二级标签，对应一级标签将由二级标签推导得到 |
| is_time_field_only | bool | 否 | 默认字段是否仅需要 time，默认为 False，该字段仅在 field_list 参数为非空时生效 |
| external_storage | dict | 否 | 额外存储配置，格式为{${storage_type}: ${storage_config}}, storage_type 可为 kafka, influxdb, redis; storage_config 与 default_storage_config 一致 |
| is_enable | bool | 否 | 是否启用结果表 |


**注意**： 上述的`label`都应该通过`metadata_get_label`接口获取，不应该自行创建

###### 参数: default_storage_config 及 storage_config -- 在 influxdb 下支持的参数
| 键值 | 类型 | 是否必选 | 默认值 |描述 |
| ---- | --- | --- | --- | --- |
| source_duration_time | string | 否 | 30d | 元数据保存时间, 需要符合 influxdb 格式 |

###### 参数: default_storage_config 及 storage_config -- 在 kafka 下支持的参数
| 键值 | 类型 | 是否必选 | 默认值 |描述 |
| ---- | --- | --- | --- | --- |
| partition | int | 否 | 1 | 存储 partition 数量，注意：此处只是记录，如果是超过 1 个 topic 的配置，需要手动通过 kafka 命令行工具进行扩容 |
| retention | int | 否 | 1800000 | kafka 数据保存时长，默认是半小时，单位 ms |

###### 参数: default_storage_config 及 storage_config -- 在 redis 下支持的参数

| 键值 | 类型 | 是否必选 | 默认值 |描述 |
| ---- | --- | --- | --- | --- |
| is_sentinel | bool | 否 | False | 是否哨兵模式 |
| master_name | string | 否 | "" | 哨兵模式下 master 名称 |

**注意**: 由于 redis 默认使用队列方式，消费后就丢弃，因此未有时长配置

###### 参数: default_storage_config 及 storage_config -- 在 elasticsearch 下支持的参数
| 键值 | 类型 | 是否必选 | 默认值 |描述 |
| ---- | --- | --- | --- | --- |
| retention | int | 否 |  30 |  保留 index 时间，单位为天，默认保留 30 天 |
| slice_size | int | 否 | 500 | 需要切分的大小阈值，单位为 GB，默认为 500GB |
| slice_gap | int | 否 | 120 | index 分片时间间隔，单位分钟，默认 2 小时 |
| index_settings | string | 是 | - | 索引创建配置, json 格式 |
| mapping_settings | string | 否 | - | 索引 mapping 配置，**不包含字段定义**， json 格式 |
| alias_name | string | 否 | None | 入库别名 |
| option | string | 否 | {} | 字段选项配置，键为选项名，值为选项配置 |

**注意**: 上述信息是否可以修改，主要决定于该修改参数是否会导致历史数据丢失

| 键值 | 类型 | 是否必选 | 默认值 |描述 |
| ---- | --- | --- | --- | --- |
| filed_name | string | 是 |  - |  字段名 |
| field_type | string | 是 |  - |  字段类型 |
| description | string | 否 |  "" |  字段描述 |
| tag | string | 是 |  - |  字段类型，可以为 metric 或 dimension |
| alias_name | string | 否 |  "" |  字段别名，入库时可以改为此别名写入 |
| option | list | 否 |  [] | 字段配置选项 |
| is_config_by_user | bool | 否 |  true | 是否启用 |

#### 请求示例

```json
{
    "bk_app_code": "xxx",
  	"bk_app_secret": "xxxxx",
  	"bk_token": "xxxx",
	"table_id": "system.cpu",
	"operator": "username",
	"field_list": [{
		"filed_name": "usage",
		"field_type": "double",
		"description": "field description",
		"tag": "metric",
        "alias_name": "usage_alias",
		"option": [],
		"is_config_by_user": true
	}],
	"label": "OS",
	"table_name_zh": "CPU性能数据",
	"default_storage": "influxdb"
}
```

### 返回结果

| 字段       | 类型   | 描述         |
| ---------- | ------ | ------------ |
| result     | bool   | 请求是否成功 |
| code       | int    | 返回的状态码 |
| message    | string | 描述信息     |
| data       | dict   | 数据         |
| request_id | string | 请求 ID       |

#### data 字段说明

| 字段                | 类型   | 描述     |
| ------------------- | ------ | -------- |
| table_id | int | 结果表 ID |
| table _name_zh | string | 结果表中文名 |
| is_custom_table | boolean | 是否自定义结果表 |
| schema_type | string | 结果表 schema 配置方案，free(无 schema 配置), dynamic(动态 schema), fixed(固定 schema) |
| default_storage | string | 默认存储方案 |
| storage_list | list | 所有存储列表，元素为 string |
| creator | string | 创建者 |
| create_time | string | 创建时间, 格式为【2018-10-10 10:00:00】|
| last_modify_user | string | 最后修改者 |
| last_modify_time | string | 最后修改时间【2018-10-10 10:00:00】|
| label | string | 结果表标签 |
| field_list | list | 字段列表 |

#### data.field_list 字段说明

| 键值              | 类型   | 描述                                                |
| ----------------- | ------ | --------------------------------------------------- |
| field_name        | string | 字段名                                              |
| field_type        | string | 字段类型，可以为 float, string, boolean 和 timestamp   |
| description       | string | 字段描述信息                                        |
| tag               | string | 字段标签，可以为 metric, dimemsion, timestamp, group |
| alias_name        | string | 入库别名                                            |
| option            | string | 字段选项配置，键为选项名，值为选项配置              |
| is_config_by_user | bool   | 用户是否启用该字段配置                              |
| unit              | string | 字段单位                                            |

#### 结果示例

```json
{
    "message":"OK",
    "code":200,
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
    		"description": "CPU用量",
    		"is_config_by_user": true,
            "unit": "字段单位"
    	}],
    	"label": "OS"
    },
    "result":true,
    "request_id":"408233306947415bb1772a86b9536867"
}
```