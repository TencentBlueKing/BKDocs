## Agent 配置文件说明
### agent.conf(gse.conf)

| 字段名           | 含义                     | 用户修改指引        |
|------------------|--------------------------|-----------------------|
| log              | 程序日志落地目录路径        | 安装时确定，用户可以修改  |
| password_keyfile | SSL 根证书文件路径          | 安装时确定，用户无需修改    |
| cert             | SSL 证书加载路径            | 安装时确定，用户无需修改    |
| proccfg          | 进程管理配置文件路径        | 安装时确定，用户无需修改   |
| alarmcfgpath     | 基础告警配置文件所在目录路径 | 安装时确定，用户无需修改   |
| dataipc          | 数据模块进程间通信配置   | 默认配置，用户可以修改。 对于 linux，该项的值是 agent 创建 domain socket 的路径；对于 Window，该项的值是 agent 监听的端口的字符串。例如： Linux: "dataipc":"/var/run/ipc.state.report", Windows: "dataipc":"47000", |
| level            | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可以修改  |
| runmode          | agent 运行模式。 0：agent 同时具备 proxy 代理和普通 agent 功能；| 安装时确定，用户无需修改 |
|                  | 1：agent 只具备普通 agent 功能；|  |
|                  | 2：agent 只具备 proxy 代理功能。|  |
| alliothread      | 系统默认配置,不需要修改     | 默认配置，用户无需修改 |
| workerthread     | 系统默认配置,不需要修改     | 默认配置，用户无需修改 |
| ioport           | agent 连接 gse_task 的端口         | 默认配置，用户无需修改。如需修改需要与 TaskServer 和 proxy 中的该配置项保持一致    |
| filesvrport      | agent 连接 gse_btsvr 的端口   | 默认配置，用户无需修改 |
| dataport         | agent 连接 gse_data 的端口    | 默认配置，用户无需修改 |
| btportstart      | bt 协议监听端口段的首，agent 从该端口段中顺序获取一个可用端口进行监听 | 安装时确定，用户可以修改 |
| btportend        | bt 协议监听端口段的尾，agent 从该端口段中顺序获取一个可用端口进行监听 | 安装时确定，用户可以修改 |
| agentip          | agent 连接管理 ip，要求为机器网卡的 ip | 安装时确定，用户可以修改     |
| identityip       | agent 标识 ip，与 JOB/CMDB 上管理的 ip 一致。在 NAT 网络下，agentip 和 identityip 可能不同 | 安装时确定，用户可以修改  |
| zkhost           | zookeeper 集群     | 安装时配置，用户无需修改，zookeeper 集群有变化时修改该配置  |
| zkauth           | zookeeper 账户密码 | 安装时配置，用户无需修改 |
| dftregid         | 所属区域 id        | 用户无需修改  |
| dftcityid        | 所属的城市 id      | 用户无需修改  |

### iagent.conf(igse.conf)

| 字段名           | 含义                        | 用户修改指引       |
|------------------|----------------------------|----------------------------|
| log              | 程序日志落地目录路径          | 安装时确定，用户可以修改 |
| password_keyfile | SSL 根证书文件路径             | 安装时确定，用户无需修改 |
| cert             | SSL 证书加载路径              | 安装时确定，用户无需修改 |
| proccfg          | 进程托管的配置文件路径        | 安装时确定，用户无需修改 |
| alarmcfgpath     | 基础告警配置文件所在目录路径   | 安装时确定，用户无需修改 |
| dataipc          | 数据模块进程间通信配置        | 默认配置，用户可以修改。 对于 linux，该项的值是 agent 创建 domain socket 的路径；对于 Window，该项的值是 agent 监听的端口的字符串。例如： Linux: "dataipc":"/var/run/ipc.state.report", Windows: "dataipc":"47000", |
| runmode          | agent 运行模式。 0：agent 同时具备 proxy 代理和普通 agent 功能；| 安装时确定，用户无需修改   |
|                  | 1：agent 只具备普通 agent 功能； |    |
|                  | 2：agent 只具备 proxy 代理功能。 |    |
| alliothread      | 网络收发包线程数             | 安装时确定，用户无需修改 |
| workerthread     | 工作线程数量                 | 安装时确定，用户无需修改 |
| level            | 日志级别, [debug,info,warn,error,fatal]     | 默认配置，用户可以修改 |
| ioport           | agent 连接 gse_task 的端口     | 安装时确定，端口不冲突的情况下无需修改 |
| filesvrport      | 连接 gse_btsvr 的端口    | 安装时确定，端口不冲突的情况下无需修改 |
| btportstart      | bt 协议监听端口段的首，agent 从该端口段中顺序获取一个可用端口进行监听 | 安装时确定，用户可以修改 |
| btportend        | bt 协议监听端口段的尾，agent 从该端口段中顺序获取一个可用端口进行监听 | 安装时确定，用户可以修改 |
| agentip          | agent 连接管理 ip，要求为机器网卡的 ip   | 安装时确定，用户可以修改 |
| identityip       | agent 标识 ip，与 JOB/CMDB 上管理的 ip 一致。在 NAT 网络下，agentip 和 identityip 可能不同      | 安装时确定，用户可以修改 |
| btfileserver     | 作为普通 agent 访问(gse_btsvr 服务/proxy 的 gse_btsvr)的 ip 和端口     | 安装时确定，用户可以修改  |
| dataserver       | 作为普通 agent 访问(gse_data/proxy 的 gse_data)的 ip 和端口   | 安装时确定，用户可以修改  |
| taskserver       | 作为普通 agent 访问(gse_task/proxy 代理服务)的 ip 和端口          | 安装时确定，用户可以修改  |
| bizid            | 开发商 id         | 安装时确定，用户无需修改 |
| cloudid          | 云区域 id         | 安装时确定，用户无需修改  |
| dftregid         | 所属区域 id       | 用户无需修改   |
| dftcityid        | 所属的城市 id     | 用户无需修改  |
