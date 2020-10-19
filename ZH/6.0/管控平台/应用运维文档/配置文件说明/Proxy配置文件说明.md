## Proxy配置文件说明

### btsvr.conf

| 字段名                    | 含义                    | 用户修改指引            |
|---------------------------|------------------------|------------------------|
| log                       | 程序日志落地目录路径     | 安装时确定，用户可以修改 |
| password_keyfile          | SSL根证书文件路径       | 安装时确定，用户无需修改 |
| cert                      | SSL证书加载路径         | 安装时确定，用户无需修改 |
| runtimedata               | 运行时产生文件的路径     | 安装时确定，用户无需修改 |
| alliothread               | 系统默认配置,不需要修改  | 默认配置，用户无需修改   |
| workerthread              | 系统默认配置,不需要修改  | 默认配置，用户无需修改   |
| level                     | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可以修改 |
| filesvrport               | btsvr监听的命令服务端口，该端口用于接收agent的文件请求 | 默认配置，用户无需修改 |
| btportstart               | bt协议起始端口           | 默认配置，用户可以修改 |
| btportend                 | bt协议结束端口           | 默认配置，用户可以修改 |
| btzkflag                  | 是否访问zk标志位         | 默认配置，用户无需修改 |
| filesvrthriftip           | btsvr 监听的bt/tracker/thrift的ip，用户btsvr之间通信 | 安装时确定，用户可以修改为0.0.0.0 |
| btServerInnerIP           | 对外通讯用的内网ip。在通知其它btsvr下载文件时，如果对方的ip是内网ip格式(内网保留地址)，则告诉对方访问自己的内网ip     | 安装时确定，用户可以修改          |
| btServerOuterIP           | 对外通讯用的外网ip。在通知其它btsvr下载文件时，如果对方的ip是公网ip格式(公用地址)，则告诉对方访问自己的外网ip；如果对方是公网ip，且自己的该配置项不存在，则会报错 | 安装时确定，用户可以修改      |
| btfilesvrscfg.ip          | 上级gse_btsvr的ip   | 安装时确定，用户无需修改 |
| btfilesvrscfg.compId      | 上级gse_btsvr的gse_composite_id | 默认配置，用户无需修改 |
| btfilesvrscfg.isTransmit  | 是否转发标志位       | 默认配置，用户无需修改  |
| btfilesvrscfg.tcpPort     | tcp直传端口         | 默认配置，用户无需修改 |
| btfilesvrscfg.thriftPort  | gse_btsvr间通讯端口 | 默认配置，用户无需修改 |
| btfilesvrscfg.btPort      | bt协议端口          | 默认配置，用户无需修改 |
| btfilesvrscfg.trackerPort | tracker服务端口     | 默认配置，用户无需修改 |
| bizid                     | 开发商id            | 安装时确定，用户无需修改 |
| cloudid                   | 云区域id            | 安装时确定，用户无需修改 |
| dftregid                  | 所属的区域id        | 默认配置，用户无需修改 |
| dftcityid                 | 所属的城市id        | 默认配置，用户无需修改 |



### proxy.conf

| 字段名           | 含义                        | 用户修改指引     |
|------------------|----------------------------|------------------------------|
| log              | 程序日志落地目录路径         | 安装时确定，用户可以修改 |
| password_keyfile | SSL根证书文件路径           | 安装时确定，用户无需修改 |
| cert             | SSL证书加载路径             | 安装时确定，用户无需修改 |
| proccfg          | 进程托管的配置文件路径       | 安装时确定，用户无需修改 |
| alarmcfgpath     | 基础告警配置文件所在目录路径 | 安装时确定，用户无需修改  |
| dataipc          | 数据模块进程间通信配置    | 默认配置，用户可以修改。 对于linux，该项的值是agent创建domain socket的路径；对于window，该项的值是agent监听的端口的字符串。例如： Linux: "dataipc":"/var/run/ipc.state.report", Windows: "dataipc":"47000", |
| runmode          | agent运行模式。 0：agent同时具备proxy代理和普通agent功能；| 安装时确定，用户在安装级联proxy agent时可修改 |
|                  | 1：agent只具备普通agent功能；|  |
|                  | 2：agent只具备proxy代理功能。|  |
| alliothread      | 网络收发包线程数    | 安装时确定，用户无需修改  |
| workerthread     | 工作线程数量        | 安装时确定，用户无需修改  |
| level            | 日志级别, [debug,info,warn,error,fatal]    | 默认配置，用户可以修改 |
| ioport           | proxy代理服务监听端口  | 安装时确定，端口不冲突的情况下无需修改    |
| btportstart      | bt协议监听端口段的首，agent从该端口段中顺序获取一个可用端口进行监听 | 安装时确定，用户可以修改 |
| btportend        | bt协议监听端口段的尾，agent从该端口段中顺序获取一个可用端口进行监听 | 安装时确定，用户可以修改 |
| proxylistenip    | proxy代理服务监听的内网ip地址，用于agent连接建立  | 安装时确定，用户可以修改   |
| agentip          | agent连接管理ip，要求为机器网卡的ip       | 安装时确定，用户可以修改   |
| identityip       | agent标识ip，与JOB/CMDB上管理的ip一致。在NAT网络下，agentip和identityip可能不同 | 安装时确定，用户可以修改   |
| proxytaskserver  | 访问上级gse_task或proxy(级联proxy的情况下)的ip和端口  | 安装时确定，用户可以修改  |
| btfileserver     | agent访问proxy的gse_btsvr服务的ip和端口       | 安装时确定，用户可以修改   |
| dataserver       | agent访问proxy的gse_transit服务的ip和端口  | 安装时确定，用户可以修改  |
| taskserver       | agent访问proxy 代理服务的ip和端口     | 安装时确定，用户可以修改    |
| bizid            | 开发商id          | 安装时确定，用户无需修改 |
| cloudid          | 云区域id          | 安装时确定，用户无需修改 |
| dftregid         | 所属区域id        | 用户无需修改 |
| dftcityid        | 所属的城市id      | 用户无需修改 |

### transit.conf

| 字段名           | 含义                                    | 用户修改指引             |
|------------------|---------------------------------------|--------------------------|
| log              | 程序日志落地目录路径                    | 安装时确定，用户可以修改 |
| password_keyfile | SSL根证书文件路径                       | 安装时确定，用户无需修改 |
| cert             | SSL证书加载路径                         | 安装时确定，用户无需修改 |
| runtimedata      | 运行时产生文件的路径                    | 安装时确定，用户无需修改 |
| level            | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可已修改   |
| runmode          | 运行模式                                | 默认配置，用户无需修改   |
| transitworker    | 工作线程个数                            | 默认配置，用户无需修改   |
| dataserver       | 目标gse_data的IP和端口                  | 安装时确定，用户可已修改 |
| transitserver    | 服务绑定IP和端口                        | 安装时确定，用户可已修改 |
| bizid            | 开发商id                                | 安装时确定，用户无需修改 |
| cloudid          | 云区域id                                | 安装时确定，用户无需修改 |
