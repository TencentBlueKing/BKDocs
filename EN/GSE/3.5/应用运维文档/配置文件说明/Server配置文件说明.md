# Server 配置文件说明
## alarm.conf

| 字段名            | 含义                                    | 用户修改指引                                              |
|------------------|----------------------------------------|-----------------------------------------------------------|
| log              | 程序日志落地目录路径                    | 安装时确定，用户可以修改                                  |
| password_keyfile | SSL 根证书文件路径                       | 安装时确定，用户无需修改                                  |
| cert             | SSL 证书加载路径                         | 安装时确定，用户无需修改                                  |
| servers          | 服务绑定的 ip                            | 安装时确定，用户无需修改                                  |
| level            | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可以修改                                    |
| dataid           | 上报统计数据的 dataid                    | 默认配置，用户无需修改                                    |
| redispwd         | redis 密码                              | 安装时确定，redis 密码修改后可修改该配置                   |
| redisport        | redis 服务端口                          | 安装时确定， redis 端口修改后可修改该配置                  |
| zkhost           | zookeeper 集群                           | 安装时配置，用户无需修改，zookeeper 集群有变化时修改该配置 |
| zkauth           | zookeeper 账户密码                       | 安装时配置，用户无需修改                                  |

## api.conf

| 字段名           | 含义                                    | 用户修改指引                                              |
|------------------|-----------------------------------------|-----------------------------------------------------------|
| log              | 程序日志落地目录路径                    | 安装时确定，用户可以修改                                  |
| password_keyfile | SSL 根证书文件路径                       | 安装时确定，用户无需修改                                  |
| cert             | SSL 证书加载路径                         | 安装时确定，用户无需修改                                  |
| runtimedata      | 运行时产生文件的路径                    | 安装时确定，用户无需修改                                  |
| alliothread      | 网络收发包线程数                        | 默认配置，用户无需修改                                    |
| workerthread     | 工作线程数量                            | 默认配置，用户无需修改                                    |
| level            | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可以修改                                    |
| apiserverport    | gse_api http 接口监听的端口                       | 默认配置，用户无需修改                                    |
| redispwd         | redis 密码                              | 安装时确定，redis 密码修改后可修改该配置                   |
| redisport        | redis 服务端口                          | 安装时确定， redis 端口修改后可修改该配置                  |
| cacheApiAddr     | thrift 接口服务的监听 ip 和端口                      | 安装时确定，用户无需修改                                  |
| dbproxynodeinzk  | 发现 redis 地址的 zk 节点名                 | 默认配置，用户无需修改                                    |
| redispwd         | redis 密码                              | 安装时确定，redis 密码修改后可修改该配置                   |
| redisport        | redis 服务端口                          | 安装时确定， redis 端口修改后可修改该配置                  |
| zkhost           | zookeeper 集群                           | 安装时配置，用户无需修改，zookeeper 集群有变化时修改该配置 |
| zkauth           | zookeeper 账户密码                       | 安装时配置，用户无需修改                                  |

## btsvr.conf

| 字段名             | 含义        | 用户修改指引                                              |
|--------------------|-----------------------------|---------------------------------------|
| log                | 程序日志落地目录路径                                  | 安装时确定，用户可以修改 |
| password_keyfile   | SSL 根证书文件路径                                    | 安装时确定，用户无需修改 |
| cert               | SSL 证书加载路径                                      | 安装时确定，用户无需修改 |
| runtimedata        | 运行时产生文件的路径                                  | 安装时确定，用户无需修改 |
| alliothread        | 网络收发包线程数                                      | 默认配置，用户无需修改 |
| workerthread       | 工作线程数量                                          | 默认配置，用户无需修改 |
| level              | 日志级别, [debug,info,warn,error,fatal]               | 默认配置，用户可以修改 |
| filesvrport        | btsvr 监听的命令服务端口，该端口用于接收 agent 的文件请求 | 默认配置，用户无需修改 |
| btportstart        | bt 协议起始端口                                        | 默认配置，用户可以修改 |
| btportend          | bt 协议结束端口                                        | 默认配置，用户可以修改 |
| filesvrthriftip    | btsvr 监听的 bt/tracker/thrift 的 ip，用于 btsvr 间相互通信                     | 默认为 0.0.0.0        |
| btServerInnerIP    | 对外通讯用的内网 ip。在通知其它 btsvr 下载文件时，如果对方的 ip 是内网 ip 格式(内网保留地址)，则告诉对方访问自己的内网 ip | 安装时确定，用户可以修改            |
| btServerOuterIP    | 对外通讯用的外网 ip。在通知其它 btsvr 下载文件时，如果对方的 ip 是公网 ip 格式(公用地址)，则告诉对方访问自己的外网 ip；如果对方是公网 ip，且自己的该配置项不存在，则会报错 | 安装时确定，用户可以修改   |
| zkhost             | zookeeper 集群      | 安装时配置，用户无需修改，zookeeper 集群有变化时修改该配置 |
| zkauth             | zookeeper 账户密码  | 安装时配置，用户无需修改                                |
| dftregid           | 所属的区域 id       | 默认配置，用户无需修改                                  |
| dftcityid          | 所属的城市 id       | 默认配置，用户无需修改                                  |
| btserver_is_bridge | 桥接模式开关       | 默认配置，用户无需修改                                  |
| btserver_is_report | 数据上报开关       | 默认配置，用户无需修改                                  |

## data.conf

| 字段名           | 含义                                    | 用户修改指引                                              |
|------------------|-----------------------------------------|-----------------------------------------------------------|
| log              | 程序日志落地目录路径                    | 安装时确定，用户可以修改                                  |
| password_keyfile | SSL 根证书文件路径                       | 安装时确定，用户无需修改                                  |
| cert             | SSL 证书加载路径                         | 安装时确定，用户无需修改                                  |
| runtimedata      | 运行时产生文件的路径                    | 安装时确定，用户无需修改                                  |
| level            | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可以修改                                    |
| datasvrip        | 注册在 ZK 上的 IP，一般为本机内网 IP        | 安装时确定，用户无需修改                                  |
| zkhost           | 服务发现的 zookeeper 集群                    | 安装时配置，用户无需修改，zookeeper 集群有变化时修改该配置 |
| zkauth           | 服务发现的 zookeeper 账户密码                  | 安装时配置，用户无需修改                                  |
| channelidzkhost | 存储 channeliid 的 zookeeper 集群 | 安装时配置，用户无需修改，channelid zookeeper 集群有变化时修改该配置 |
| channelidzkauth | 存储 channelid 的 zookeeper 账户密码 | 安装时配置，用户无需修改 |
| dataflow | dataflow 配置文件路径，dataflow 配置详细说明见 dataflow.conf | 安装时配置，用户无需修改 |
| prometheus_http_svr_ip | 提供 metrics 数据服务的 IP | 安装时确定，用户无需修改 |
| prometheus_datasvr_port | 提供 metrics 据服务的端口 | 安装时确定，用户无需修改 |
| enableops | false | 默认配置，用户无需修改 |
| dftregid         | 所属的区域 id                            | 默认配置，用户无需修改                                    |
| dftcityid        | 所属的城市 id                            | 默认配置，用户无需修改                                    |


## dataflow.conf

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




## dba.conf

| 字段名           | 含义                                      | 用户修改指引                                              |
|------------------|-------------------------------------------|-----------------------------------------------------------|
| log              | 程序日志落地目录路径                      | 安装时确定，用户可以修改                                  |
| password_keyfile | SSL 根证书文件路径                         | 安装时确定，用户无需修改                                  |
| cert             | SSL 证书加载路径                           | 安装时确定，用户无需修改                                  |
| runtimedata      | 运行时产生文件的路径                      | 安装时确定，用户无需修改                                  |
| dbajsonpath      | redis 监控配置文件路径                     | 安装时确定，用户无需要修                                  |
| runmode          | 访问 redis 模式，1:pipeline 模式，2:普通模式 | 默认配置，用户无需要修改                                  |
| alliothread      | 网络收发包线程数                          | 安装时确定，用户无需要修改                                |
| workerthread     | 工作线程数量                              | 安装时确定，用户无需要修改                                |
| level            | 日志级别, [debug,info,warn,error,fatal]   | 默认配置，用户可以修改                                    |
| dbproxyport      | dbproxy 监听端口                              | 安装时确定，端口不冲突的情况下无需修改                    |
| servers          | ip， redis 服务器的 ip 地址                 | 安装时确定，用户可以根据实 redis ip 进行修改               |
| redispwd         | redis 密码                                | 安装时确定，redis 密码修改后可修改该配置                   |
| redisport        | redis 服务端口                            | 安装时确定， redis 端口修改后可修改该配置                  |
| zkhost           | zookeeper 集群                             | 安装时配置，用户无需修改，zookeeper 集群有变化时修改该配置 |
| zkauth           | zookeeper 账户密码                         | 安装时配置，用户无需修改                                  |



## procmgr.conf

| 字段名              | 含义                                    | 用户修改指引                                              |
|---------------------|-----------------------------------------|-----------------------------------------------------------|
| log                 | 程序日志落地目录路径                    | 安装时确定，用户可以修改                                  |
| password_keyfile    | SSL 根证书文件路径                       | 安装时确定，用户无需修改                                  |
| cert                | SSL 证书加载路径                         | 安装时确定，用户无需修改                                  |
| level               | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可以修改                                    |
| alliothread         | 网络收发包线程数                        | 默认配置，用户无需修改                                    |
| workerthread        | 工作线程数量                            | 默认配置，用户无需修改                                    |
| synccycle           | 进程状态同步周期，单位秒                | 默认配置，用户无需修改                                    |
| syncconcurrency     | 进程状态同步并发量                      | 默认配置，用户无需修改                                    |
| ioport              | 服务监听端口                            | 安装时确定，用户无需修改                                  |
| servers             | 服务绑定 ip 和端口                        | 安装时确定，用户无需修改                                  |
| taskserver          | 访问 gse_task 的接口地址                  | 安装时确定，用户无需修改                                  |
| mongohosts          | mongodb 地址                             | 安装时确定，mongodb 集群迁移时可修改                       |
| mongoreplicasetname | mongodb replicaset name                 | 默认配置，用户无需修改                                    |
| mongodbname         | mongodb name                            | 默认配置，用户无需修改                                    |
| mongouser           | mongodb 账户                             | 安装时配置，用户无需修改                                  |
| mongopwd            | mongodb 密码                             | 安装时配置，用户无需修改                                  |
| zkhost              | zookeeper 集群                           | 安装时配置，用户无需修改，zookeeper 集群有变化时修改该配置 |
| zkauth              | zookeeper 账户密码                       | 安装时配置，用户无需修改                                  |
| dftregid            | 所属的区域 id                            | 默认配置，用户无需修改                                    |
| dftcityid           | 所属的城市 id                            | 默认配置，用户无需修改                                    |

## syncdata.conf

| 字段名           | 含义                                    | 用户修改指引                                              |
|------------------|-----------------------------------------|-----------------------------------------------------------|
| log              | 程序日志落地目录路径                    | 安装时确定，用户可以修改                                  |
| password_keyfile | SSL 根证书文件路径                       | 安装时确定，用户无需修改                                  |
| cert             | SSL 证书加载路径                         | 安装时确定，用户无需修改                                  |
| level            | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可以修改                                    |
| alliothread      | 网络收发包线程数                        | 默认配置，用户无需修改                                    |
| workerthread     | 工作线程数量                            | 默认配置，用户无需修改                                    |
| servers          | 服务绑定 ip 和端口                        | 安装时确定，用户无需修改                                  |
| thriftport       | 访问 gse_task 的端口                      | 默认配置，用户无需修改                                    |
| ccurl            | 访问 cmdb 的接口地址                      | 安装时确定，用户无需修改                                  |
| zkhost           | zookeeper 集群                           | 安装时配置，用户无需修改，zookeeper 集群有变化时修改该配置 |
| zkauth           | zookeeper 账户密码                       | 安装时配置，用户无需修改                                  |
| dftregid         | 所属的区域 id                            | 默认配置，用户无需修改                                    |
| dftcityid        | 所属的城市 id                            | 默认配置，用户无需修改                                    |

## task.conf

| 字段名           | 含义                                        | 用户修改指引                                              |
|------------------|---------------------------------------------|-----------------------------------------------------------|
| log              | 程序日志落地目录路径                        | 安装时确定，用户可以修改                                  |
| password_keyfile | SSL 根证书文件路径                           | 安装时确定，用户无需修改                                  |
| cert             | SSL 证书加载路径                             | 安装时确定，用户无需修改                                  |
| runtimedata      | 运行时产生文件的路径                        | 安装时确定，用户无需修改                                  |
| alliothread      | 网络收发包线程数                            | 默认配置，用户无需修改                                    |
| workerthread     | 工作线程数量                                | 默认配置，用户无需修改                                    |
| level            | 日志级别, [debug,info,warn,error,fatal]     | 默认配置，用户可以修改                                    |
| thriftport       | 非规范化的 thrift 接口的服务端口              | 安装时确定，端口不冲突的情况下无需修改                    |
| thriftportV3     | 接口命名规范化后的 thrift 接口的服务端口      | 安装时确定，端口不冲突的情况下无需修改                    |
| ioport           | task 服务监听端口，用于 agent 连接任务服务                         | 安装时确定，端口不冲突的情况下无需修改                    |
| tasksvrip        | agent 连接建立的 ip, 默认监听全网段的连接请求 | 安装时确定，默认无需修改                                  |
| tasksvrthirftip  | thrift 接口提供服务的 ip                      | 安装时确定，用户可以修改                                  |
| tasksvrtrunkip   | taskserver 集群内网通信 ip                   | 安装时确定，用户可以修改                                  |
| redispwd         | redis 密码                                  | 安装时确定，可以根据 redis 实际密码修改                     |
| redisport        | redis 端口                                  | 安装时确定，可以根据 redis 实际端口修改                     |
| zkhost           | zookeeper 集群                               | 安装时配置，用户无需修改，zookeeper 集群有变化时修改该配置 |
| zkauth           | zookeeper 账户密码                           | 安装时配置，用户无需修改                                  |
| dftregid         | 所属的区域 id                                | 默认配置，用户无需修改                                    |
| dftcityid        | 所属的城市 id                                | 默认配置，用户无需修改                                    |
