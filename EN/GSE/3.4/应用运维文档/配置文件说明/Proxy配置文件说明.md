## Proxy 配置文件说明

### btsvr.conf

| 字段名                    | 含义                    | 用户修改指引            |
|---------------------------|------------------------|------------------------|
| log                       | 程序日志落地目录路径     | 安装时确定，用户可以修改 |
| password_keyfile          | SSL 根证书文件路径       | 安装时确定，用户无需修改 |
| cert                      | SSL 证书加载路径         | 安装时确定，用户无需修改 |
| runtimedata               | 运行时产生文件的路径     | 安装时确定，用户无需修改 |
| alliothread               | 系统默认配置,不需要修改  | 默认配置，用户无需修改   |
| workerthread              | 系统默认配置,不需要修改  | 默认配置，用户无需修改   |
| level                     | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可以修改 |
| filesvrport               | btsvr 监听的命令服务端口，该端口用于接收 agent 的文件请求 | 默认配置，用户无需修改 |
| btportstart               | bt 协议起始端口           | 默认配置，用户可以修改 |
| btportend                 | bt 协议结束端口           | 默认配置，用户可以修改 |
| btzkflag                  | 是否访问 zk 标志位         | 默认配置，用户无需修改 |
| filesvrthriftip           | btsvr 监听的 bt/tracker/thrift 的 ip，用户 btsvr 之间通信 | 安装时确定，用户可以修改为 0.0.0.0 |
| btServerInnerIP           | 对外通讯用的内网 ip。在通知其它 btsvr 下载文件时，如果对方的 ip 是内网 ip 格式(内网保留地址)，则告诉对方访问自己的内网 ip     | 安装时确定，用户可以修改          |
| btServerOuterIP           | 对外通讯用的外网 ip。在通知其它 btsvr 下载文件时，如果对方的 ip 是公网 ip 格式(公用地址)，则告诉对方访问自己的外网 ip；如果对方是公网 ip，且自己的该配置项不存在，则会报错 | 安装时确定，用户可以修改      |
| btfilesvrscfg.ip          | 上级 gse_btsvr 的 ip   | 安装时确定，用户无需修改 |
| btfilesvrscfg.compId      | 上级 gse_btsvr 的 gse_composite_id | 默认配置，用户无需修改 |
| btfilesvrscfg.isTransmit  | 是否转发标志位       | 默认配置，用户无需修改  |
| btfilesvrscfg.tcpPort     | tcp 直传端口         | 默认配置，用户无需修改 |
| btfilesvrscfg.thriftPort  | gse_btsvr 间通讯端口 | 默认配置，用户无需修改 |
| btfilesvrscfg.btPort      | bt 协议端口          | 默认配置，用户无需修改 |
| btfilesvrscfg.trackerPort | tracker 服务端口     | 默认配置，用户无需修改 |
| bizid                     | 开发商 id            | 安装时确定，用户无需修改 |
| cloudid                   | 云区域 id            | 安装时确定，用户无需修改 |
| dftregid                  | 所属的区域 id        | 默认配置，用户无需修改 |
| dftcityid                 | 所属的城市 id        | 默认配置，用户无需修改 |



### proxy.conf

| 字段名           | 含义                        | 用户修改指引     |
|------------------|----------------------------|------------------------------|
| log              | 程序日志落地目录路径         | 安装时确定，用户可以修改 |
| password_keyfile | SSL 根证书文件路径           | 安装时确定，用户无需修改 |
| cert             | SSL 证书加载路径             | 安装时确定，用户无需修改 |
| proccfg          | 进程托管的配置文件路径       | 安装时确定，用户无需修改 |
| alarmcfgpath     | 基础告警配置文件所在目录路径 | 安装时确定，用户无需修改  |
| dataipc          | 数据模块进程间通信配置    | 默认配置，用户可以修改。 对于 linux，该项的值是 agent 创建 domain socket 的路径；对于 Window，该项的值是 agent 监听的端口的字符串。例如： Linux: "dataipc":"/var/run/ipc.state.report", Windows: "dataipc":"47000", |
| runmode          | agent 运行模式。 0：agent 同时具备 proxy 代理和普通 agent 功能；| 安装时确定，用户在安装级联 proxy agent 时可修改 |
|                  | 1：agent 只具备普通 agent 功能；|  |
|                  | 2：agent 只具备 proxy 代理功能。|  |
| alliothread      | 网络收发包线程数    | 安装时确定，用户无需修改  |
| workerthread     | 工作线程数量        | 安装时确定，用户无需修改  |
| level            | 日志级别, [debug,info,warn,error,fatal]    | 默认配置，用户可以修改 |
| ioport           | proxy 代理服务监听端口  | 安装时确定，端口不冲突的情况下无需修改    |
| btportstart      | bt 协议监听端口段的首，agent 从该端口段中顺序获取一个可用端口进行监听 | 安装时确定，用户可以修改 |
| btportend        | bt 协议监听端口段的尾，agent 从该端口段中顺序获取一个可用端口进行监听 | 安装时确定，用户可以修改 |
| proxylistenip    | proxy 代理服务监听的内网 ip 地址，用于 agent 连接建立  | 安装时确定，用户可以修改   |
| agentip          | agent 连接管理 ip，要求为机器网卡的 ip       | 安装时确定，用户可以修改   |
| identityip       | agent 标识 ip，与 JOB/CMDB 上管理的 ip 一致。在 NAT 网络下，agentip 和 identityip 可能不同 | 安装时确定，用户可以修改   |
| proxytaskserver  | 访问上级 gse_task 或 proxy(级联 proxy 的情况下)的 ip 和端口  | 安装时确定，用户可以修改  |
| btfileserver     | agent 访问 proxy 的 gse_btsvr 服务的 ip 和端口       | 安装时确定，用户可以修改   |
| dataserver       | agent 访问 proxy 的 gse_transit 服务的 ip 和端口  | 安装时确定，用户可以修改  |
| taskserver       | agent 访问 proxy 代理服务的 ip 和端口     | 安装时确定，用户可以修改    |
| bizid            | 开发商 id          | 安装时确定，用户无需修改 |
| cloudid          | 云区域 id          | 安装时确定，用户无需修改 |
| dftregid         | 所属区域 id        | 用户无需修改 |
| dftcityid        | 所属的城市 id      | 用户无需修改 |

### transit.conf

| 字段名           | 含义                                    | 用户修改指引             |
|------------------|---------------------------------------|--------------------------|
| log              | 程序日志落地目录路径                    | 安装时确定，用户可以修改 |
| password_keyfile | SSL 根证书文件路径                       | 安装时确定，用户无需修改 |
| cert             | SSL 证书加载路径                         | 安装时确定，用户无需修改 |
| runtimedata      | 运行时产生文件的路径                    | 安装时确定，用户无需修改 |
| level            | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可已修改   |
| runmode          | 运行模式                                | 默认配置，用户无需修改   |
| transitworker    | 工作线程个数                            | 默认配置，用户无需修改   |
| dataserver       | 目标 gse_data 的 IP 和端口                  | 安装时确定，用户可已修改 |
| transitserver    | 服务绑定 IP 和端口                        | 安装时确定，用户可已修改 |
| bizid            | 开发商 id                                | 安装时确定，用户无需修改 |
| cloudid          | 云区域 id                                | 安装时确定，用户无需修改 |
