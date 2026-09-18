SaaS 使用数据模型构建规范的指标
----

在数据模型页面创建好数据模型后，SaaS 调用数据模型 API ，可以实现输入结果数据表，自动创建 Dataflow 任务，生成对应指标。

![-w1025](media/16380025404954.jpg)


## 获取模型列表 和 获取模型输入字段
如果上层 SaaS 需要终端用户映射结果输入表以及对应字段，则在真正实例化数据模型前，一般需要获取数据模型列表和获取数据模型的输入字段，方便用户将业务的结果表作为模型输入。

### 获取模型列表
参照 获取模型列表 API（v3_datamanage_datamodel_models_get）文档，获取模型列表。

### 获取模型输入字段
参照 获取模型主表详情 API（v3_datamanage_datamodel_models__model_id__master_tables_get） 文档，获取模型输入字段。

## 实例化数据模型，生成 Dataflow 任务
参照 模型应用实例生成完整 dataflow 任务 API（v3_datamanage_datamodel_model_instance_generate_dataflow）文档。

### 实例化维表数据模型
> [维度表数据模型](../concepts.md): 描述事实表数据模型中的维度，如用户表，定义登录流水表中的用户维度（性别、年龄等字段）。 通过在事实表数据模型中通过关联维度表数据模型中的维度，可以扩展更多可读性更强的维度，例如将用户 ID 扩展为用户名、用户年龄等。

主要是 `input` 和 `main_table` 这两个参数。

- input
    - main_table: 为主表对应结果表
    - dimension_tables: 如果该维表数据模型中没有关联其他维表，则为空；
- main_table
    - table_name: 选填，默认为模型英文名称，最终实例化后结果表带业务 ID，如果有重名请指定该参数（不需要带业务 ID）。
    - storages[]: （维表数据模型实例化后，必须有一个 ignite 存储）
       - cluster_type: 集群类型
       - cluster_name: 存储集群，例如 default 为 `ignite 关联数据公共集群 `
       - expires": ignite 存储过期时间，`-1` 为永久保存，只能为该值。
       - indexed_fields: 索引字段
       - specific_params（ignite 存储除了通用参数外，还需要设置如下参数）
           - storage_type: 存储类型，用于关联计算
           - max_records: 最大数据量，超出数据无法入库
           - storage_keys: 构成唯一键  

以下为请求示例

```json
{
    "model_id": 32,
    "project_id": 4716,
    "bk_biz_id": 591, 
    "input": {
        "main_table": "591_dmm_model_info_xxx",
        "dimension_tables": []},
    "main_table": {
        "table_name": "dim_dmm_model_info_xx",
        "storages": [
            {
                "cluster_type": "ignite",
                "cluster_name": "default",
                "expires": -1,
                "indexed_fields": ["model_id"],
                "specific_params": {
                	   "storage_type": "join",
                	   "max_records": 1000000,
                	   "storage_keys":["model_id"]
                }
            }
        ]
    }
}'
```

以下为请求返回示例。

```json
{
  "errors": null,
  "message": "ok",
  "code": "1500200",
  "data": {
    "flow_id": "35870",
    "node_ids": [
      274295,
      274296,
      274297
    ]
  },
  "result": true
}
```

实例化的效果如下，可以看到一个名为 `[业务名称]数据模型 (模型名称) 应用任务 ` 的 Dataflow 任务。

![-w1628](media/16378945096172.jpg)

### 实例化事实表数据模型
> [事实表数据模型](../concepts.md): 描述业务活动的细节，如：登录流水、对局流水、用户访问记录等

重点说一下和上面不一样的地方。

由于明细表和指标实例化后的结果表名是自动生成的，所以实例化时重点关注这两类表的存储即可。

- input.dimension_tables: 在这个示例中，事实表数据模型有关联维表。
- main_table
    - storages: 如果存在离线指标，则需要增加 hdfs 存储
- default_indicators_storages: 选填，【公共配置】默认指标存储集群

以下为请求示例

```json
{
    "model_id": 16,
    "project_id": 4716,
    "bk_biz_id": 591,
    "input": {
        "main_table": "591_dataweb_user_browser_behavior_module",
        "dimension_tables": ["591_dim_dataweb_user_list"]

    },
    "main_table": {
        "storages": [
            {
                "cluster_type": "tspider",
                "cluster_name": "default4",
                "expires": 30
            },
            {
                "cluster_type": "hdfs",
                "cluster_name": "hdfsOnline4",
                "expires": 90
            }
        ]
    },
    "default_indicators_storages": [
        {
            "cluster_type": "tspider",
            "cluster_name": "default4",
            "expires": 30
		}
    ]
}
```

请求成功后，会在项目下创建了一个数据开发任务。
![-w1910](media/16381700612076.jpg)


接下来，启动数据开发任务即可，通过 数据查询的接口就可以正常消费数据了。

## FAQ

### 结果表已存在，不允许重复创建
自动生成的结果表名已存在，则可以自定义结果表名。

主表使用 `main_table.table_name` 自定义结果表的英文名（不含业务 ID），具体示例详见上文 维度表实例化示例。

指标使用 `indicators[].table_custom_name` 自定义，或者直接在数据模型中修改指标的英文名，发布后再应用。

```json
{
  "errors": null,
  "code": "1500003",
  "message": "增加节点失败，明细 (节点(计算平台错误码) 创建失败，[1500003] [1571033] 结果表已存在，不允许重复创建)",
  "data": null,
  "result": false
}
```

### 创建任务期间出现非预期异常(list index out of range)，请联系管理员

```json
{
  "errors": null,
  "code": "1500003",
  "message": "创建任务期间出现非预期异常(list index out of range)，请联系管理员",
  "data": null,
  "result": false
}
```

出现该报错的可能性很多，例如

- 存储集群不存在
例如 hdfs 公共集群 4 的 `storages.cluster_name` 为 `hdfsOnline4`，而不是 `default4`

- 模型实例指标结果表 ID(591_xxxxxx)已经被使用

请参照文档重命名该指标的表名 `indicators.table_custom_name`

- 当前节点窗口长度 (31) 应小于结果表 (xxxx) 的过期时间(7 天)
指标节点的过期时间超过前置数据模型应用节点的过期时间。
例如数据模型节点的 HDFS 存储过期时间为 7 天，但 MAU 指标节点的存储过期时间是 30 天。


### 项目下存在同名任务
模型实例化前会检查当前项目下是否有重名的任务（`[业务名称]数据模型 (模型名称) 应用任务 ` 的 Dataflow 任务），如果想多次运行测试，可以手动修改已存在的 数据开发任务名称。

此外，还需要修改 主表的 `table_name` 和指标节点的 `table_custom_name`，否则生成的结果表有重名，导致实例化失败。

```json
{
  "errors": null,
  "code": "1500400",
  "message": "项目底下存在同名任务",
  "data": null,
  "result": false
}
```
