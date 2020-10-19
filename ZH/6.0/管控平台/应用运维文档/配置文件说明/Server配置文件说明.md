# Server配置文件说明
## alarm.conf

| 字段名            | 含义                                    | 用户修改指引                                              |
|------------------|----------------------------------------|-----------------------------------------------------------|
| log              | 程序日志落地目录路径                    | 安装时确定，用户可以修改                                  |
| password_keyfile | SSL根证书文件路径                       | 安装时确定，用户无需修改                                  |
| cert             | SSL证书加载路径                         | 安装时确定，用户无需修改                                  |
| servers          | 服务绑定的ip                            | 安装时确定，用户无需修改                                  |
| level            | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可以修改                                    |
| dataid           | 上报统计数据的dataid                    | 默认配置，用户无需修改                                    |
| redispwd         | redis 密码                              | 安装时确定，redis密码修改后可修改该配置                   |
| redisport        | redis 服务端口                          | 安装时确定， redis端口修改后可修改该配置                  |
| zkhost           | zookeeper集群                           | 安装时配置，用户无需修改，zookeeper集群有变化时修改该配置 |
| zkauth           | zookeeper账户密码                       | 安装时配置，用户无需修改                                  |

## api.conf

| 字段名           | 含义                                    | 用户修改指引                                              |
|------------------|-----------------------------------------|-----------------------------------------------------------|
| log              | 程序日志落地目录路径                    | 安装时确定，用户可以修改                                  |
| password_keyfile | SSL根证书文件路径                       | 安装时确定，用户无需修改                                  |
| cert             | SSL证书加载路径                         | 安装时确定，用户无需修改                                  |
| runtimedata      | 运行时产生文件的路径                    | 安装时确定，用户无需修改                                  |
| alliothread      | 网络收发包线程数                        | 默认配置，用户无需修改                                    |
| workerthread     | 工作线程数量                            | 默认配置，用户无需修改                                    |
| level            | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可以修改                                    |
| apiserverport    | gse_api http接口监听的端口                       | 默认配置，用户无需修改                                    |
| redispwd         | redis 密码                              | 安装时确定，redis密码修改后可修改该配置                   |
| redisport        | redis 服务端口                          | 安装时确定， redis端口修改后可修改该配置                  |
| cacheApiAddr     | thrift接口服务的监听ip和端口                      | 安装时确定，用户无需修改                                  |
| dbproxynodeinzk  | 发现redis地址的zk节点名                 | 默认配置，用户无需修改                                    |
| redispwd         | redis 密码                              | 安装时确定，redis密码修改后可修改该配置                   |
| redisport        | redis 服务端口                          | 安装时确定， redis端口修改后可修改该配置                  |
| zkhost           | zookeeper集群                           | 安装时配置，用户无需修改，zookeeper集群有变化时修改该配置 |
| zkauth           | zookeeper账户密码                       | 安装时配置，用户无需修改                                  |

## btsvr.conf

| 字段名             | 含义        | 用户修改指引                                              |
|--------------------|-----------------------------|---------------------------------------|
| log                | 程序日志落地目录路径                                  | 安装时确定，用户可以修改 |
| password_keyfile   | SSL根证书文件路径                                    | 安装时确定，用户无需修改 |
| cert               | SSL证书加载路径                                      | 安装时确定，用户无需修改 |
| runtimedata        | 运行时产生文件的路径                                  | 安装时确定，用户无需修改 |
| alliothread        | 网络收发包线程数                                      | 默认配置，用户无需修改 |
| workerthread       | 工作线程数量                                          | 默认配置，用户无需修改 |
| level              | 日志级别, [debug,info,warn,error,fatal]               | 默认配置，用户可以修改 |
| filesvrport        | btsvr监听的命令服务端口，该端口用于接收 agent 的文件请求 | 默认配置，用户无需修改 |
| btportstart        | bt协议起始端口                                        | 默认配置，用户可以修改 |
| btportend          | bt协议结束端口                                        | 默认配置，用户可以修改 |
| filesvrthriftip    | btsvr 监听的bt/tracker/thrift的ip，用于btsvr间相互通信                     | 默认为0.0.0.0        |
| btServerInnerIP    | 对外通讯用的内网ip。在通知其它btsvr下载文件时，如果对方的ip是内网ip格式(内网保留地址)，则告诉对方访问自己的内网 ip | 安装时确定，用户可以修改            |
| btServerOuterIP    | 对外通讯用的外网ip。在通知其它btsvr下载文件时，如果对方的ip是公网ip格式(公用地址)，则告诉对方访问自己的外网ip；如果对方是公网ip，且自己的该配置项不存在，则会报错 | 安装时确定，用户可以修改   |
| zkhost             | zookeeper集群      | 安装时配置，用户无需修改，zookeeper集群有变化时修改该配置 |
| zkauth             | zookeeper账户密码  | 安装时配置，用户无需修改                                |
| dftregid           | 所属的区域id       | 默认配置，用户无需修改                                  |
| dftcityid          | 所属的城市id       | 默认配置，用户无需修改                                  |
| btserver_is_bridge | 桥接模式开关       | 默认配置，用户无需修改                                  |
| btserver_is_report | 数据上报开关       | 默认配置，用户无需修改                                  |

## data.conf

| 字段名           | 含义                                    | 用户修改指引                                              |
|------------------|-----------------------------------------|-----------------------------------------------------------|
| log              | 程序日志落地目录路径                    | 安装时确定，用户可以修改                                  |
| password_keyfile | SSL根证书文件路径                       | 安装时确定，用户无需修改                                  |
| cert             | SSL证书加载路径                         | 安装时确定，用户无需修改                                  |
| runtimedata      | 运行时产生文件的路径                    | 安装时确定，用户无需修改                                  |
| level            | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可以修改                                    |
| runmode          | 运行模式,1:dataserver模式               | 默认配置，用户无需修改                                    |
| datasvrip        | 注册在ZK上的IP，一般为本机内网IP        | 安装时确定，用户无需修改                                  |
| zkhost           | zookeeper集群                           | 安装时配置，用户无需修改，zookeeper集群有变化时修改该配置 |
| zkauth           | zookeeper账户密码                       | 安装时配置，用户无需修改                                  |
| dftregid         | 所属的区域id                            | 默认配置，用户无需修改                                    |
| dftcityid        | 所属的城市id                            | 默认配置，用户无需修改                                    |

## dataop.conf

| 字段名           | 含义                                    | 用户修改指引                                              |
|------------------|-----------------------------------------|-----------------------------------------------------------|
| log              | 程序日志落地目录路径                    | 安装时确定，用户可以修改                                  |
| password_keyfile | SSL根证书文件路径                       | 安装时确定，用户无需修改                                  |
| cert             | SSL证书加载路径                         | 安装时确定，用户无需修改                                  |
| runtimedata      | 运行时产生文件的路径                    | 安装时确定，用户无需修改                                  |
| level            | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可以修改                                    |
| runmode          | 运行模式，2:dataserver op模式            | 默认配置，用户无需修改                                    |
| dataport         | 服务监听端口                            | 安装时确定，用户无需修改                                  |
| alliothread      | 工作线程数量                            | 默认配置，用户无需修改                                    |
| zkhost           | zookeeper集群                           | 安装时配置，用户无需修改，zookeeper集群有变化时修改该配置 |
| zkauth           | zookeeper账户密码                       | 安装时配置，用户无需修改                                  |
| dftregid         | 所属的区域id                            | 默认配置，用户无需修改                                    |
| dftcityid        | 所属的城市id                            | 默认配置，用户无需修改                                    |

## dba.conf

| 字段名           | 含义                                      | 用户修改指引                                              |
|------------------|-------------------------------------------|-----------------------------------------------------------|
| log              | 程序日志落地目录路径                      | 安装时确定，用户可以修改                                  |
| password_keyfile | SSL根证书文件路径                         | 安装时确定，用户无需修改                                  |
| cert             | SSL证书加载路径                           | 安装时确定，用户无需修改                                  |
| runtimedata      | 运行时产生文件的路径                      | 安装时确定，用户无需修改                                  |
| dbajsonpath      | redis监控配置文件路径                     | 安装时确定，用户无需要修                                  |
| runmode          | 访问redis模式，1:pipeline模式，2:普通模式 | 默认配置，用户无需要修改                                  |
| alliothread      | 网络收发包线程数                          | 安装时确定，用户无需要修改                                |
| workerthread     | 工作线程数量                              | 安装时确定，用户无需要修改                                |
| level            | 日志级别, [debug,info,warn,error,fatal]   | 默认配置，用户可以修改                                    |
| dbproxyport      | dbproxy监听端口                              | 安装时确定，端口不冲突的情况下无需修改                    |
| servers          | ip， redis 服务器的ip地址                 | 安装时确定，用户可以根据实redis ip 进行修改               |
| redispwd         | redis 密码                                | 安装时确定，redis密码修改后可修改该配置                   |
| redisport        | redis 服务端口                            | 安装时确定， redis端口修改后可修改该配置                  |
| zkhost           | zookeeper集群                             | 安装时配置，用户无需修改，zookeeper集群有变化时修改该配置 |
| zkauth           | zookeeper账户密码                         | 安装时配置，用户无需修改                                  |



## procmgr.conf

| 字段名              | 含义                                    | 用户修改指引                                              |
|---------------------|-----------------------------------------|-----------------------------------------------------------|
| log                 | 程序日志落地目录路径                    | 安装时确定，用户可以修改                                  |
| password_keyfile    | SSL根证书文件路径                       | 安装时确定，用户无需修改                                  |
| cert                | SSL证书加载路径                         | 安装时确定，用户无需修改                                  |
| level               | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可以修改                                    |
| alliothread         | 网络收发包线程数                        | 默认配置，用户无需修改                                    |
| workerthread        | 工作线程数量                            | 默认配置，用户无需修改                                    |
| synccycle           | 进程状态同步周期，单位秒                | 默认配置，用户无需修改                                    |
| syncconcurrency     | 进程状态同步并发量                      | 默认配置，用户无需修改                                    |
| ioport              | 服务监听端口                            | 安装时确定，用户无需修改                                  |
| servers             | 服务绑定ip和端口                        | 安装时确定，用户无需修改                                  |
| taskserver          | 访问gse_task的接口地址                  | 安装时确定，用户无需修改                                  |
| mongohosts          | mongodb地址                             | 安装时确定，mongodb集群迁移时可修改                       |
| mongoreplicasetname | mongodb replicaset name                 | 默认配置，用户无需修改                                    |
| mongodbname         | mongodb name                            | 默认配置，用户无需修改                                    |
| mongouser           | mongodb账户                             | 安装时配置，用户无需修改                                  |
| mongopwd            | mongodb密码                             | 安装时配置，用户无需修改                                  |
| zkhost              | zookeeper集群                           | 安装时配置，用户无需修改，zookeeper集群有变化时修改该配置 |
| zkauth              | zookeeper账户密码                       | 安装时配置，用户无需修改                                  |
| dftregid            | 所属的区域id                            | 默认配置，用户无需修改                                    |
| dftcityid           | 所属的城市id                            | 默认配置，用户无需修改                                    |

## syncdata.conf

| 字段名           | 含义                                    | 用户修改指引                                              |
|------------------|-----------------------------------------|-----------------------------------------------------------|
| log              | 程序日志落地目录路径                    | 安装时确定，用户可以修改                                  |
| password_keyfile | SSL根证书文件路径                       | 安装时确定，用户无需修改                                  |
| cert             | SSL证书加载路径                         | 安装时确定，用户无需修改                                  |
| level            | 日志级别, [debug,info,warn,error,fatal] | 默认配置，用户可以修改                                    |
| alliothread      | 网络收发包线程数                        | 默认配置，用户无需修改                                    |
| workerthread     | 工作线程数量                            | 默认配置，用户无需修改                                    |
| servers          | 服务绑定ip和端口                        | 安装时确定，用户无需修改                                  |
| thriftport       | 访问gse_task的端口                      | 默认配置，用户无需修改                                    |
| ccurl            | 访问cmdb的接口地址                      | 安装时确定，用户无需修改                                  |
| zkhost           | zookeeper集群                           | 安装时配置，用户无需修改，zookeeper集群有变化时修改该配置 |
| zkauth           | zookeeper账户密码                       | 安装时配置，用户无需修改                                  |
| dftregid         | 所属的区域id                            | 默认配置，用户无需修改                                    |
| dftcityid        | 所属的城市id                            | 默认配置，用户无需修改                                    |

## task.conf

| 字段名           | 含义                                        | 用户修改指引                                              |
|------------------|---------------------------------------------|-----------------------------------------------------------|
| log              | 程序日志落地目录路径                        | 安装时确定，用户可以修改                                  |
| password_keyfile | SSL根证书文件路径                           | 安装时确定，用户无需修改                                  |
| cert             | SSL证书加载路径                             | 安装时确定，用户无需修改                                  |
| runtimedata      | 运行时产生文件的路径                        | 安装时确定，用户无需修改                                  |
| alliothread      | 网络收发包线程数                            | 默认配置，用户无需修改                                    |
| workerthread     | 工作线程数量                                | 默认配置，用户无需修改                                    |
| level            | 日志级别, [debug,info,warn,error,fatal]     | 默认配置，用户可以修改                                    |
| thriftport       | 非规范化的thrift接口的服务端口              | 安装时确定，端口不冲突的情况下无需修改                    |
| thriftportV3     | 接口命名规范化后的thrift接口的服务端口      | 安装时确定，端口不冲突的情况下无需修改                    |
| ioport           | task服务监听端口，用于agent连接任务服务                         | 安装时确定，端口不冲突的情况下无需修改                    |
| tasksvrip        | agent连接建立的ip, 默认监听全网段的连接请求 | 安装时确定，默认无需修改                                  |
| tasksvrthirftip  | thrift接口提供服务的ip                      | 安装时确定，用户可以修改                                  |
| tasksvrtrunkip   | taskserver 集群内网通信ip                   | 安装时确定，用户可以修改                                  |
| redispwd         | redis 密码                                  | 安装时确定，可以根据redis实际密码修改                     |
| redisport        | redis 端口                                  | 安装时确定，可以根据redis实际端口修改                     |
| zkhost           | zookeeper集群                               | 安装时配置，用户无需修改，zookeeper集群有变化时修改该配置 |
| zkauth           | zookeeper账户密码                           | 安装时配置，用户无需修改                                  |
| dftregid         | 所属的区域id                                | 默认配置，用户无需修改                                    |
| dftcityid        | 所属的城市id                                | 默认配置，用户无需修改                                    |
