## Agent配置文件说明
### agent.conf(gse.conf)

| 字段名           | 含义                     | 用户修改指引        |
|------------------|--------------------------|-----------------------|
| log              | 程序日志落地目录路径        | 安装时确定，用户可以修改  |
| password_keyfile | SSL根证书文件路径          | 安装时确定，用户无需修改    |
| cert             | SSL证书加载路径            | 安装时确定，用户无需修改    |
| proccfg          | 进程管理配置文件路径        | 安装时确定，用户无需修改   |
| alarmcfgpath     | 基础告警配置文件所在目录路径 | 安装时确定，用户无需修改   |
| dataipc          | 数据模块进程间通信配置   | 默认配置，用户可以修改。 对于linux，该项的值是agent创建domain socket的路径；对于window，该项的值是agent监听的端口的字符串。例如： Linux: "dataipc":"/var/run/ipc.state.report", Windows: "dataipc":"47000", |
| level            | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可以修改  |
| runmode          | agent运行模式。 0：agent同时具备proxy代理和普通agent功能；| 安装时确定，用户无需修改 |
|                  | 1：agent只具备普通agent功能；|  |
|                  | 2：agent只具备proxy代理功能。|  |
| alliothread      | 系统默认配置,不需要修改     | 默认配置，用户无需修改 |
| workerthread     | 系统默认配置,不需要修改     | 默认配置，用户无需修改 |
| ioport           | agent连接gse_task的端口         | 默认配置，用户无需修改。如需修改需要与TaskServer 和 proxy 中的该配置项保持一致    |
| filesvrport      | agent连接gse_btsvr的端口   | 默认配置，用户无需修改 |
| dataport         | agent连接gse_data的端口    | 默认配置，用户无需修改 |
| btportstart      | bt协议监听端口段的首，agent从该端口段中顺序获取一个可用端口进行监听 | 安装时确定，用户可以修改 |
| btportend        | bt协议监听端口段的尾，agent从该端口段中顺序获取一个可用端口进行监听 | 安装时确定，用户可以修改 |
| agentip          | agent连接管理ip，要求为机器网卡的ip | 安装时确定，用户可以修改     |
| identityip       | agent标识ip，与JOB/CMDB上管理的ip一致。在NAT网络下，agentip和identityip可能不同 | 安装时确定，用户可以修改  |
| zkhost           | zookeeper集群     | 安装时配置，用户无需修改，zookeeper集群有变化时修改该配置  |
| zkauth           | zookeeper账户密码 | 安装时配置，用户无需修改 |
| dftregid         | 所属区域id        | 用户无需修改  |
| dftcityid        | 所属的城市id      | 用户无需修改  |

### iagent.conf(igse.conf)

| 字段名           | 含义                        | 用户修改指引       |
|------------------|----------------------------|----------------------------|
| log              | 程序日志落地目录路径          | 安装时确定，用户可以修改 |
| password_keyfile | SSL根证书文件路径             | 安装时确定，用户无需修改 |
| cert             | SSL证书加载路径              | 安装时确定，用户无需修改 |
| proccfg          | 进程托管的配置文件路径        | 安装时确定，用户无需修改 |
| alarmcfgpath     | 基础告警配置文件所在目录路径   | 安装时确定，用户无需修改 |
| dataipc          | 数据模块进程间通信配置        | 默认配置，用户可以修改。 对于linux，该项的值是agent创建domain socket的路径；对于window，该项的值是agent监听的端口的字符串。例如： Linux: "dataipc":"/var/run/ipc.state.report", Windows: "dataipc":"47000", |
| runmode          | agent运行模式。 0：agent同时具备proxy代理和普通agent功能；| 安装时确定，用户无需修改   |
|                  | 1：agent只具备普通agent功能； |    |
|                  | 2：agent只具备proxy代理功能。 |    |
| alliothread      | 网络收发包线程数             | 安装时确定，用户无需修改 |
| workerthread     | 工作线程数量                 | 安装时确定，用户无需修改 |
| level            | 日志级别, [debug,info,warn,error,fatal]     | 默认配置，用户可以修改 |
| ioport           | agent连接gse_task的端口     | 安装时确定，端口不冲突的情况下无需修改 |
| filesvrport      | 连接gse_btsvr的端口    | 安装时确定，端口不冲突的情况下无需修改 |
| btportstart      | bt协议监听端口段的首，agent从该端口段中顺序获取一个可用端口进行监听 | 安装时确定，用户可以修改 |
| btportend        | bt协议监听端口段的尾，agent从该端口段中顺序获取一个可用端口进行监听 | 安装时确定，用户可以修改 |
| agentip          | agent连接管理ip，要求为机器网卡的ip   | 安装时确定，用户可以修改 |
| identityip       | agent标识ip，与JOB/CMDB上管理的ip一致。在NAT网络下，agentip和identityip可能不同      | 安装时确定，用户可以修改 |
| btfileserver     | 作为普通agent访问(gse_btsvr服务/proxy的gse_btsvr)的ip和端口     | 安装时确定，用户可以修改  |
| dataserver       | 作为普通agent访问(gse_data/proxy的gse_data)的ip和端口   | 安装时确定，用户可以修改  |
| taskserver       | 作为普通agent访问(gse_task/proxy代理服务)的ip和端口          | 安装时确定，用户可以修改  |
| bizid            | 开发商id         | 安装时确定，用户无需修改 |
| cloudid          | 云区域id         | 安装时确定，用户无需修改  |
| dftregid         | 所属区域id       | 用户无需修改   |
| dftcityid        | 所属的城市id     | 用户无需修改  |
