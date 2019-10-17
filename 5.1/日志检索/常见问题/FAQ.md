# 常见问题 

1. Q: 下发采集项失败

   A: 请检查失败的IP地址是否能在作业平台正常执行脚本和下发文件。

2. Q: 下发采集项成功但是查不到数据

   A: 请检查日志是否在持续上报，采集项下发成功以后，只会采集新产生的数据，不会采集老日志。

3. Q: 如何查看索引及数据量

   A: 在中控机上 `source /data/install/utils.fc`, `curl ${ES_IP}:${ES_REST_PORT}/_cat/indices | sort | less -N`