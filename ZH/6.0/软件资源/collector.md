## 采集器版本及下载

采集器 | 当前版本 | 包名
----|------|---
basereport | 10.9.x | [basereport-10.9.57.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/basereport-10.9.57.tgz)
processbeat | 1.16.x | [processbeat-1.16.63.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/processbeat-1.16.63.tgz)
exceptionbeat | 1.6.x | [exceptionbeat-1.6.40.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/exceptionbeat-1.6.40.tgz)
bkmonitorbeat | 1.14.x | [bkmonitorbeat-1.14.105.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/bkmonitorbeat-1.14.105.tgz)
bkmonitorproxy | 1.2.x | [bkmonitorproxy-1.2.43.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/bkmonitorproxy-1.2.43.tgz)
bkunifylogbeat | 7.2.x | [bkunifylogbeat-7.2.76.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/bkunifylogbeat-7.2.76.tgz)
gsecmdline | 2.0.x | [gsecmdline-2.0.3.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/gsecmdline-2.0.3.tgz)


## 采集器版本日志


### basereport-10.9.57.tgz

- 【修复】解决 basereport 采集时卡主导致调度周期出现异常 数据断点的问题

### processbeat-1.16.63.tgz

- 【修复】 netlink获取信息结束的判断逻辑，改为通过消息类型判断，而非判断消息为空
- 【修复】 在netlink被废弃的时候，第一次获取命令信息也不会使用netlink


### exceptionbeat-1.6.40.tgz

- 【重构】使用 kmsgparser 重构内存 OOM 事件采集

### bkunifylogbeat-7.2.73.tgz

- 【新增】兼容bklogbeat、unifyTlogc配置及输出
- 【新增】文件采集支持软链
- 【新增】采集器任务管理按任务hash去重
- 【修复】修复文件监听删除或过期后未移除采集进度的问题
- 【优化】采集器默认监听最近7天的变更的文件

### bkmonitorbeat

#### bkmonitorbeat-1.14.105.tgz

无

#### bkmonitorbeat-1.14.101.tgz

- 【优化】优化 prometheus 抓取大量数据而造成数据截断的问题


#### bkmonitorbeat-1.13.98.tgz

- 【优化】日志关键字采集增加labels字段的上报
- 【新增】日志关键字采集增加过滤选项，用来过滤日志文本

#### bkmonitorbeat-1.13.97.tgz

- 【修复】拨测ICMP采集的数据中业务ID维度使用采集配置中的业务


#### bkmonitorbeat-1.13.95.tgz

- 【优化】发送event信息时用"云区域id:主机内网IP"替换node_id

### bkmonitorproxy-1.2.43.tgz

- 【优化】提供数据上报校验功能，包括数据格式和数据类型的校验
- 【新增】提供 consul 域名注册上报功能


### bkunifylogbeat-7.2.76.tgz

- 【新增】兼容bklogbeat、unifyTlogc配置及输出
- 【新增】文件采集支持软链
- 【新增】采集器任务管理按任务hash去重
- 【修复】修复文件监听删除或过期后未移除采集进度的问题
- 【修复】修复windows采集器reload异常的问题
- 【优化】采集器默认监听最近7天的变更的文件


### gsecmdline-2.0.3.tgz

- 【新增】gsecmdline与agent通信的ipc路径（或端口）可配置