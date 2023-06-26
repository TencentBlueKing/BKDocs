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

### data.conf

| 字段名                  | 含义                                                       | 用户修改指引                                               |
| ----------------------- | ---------------------------------------------------------- | ---------------------------------------------------------- |
| log                     | 程序日志落地目录路径                                       | 安装时确定，用户可以修改                                   |
| password_keyfile        | SSL 根证书文件路径                                         | 安装时确定，用户无需修改                                   |
| cert                    | SSL 证书加载路径                                           | 安装时确定，用户无需修改                                   |
| runtimedata             | 运行时产生文件的路径                                       | 安装时确定，用户无需修改                                   |
| level                   | 日志级别, [debug,info,warn,error,fatal]                    | 默认配置，用户可以修改                                     |
| datasvrip               | 注册在 ZK 上的 IP，一般为本机内网 IP                       | 安装时确定，用户无需修改                                   |
| zkhost                  | 服务发现的 zookeeper 集群                                   | 安装时配置，用户无需修改，zookeeper 集群有变化时修改该配置 |
| dataflow                | dataflow 配置文件路径，dataflow 配置详细说明见 dataflow.conf | 安装时配置，用户无需修改                                   |
| prometheus_http_svr_ip  | 提供 metrics 数据服务的 IP                                    | 安装时确定，用户无需修改                                   |
| prometheus_datasvr_port | 提供 metrics 据服务的端口                                    | 安装时确定，用户无需修改                                   |
| enableops               | false                                                      | 默认配置，用户无需修改                                     |
| dftregid                | 所属的区域 id                                              | 默认配置，用户无需修改                                     |
| dftcityid               | 所属的城市 id                                              | 默认配置，用户无需修改                                     |


### dataflow.conf

- dataflow.conf 字段含义说明

| 字段     | 含义                                           | 用户修改指引             |
| -------- | ---------------------------------------------- | ------------------------ |
| receiver | DS 接收模块配置，用于定义接收服务器             | 安装时确定，用户可以修改 |
| exporter | DS 数据发送模块配置，用于定义数据转发模块      | 安装时确定，用户可以修改 |
| channel  | DS 数据链路配置，用于定义 dataserver 的工作流。 | 安装时确定，用户可以修改 |

- receiver 字段含义说明

| 字段       | 数据类型 | 含义                                                         | 用户修改指引             |
| ---------- | -------- | ------------------------------------------------------------ | ------------------------ |
| name       | string   | receiver 的名字，名字唯一不允许重复                           | 安装时确定，用户可以修改 |
| protocol   | int      | 枚举值：<br/> 0：未定义<br/> 1：TCP <br/> 2：UDP <br/> 3：KCP （保留编号，暂未启用）<br/> 4：HTTP | 安装时确定，用户可以修改 |
| bind       | string   | 接收服务监听的 IP                                             | 安装时确定，用户可以修改 |
| port       | int      | 接收服务监听的端口                                           | 安装时确定，用户可以修改 |
| cert       | string   | 证书存放的绝对路径                                           | 安装时确定，用户可以修改 |
| workernum  | int      | 接收数据的线程数                                             | 安装时确定，用户可以修改 |
| protostack | int      | 枚举值:<br/> 0：未定义 <br/> 1：GSE V2 版本数据传输动态协议<br/> 2: GSE V1 版本数据通信协议（所有发布版本都支持）<br/> | 安装时确定，用户可以修改 |

- exporter 字段含义说明

| 字段                    | 数据类型      | 含义                                                         | 备注                                                | 用户修改指引             |
| ----------------------- | ------------- | ------------------------------------------------------------ | --------------------------------------------------- | ------------------------ |
| name                    | string        | exporter 的名字，名字唯一不允许重复                           |                                                     | 安装时确定，用户可以修改 |
| type                    | int           | 枚举值：<br/> 9：Next DataServer （用于级联数据转发）<br />  |                                                     | 安装时确定，用户可以修改 |
| cert                    | string        | 证书存放的绝对路径                                           |                                                     | 安装时确定，用户可以修改 |
| proxyprotocol           | string        | tcp：以 tcp 协议转发给下一个节点 <br/> udp: 以 udp 协议转发给下一个节点<br />http：http 协议数据转发转发给下一节点 | type 取值 9 的时 有效                               | 安装时确定，用户可以修改 |
| heartbeat               | bool          | 是否发送心跳消息                                             | type 取值 9 的时,协议 有效                          | 安装时确定，用户可以修改 |
| proxyversion            | string        | v1: 采用 v1 版本的数据传输协议打包数据 v2：采用 v2 版本的数据传输协议打包数据（1.60.66 开始支持） | type 取值 9 的时 有效                               | 安装时确定，用户可以修改 |
| connectionnum           | int           | 与下一个节点建立连接的数量                                   | 默认与每个地址建立 2 个连接                           | 安装时确定，用户可以修改 |
| extensions              | array(string) | 在向下一个节点发送数据时需要在协议部分追加的静态信息         | 仅在 proxyversion 设置为 v2 且 type 取值 9 的时 有效 | 安装时确定，用户可以修改 |
| http_request_uri        | string        | http 转发消息到一级节点请求 URI                               | 仅在 proxyprotocol 为 http, 且 type 取值 9 的时 有效 | 安装时确定，用户可以修改 |
| is_thirdparty_cert      | bool          | http 转发到下一级节点是否使用第三方证书                       | 仅在 proxyprotocol 为 http, 且 type 取值 9 的时 有效 | 安装时确定，用户可以修改 |
| third_party_cert_passwd | string        | http 转发到下一级节点是否使用第三方证书密码                   | 仅在 proxyprotocol 为 http, 且 type 取值 9 的时 有效 | 安装时确定，用户可以修改 |
| third_party_cert        | string        | http 转发到下一级节点是否使用第三方证书文件路径               | 仅在 proxyprotocol 为 http, 且 type 取值 9 的时 有效 | 安装时确定，用户可以修改 |
| third_party_keyfile     | string        | http 转发到下一级节点是否使用第三方证书 key 文件路径            | 仅在 proxyprotocol 为 http, 且 type 取值 9 的时 有效 | 安装时确定，用户可以修改 |
| addresses               | array(object) | 地址信息，{"ip":"127.0.0.1","port":58625}，其中 ip 和 port 按需要进行调整取值 |                                                     | 安装时确定，用户可以修改 |


- channel 字段含义说明

| 字段      | 数据类型      | 含义                                                         | 用户修改指引             |
| --------- | ------------- | ------------------------------------------------------------ | ------------------------ |
| name      | string        | channel 的名字,需要保证唯一性                                 | 安装时确定，用户可以修改 |
| decode    | int           | 用于对数据解析的协议编码：<br/> 1：预留编号，未启用 <br/> 2：预留编号，未启用 <br/> 3： 内部数据传输协议<br/> 4： GSE V2 版本数据协议（从 1.60.55 版本开始支持）<br/> 5： GSE V1 版本的传输协议（所有版本都支持）<br/> 6： 内部推送的数据的协议 <br/> 7：无协议设置，不做任何解析 | 安装时确定，用户可以修改 |
| receiver  | string        | 被选中的 reciever 的名字，此名字必须在 receiver 中被定义        | 安装时确定，用户可以修改 |
| workernum | int           | 启用的线程数量，默认值为 8                                    | 安装时确定，用户可以修改 |
| exporter  | array(string) | 被选中的 exporter 的名字的集合，exporter 的名字必须在 exporter 中被定义 | 安装时确定，用户可以修改 |

