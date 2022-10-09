
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/monitor_v3/metadata_create_result_table/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

创建结果表
根据给定的配置参数，创建一个结果表

### 请求参数



#### 接口参数

| 字段           | 类型   | 是否必选 | 描述        |
| -------------- | ------ | ---- | ----------- |
| bk_data_id     | int | 是   | 数据源 ID |
| table_id | string |  是    | 结果表 ID，格式应该为 库.表(例如，system.cpu)    |
| table_name_zh | string | 是 | 结果表中文名 |
| is_custom_table | bool | 是 | 是否用户自定义结果表 |
| schema_type | string | 是 | 结果表字段配置方案, free(无 schema 配置), fixed(固定 schema) |
| operator | string | 是 | 操作者 |
| default_storage | string | 是 | 默认存储类型，目前支持 influxdb |
| default_storage_config | dict | 否 | 默认的存储信息, 根据每种不同的存储，会有不同的配置内容, 如果不提供则会使用默认值；具体内容请参考下面的具体说明 |
| field_list | list | 否 | 字段信息，数组元素为 object，例如，字段有 field_name(字段名), field_type(字段类型), tag(字段类型, metirc -- 指标, dimension -- 维度), alias_name(字段别名) |
| bk_biz_id | int | 否 | 业务 ID，如果不提供，默认是 0（全业务）结果表;如果非零时，将会校验结果表命名规范 |
| label | string | 是 | 结果表标签，此处记录的是二级标签，对应一级标签将由二级标签推导得到 |
| external_storage | list | 否 | 额外存储配置，格式为{${storage_type}: ${storage_config}}, storage_type 可为 kafka, influxdb, redis; storage_config 与 default_storage_config 一致 |
| is_time_field_only | bool | 否 | 默认字段是否仅需要 time，默认为 False |
| option | list | 否 | 结果表的额外配置信息，格式为{`option_name`: `option_value`} |
| time_alias_name | string | 否 | 时间字段上传时需要使用其他字段名 |

**注意**： 上述的`label`都应该通过`metadata_get_label`接口获取，不应该自行创建

#### 目前结果表可以选择的选项包括
| 选项名 | 类型 | 描述 |
| -------------- | ------ | ----------- |
| cmdb_level_config | list | CMDB 层级拆分配置 |
| group_info_alias | string | 分组标识字段别名 |
| es_unique_field_list | list | ES 生成 doc_id 的字段列表 |

###### 参数: default_storage_config 及 storage_config -- 在 influxdb 下支持的参数

| 键值 | 类型 | 是否必选 | 默认值 |描述 |
| ---- | --- | --- | ---| ---|
| storage_cluster_id | int | 否 | 使用该存储类型的默认存储集群  | 指定存储集群 |
| database | string | 否 | table_id 的点分第一部分 | 存储的数据库 |
| real_table_name | string | 否 | table_id 的点分第二部分 | 实际存储表名 |
| source_duration_time | string | 否 | 30d | 元数据保存时间, 需要符合 influxdb 格式 |

###### 参数: default_storage_config 及 storage_config -- 在 kafka 下支持的参数
| 键值 | 类型 | 是否必选 | 默认值 |描述 |
| ---- | --- | --- |--- | --- | 
| storage_cluster_id | int | 否 | 使用该存储类型的默认存储集群  | 指定存储集群 |
| topic | string | 否 | 0bkmonitor_storage_${table_id} | 存储的 topic 配置 |
| partition | int | 否 | 1 | 存储 partition 数量，注意：此处只是记录，如果是超过 1 个 topic 的配置，需要手动通过 kafka 命令行工具进行扩容 |
| retention | int | 否 | 1800000 | kafka 数据保存时长，默认是半小时，单位 ms |

###### 参数: default_storage_config 及 storage_config -- 在 redis 下支持的参数
| 键值 | 类型 | 是否必选 | 默认值 |描述 |
| ---- | --- | --- | --- | --- |
| storage_cluster_id | int | 否 | 使用该存储类型的默认存储集群  | 指定存储集群 |
| key | string | 否 | table_id 名字 | 存储键值 |
| db | int | 否 | 0 |使用 db 配置 |
| command | string | 否 | PUBLISH | 存储命令 |
| is_sentinel | bool | 否 | False | 是否哨兵模式 |
| master_name | string | 否 | "" | 哨兵模式下 master 名称 |

**注意**: 由于 redis 默认使用队列方式，消费后就丢弃，因此未有时长配置

###### 参数: default_storage_config 及 storage_config -- 在 elasticsearch 下支持的参数

| 键值 | 类型 | 是否必选 | 默认值 |描述 |
| ---- | --- | --- | --- | --- |
| storage_cluster_id | int | 否 | - |使用该存储类型的默认存储集群
| retention | int | 否 |  30 |  保留 index 时间，单位为天，默认保留 30 天 |
| date_format | string | 否 | %Y%m%d%H | 时间格式，默认具体到小时 |
| slice_size | int | 否 | 500 | 需要切分的大小阈值，单位为 GB，默认为 500GB |
| slice_gap | int | 否 | 120 | index 分片时间间隔，单位分钟，默认 2 小时 |
| index_settings | string | 是 | - | 索引创建配置, json 格式 |
| mapping_settings | string | 否 | - | 索引 mapping 配置，**不包含字段定义**， json 格式 |

**注意**: 实际 index 构造方式为`${table_id}_${date_format}_${current_index}`

###### 参数: field_list 的具体参数说明

| 键值 | 类型 | 是否必选 | 默认值 |描述 |
| ---- | --- | --- | --- | --- |
| field_name | string | 是 | - | 字段名 |
| field_type | string | 是 | - |  字段类型，可以为 float, string, boolean 和 timestamp |
| description | string | 否 | "" |  字段描述信息 |
| tag | string | 是 | - | 字段标签，可以为 metric, dimemsion, timestamp, group |
| alias_name | string | 否 | None | 入库别名 |
| option | string | 否 | {} | 字段选项配置，键为选项名，值为选项配置 |
| is_config_by_user | bool | 是 | true | 用户是否启用该字段配置 |

目前可以选择的 option 包括：
| 选项名 | 类型 | 描述 |
| -------------- | ------ | ----------- |
| es_type | string | es 配置：映射实际字段类型 |
| es_include_in_all | bool | es 配置：是否包含到_all 字段中 |
| es_format | string | es 配置：时间格式 |
| es_doc_values | bool | es 配置：是否维度 |
| es_index | string | es 配置：是否分词，值可以为 true 或 false |
| time_format | string | 数据源时间格式，供 Transfer 解析上报时间 |
| time_zone | int | 时区配置，供 Transfer 解析上报时间为 UTC，取值范围[-12, +12] |


#### 请求示例

```json
{
    "bk_app_code": "xxx",
    "bk_app_secret": "xxxxx",
    "bk_token": "xxxx",
    "bk_data_id": 1001,
    "table_id": "system.cpu_detail",
    "table_name_zh": "CPU记录",
    "is_custom_table": true,
    "schema_type": "fixed",
    "operator": "username",
    "default_storage": "influxdb",
    "default_storage_config": {
        "storage": 1,
        "source_duration_time": "30d"
    },
    "field_list": [{
        "field_name": "usage",
        "field_type": "double",
        "description": "field description",
        "tag": "metric",
        "alias_name": "usage_alias",
        "option": [],
        "is_config_by_user": true
    }],
    "label": "OS",
    "external_storage": {
        "kafka": {
            "expired_time": 1800000
        }
    }
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
| table_id | string | 结果表 ID |

#### 结果示例

```json
{
    "message": "OK",
    "code": 200,
    "data": {
    	"table_id": "system.cpu_detail"
    },
    "result": true,
    "request_id": "408233306947415bb1772a86b9536867"
}
```