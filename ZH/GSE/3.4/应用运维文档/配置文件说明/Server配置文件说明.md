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
| runmode          | 运行模式,1:dataserver 模式               | 默认配置，用户无需修改                                    |
| datasvrip        | 注册在 ZK 上的 IP，一般为本机内网 IP        | 安装时确定，用户无需修改                                  |
| zkhost           | zookeeper 集群                           | 安装时配置，用户无需修改，zookeeper 集群有变化时修改该配置 |
| zkauth           | zookeeper 账户密码                       | 安装时配置，用户无需修改                                  |
| dftregid         | 所属的区域 id                            | 默认配置，用户无需修改                                    |
| dftcityid        | 所属的城市 id                            | 默认配置，用户无需修改                                    |

## dataop.conf

| 字段名           | 含义                                    | 用户修改指引                                              |
|------------------|-----------------------------------------|-----------------------------------------------------------|
| log              | 程序日志落地目录路径                    | 安装时确定，用户可以修改                                  |
| password_keyfile | SSL 根证书文件路径                       | 安装时确定，用户无需修改                                  |
| cert             | SSL 证书加载路径                         | 安装时确定，用户无需修改                                  |
| runtimedata      | 运行时产生文件的路径                    | 安装时确定，用户无需修改                                  |
| level            | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可以修改                                    |
| runmode          | 运行模式，2:dataserver op 模式            | 默认配置，用户无需修改                                    |
| dataport         | 服务监听端口                            | 安装时确定，用户无需修改                                  |
| alliothread      | 工作线程数量                            | 默认配置，用户无需修改                                    |
| zkhost           | zookeeper 集群                           | 安装时配置，用户无需修改，zookeeper 集群有变化时修改该配置 |
| zkauth           | zookeeper 账户密码                       | 安装时配置，用户无需修改                                  |
| dftregid         | 所属的区域 id                            | 默认配置，用户无需修改                                    |
| dftcityid        | 所属的城市 id                            | 默认配置，用户无需修改                                    |

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
