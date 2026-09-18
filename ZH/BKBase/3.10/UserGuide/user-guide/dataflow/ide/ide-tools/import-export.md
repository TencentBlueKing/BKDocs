###  画布导出和导入
对于用户已创建的任务，用户可在工作台中通过点击相应按钮将画布拓扑信息以`json`文件的格式导出并保存。
![](../../../../assets/dataflow/ide/ide-tools/import-export/dataflow-export-or-create.png)

- 导出到本地

  通过点击导出按钮，如下所示，将当前画布以文本导出到本地文件系统，数据格式为`json`。
```json
// 基本格式样例
{
  "nodes": [
    {
      "id": 130369,
      "node_type": "stream_source",
      "bk_biz_id": 591,
      "from_nodes": [],
      "result_table_id": "591_ip_alert_parse",
      "name": "ip告警解析",
      "frontend_info": {
        "x": 199,
        "y": 219
      }
    },
    {
      "session_gap": null,
      "table_name": "f18626_s_01",
      "count_freq": null,
      "window_time": null,
      "id": 130373,
      "node_type": "realtime",
      "counter": null,
      "bk_biz_id": 591,
      "from_nodes": [
        {
          "from_result_table_ids": [
            "591_ip_alert_parse"
          ],
          "id": 130369
        }
      ],
      "output_name": "数据实时处理",
      "name": "数据实时处理",
      "frontend_info": {
        "x": 473,
        "y": 231
      },
      "waiting_time": null,
      "sql": "select type, event_desc, event_raw_id, event_source_system, \n    event_timezone, event_title, event_type, \n    bizid, cloudid, count, \n    host, ip\nfrom 591_ip_alert_parse",
      "window_type": "none"
    },
    {
      "expires": 3,
      "id": 130374,
      "node_type": "hdfs_storage",
      "bk_biz_id": 591,
      "from_nodes": [
        {
          "from_result_table_ids": [
            "591_f18626_s_01"
          ],
          "id": 130373
        }
      ],
      "result_table_id": "591_f18626_s_01",
      "name": "591_f18626_s_01(HDFS)",
      "frontend_info": {
        "x": 830,
        "y": 224
      },
      "cluster": "default"
    }
  ]
}
```

- 导入到画布

  通过导出按钮，可得到如上格式的`json`文件，通过修改必要信息，如各节点的表名(结果表不可重复)，可在一个画布中，初始化一个相同拓扑的任务。

  **值得一提的是，一方面，导入操作将清空当前任务并根据配置信息创建全新任务，另一方面，不可在已运行的画布中进行导入，即对运行中任务导入将提示失败。**

![](../../../../assets/dataflow/ide/ide-tools/import-export/dataflow-create.png)
