# Plug-ins and collection related

It involves functions related to the production of plug-ins and the delivery of collection tasks.

### Collection failed exit code non-zero

After collecting and delivering the update details, I found an error similar to the following:

```bash
[2020-03-18 20:32:07 ERROR] GSE restart process failed. task_id->[GSETASK:20200318203203:57196] task_result->[{"failed": [{"content": "{\n \"value \" : [\n {\n \"funcID\" : \"\",\n \"instanceID\" : \"\",\n \"procName\" : \"bkmonitorbeat\",\n \ "result\" : \"Script exit code non-zero. Error msessage: []\",\n \"setupPath\" : \"/usr/local/gse/plugins/bin\"\n }\n ] \n}\n", "bk_supplier_id": "0", "ip": "10.0.0.1", "error_code": 65535, "error_msg": "Script exit code non-zero. Error msessage: []", "bk_cloud_id": "415"}], "pending": [], "success": []}]
```

Method of exclusion: 

* Whether this machine has a corresponding process
* If a process exists, check whether there is a bkmonitorbeat process and the corresponding configuration.

### No process-related data

1. First confirm whether the CMDB is configured with process information
2. Confirm the version of processbeat in the node management and whether it is enabled

### After the collection task is issued, breakpoint data appears in the inspection view and dashboard.

1. First check whether all data has breakpoints
2. If all indicator data has breakpoints, check whether the collection period is not 1 minute. If it is greater than 1 minute, you need to draw a graph with 2 minutes as a point in the dashboard.
3. If there are breakpoints in some indicator data, it has nothing to do with the collection. Check the collection program logic.


### No data troubleshooting document

Please see [No data troubleshooting document](./nodata_faq.md) for details