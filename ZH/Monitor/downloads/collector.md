## 采集器版本及下载

采集器 | 当前版本 | 包名 | 版本情况
----|------|------|---
basereport | 10.12.x | [basereport-10.12.76.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/basereport-10.12.76.tgz) | 不再更新，换新版 bkmonitorbeat
processbeat | 1.19.x | [processbeat-1.19.71.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/processbeat-1.19.71.tgz) | 不再更新，换新版 bkmonitorbeat
exceptionbeat | 1.8.x | [exceptionbeat-1.8.44.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/exceptionbeat-1.8.44.tgz) | 不再更新，换新版 bkmonitorbeat
bkmonitorbeat | 1.24.x | [bkmonitorbeat-1.24.132.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/bkmonitorbeat-1.24.132.tgz) | 不再更新，换新版  bkmonitorbeat
bkmonitorproxy | 1.3.x | [bkmonitorproxy-1.3.49.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/bkmonitorproxy-1.3.49.tgz) |
bkunifylogbeat | 7.3.x | [bkunifylogbeat-7.3.0.104.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/bkunifylogbeat-7.3.0.104.tgz) |
gsecmdline | 2.0.x | [gsecmdline-2.0.3.tgz](https://bkopen-1252002024.file.myqcloud.com/gse_plugins/gsecmdline-2.0.3.tgz) |

## 采集器版本日志

### === basereport ===

- `basereport-10.12.76.tgz`

  【新增】新增多路径读取 gseagent/proxy cloudid 的能力

  【修复】修复空指针异常


- `basereport-10.11.66.tgz`

  【修复】修复麒麟系统信息采集的 bug


- `basereport-10.11.65.tgz`

  【优化】支持麒麟系统信息采集


- `basereport-10.11.63.tgz`

  【修复】解决国产 CPU 和操作系统信息采集不全的问题


- `basereport-10.11.62.tgz`

  【优化】优化 GetEnv collector 采集，异步化执行逻辑


- `basereport-10.11.60.tgz`

  【修复】 网卡指标采集数值溢出的问题


- `basereport-10.11.58.tgz`

  【优化】 当采集周期低于分钟时，动态调整采集次数及间隔


- `basereport-10.9.57.tgz`

  【修复】解决 basereport 采集时卡主导致调度周期出现异常 数据断点的问题


---
### === processbeat ===

- `processbeat-1.19.71.tgz`

  【修复】windows 默认子任务配置路径错误问题

  【修复】监控平台下发的进程监控任务，在 windows 下匹配命令行异常


- `processbeat-1.18.69.tgz`

  【修复】当监听 IPv6 的 0.0.0.0 时，不能正确匹配的问题


- `processbeat-1.17.68.tgz`

  【优化】优化采集进程性能数据时不上报端口数据


- `processbeat-1.17.66.tgz`

  【修复】进程采集功能偶现 reload 失效的问题


- `processbeat-1.16.63.tgz`

  【修复】 netlink 获取信息结束的判断逻辑，改为通过消息类型判断，而非判断消息为空
  
  【修复】 在 netlink 被废弃的时候，第一次获取命令信息也不会使用 netlink
  

---
### === exceptionbeat ===

- `exceptionbeat-1.8.44.tgz`

  【修复】修复 oom 读取 /dev/kmsg 的 bug


- `exceptionbeat-1.7.43.tgz`

  【修复】解决 OOM 采集时无过滤采集器启动前事件的问题

  【新增】新增对容器内环境的过滤判断，容器内不开启 OOM 采集


- `exceptionbeat-1.6.40.tgz`

  【重构】使用 kmsgparser 重构内存 OOM 事件采集


---
### === bkunifylogbeat ===

- `bkunifylogbeat-7.3.0.104.tgz`

  【特性】 BCS 配置独立目录

  【修复】 修复删除配置后，文件未立即释放问题
  
  【修复】 过滤功能支持下标为 0 的场景


- `bkunifylogbeat-7.3.0.101.tgz`

  【特性】新增支持 TQOS 数据上报协议

  【修复】修复在 lxcfs 系统下读取 uptime 文件，会导致系统卡主问题

- `bkunifylogbeat-7.3.0.100.tgz`

  【修复】修复日志采集卡主问题


- `bkunifylogbeat-7.2.77.tgz`

  【修复】因采集配置差异移除 aix 采集模块（aix 可部署 7.1.x 版本）


- `bkunifylogbeat-7.2.76.tgz`

  【新增】兼容 bklogbeat、unifyTlogc 配置及输出
  
  【新增】文件采集支持软链
  
  【新增】采集器任务管理按任务 hash 去重
  
  【修复】修复文件监听删除或过期后未移除采集进度的问题
  
  【修复】修复 windows 采集器 reload 异常的问题
  
  【优化】采集器默认监听最近 7 天的变更的文件


- `bkunifylogbeat-7.2.73.tgz`

  【新增】兼容 bklogbeat、unifyTlogc 配置及输出
  
  【新增】文件采集支持软链
  
  【新增】采集器任务管理按任务 hash 去重
  
  【修复】修复文件监听删除或过期后未移除采集进度的问题
  
  【优化】采集器默认监听最近 7 天的变更的文件


---
### === bkmonitorbeat ===
- `bkmonitorbeat-1.24.132.tgz`
  
  【更新】修复 http 拨测读取响应截取异常的问题


- `bkmonitorbeat-1.22.127.tgz`

  【修复】prometheus 指标采集开启 HTTP KeepAlive  选项


- `bkmonitorbeat-1.19.123.tgz`

  【优化】优化主机静态数据采集


- `bkmonitorbeat-1.17.119.tgz`

  【修复】修复 UDP 拨测 Endtime 未赋值的问题


- `bkmonitorbeat-1.16.118.tgz`

  【重构】关闭 trap 的 oid 自动维度上报

  【优化】修改 trap 的 content 格式为 json

  【优化】增加可配置的 oid 维度上报，oid 翻译开关以及 oid raw_byte 处理配置

  【优化】prom 采集每个指标追加一个采集时间

- `bkmonitorbeat-1.14.114.tgz`

  【aix】aix 版本更新


- `bkmonitorbeat-1.14.113.tgz`

  【aix】aix 版本更新


- `bkmonitorbeat-1.14.101.tgz`

  【优化】优化 prometheus 抓取大量数据而造成数据截断的问题

- `bkmonitorbeat-1.13.98.tgz`

  【优化】日志关键字采集增加 labels 字段的上报

  【新增】日志关键字采集增加过滤选项，用来过滤日志文本


- `bkmonitorbeat-1.13.97.tgz`

  【修复】拨测 ICMP 采集的数据中业务 ID 维度使用采集配置中的业务


- `bkmonitorbeat-1.13.95.tgz`

  【优化】发送 event 信息时用 "云区域 id:主机内网 IP" 替换 node_id


---
### === bkmonitorproxy ===

- `bkmonitorproxy-1.3.49.tgz`

  【新增】自定义事件类型支持 target 字段校验


- `bkmonitorproxy-1.2.43.tgz`

  【优化】提供数据上报校验功能，包括数据格式和数据类型的校验

  【新增】提供 consul 域名注册上报功能


---
### === gsecmdline ===

- `gsecmdline-2.0.3.tgz`

  【新增】gsecmdline 与 agent 通信的 ipc 路径（或端口）可配置
