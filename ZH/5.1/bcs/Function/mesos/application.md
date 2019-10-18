# bcs application 配置说明

bcs application 实现 Pod 的含义，并与 k8s 的 RC，Mesos 的 app 概念等价。

## 1. 配置模板说明

```json
{
    "apiVersion": "v4",
    "kind": "application",
    "restartPolicy": {
        "policy": "Never | Always | OnFailure",
        "interval": 5,
        "backoff": 10,
        "maxtimes": 10
    },
    "killPolicy":{
        "gracePeriod": 10
    },
    "constraint": {
        "intersectionItem": [
            {
                "unionData": [
                    {
                        "name": "ip-resources",
                        "operate": "GREATER",
                        "type": 1,
                        "scalar": {
                            "value": 0
                        }
                    }
                ]
            },
            {
                "unionData": [
                    {
                        "name": "label",
                        "operate": "EXCLUDE",
                        "type": 4,
                        "set": {
                            "item": [
                                "appname:gamesvr",
                                "appname:dbsvr"
                            ]
                        }
                    }
                ]
            },
            {
                "unionData": [
                    {
                        "name": "hostname",
                        "operate": "CLUSTER",
                        "type": 4,
                        "set": {
                            "item": [
                                "slave3",
                                "slave4",
                                "slave5"
                            ]
                        }
                    }
                ]
            },
            {
                "unionData": [
                    {
                        "name": "district",
                        "operate": "GROUPBY",
                        "type": 4,
                        "set": {
                            "item": [
                                "shanghai",
                                "shenzhen",
                                "tianjin"
                            ]
                        }
                    }
                ]
            },
            {
                "unionData": [
                    {
                        "name": "hostname",
                        "operate": "LIKE",
                        "type": 3,
                        "text": {
                            "value": "slave[3-5]"
                        }
                    }
                ]
            },
            {
                "unionData": [
                    {
                        "name": "hostname",
                        "operate": "UNLIKE",
                        "type": 3,
                        "text": {
                            "value": "slave[1-2]"
                        }
                    }
                ]
            },
            {
                "unionData": [
                    {
                        "name": "hostname",
                        "operate": "UNIQUE"
                    }
                ]
            },
            {
                "unionData": [
                    {
                        "name": "idc",
                        "operate": "MAXPER",
                        "type": 3,
                        "text": {
                            "value": "5"
                        }
                    }
                ]
            }
        ]
    },
    "metadata": {
        "labels": {
            "io.tencent.bcs.netsvc.requestip.0": "10.168.1.1",
            "io.tencent.bcs.netsvc.requestip.1": "10.168.2.1",
            "io.tencent.bcs.netsvc.requestip.2": "10.168.1.3",
            "test_label": "test_label"
        },
        "name": "ri-test-rc-001",
        "namespace": "nfsol"
    },
    "spec": {
        "instance": 1,
        "template": {
            "metadata": {
                "labels": {
                    "test_label": "test_label"
                }
            },
            "spec": {
                "containers": [
                    {
                        "hostname": "container-hostname",
                        "command": "bash",
                        "args": [
                            "args1",
                            "args2"
                        ],
                        "parameters": [
                            {
                                "key": "rm",
                                "value": "false"
                            }
                        ],
                        "type": "MESOS",
                        "env": [
                            {
                                "name": "test_env",
                                "value": "test_env"
                            }
                        ],
                        "image": "hub_address.com/nfsol/log:92763",
                        "imagePullUser": "userName",
                        "imagePullPasswd": "passwd",
                        "imagePullPolicy": "Always|IfNotPresent",
                        "privileged": false,
                        "ports": [
                            {
                                "containerPort": 8090,
                                "hostPort": 8090,
                                "name": "test-tcp",
                                "protocol": "TCP"
                            },
                            {
                                "containerPort": 8080,
                                "hostPort": 8080,
                                "name": "test-http",
                                "protocol": "http"
                            }
                        ],
                        "healthChecks": [
                            {
                                "type": "HTTP|TCP|COMMAND|REMOTE_HTTP|REMOTE_TCP",
                                "delaySeconds": 10,
                                "intervalSeconds": 60,
                                "timeoutSeconds": 20,
                                "consecutiveFailures": 3,
                                "gracePeriodSeconds": 300,
                                "command" : {
                                    "value": ""
                                },
                                "http": {
                                    "port": 8080,
                                    "portName": "test-http",
                                    "scheme": "http|https",
                                    "path": "/check",
                                    "headers": {
                                        "key1": "value1",
                                        "key2": "value2"
                                    }
                                },
                                "tcp": {
                                    "port": 8090,
                                    "portName": "test-tcp"
                                }
                            }
                        ],
                        "resources": {
                            "limits": {
                                "cpu": "2",
                                "memory": "8"
                            },
                            "requests": {
                                "cpu": "2",
                                "memory": "8"
                            }
                        },
                        "volumes": [
                            {
                                "volume": {
                                    "hostPath": "/data/host/path",
                                    "mountPath": "/container/path",
                                    "readOnly": false
                                },
                                "name": "test-vol"
                            }
                        ],
                        "secrets": [
                            {
                                "secretName": "mySecret",
                                "items": [
                                    {
                                        "type": "env",
                                        "dataKey": "abc",
                                        "keyOrPath": "SRECT_ENV"
                                    },
                                    {
                                        "type": "file",
                                        "dataKey": "abc",
                                        "keyOrPath": "/data/container/path/filename.conf",
                                        "subPath": "relativedir/",
                                        "readOnly": false,
                                        "user": "user00"
                                    }
                                ]
                            }
                        ],
                        "configmaps": [
                            {
                                "name": "template-configmap",
                                "items": [
                                    {
                                        "type": "env",
                                        "dataKey": "config-one",
                                        "keyOrPath": "SECRET_ENV"
                                    },
                                    {
                                        "type": "file",
                                        "dataKey": "config_two",
                                        "dataKeyAlias": "config-two",
                                        "KeyOrPath": "/data/contianer/path/filename.txt",
                                        "readOnly": false,
                                        "user": "root"
                                    }
                                ]
                            }
                        ]
                    }
                ],
                "networkMode": "USER",
                "networkType": "cni",
                "netLimit": {
                    "egressLimit": 100
                }
            }
        }
    }
}
```

### 1.1 KillPolicy 机制

gracePeriod：宽限期描述在强制 kill container 之前等待多久，单位秒。 默认为 1

### 1.2 RestartPolicy 机制
    - policy：支持Never Always OnFailure三种配置(默认为OnFailure),OnFailure表示在失败的情况下重新调度,Always表示在失败和Lost情况下重新调度, Never表示任何情况下不重新调度plainplainplainplainplainplainplainplainplainplainplainplain
    - interval: 失败后到执行重启的间隔(秒),默认为0
    - backoff：多次失败时,每次重启间隔增加秒,默认为0.如果interval为5,backoff为10,则首次失败时5秒后重新调度,第二次失败时15秒后重新调度,第三次失败时25秒后重新调度
    - maxtimes: 最多重新调度次数,默认为0表示不受次数限制.容器正常运行30分钟后重启次数清零重新计算

### 1.3 constraint 调度约束

constraint 字段用于定义调度策略

- IntersectionItem

该字段为数组，策略为：所有元素同时满足时才进行调度。使用多个 IntersectionItem 可以同时满足多个条件限制。

每个 IntersectionItem 中支持多个 UnionData 为规则细节字段，用于填写调度匹配规则，也为数组，该数组含义为：所有元素只需要满足一个即可。使用 UnionData 可以实现多个条件满足其一即可。

### 1.4 UnionData 字段说明

```json
{
    "name": "hostname",
    "operate": "ClUSTER",
    "type": 3|4,
    "set": {
        "item": ["mesos-slave-1", "mesos-slave-2", "mesos-slave-3"]
    },
    "text":{
        "value": "mesos-slave-1"
    }
}
```

* name: 调度字段 key（如主机名，主机类型，主机 IDC 等）用来调度的字段需要 mesos slave 通过属性的方式进行上报，hostname 参数自动获取无需属性上报
* operator：调度算法，当前支持以下 5 种调度算法（大写）：
  * UNIQUE: 每个实例的 name 的取值唯一：如果 name 为主机名则表示每台主机只能部署一个实例，如果 name 为 IDC 则表示每个 IDC 只能部署一个实例。UNIQUE 算法无需参数。
  * MAXPER: name 同一取值下最多可运行的实例数，为 UNIQUE 的增强版（数量可配置），MAXPER 算法需通过参数 text(type 为 3)指定最多运行的实例数。
  * CLUSTER: 配合 set 字段（type 为 4），要求 name 的取值必须是 set 中一个，可以限定实例部署在 name 的取值在指定 set 范围。
  * LIKE: 配合 text 字段（type 为 3）或者 set 字段（type 为 4），name 与 text（或者 set）中的内容进行简单的正则匹配，可以限定实例部署时 name 的取值。如果是参数是 set（type 为 4），只要和 set 中某一个匹配即可。
  * UNLIKE: LIKE 取反。如果是参数为 set（type 为 4），必须和 set 中所有项都不匹配。
  * GROUPBY: 根据 name 的目标个数，实例被均匀调度在目标上，与 set 一起使用，如果实例个数不能被 set 的元素个数整除，则会存在差 1 的情况，例如：name 为 IDC，实例数为 3,set 为["idc1","idc2"],则会在其中一个 idc 部署两个实例。
  * EXCLUDE: 和具有指定标签的 application 不部署在相同的机器上，即：如果该主机上已经部署有这些标签（符合一个即可）的 application 的实例，则不能部署该 application 的实例。目前 name 只支持"label",label 的 k:v 在 set 数组中指定。
  * GREATER: 配合 scaler 字段（type 为 1），要求 name 的取值必须大于 scalar 的值。
* type: 参数的数据类型，决定 operator 所操作 key 为 name 的值的范围
  1: scaler: float64
  3：text：字符串。
  4：set：字符串集合。

案例说明：

* 要求各实例运行在不同主机上

```json
{
    "name": "hostname",
    "operate": "UNIQUE"
}
```

* 要求实例限制运行在深圳和东莞地区（要求 slave 上报 section 字段）

```json
{
    "name": "section",
    "operate": "ClUSTER",
    "type": 4,
    "set": {
        "item": ["shenzhen", "dongguan"]
    }
}
```

* 要求实例运行在 mesos-slave-1，mesos-slave-2 上

```json
{
    "name": "hostname",
    "operate": "LIKE",
    "type": 3,
    "text": {
        "value": "mesos-slave-[1-2]"
    }
}

```

### 1.5 meta 元数据

* name: Application 名字，小写字母与数字构成，但不能完全由数字构成，不能数字开头
* namespace：App 命名空间，小写字母与数字构成，不能完全由数字构成，不能数字开头；不同业务必然不同，默认值为 defaultGroup
* label：app 的 lable 信息，对应 k8s RC label
    * io.tencent.bcs.cluster：用于标识集群 Id 信息
    * io.tencent.bcs.app.appid：业务 ccID
    * io.tencent.bcs.app.setid：业务 cc 大区 ID
    * io.tencent.bcs.app.moduleid：业务 cc 模块 ID

当容器网络使用 bcs-cni 方案的时，如果想针对容器指定 IP，可以使用以下 label

* io.tencent.bcs.netsvc.requestip.[i]：针对 Pod 申请 IP，i 代表 Pod 的实例，从 0 开始计算

当容器指定 Ip 时，不同的 taskgroup 需要调度到特定的宿主机上面，宿主机的制定方式与 constraint 调度约束一致，如下是使用 InnerIp：

io.tencent.bcs.netsvc.requestip.[i]: "10.168.1.1|InnerIp=10.158.49.13;10.158.49.12"

使用分隔符"|"分隔，"|"前面为容器 Ip，后面为需要调度到的宿主机 Ip，多个宿主机之间使用分隔符";"分隔，宿主机 Ip 支持正则表示式，方式如下：
io.tencent.bcs.netsvc.requestip.[i]: "10.168.1.1|InnerIp=10.158.49.[12-25];10.158.48.[11-13]"

### 1.6 容器字段信息

* instance：运行实例个数
* label：运行时容器 label 信息，对应 k8s pod label
* name: pod 名字，mesos 中不启用
* type：DOCKER/MESOS
* hostname: 容器的 hostname 设置，如果网络模式为"HOST"，则该字段无效
* command：字符串，容器启动命令，例如/bin/bash
* args：command 的参数，例如 ["-c", "echo hello world"]
* env: key/value 格式，环境变量。针对 BCS 默认注入的环境变量（BCS_CONTAINER_IP,BCS_NODE_IP）支持赋值操作
* parameters：docker 参数，当前以下 docker 参数已支持
  * oom-kill-disable：有效值 true，设置为 true 后，如果容器资源超限会进行强杀
  * ulimit：可以设置 ulimit 参数，例如 core=-1
  * rm：有效值为 true，容器退出后，是否直接删除容器
* image：镜像链接
* imagePullSecrets：存储仓库鉴权信息的 secret 名字
* imagePullPolicy：拉取容器策略
  * Always：每次都重新从仓库拉取
  * IfNotPresent：如果本地没有，则尝试拉取（默认值）
* privileged：容器特权参数，默认为 false
* resources：容器使用资源
  * limits.cpu:字符串，可以填写小数，1 为使用 1 核
  * limits.memory：内存使用，字符串，单位默认为 M. 注意：当 memory >= 4Mb, 使用 memory 的值限制内存；否则，不对 memory 做 limits
  * limits.storage：磁盘使用大小，默认单位 M
  * request 仅对 k8s 生效
* networkMode：网络模式
  * HOST: docker 原生网络模式，与宿主机共用一个 Network Namespace，此模式下需要自行解决网络端口冲突问题
  * BRIDGE: docker 原生网络模式，此模式会为每一个容器分配 Network Namespace、设置 IP 等，并将一个主机上的 Docker 容器连接到一个虚拟网桥上，通过端口映射的方式对外提供服务
  * NONE: 除了 lo 网络之外，不配置任何网络
  * USER: 用户深度定制的网络模式，支持 macvlan、calico 等网络方案
* networkType：只有在 networkMode 为 USER 模式下，该字段才有效
  * cni(小写): 使用 bcs 提供的 cni 来构建网络，具体 cni 的类型是由配置决定
  * 空或其它值：使用 docker 原生或用户自定义的方式来构建网络

### 1.7 netLimit 说明

对容器的网络流量进行限制，包括 ingress(进流量)和 egress(出流量)，默认情况下不限制。
暂时只支持对 egress 的限制。

* egressLimit: 容器出流量的限制，value 为大于 0 的整数，单位为 Mbps。

### 1.8 Volume 说明

支持主机磁盘挂载

* name：挂载名，在 app 中需要保持唯一
* volume.hostPath: 主机目录
  * 当目录没填写时，默认为创建一个随机目录，该目录 Pod 唯一
  * 该目录路径可以支持变量$BCS_POD_ID
* volume.mountPath: 需要挂载的容器目录，需要其父目录存在，否则报错
* readOnly: true/false, 是否只读，默认 false

### 1.9 ConfigMap 说明

主要功能是引用 configmap 数据，并作为环境变量/文件注入容器中。

* name：configmap 索引名字

**环境变量**注入

* items[x].type: env
* items[x].dataKey: configmap 子项索引名
* items[x].keyOrPath: 需要注入环境变量名

**文件**注入

* items[x].type: file
* items[x].dataKey: configmap 子项索引名，默认为文件名
* items[x].dataKeyAlias: 对于 k8s configmap，如果原始文件名带有"_"，则需要对文件进行重命名，使用 keyAlias 对子项进行索引。也可以增加前缀目录，keyAlias 拼接默认构成完成容器路径。
* items[x].keyOrPath: 文件在容器中路径，需要保证父目录存在
* items[x].readOnly: true/false，默认 false，文件是否只读
* items[x].user: 文件用户设置，默认 root，k8s 不生效

### 1.10 Secrets 机制

secret 在 k8s 和 mesos 中实现存在差异。在 k8s 中，即为默认支持的 secret 数据，并存储在 etcd 中；在 mesos 中，secret 为 bcs-scheduler 增加
的数据结构，数据默认存储在 vault 中，读写控制需要通过 bcs-authserver。secrets 的数据默认可以注入环境变量/文件。

在 k8s 中，secret 只能存储一项数据，所以不存在子项数据结构。mesos 下，一个 secret 可以存储多项数据。

* secretName: 引用的 secret 名字

注入**环境变量**：

* items[x].type: env
* items[x].dataKey: secret 中子项索引，mesos 有效
* items[x].keyOrPath： 环境变量 KEY

注入**文件**

* items[x].type: file
* items[x].dataKey：secret 中子项索引，mesos 有效
* items[x].keyOrPath：需要挂载的容器目录
* items[x].subPath：需要挂载子目录，仅 k8s 有效
* items[x].readOnly： true/false，文件是否只读，默认为 false
* items[x].user：user00，文件属主，mesos 有效

### 1.11 容器 Ports 机制说明

ports 字段说明：

* protocol：协议，必填，http，tcp，udp
* name：标识 port 信息，唯一，必填
* containerPort：容器中服务使用端口，必填
* hostPort: 物理主机使用的端口，0 代表 scheduler 进行随机选择

特别说明：

* host 模式下，containerPort 即代表 hostPort
  * 填写固定端口，需要业务自行确认是否产生冲突
  * 填写 0，意味着 scheduler 进行随机选择
* bridge 模式下，hostPort 代表物理主机上的端口
  * hostPort 填写固定端口，业务自行解决冲突的问题
  * 填写 0，scheduler 默认进行端口随机

**端口随机**的状态下，scheduler 会根据 ports 字段序号，生成 PORT0 ~ n 的环境变量，以便业务读取该随机端口。不支持 PORT_NAME 的方式

## 2. **容器 Health Check 机制说明**

### 2.1 通过 mesos 协议下发检测机制到 executor，通过 executor 执行检测

* 支持的类型为 HTTP,TCP 和 COMMAND 三种
* scheduler 根据 application 定义的检测机制，启动进程时下发到 executor
* executor 根据检测配置实施检测（并在多次检测失败的情况下 kill 进程，可配置）
* executor 将检测结果通过 TaskStatus 中的 healthy（bool）上报到 scheduler
* scheduler 根据 healthy 的值以及进程的其他数据(配置数据和动态数据)来确定后续行为：
  * 状态修改，数据记录，触发告警等
  * 重新调度

### 2.2 mesos scheduler 根据检测机制直接远程执行检测

* 支持的类型为 REMOTE_HTTP,REMOTE_TCP

### 2.3 health check Type 说明

* health check 可以同时支持多种类型的 check，目前最多为三种
* HTTP,TCP 和 COMMAND 三种类型，最多只能同时支持一种
* REMOTE_HTTP,REMOTE_TCP 两种类型可以同时支持

### 2.4 healthChecks 字段说明

* type: 检测方式，目前支持 HTTP,TCP,COMMAND,REMOTE_TCP 和 REMOTE_HTTP 五种
* delaySeconds：容器启动之后到开始进行健康检测的等待时长(mesos 协议中有,marathon 协议中不支持,因为有 gracePeriodSeconds,该参数好像意义不大,可能被废弃)
* intervalSeconds：前后两次执行健康监测的时间间隔.
* timeoutSeconds: 健康监测可允许的等待超时时间。在该段时间之后，不管收到什么样的响应，都被认为健康监测是失败的，**timeoutSeconds 需要小于 intervalSeconds**
* consecutiveFailures: 在一个不健康的任务被杀掉之前，连续的健康监测失败次数，如果值设为 0，tasks 如果不通过健康监测，则它不会被杀掉。进程被杀掉后 scheduler 根据 application 的 restartpolicy 来决定是否重新调度. marathon 协议中为 maxConsecutiveFailures
* gracePeriodSeconds：启动之后在该时段内健康监测失败会被忽略。或直到任务首次变成健康状态.
* command: type 为 COMMAND 时有效
  * value: 需要执行的命令,value 中支持环境变量.mesos 协议中区分是否 shell,这里不做区分,如果为 shell 命令,需要包括"/bin/bash ‐c",系统不会自动添加(参考 marathon)
  * 后续可能需要补充其他参数如 USER
* http: type 为 HTTP 和 REMOTE_HTTP 时有效
  * port: 检测的端口,如果配置为 0,则该字段无效
  * portName: 检测端口名字(替换 marathon 协议中的 portIndex)
    * portName 在 port 配置大于 0 的情况下,该字段无效
    * portName 在 port 配置不大于 0 的情况下,检测的端口通过 portName 从 ports 配置中获取（scheduler 处理）
    * 根据 portName 获取端口的时候,需要根据不同的网络模型获取不同的端口，目前规则(和 exportservice 保持一致)如下：
      * BRIDGE 模式下如果 HostPort 大于零则为 HostPort,否则为 ContainerPort
      * 其他模式为 ContainerPort
  * scheme： http 和 https(https 不会做认证的处理)
  * path：请求路径
  * headers: http 消息头，为了支持 health check 时，需要认证的方式，例如：Host: www.xxxx.com。NOTE:目前只支持 REMOTE_HTTP。
  * 检测方式:
        *  Sends a GET request to scheme://<host>:port/path.
        *  Note that host is not configurable and is resolved automatically, in most cases to 127.0.0.1.
        *  Default executors treat return codes between 200 and 399 as success; custom executors may employ a different strategy, e.g. leveraging the `statuses` field.
        *  bcs executor 需要根据网络模式等情况再具体确认规则
* tcp： type 为 TCP 和 REMOTE_TCP 的情况下有效：
  * port: 检测的端口,如果配置为 0,则该字段无效
  * portName: 检测端口名字(替换 marathon 协议中的 portIndex)
    * protName 在 port 配置大于 0 的情况下,该字段无效
    * portName 在 port 配置不大于 0 的情况下,检测的端口通过 portName 从 ports 配置中获取（scheduler 处理）
    * 根据 portName 获取端口的时候,需要根据不同的网络模型获取不同的端口，目前规则(和 exportservice 保持一致)如下：
      * BRIDGE 模式下如果 HostPort 大于零则为 HostPort,否则为 ContainerPort
      * 其他模式为 ContainerPort
  * 检测方式： tcp 连接成功即表示健康，需根据不同网络模型获取不同的地址
