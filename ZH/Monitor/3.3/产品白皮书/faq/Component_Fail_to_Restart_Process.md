# 组件监控启动 Exporter 失败，fail to restart process

## 问题描述

![-w2021](../media/15366475980839.png)

## 排查方法

1.进入作业平台，打开“执行历史”页面，按红框内的条件过滤任务列表，筛选出与组件下发时间相近任务，点击“查看详情”

![-w2021](../media/15366476048793.png)

2.进入任务详情后，查看步骤详情。记录组件名称和脚本参数

![图片描述](../media/tapd_20365752_base64_1536201059_26.png)

3.使用 job 或登录目标机器，执行脚本

假设组件名称为`oracle_exporter`，脚本参数为`--port=1521 --host=127.0.0.1`

```bash
cd /usr/local/gse/external_collector/oracle_exporter
./oracle_exporter --port=1521 --host=127.0.0.1
```

然后根据具体的错误信息解决问题

- 端口被占用：Exporter 已经启动过，kill 掉进程重新下发即可
- 对于 oracle 组件，一般是因为缺少`libclntsh.so`库
