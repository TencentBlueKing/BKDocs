# Mesos Service 定义

## 1. Service 数据结构说明

service 主要用**服务发现**，**DNS 基础数据**，**loadbalance 服务导出**。

```json
{
    "apiVersion":"v4",
    "kind":"service",
    "metadata":{
        "name":"template-service",
        "namespace":"defaultGroup",
        "labels":{
            "BCSGROUP": "external",
            "BCSBALANCE": "source|roundrobin|leastconn",
            "BCS-WEIGHT-lol-summoner": "3",
            "BCS-WEIGHT-new-lol-summoner": "7"
        }
    },
    "spec": {
        "selector": {
            "label-one": "lol-summoner",
            "label-two": "new-lol-summoner"
        },
        "type": "ClusterIP|NodePort|None|Integration",
        "clusterIP": ["1.1.1.1", "1.1.1.2"],
        "ports": [
            {
                "name": "http_8080",
                "domainName": "demo.bcs.com",
                "path": "/local/path",
                "protocol": "http",
                "servicePort": 80,
                "targetPort": 8080,
                "nodePort": 31000
            },
            {
                "name": "tcp-28800",
                "domainName": "demo.bcs.com",
                "path": "/local/path",
                "protocol": "tcp",
                "servicePort": 28800,
                "targetPort": 8080,
                "nodePort": 31001
            }
        ]
    }
}
```

## 2. endpoints

如果存在 endpoints，DNS 直接 watch 并直接关联 DNS 解析记录。
如果没有，自行关联 service 和 taskgroup 信息，解析 status 信息提取 IP。

```json
{
    "apiVersion":"v1",
    "kind":"endpoint",
    "metadata":{
        "name":"template-endpoint",
        "namespace":"defaultGroup",
        "label":{
            "io.tencent.bcs.app.appid": "756",
            "io.tencent.bcs.cluster": "SET-SH-16111614092707",
            "io.tencent.bcs.app.moduleid": "5088",
            "io.tencent.bcs.app.setid": "1767"
        }
    },
    "eps": [
        {
            "nodeIP": "10.1.1.1",
            "containerIP": "192.168.1.2"
        },{
            "nodeIP": "10.1.1.2",
            "containerIP": "192.168.1.1"
        }
    ]
}
```

## 3. 特别字段说明

**clusterIP**：考虑未来需要做外部域名访问和服务发现，clusterIP 暂留用于指向 proxyIP 信息

**ports**[x]说明：

* name：该 name 需要和 taskgroup 中 ports 字段中的 name 一致
* domainName：http 协议的状态下，需要填写域名信息，做转发用途
* servicePort：主要用于负载均衡和服务导出端口
* targetPort：用于指向 taskgroup 中 ports 字段中目标端口，默认目标端口为 containerPort，如果有 hostPort，则指向 hostPort

**BCSGROUP**: 用于 service 导出标识
**BCSBALANCE**：用于服务导出负载均衡算法，默认值为 roundrobin
**BCS-WEIGHT-**: 当使用 selector 匹配多个 application 时，用于表达多个 application 之间的权重，该值为大于等于 0 的整数，类型为 string。如果等于 0，则该 application 没有流量导入。

## 4. **bcs-loadbalance 功能使用**

如果要启动 loadbalance 的功能，需要：

* label 中增加特殊字段**"BCSGROUP":"external"**：external 代表 bcs-loadbalance 模块的集群 ID，默认值 external
* label 中增加特殊字段**"BCSBALANCE":"roundrobin"**：负载均衡算法，默认值为 roundrobin，其他值为 source（ip_hash），leastconn
* application 有定义 ports 信息，并和 service 对应

ports 信息在 loadbalance 中的含义说明：

* protocol：http 或者 tcp，当前不支持 udp
* name：名字为 application 中定义 port 的名字，必须要对应
* domainName：协议为 http 时有效
* servicePort：如果协议是 http，该值被忽略，loadbalance 默认使用 80 端口；如果是 tcp，loadbalance 则监听该指定端口，各 service 之间该端口不能冲突

bcs-loadbalance 可以工作两种环境下：

* overlay 方式，默认使用 servicePort 作为服务端口，流量转发至 containerPort
* underlay 方式，使用 servicePort 作为服务端口，流量转发至 hostPort（限于 host/bridge 模式）

## 5. taskgroup 服务端口机制

服务端口数据来源于镜像字段 ports，主要包含：

* containerPort：容器中使用端口
* servicePort：多实例状态使用的服务端口，用于服务导出和负载均衡使用
* hostPort：从容器映射到主机的端口
* hostIP：预留字段，当物理主机包含多个网卡时，默认是所有网卡都映射。如果 0.0.0.0 监听存在风险，可以监听内网
* protocol：协议，tcp/udp，http（默认转换为 tcp 处理，仅对 datawatch/loadbalance 生效）
* name：域名信息，http 时必须为域名，必须唯一
* path: 路由转发，用于转发到后端对应的 endpoint

填写端口信息，至少需要填写 name、protocol、containerPort、servicePort 信息。如果不需要实现端口映射，hostPort 无需填写。

docker 存在网络模式：None，Host，Bridge，User（CNM/CNI），端口映射对 None（当前 Executor 暂未校验）

**hostPort**使用定义：-1 为不使用，0 为随机端口，正数为指定端口

针对 docker 容器端口映射实现，端口绑定有两个情况：

* **指定端口**绑定

下发参数中没有 parameter 参数-P，并直接指定 hostPort，executor 默认直接将该指定参数提交给 docker 进行绑定。端口冲突是否需要用户执行决断。
如果没有特别指定调度策略将实例分开，有极大几率造成端口冲突。

* Host 模式下 hostPort 保持和 containerPort 一致，方便 datawatch 处理

* **随机端口**绑定

下发参数中存在-P，并且有 ports 字段，hostPort 字段默认为 0，scheduler 使用 offer 上报的端口信息确认端口，更新 taskgroup 字段，并下发给 Executor。
随机端口绑定可以**消除端口冲突**的问题。**有随机端口的情况下，为了方便应用获取到端口信息，需要将 port 端口根据需要导入环境变量 PORT0 ~ PORTn**

**更新**（2017-05-22，根据 LOL 需求更新）：

* Host 模式下:
  * containerPort 设置为 0，默认使用 offer 提供端口资源，hostPort 和 containerPort 保持一致。port 端口根据序号导入环境变量 PORT0 ~ PORTn
  * containerPort 指定端口，默认传递该端口，port 端口根据序号导入环境变量 PORT0 ~ PORTn
* Bridge 模式
  * hostPort 不填写默认补齐为-1，仅有 containerPort
  * hostPort 为 0，默认随机端口，使用 offer 端口资源，port 端口根据序号导入环境变量 PORT0 ~ PORTn

### 5.1 服务端口代码调整说明

* executor

executor 上报容器状态时，增加 ports 字段，结构包括 name，hostPort，containerPort，protocol

* api/scheduler

使用随机端口时，默认 hostPort 直接填写 0，使用 offer 里面端口资源更新 hostPort 信息，不使用 HostPort，建议默认值为负数

* datawatch-mesos/datawatch-kube/loadbalance 支持

上报 ExportService 时，结构调整，当前为

```go
//ExportService info to hold export service
type ExportService struct {
    Cluster     string       `json:"cluster"`     //cluster info
    Namespace   string       `json:"namespace"`   //namespace info, for business
    ServiceName string       `json:"serviceName"` //service name
    ServicePort []ExportPort `json:"ports"`       //export ports info
    BCSGroup    []string     `json:"BCSGroup"`    //service export group
    SSLCert     bool         `json:"sslcert"`     //SSL certificate for ser
    Balance     string       `json:"balance"`     //loadbalance algorithm, default source
    MaxConn     int          `json:"maxconn"`     //max connection setting
}
```

字段信息：

* SSLCert：是否使用 https，当前默认不开启，忽略
* Balance：负载均衡的算法，默认是 source，忽略；
* MaxConn：最大连接数，默认是 20000

调整 ServicePort 和 Backends 字段，对其进行合并

```go
type ExportPort struct {
    BCSVHost    string    `json:"BCSVHost"`
    Protocol    string    `json:"protocol"`
    Path        string    `json:"path"`
    ServicePort int       `json:"servicePort"`
    Backends    []Backend `json:"backends"`
}

type Backend struct {
    TargetIP string `json:"targetIP"`
    TargetPort int   `json:"targetPort"`
}
```

datawatch 构建 ExportService 时需要按照新结构进行。构建 ExportService 信息需要结合 Service 和 TaskGroup 信息。

* service 中，多个 ports 对应多个 ExportPort
* Service.ports[i].name == TaskGroup.container[i].ports[i].name
* 提取 TaskGroup 多个实例的 containerIP，NodeIP，ContainerPort，HostPort
* backend 组装说明，多个实例有多个 backend
  * 如果 TaskGroup 网络模式 host，取 NodeIP 和 ContainerPort，组成 backend
  * 网络模式为 bridge，如果有 HostPort：NodeIP + HostPort；如果没有，则 ContainerIP + ContainerPort
  * 其他模式：ContainerIP + ContainerPort
