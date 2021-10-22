## 采集器版本及下载

采集器 | 当前版本 | 包名
----|------|---
basereport | 10.11.x | [basereport-10.11.66.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/basereport-10.11.66.tgz)
processbeat | 1.17.x | [processbeat-1.18.69.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/processbeat-1.18.69.tgz)
exceptionbeat | 1.7.x | [exceptionbeat-1.8.44.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/exceptionbeat-1.8.44.tgz)
bkmonitorbeat | 1.14.x | [bkmonitorbeat-1.14.114.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/bkmonitorbeat-1.14.114.tgz)
bkmonitorproxy | 1.2.x | [bkmonitorproxy-1.2.43.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/bkmonitorproxy-1.2.43.tgz)
bkunifylogbeat | 7.2.x | [bkunifylogbeat-7.2.77.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/bkunifylogbeat-7.2.77.tgz)
gsecmdline | 2.0.x | [gsecmdline-2.0.3.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/gsecmdline-2.0.3.tgz)

## 采集器版本日志

### basereport

- basereport-10.11.66.tgz

【Fix】修复麒麟系统信息采集的 bug

- basereport-10.11.65.tgz

【Optimize】支持麒麟系统信息采集

- basereport-10.11.63.tgz

【Fixed】解决国产 CPU 和操作系统信息采集不全的问题

- basereport-10.11.62.tgz

【Optimize】优化 GetEnv collector 采集，异步化执行逻辑

- basereport-10.11.60.tgz

【修复】 网卡指标采集数值溢出的问题

- basereport-10.11.58.tgz

【优化】 当采集周期低于分钟时，动态调整采集次数及间隔

- basereport-10.9.57.tgz

【修复】解决 basereport 采集时卡主导致调度周期出现异常 数据断点的问题


### processbeat

- processbeat-1.18.69.tgz

【Bugfix】当监听IPv6的0.0.0.0时，不能正确匹配的问题

- processbeat-1.17.68.tgz

【Optimize】优化采集进程性能数据时不上报端口数据

- processbeat-1.17.66.tgz

【修复】进程采集功能偶现 reload 失效的问题

- processbeat-1.16.63.tgz

【修复】 netlink 获取信息结束的判断逻辑，改为通过消息类型判断，而非判断消息为空
【修复】 在 netlink 被废弃的时候，第一次获取命令信息也不会使用 netlink

### exceptionbeat

- exceptionbeat-1.8.44.tgz

【Fixed】修复 oom 读取 /dev/kmsg 的 bug

- exceptionbeat-1.7.43.tgz

【Fixed】解决 OOM 采集时无过滤采集器启动前事件的问题
【Added】新增对容器内环境的过滤判断，容器内不开启 OOM 采集

- exceptionbeat-1.6.40.tgz

【重构】使用 kmsgparser 重构内存 OOM 事件采集

### bkunifylogbeat

- bkunifylogbeat-7.2.77.tgz

【修复】因采集配置差异移除 aix 采集模块（aix 可部署 7.1.x 版本）

- bkunifylogbeat-7.2.76.tgz

【新增】兼容 bklogbeat、unifyTlogc 配置及输出
【新增】文件采集支持软链
【新增】采集器任务管理按任务 hash 去重
【修复】修复文件监听删除或过期后未移除采集进度的问题
【修复】修复 windows 采集器 reload 异常的问题
【优化】采集器默认监听最近 7 天的变更的文件

- bkunifylogbeat-7.2.73.tgz

【新增】兼容 bklogbeat、unifyTlogc 配置及输出
【新增】文件采集支持软链
【新增】采集器任务管理按任务 hash 去重
【修复】修复文件监听删除或过期后未移除采集进度的问题
【优化】采集器默认监听最近 7 天的变更的文件

### bkmonitorbeat

- bkmonitorbeat-1.14.114.tgz

【aix】aix 版本更新

- bkmonitorbeat-1.14.113.tgz

【aix】aix 版本更新

- bkmonitorbeat-1.14.101.tgz

【优化】优化 prometheus 抓取大量数据而造成数据截断的问题

- bkmonitorbeat-1.13.98.tgz

【优化】日志关键字采集增加 labels 字段的上报
【新增】日志关键字采集增加过滤选项，用来过滤日志文本

- bkmonitorbeat-1.13.97.tgz

【修复】拨测 ICMP 采集的数据中业务 ID 维度使用采集配置中的业务


- bkmonitorbeat-1.13.95.tgz

【优化】发送 event 信息时用"云区域 id:主机内网 IP"替换 node_id

- bkmonitorproxy-1.2.43.tgz

【优化】提供数据上报校验功能，包括数据格式和数据类型的校验
【新增】提供 consul 域名注册上报功能


### gsecmdline-2.0.3.tgz

- 【新增】gsecmdline 与 agent 通信的 ipc 路径（或端口）可配置