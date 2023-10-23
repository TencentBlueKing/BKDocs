### 功能描述

查询任务实例日志

### 请求参数

{{ common_args_desc }}

#### 接口参数

| 字段          | 类型  | <div style="width: 50pt">必选</div> | 描述                       |
| ----------- | --- | --------------------------------- | ------------------------ |
| job_id      | int | 是                                 | 任务ID                     |
| instance_id | int | 是                                 | 任务实例ID，详情见instance_id 定义 |

##### instance_id

由scope内的主机实例信息转换而来，由以下字段拼接，，可通过接口`task_result_subscription`查询，规则：{object_type}|{node_type}|{type}|{id}，示例：1: host|instance|host|1, 2: host|instance|host|127.0.0.1-1-0

| 字段          | 类型     | <div style="width: 50pt">必选</div> | 描述                                                                                  |
| ----------- | ------ | --------------------------------- | ----------------------------------------------------------------------------------- |
| object_type | string | 是                                 | 对象类型，1：host，主机类型  2：service，服务类型                                                    |
| node_type   | string | 是                                 | 节点类别，1: topo，动态实例（拓扑）2: instance，静态实例 3: service_template，服务模板 4: set_template，集群模板 |
| type        | string | 是                                 | 服务类型，1: host 主机 2: bk_obj_id 模板ID                                                   |
| id          | string | 是                                 | 服务实例ID，1： 根据ip，bk_cloud_id，bk_supplier_id和分隔符”-“生成key  2: bk_host_id, 主机Host-ID     |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_username": "admin",
    "bk_token": "xxx",
    "job_id": 1,
    "instance_id": 1,
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": [
        {
            "step": "更新任务状态",
            "status": "SUCCESS",
            "log": "[2021-09-16 15:06:04 INFO] 开始更新任务状态",
            "start_time": "2021-09-16 15:06:04",
            "finish_time": "2021-09-16 15:06:04"
        },
        {
            "step": "批量下发升级包",
            "status": "SUCCESS",
            "log": "[2021-09-16 15:06:04 INFO] 开始下发升级包......",
            "start_time": "2021-09-16 15:06:04",
            "finish_time": "2021-09-16 15:06:39"
        },
        {
            "step": "执行升级脚本",
            "status": "SUCCESS",
            "log": "[2021-09-16 15:06:39 INFO] 开始执行升级脚本\n[2021-09-16 15:06:39 INFO]...........",
            "start_time": "2021-09-16 15:06:39",
            "finish_time": "2021-09-16 15:06:45"
        },
        {
            "step": "查询Agent状态",
            "status": "SUCCESS",
            "log": "[2021-09-16 15:06:45 INFO] 开始查询 GSE 状态期望的GSE主机状态为RUNNING......",
            "start_time": "2021-09-1615: 06: 45",
            "finish_time": "2021-09-1615: 07: 20"
        },
        {
            "step": "更新任务状态",
            "status": "SUCCESS",
            "log": "[2021-09-1615: 0720 INFO]开始更新任务状态",
            "start_time": "2021-09-1615: 07: 20",
            "finish_time": "2021-09-1615: 07: 20"
        }
    ]
}
```

### 返回结果参数说明

#### response

| 字段      | 类型     | 描述                         |
| ------- | ------ | -------------------------- |
| result  | bool   | 请求成功与否。true:请求成功；false请求失败 |
| code    | int    | 错误编码。 0表示success，>0表示失败错误  |
| message | string | 请求失败返回的错误信息                |
| data    | array  | 请求返回的数据，见data定义            |

#### data

| 字段          | 类型     | 描述             |
| ----------- | ------ | -------------- |
| step        | string | 节点名称           |
| status      | string | 执行状态，见status定义 |
| log         | string | 执行日志           |
| start_time  | string | 启动时间           |
| finish_time | string | 完成时间           |

##### status

| 状态类型        | 类型     | 描述   |
| ----------- | ------ | ---- |
| PENDING     | string | 等待执行 |
| RUNNING     | string | 正在执行 |
| FAILED      | string | 执行失败 |
| SUCCESS     | string | 执行成功 |
| PART_FAILED | string | 部分失败 |
| TERMINATED  | string | 已终止  |
| REMOVED     | string | 已移除  |
| FILTERED    | string | 被过滤的 |
| IGNORED     | string | 已忽略  |
