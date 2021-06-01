# 插件和采集相关

涉及到插件的制作和采集任务下发相关的功能。 

### 采集失败 exit code non-zero

采集下发查看更新详情发现类似如下报错：

```bash
[2020-03-18 20:32:07 ERROR] GSE restart process failed. task_id->[GSETASK:20200318203203:57196] task_result->[{"failed": [{"content": "{\n   \"value\" : [\n      {\n         \"funcID\" : \"\",\n         \"instanceID\" : \"\",\n         \"procName\" : \"bkmonitorbeat\",\n         \"result\" : \"Script exit code non-zero. Error msessage: []\",\n         \"setupPath\" : \"/usr/local/gse/plugins/bin\"\n      }\n   ]\n}\n", "bk_supplier_id": "0", "ip": "10.21.64.14", "error_code": 65535, "error_msg": "Script exit code non-zero. Error msessage: []", "bk_cloud_id": "415"}], "pending": [], "success": []}]
```

排除方法： 

* 本机是否有对应的进程 
* 如果存在进程，查看是否存在 bkmonitorbeat 进程和对应的配置

### 无进程相关的数据

1. 先确认 CMDB 是否配置了进程信息
2. 再确认 processbeat 在节点管理中的版本和是否已经启用

### 采集任务下发后在检查视图和仪表盘中出现了断点的数据

1. 先检查是不是所有的数据都有断点
2. 如果是所有指标数据都有断点，查看采集周期是否不为 1 分钟，如果是大于 1 分钟的在仪表盘中需要以 2 分钟为一个点进行画图
3. 如果是部分指标数据有断点，那么就和采集没有关系，检查采集的程序逻辑


### 无数据排查文档

具体查看[无数据排查文档](./nodata_faq.md)


