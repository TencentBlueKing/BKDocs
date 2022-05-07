# FAQ
## 产品使用

### BCS 与 K8S 的关系和区别是什么

K8S 为容器编排引擎，BCS 是容器管理平台，支持 K8S 容器编排引擎，提供便捷的容器管理服务，更多介绍详见 [产品架构](../Architecture/Architecture.md)。

### 一个集群需要至少需要几台机器

集群由 Master 和 Node 组成，其中 Master 主要用来部署集群的基础组件，Slave 主要用来承载业务容器。

> 注：master 不允许调度，因此，至少需要一台 slave 运行业务容器。

- 平台建议 Master 配置
  建议至少 4 核 / 8 G / 3 台 / CentOS 7.4 +

- 平台建议 Node 配置
   配置和数量视业务需求而定(至少需要 1 台)；操作系统：CentOS 7.4 +

### 调度约束

用户通过调度约束可以自动的为 POD 选择指定节点，而且可以通过 **亲和性** 和 **反亲和性** 实现个性化的调度能力。

> 注意：使用不当可能导致其他的 POD 调度不成功。

- 使用场景
    - 想要自己的服务运行到指定的节点
    - 限制其他服务运行到指定节点

- 出现节点匹配提示问题

```bash
# 错误信息
No nodes are available that match all of the predicates: MatchInterPodAffinity (2), MatchNodeSelector (3), NodeNotReady (3), PodToleratesNodeTaints (3).
```

-  确认是否必须调度约束
> 如果自己的场景不必须使用调度约束，可以直接去掉；如果必须使用可以确认下面条件是否满足
    - 是否设置相应的节点标签，比如 nodeselect 为 app=test，这样节点必须要打 app=test 的标签
    - 当前节点是否有设置亲和性，比如设置了亲和性，那么必须满足亲和性条件
    - 其他服务是否有设置反亲和性，比如别的节点设置了反亲和性，那么设置的节点就不允许其他服务调度

## 问题排查

### 拉取镜像失败

出现镜像拉取失败的问题，可能有如下两种可能导致：

- 镜像不存在
针对这种情况，需要用户上传镜像即可。

- 节点没有权限拉取镜像
这种情况，一般是由于平台侧创建`imagePullSecrets`失败导致。

## 启动容器失败

这种情况一般是用户镜像有问题，用户可以通过如下两种方式查看日志：
- 使用 Webconsole，kubectl logs `pod name` -n `namespace name`
- 登录节点机器，通过 docker logs `container id`查看相应日志信息

### 使用 Webconsole 查看日志

- 登录 Webcosole
点击容器服务的右下角“WebConsole”，点击相应的集群，弹出 Webcosole 页面

![webconsole](../assets/web-console.png)

然后，输入 kubectl logs `pod name` -n `namespace name`，查看指定命名空间下的应用日志

### 登录节点查看日志

- 通过点击应用详情，跳转到应用详情页

![点击查看详情](../assets/app.jpg)

- 查找 Pod / Taskgroup 管理项，查看到部署的节点

![应用详情](../assets/taskgroup_pod.jpg)

- 登录节点查看相应的容器日志

### 关于 POD 创建后一直处于 Waiting 或 ContainerCreating 状态

#### 检查应用配置的资源设置

首先，通过查看事件日志，如果此时出现下面这种错误，可以认为启动容器的资源不能满足需求。

```bash
to start sandbox container for pod ... Error response from daemon: OCI runtime create failed: container_linux.go:348: starting container process caused "process_linux.go:301: running exec setns process for init caused "signal: killed"": unknown
```

其次，检查下应用下面容器的配置，类似下图；然后根据需求设置 request 和 limit 数量

![应用资源限制](../assets/res_limit.jpg)

#### 镜像问题

请参考 查看本文上面的 [拉取镜像失败](./faq.md#拉取镜像失败)处理流程
