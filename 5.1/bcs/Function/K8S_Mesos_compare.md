# BCS K8S / Mesos 方案功能对比

BCS 支持 K8S 和 Mesos 两种容器编排方案，以下是两种编排方案的功能对比：

<div>
    <table border="1" width="100%">
        <tr bgcolor="#D3D3D3">
            <td width="10%">功能点</td>
            <td width="15%">K8S 方案</td>
            <td width="15%">Mesos 方案</td>
            <td width="60%">主要功能及差异说明</td>
        </tr>
        <tr>
            <td>POD</td>
            <td>POD</td>
            <td>POD(taskgroup)</td>
            <td>
                <b>K8S、Mesos 方案均支持：</b>
                <ul>
                    <li>1. Pod 是所有业务类型的基础，它是一个或多个容器的组合，例如：业务容器，sidecar容器
                    <li>2. 这些容器共享存储、网络和命名空间，以及如何运行的规范
                    <li>3. 在 Pod 中，所有容器都被统一编排和调度
                </ul>
            </td>
        </tr>
        <tr>
            <td>无状态应用</td>
            <td>ReplicaSet/Deployment</td>
            <td>Application/Deployment</td>
            <td>
                <b>K8S、Mesos 方案均支持：</b>
                <ul>
                    <li>1. 支持设定编排策略（Restart、Kill等）；
                    <li>2. 支持设定容器启动参数；
                    <li>3. 支持设定镜像版本及加载方式；
                    <li>4. 支持设定端口映射；
                    <li>5. 支持设定环境变量；
                    <li>6. 支持设定 label、备注；
                    <li>7. 支持设定卷、configmap、secret 的关联关系；
                    <li>8. 支持设定网络；
                    <li>9. 支持设定资源配额设定；
                    <li>10. 支持设定健康检查机制；
                </ul>
                <b>差异点主要有：</b>
                <ul>
                    <li>1. K8S 支持设定生命周期、就绪检查；
                    <li>2. K8S 支持更多的存储 driver，并且从 1.9 版本开始支持CSI；
                    <li>3. 调度策略配置不同：
                        K8S：基于 label 的调度策略，通过 selector 进行筛选
                        Mesos：基于变量运算符的调度策略，支持获取 CC 的属性作为调度依据
                    <li>4. 自定义调度支持方式不同：
                        K8S：支持自定义 controller
                        Mesos：支持自定义调度插件
                    <li>5. Mesos 方案支持 POD 固定 IP 调度
                    <li>6. Mesos 方案支持 bridge 模式下端口随机
                </ul>
            </td>
        </tr>
        <tr>
            <td>部署方案</td>
            <td>Deployment</td>
            <td>Deployment</td>
            <td>
                <b>K8S、Mesos 方案均支持：</b>
                <ul>
                    <li>1. recreate 操作方式；
                </ul>
                <b>差异点主要有：</b>
                <ul>
                    <li>1. rollingUpdate：
                        K8S 方案支持设置滚动方式，最大不可用数和最大更新数
                        Mesos 方案支持设置滚动方式，周期，频率，和手动模式
                    </li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>有状态应用</td>
            <td>StatefulSets</td>
            <td>Application</td>
            <td>
                <b>K8S、Mesos 方案均支持：</b>
                <ul>
                    <li>1. POD 拥有独立唯一不变的 ID；
                    <li>2. POD 拥有独立唯一的域名；
                    <li>3. 挂载独立的数据卷；
                </ul>
            </td>
        </tr>
        <tr>
            <td>任务</td>
            <td>Job/CronJob</td>
            <td>Application</td>
            <td>
                <b>K8S、Mesos 方案均支持：</b>
                <ul>
                    <li>1. 短任务单次执行，例如数据库初始化任务；
                </ul>
                <b>差异点主要有：</b>
                <ul>
                    <li>1. Mesos 方案无专门 Workload，通过设置 Application的参数实现
                    <li>2. K8S 支持部署定时任务
                </ul>
            </td>
        </tr>
        <tr>
            <td>配置文件</td>
            <td>Configmap</td>
            <td>Configmap</td>
            <td>
                <b>K8S、Mesos 方案均支持：</b>
                <ul>
                    <li>1. Configmap 内容落地为文件或者环境变量；
                </ul>
                <b>差异点主要有：</b>
                <ul>
                    <li>1. K8S 方案支持在 POD command 中以变量方式引用；
                    <li>2. Mesos 方案支持远端配置，包括文本和二进制配置文件
                </ul>
            </td>
        </tr>
        <tr>
            <td>DaemonSet</td>
            <td>DaemonSet</td>
            <td>Application</td>
            <td>
                <b>K8S、Mesos 方案均支持：</b>
                <ul>
                    <li>1. 按主机 1：1 动态部署容器；
                    <li>2. 能动态跟随物理机资源缩扩容；
                </ul>
                <b>差异点主要有：</b>
                <ul>
                    <li>1. Mesos 方案无专门 Workload，需要通过设置Application 的调度算法实现相同功能；
                </ul>
            </td>
        </tr>
        <tr>
            <td>服务</td>
            <td>Service</td>
            <td>Service</td>
            <td>
                <b>K8S、Mesos 方案均支持：</b>
                <ul>
                    <li>1. 通过自定义域名描述外部服务；
                    <li>2. 对 RS 或者 Application 的服务做抽象；
                    <li>3. 支持容器故障或者扩缩容时 Backends 的动态刷新；
                    <li>4. 支持简单的负载均衡策略；
                    <li>5. 支持 HTTP、TCP、UDP 等主流通讯协议；
                </ul>
                <b>差异点主要有：</b>
                <ul>
                    <li>1. Mesos 方案支持通过 location 对不同域名进行分流
                    <li>2. Mesos 方案支持对两个 Application 之间设置流量权重
                    <li>3. K8S 支持更多对外暴露服务折射方式，除 ClusterIP、LB外，还是支持 NodePort
                </ul>
            </td>
        </tr>
        <tr>
            <td>加密配置</td>
            <td>Secrets</td>
            <td>Secrets</td>
            <td>
                <b>K8S、Mesos 方案均支持：</b>
                <ul>
                    <li>1. 对敏感信息加密；
                </ul>
            </td>
        </tr>
        <tr>
            <td>挂载卷</td>
            <td>Volumes</td>
            <td>Volumes</td>
            <td>
                <b>K8S、Mesos 方案均支持：</b>
                <ul>
                    <li>1. 支持 Empty DIR；
                    <li>2. 支持 Host Path；
                    <li>3. 支持挂载 Ceph、nfs 等远端目录；
                    <li>4. 支持 subPath；
                </ul>
            </td>
        </tr>
        <tr>
            <td>Ingress</td>
            <td>Ingress</td>
            <td>Ingress</td>
            <td>
                <b>K8S、Mesos 方案均支持：</b>
                <ul>
                    <li>1. 实现集群外部对集群内服务的访问；
                    <li>2. 支持 HTTP、TCP；
                    <li>3. 支持轮询的负载均衡方式；
                </ul>
                <b>差异点主要有：</b>
                <ul>
                    <li>1. Mesos 方案支持流量权重设置；
                    <li>2. Mesos 方案支持 Balance Source；
                </ul>
            </td>
        </tr>
    </table>
</div>
