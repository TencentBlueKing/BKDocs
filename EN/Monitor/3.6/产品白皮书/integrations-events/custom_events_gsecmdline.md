# 字符型告警-gsecmdline

## 不推荐说明

自定义字符型告警是比较早期的用法，为了兼容早期的使用，使用上确实也是非常的简单易用，但有如下几个问题无法扩展

1. 所有上报数据只能有相同的告警策略，最多按监控目标范围进行区分，无法区分事件本身。
2. 没有办法收敛，不能分组，不能基于数据条件进行分类。 

所以更推荐使用 [自定义事件-HTTP上报](custom_events_http.md)

## 如何配置告警策略

### 默认策略

默认策略中，存在一个“自定义字符型告警”策略，会将告警发送给机器的主备负责人。即在哪台机器发送数据处理，即会发送给该IP的主备负责人。
![](media/16613229739162.jpg)

### 新增策略

如需创建更多范围的匹配策略，如下所示

![](media/16613230013888.jpg)

![](media/16613230341581.jpg)


## 上报数据

如何用命令发送告警

Linux用法：
```
/usr/local/gse_bkte/plugins/bin/gsecmdline -d 1100000 -l "This service is offline."
```
注意：此命令只需修改"This service is offline."引号内的字符即可，1100000为内置的data_id，不可以修改。

版本要求：/usr/local/gse_bkte/plugins/bin/gsecmdline -v 输出版本需>= 2.0.2，如版本不满足要求，请到节点管理更新二进制

windows用法：

```
c:/gse_bkte/plugins/bin/gsecmdline.exe -d 1100000 -l "This service is offline."
```





