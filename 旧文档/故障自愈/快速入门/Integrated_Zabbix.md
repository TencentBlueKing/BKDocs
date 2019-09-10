## 集成Zabbix

Zabbix通过推送的方式，将告警推动至故障自愈的告警接收API中。

集成Zabbix统计数据展示

![-w228](../assets/15060385121293.jpg)

1. 运行初始化脚本

![](../assets/15060403024197.png)



2. Zabbix是如何发送消息给故障自愈的
执行了初始化脚本后，自愈会自动创建如下操作。自动创建名为 FTA_Ac t的 Action

![](../assets/15060403626099.jpg)

FTA_Act 这个 Action 的 Operation 会通知FTA_Mgr用户，FTA_Mgr 的通知媒介就是调用 /usr/lib/zabbix/alertscripts/zabbix_fta_alarm.py

![](../assets/15060409949390.jpg)

告警产生后在 Action log 中可以看到发给 FTA_Act 的 Message

![](../assets/15060403778865.jpg)

3. 自愈集成Zabbix告警注意事项
自愈处理告警是把 {HOST.IP} 作为故障主机IP，{ITEM.KEY} 作为告警类型，请确保 {HOST.IP} 在配置平台中注册，同时 ITEM.KEY 能被你接入的告警类型所匹配。

上图的ITEM.KEY为 system.swap.size[,pfree]被下图的 Swap 使用量(system.swap.)的规则所匹配。

![](../assets/15060407047244.jpg)

![](../assets/15060408193567.jpg)

在 /tmp/zabbix_fta_alarm.log 中可以查看到日志信息
![](../assets/15060409189531.jpg)

4. Zabbix 告警自愈历史

![](../assets/15060131567224.jpg)
