## 开发数据分析类 SaaS

## 情景

每 5 分钟统计占用的 最大的 CPU、内存，可以使用 SQL 实现，不过查询很慢。

可以使用数据开发的实时计算做好预计算，可以直接查询预计算后的数据。


## 前提条件

- [在平台上创建项目，并给项目申请一个结果数据表权限](../user-guide/user-center/projects.md)
- 熟悉一门脚本语言，如 `Python`，本教程以 `Python` 为例
- [使用平台的接口进行数据查询](../user-guide/auth-management/token.md) 

## 操作步骤

- 创建 DataFlow
- 启动 Flow
- 预览效果
  

### 创建 DataFlow

创建 DataFlow ,首先需要明确 DataFlow 上各个节点的作用，然后构造节点配置所需的参数

```python
# -*- coding: utf-8 -*-
import json
import requests
# DataFlow 各个节点的信息，不同节点配置不一样，参考平台 API 文档
# 以下是简单计算进行 5min 内的最大内存和 CPU,xxx为业务 ID
nodes = [
  {
            "result_table_id": "xxx_system_proc",
            "bk_biz_id": xxx,
            "from_nodes": [],
            "frontend_info": {
                "y": 50,
                "x": 30
            },
            "id": 1,
            "node_type": "stream_source",
            "name": "数据源"
        },
        {
            "id": 2,
            "bk_biz_id": xxx,
            "count_freq": 300,
            "window_type": "scroll",
            "table_name": "system_proc_ip_grp",
            "from_nodes": [
                {
                    "from_result_table_ids": [
                        "xxx_system_proc"
                    ],
                    "id": 1
                }
            ],
            "output_name": "统计 5min 最大内存和 cpu",
            "waiting_time": 60,
          "frontend_info": {
                "y": 50,
              "x": 350
            },
          "sql": """SELECT max(mem_res) as mem, max(cpu_usage_pct)  as cpu_usage_pct,max(mem_usage_pct) as mem_usage_pct,ip,pid
                       FROM xxx_system_proc 
                     group by ip, pid""",
            "node_type": "realtime",
            "name": "统计 5min 最大内存和 cpu"
        },
        {
            "indexed_fields": [
                "create_by",
                "biz_id",
                "visitor_department",
                "visitor_group"
            ],
            "expires": 3,
            "result_table_id": "xxx_cpu_mem_test_5min",
            "bk_biz_id": xxx,
            "from_nodes": [
                {
                    "from_result_table_ids": [
                        "xxx_system_proc_ip_grp"
                    ],
                    "id": 2
                }
            ],
            "frontend_info": {
                "y": 50,
                "x": 600
            },
            "id": 3,
            "cluster": "yyy-lasting",
            "node_type": "tspider_storage",
            "name": "统计5min最大内存和cpu"
        }
]  
PROJECT_ID = 1 # 平台上创建的项目的 ID
BK_DATA_URL = 'http://<BK_PAAS_HOST>/api/c/compapi/data/v3/' # 平台地址
headers = {"Content-Type": "application/json; charset=utf-8"} # 请求头
data = json.dumps({
     "bk_app_code": '<YOUR bk_app_code>',  # app_code
       "bk_app_secret": '<YOUR bk_app_secret>', # app_secret
     "bkdata_authentication_method": "user", # 授权模式，按用户进行授权
       "bk_username": '<YOUR bk_username>',  # 请求接口的用户
     "project_id": PROJECT_ID, 
       "flow_name": 'data-test', # DataFlow 的名称
       "nodes": nodes  # flow 节点信息
     })
response = requests.post(
       url=BK_DATA_URL + '/dataflow/flow/flows/create/',  # api 请求地址
       headers=headers,
       data=data
     )
print("Status Code: {status_code}".format(
       status_code=response.status_code))
print("Response Body: {content}".format(
       content=response.content))
return json.loads(response.content)
```

创建 DataFlow 返回结果包括 DataFlow 的 ID 和各个节点的 ID 

```json     
{'errors': None,
 'message': 'ok', 
 'code': '1500200',
 'data': {'flow_id': 25966, 'node_ids': [179685, 179686, 179687]}, 
 'result': True
}
```
  
### 启动 Flow
  
在创建 DataFlow 之后，DataFlow 只是静态的配置文件，还没有生成实际的计算任务，因此需要调用启动 DataFlow 的接口把 DataFlow 启动，同时建立存储数据的表
  
```python
# -*- coding: utf-8 -*-
import json
import requests
flow_id = 1 # 创建 DataFlow 时返回的 flowID
BK_DATA_URL = 'http://<BK_PAAS_HOST>/api/c/compapi/data/v3/' # 平台接口地址
headers = {"Content-Type": "application/json; charset=utf-8"}  # 请求头
data = json.dumps({
  "bk_app_code": 'data-test',  # app_code
  "bk_app_secret": 'xxxxxx', # app_secret
  "bkdata_authentication_method": "user", # 授权模式，按用户进行授权
  "bk_username": 'xxx',  # 请求接口的用户
  })
response = requests.post(
  url=BK_DATA_URL + '/dataflow/flow/flows/{fid}/start/'.format(fid=flow_id), # flow_id
  headers=headers,
  data=data
)
print("Status Code: {status_code}".format(
  status_code=response.status_code))
print("Response Body: {content}".format(
  content=response.content))
return json.loads(response.content)
```


接口返回 DataFlow 启动任务的 ID，后续可以跟据这个 ID 查询启动是否成功

```json
{"errors": null, 
 "message": "ok", 
 "code": "1500200",
 "data": {"task_id": 84507}, 
 "result": true
}
```
  

### 预览效果

以上例子创建 3 个节点的 Dataflow，第一个节点为输入的数据源，第二个节点为实时计算节点，每 5 分钟进行数据统计，最后一个节点为存储节点，将数据存储到 DB。

启动之后效果如下：

![image-20200412163554225](media/image-20200412163554225.png)



