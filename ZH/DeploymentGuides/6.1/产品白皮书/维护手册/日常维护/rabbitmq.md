# RabbitMQ

RabbitMQ 是实现了高级消息队列协议（AMQP）的开源消息代理软件（亦称面向消息的中间件）。

在蓝鲸组件中，以下产品依赖 RabbitMQ 服务：

- PaaS 平台（需要注册 RabbitMQ 服务，提供给通过 PaaS 平台部署的 SaaS 用）
- 后台 Django 工程使用 celery 任务的 （节点管理、用户管理、监控平台等）
- 作业平台（job）
- 蓝盾（bkci）

## 安装 RabbitMQ

rabbitmq-server 在 EPEL 仓库里存在，不过一般版本会比较旧，蓝鲸提供的 rpm 包中包含了较新的版本。

通过 yum 直接安装，自动解决 erlang 依赖:

```bash
yum install rabbitmq-server
```

如果想安装官方最新的版本，可以通过`rpm`的方式手动安装。推荐使用 RabbitMQ 官方提供的精简版
Erlang/OTP 的 rpm 包作为依赖：

1. 从这里下载最新的 CentOS 对应版本的 Erlang rpm 包：https://github.com/rabbitmq/erlang-rpm/releases 比如 Centos7 下就下载 erlang-21.3.7-1.el7.x86_64.rpm 这个文件

    ```bash
    wget https://github.com/rabbitmq/erlang-rpm/releases/download/v21.3.7/erlang-21.3.7-1.el7.x86_64.rpm
    ```

2. 从官网下载最新的 rabbitmq-server rpm 包：https://www.rabbitmq.com/install-rpm.html#downloads

    ```bash
    wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.7.14/rabbitmq-server-3.7.14-1.el7.noarch.rpm
    ```

3. 安装 rabbitmq-server 3.7 以上的版本需要满足以下依赖包，可以通过 yum 安装：

    ```bash
    yum install socat logrotate
    ```

4. 安装 erlang 虚拟机：

    ```bash
    rpm -ivh erlang-21.3.7-1.el7.x86_64.rpm
    ```

5. 安装 rabbitmq-server:

    ```bash
    rpm -ivh rabbitmq-server-3.7.14-1.el7.noarch.rpm
    ```

6. 启动 rabbitmq-server:

    ```bash
    systemctl start rabbit-server
    ```

7. 查看状态: 

    ```bash
    rabbitmqctl status
    ```

## 配置 RabbitMQ

正确配置好 rabbitmq 是运维 rabbitmq 非常重要的一环。它影响到 rabbitmq 运行的性能，高可用和可扩展性。

配置 RabbitMQ，有三种途径：

- 环境变量: 配置网络相关参数和文件路径。
- 配置文件：权限，资源限制，插件以及集群相关配置
- 运行时参数：配置可能在运行时需要动态调整的参数

开始进行配置前，我们检查默认的配置文件是否存在，在 Linux 下，一般是：

```bash
/etc/rabbitmq/rabbitmq.conf
```

从 RabbitMQ 3.7 版本开始，它默认的配置文件格式是 [sysctl 格式](https://github.com/basho/cuttlefish/wiki/Cuttlefish-for-Application-Users)

### 环境变量

Linux 下，我们通过一个名为 `rabbitmq-env.conf` 的文件来配置 rabbitmq-server 相关的路径，网络参数等。在这个文件中，我们这样添加参数：

```bash
CONFIG_FILE=/etc/rabbitmq/testfile
```

修改后，需要重启 rabbitmq-server 让它们生效。

rabbitmq 提供了大量的环境变量参数来配置，这里我们只介绍比较重要的几个：

- **RABBITMQ_CONFIG_FILE**: 虽然 rabbitmq 有默认读取配置文件的路径，你依然可以通过这个变量来修改它。
- **RABBITMQ_LOGS**: 这个变量定义后台日志存放的路径。
- **RABBITMQ_NODE_IP_ADDRESS**: rabbitmq 默认监听所有的网卡地址，如果需要只绑定特定的网卡 IP，可以用这个变量指定。
- **RABBITMQ_NODE_PORT**: rabbitmq 默认的端口是 5672。如果有冲突时，可以使用它来修改。
- **RABBITMQ_NODENAME**: 这是 rabbitmq 服务的节点名称，它在每个 erlang 节点上必须唯一。Linux 上默认为 rabbit@hostname
- **RABBITMQ_SASL_LOGS**: 这是 rabbitmq 服务的 System Application Support Libraries(SASL) 的日志文件路径。

Linux 下这些环境变量的默认值：

- RABBITMQ_CONFIG_FILE ${install_prefix}/etc/rabbitmq/rabbitmq
- RABBITMQ_NODENAME rabbit@$HOSTNAME
- RABBITMQ_LOG_BASE ${install_prefix}/var/log/rabbitmq
- RABBITMQ_LOGS $RABBITMQ_LOG_BASE/$RABBITMQ_NODENAME.log
- RABBITMQ_MNESIA_BASE ${install_prefix}/var/lib/rabbitmq/mnesia
- RABBITMQ_MNESIA_DIR $RABBITMQ_MNESIA_BASE/$RABBIMQ_NODENAME
- RABBITMQ_SASL_LOGS $RABBITMQ_LOG_BASE/$RABBITMQ_NODENAME-sasl.log

### 配置文件

上一节看出，rabbitmq 的环境变量主要控制一些文件目录的路径。而 rabbitmq 的配置文件，则控制后台引擎相关的配置。比如
权限认证，性能参数，内存资源限制，磁盘限制，exchanges，queues, bindings 等等。

和上一节一样，我们只讨论最重要的一些参数。

- **auth_mechanisms**: 指定认证方式，默认值为 ['PLAIN', 'AMQPLAIN']
- **default_user**: 使用 rabbitmq 客户端访问 rabbitmq 服务端时用的默认用户名。默认为 guest
- **default_pass**: 和 rabbitmq_user 类似，默认用户名对应的默认密码。默认值为 guest
- **default_permission**: 默认用户名拥有的权限。默认值是`[".*", ".*", ".*"]`
- **disk_free_limit**: rabbitmq 数据文件所在分区的磁盘限额，如果可用空间低于它，会触发访问限制。默认值是 50000000（Bytes）
- **log_levels**: 日志级别，默认值为 [{connection, info}]，可选值有：none, error, warning, info
- **tcp_listeners**: 配置绑定的 IP 和端口。默认值[5672]
- **vm_memory_high_watermark**: 空闲内存大小比率。默认为 0.4，即 4/10

### 运行参数

环境变量和配置文件这两种方式，提供在启动 rabbitmq 时的配置能力。在 rabbitmq 运行后，有一些参数，可以通过 rabbitmq 提供的命令行工具 `rabbitmqctl` 来调整配置。

#### 参数管理

- 通过 `rabbitmqctl set_parameter [-p vhostpath] {component_name} {name} {value}` 这样的命令形式来配置参数。
- 通过 `rabbitmqctl clear_parameter [-p vhostpath] {component_name} {key}` 这样的命令形式来清除参数。

#### 策略管理

策略管理用来配置 RabbitMQ 的消息队列运行时的一些策略值。这些策略配置可以影响 exchanges 和 queues 的默认行为。

- 通过 `rabbitmqctl set_policy [-p vhostpath] [--priority priority] [--apply-to apply-to] {name} {pattern} {definition}` 这样的命令形式来配置策略。
- 通过 `rabbitmqctl clear_policy [-p vhostpath] {name}` 这样的命令形式来删除策略。

#### 内存管理

上一节我们看到通过配置文件方式来指定`vm_memory_high_watermark`，rabbitmq 也提供了运行时动态调整它的方法：

`rabbitmqctl set_vm_memory_high_watermark {fraction}`

## AMQP 概念

RabbitMQ 只是 AMQP(Advanced Message Queuing Protocol) 的一种实现，所以要理解 rabbitmq 的运维，需要简单了解下 AMQ 协议中的一些基础元素：

- Message Flow: 它指消息的整个生命周期。
- Exchanges: 它从消息发布者中接受消息，然后路由到消息队列中（Message Queues）。
- Message Queues: 它将消息存储在内存或磁盘，然后传递消息给对应的消费者。
- Bindings: 它描述 exchange 和 message queue 的关系。如何将消息路由给正确的消息队列。
- Virtual Hosts: 有点类似 web 服务器的 virtualhost，它是一个隔离独立的环境，拥有一组 users,exchanges,message queues 等。

![AMQP stack](../../assets/AMQP_stack.jpg)

## 集群和高可用

RabbitMQ 有两种方式解决单机性能瓶颈：

- Federation/shovel
- Cluster

第一种 rabbitmq 是通过插件的方式实现。这里不做详细介绍。第二种 Cluster 的方式是 RabbitMQ 原生支持的。

集群模式下，所有的数据/状态都会被复制到所有节点达到高可用和可扩展性。

集群模式下的节点类型可以是内存型或者磁盘型。如果选择内存型，那么 rabbitmq 会将状态数据只保存在内存中。
选择磁盘的话，状态数据内存和磁盘都会保存。

### 节点名（标识）

RabbitMQ 节点通过节点名称标识。节点名由两部分组成，一个前缀，通常叫 "rabbit"，一个主机名。例如：`rabbit@node1.svc.local` 这个节点名前缀是 `rabbit`，主机名是 `node1.svc.local`。

节点名在集群中必须唯一。在集群中，节点之间通过节点名来通信。这意味着主机名部分，必须每个节点都可以成功解析。

当节点启动时，它会检查是否给它分配了节点名（通过 RABBITMQ_NODENAME 环境变量），如果没有，它会自动生成 `rabbit@$(hostname -s)` 作为节点名。

如果系统使用 FQDN 作为主机名，rabbitmq 节点必须配置使用这种长的节点名。对于 server 节点，`RABBITMQ_USE_LONGNAME` 必须设置为`true`。对于命令行工具， 要么设置`RABBITMQ_USE_LONGNAME` 要么使用 `--longnames` 的开关。

### RabbitMQ 节点有什么特点

所有的节点之间都共享 RabbitMQ broker 所有需要数据和状态，除了消息队列。消息队列默认只存在一个节点上，虽然它们可以通过其他所有节点来访问。

如果要在节点之间共享复制消息队列，这里涉及到高可用和镜像队列配置，后面会提到。

和其他分布式系统存在 leader 和 follower 角色不同。RabbitMQ 不区分，所有节点都是一样的。

节点之间认证的方式是：Erlang Cookie 。 RabbitMQ 节点和命令行工具（比如 rabbitmqctl)，使用 cookie 来确保它们是否能相互通信。对于同一个集群的 rabbitmq 节点，它的内容需要保持一致，才能相互之间通信。 cookie 是一个长度不大于 255 的字符串。它存在本地文件中。该文件只能由 owner 访问。

对于 rabbitmq 服务端，它默认存储在 /var/lib/rabbitmq/.erlang.cookie，需要保证文件属性是 400，属主是 rabbitmq 的启动用户。

对于 rabbitmqctl 这个命令行客户端，它要和 rabbitmq 集群通信也需要使用同样的 `.erlang.cookie` 文件， 只不过路径不同，位于 `$HOME/.erlang.cookie` 。我们为三台节点生成同样的 erlang cookie 文件， 需要注意的是，`cookie=$(uuid -v4)` 只需要生成一次即可。其他机器必须使用相同的字符串。

```bash
cookie=$(uuid -v4)
echo -n "$cookie" > /var/lib/rabbitmq/.erlang.cookie
echo -n "$cookie" > $HOME/.erlang.cookie
chown rabbitmq.rabbitmq /var/lib/rabbitmq/.erlang.cookie
chmod 400 /var/lib/rabbitmq/.erlang.cookie $HOME/.erlang.cookie
```

### 创建集群

假设有 3 台服务器，分别叫 opensrc-1, opensrc-2, opensrc-3 在 3 台上分别安装和启动 rabbitmq-server 进程。

配置好 erlang cookie 后，在三台服务器上分别启动服务端进程。

```bash
opensrc-1 $ systemctl start rabbitmq-server
opensrc-2 $ systemctl start rabbitmq-server
opensrc-3 $ systemctl start rabbitmq-server
```

然后在每一台机器上运行 cluster_status 指令来确认单节点的 cluster 是否正常运行：

```bash
opensrc-1 $ rabbitmqctl cluster_status
Cluster status of node rabbit@opensrc-1 ...
[{nodes,[{disc,['rabbit@opensrc-1']}]},
 {running_nodes,['rabbit@opensrc-1']},
 {cluster_name,<<"rabbit@opensrc-1">>},
 {partitions,[]},
 {alarms,[{'rabbit@opensrc-1',[]}]}]
```

确认每个节点的状态都正常后。我们可以开始组建多节点集群。首先要停掉应用，然后通过命令行加入集群，最后启动应用。 譬如，下面以第二台加入到第一台的集群为例：

```bash
opensrc-2 $ rabbitmqctl stop_app
Stopping rabbit application on node rabbit@opensrc-2 ...

opensrc-2 $ rabbitmqctl reset
Resetting node rabbit@opensrc-2 ...

opensrc-2 $ rabbitmqctl join_cluster rabbit@opensrc-1
Clustering node rabbit@opensrc-2 with rabbit@opensrc-1

opensrc-2 $ rabbitmqctl start_app
Starting node rabbit@opensrc-2 ...
 completed with 0 plugins.
```

注意到这里使用了 reset 来确保它加入新集群之前，删除之前集群相关的数据和信息。 对 opensrc-3 做同样的操作后。我们运行 `cluster_status` 命令可以看到，三台访问的结果一样了，它们位于同一个集群了。

```bash
opensrc-2 $ rabbitmqctl cluster_status
Cluster status of node rabbit@opensrc-2 ...
[{nodes,[{disc,['rabbit@opensrc-1','rabbit@opensrc-2','rabbit@opensrc-3']}]},
 {running_nodes,['rabbit@opensrc-3','rabbit@opensrc-1','rabbit@opensrc-2']},
 {cluster_name,<<"rabbit@opensrc-1">>},
 {partitions,[]},
 {alarms,[{'rabbit@opensrc-3',[]},
          {'rabbit@opensrc-1',[]},
          {'rabbit@opensrc-2',[]}]}]
```

让一台脱离集群，有两种方法。

我们将 opensrc-3 移除集群为例，第一种方法是当 opensrc-3 节点还处于正常状态可访问时：

```bash
opensrc-3 $ rabbitmqctl stop_app
Stopping rabbit application on node rabbit@opensrc-3 ...

opensrc-3 $ rabbitmqctl reset
Resetting node rabbit@opensrc-3 ...

opensrc-3 $ rabbitmqctl start_app
Starting node rabbit@opensrc-3 ...

opensrc-3 $ rabbitmqctl cluster_status
Cluster status of node rabbit@opensrc-3 ...
[{nodes,[{disc,['rabbit@opensrc-3']}]},
 {running_nodes,['rabbit@opensrc-3']},
 {cluster_name,<<"rabbit@opensrc-3">>},
 {partitions,[]},
 {alarms,[{'rabbit@opensrc-3',[]}]}]
```

第二种方法是，从集群中另外一台正常节点上剔除 opensrc-3,假设我们停掉 opensrc-3 上的 rabbitmq 服务，然后登录 opensrc-1 来操作：

```bash
opensrc-1 $ rabbitmqctl cluster_status
Cluster status of node rabbit@opensrc-1 ...
[{nodes,[{disc,['rabbit@opensrc-1','rabbit@opensrc-2','rabbit@opensrc-3']}]},
 {running_nodes,['rabbit@opensrc-2','rabbit@opensrc-1']},
 {cluster_name,<<"rabbit@opensrc-1">>},
 {partitions,[]},
 {alarms,[{'rabbit@opensrc-2',[]},{'rabbit@opensrc-1',[]}]}]

opensrc-1 $ rabbitmqctl forget_cluster_node rabbit@opensrc-3
Removing node rabbit@opensrc-3 from the cluster

opensrc-1 $ rabbitmqctl cluster_status
Cluster status of node rabbit@opensrc-1 ...
[{nodes,[{disc,['rabbit@opensrc-1','rabbit@opensrc-2']}]},
 {running_nodes,['rabbit@opensrc-2','rabbit@opensrc-1']},
 {cluster_name,<<"rabbit@opensrc-1">>},
 {partitions,[]},
 {alarms,[{'rabbit@opensrc-2',[]},{'rabbit@opensrc-1',[]}]}]
```

这时 opensrc-1 和 opensrc-2 组成集群，opensrc-3 此时还认为自己属于之前的集群，这时启动它，会以下错误：

```txt
throw:{error,{inconsistent_cluster,"Node 'rabbit@opensrc-3' thinks it's clustered with node 'rabbit@opensrc-2', but 'rabbit@opensrc-2' disagrees"}}
```

解决它启动的问题需要 reset 节点信息：

```bash
opensrc-3 $ rabbitmqctl reset
Resetting node rabbit@opensrc-3 ...

opensrc-3 $ rabbitmqctl start_app
Starting node rabbit@opensrc-3 ...
```

如果一个节点 reset 后，重新加入之前的集群，它会同步所有的 virtual hosts,用户，权限以及拓扑（队列，exchangs，bindings），运行参数和策略。如果有配置镜像队列策略命中它，它也会同步镜像队列的内容。没有配置镜像策略的队列，在该节点的数据则会丢失。

## 高可用（镜像）队列

什么是镜像队列？默认配置下，RabbitMQ 中一个队列的内容，只存在单一节点上。这和 exchanges 以及 bindings 不同，它们在集群中所有节点上会复制同步。 不过队列的内容可以通过配置策略来实现多节点同步。

```bash
rabbitmqctl set_policy ha-all "^" \
   '{"ha-mode":"all","ha-sync-mode":"automatic"}'
```

对所有队列（正则表达匹配所有），设置 ha-mode 为 all，表示所有 node 节点都镜像队列，ha-sync-mode 为自动同步。

## 管理插件

RabbitMQ 的"management plugin"提供了基于 HTTP API 对 RabbitMQ 的节点和集群进行管理和监控的工具。它包括一个浏览器访问的 WebUI 页面，和一个命令行工具 rabbitmqadmin。

首先我们开启 web 管理插件：

```bash
rabbitmq-plugins enable rabbitmq_management
```

开启后不需要重启 rabbitmq，会直接激活生效。这时查看本机 rabbitmq 监听了 15672 的 http 端口。

注意这个命令，只对当前运行的 node 生效，但是通过这个启用 web 插件的节点，可以管理操作整个集群的所有节点。

除了用 `rabbitmq-plugins` 命令开启，也可以用配置文件的方式：

```bash
echo '[rabbitmq_management,rabbitmq_management_agent].' > /etc/rabbitmq/enabled_plugins
```

## 启动脚本

- systemd 定义：/usr/lib/systemd/system/rabbitmq-server.service
- /usr/lib/rabbitmq/bin/rabbitmq-server
  - source /usr/lib/rabbitmq/bin/rabbitmq-env
    - set NODENAME RABBITMQ_HOME
    - source /usr/lib/rabbitmq/bin/rabbitmq-defaults
      - source $CONF_ENV_FILE(如果存在)

- 这么多层 source 最后合并的环境变量是怎么样的，可以通过 `rabbitmqctl environment` 命令来打印

## 端口用途

- 4379: epmd 服务发现的端口，rabbitmq 节点之间和命令行工具会访问。
- 5672: AMQP 0-9-1 and 1.0 的客户端会访问到。
- 25672: 节点之间内部通信用。它是 20000+上面的 AMQP 端口(5672)生成的。
- 15672: 开启管理插件后启用，使用 HTTP API 客户端以及 rabbitmqadmin 命令行工具会访问这个端口。

## 启动成功检验标准

- `netstat -tnlpu | grep 5672` 能看到三个端口 5672、15672、25672，则表示监听和启动正常
- `curl -i -u $BK_RABBITMQ_ADMIN_USER:$BK_RABBITMQ_ADMIN_PASSWORD http://<rabbitmq IP>:15672/api/vhosts` 看返回是否正常

## 权限管理

rabbitmq 默认启动时，会创建一个"/"的 vhost，以及默认的"guest"账号，密码为"guest"，仅可以通过本地网卡访问。

蓝鲸初始化时，会删除 guest 账号，并通过 `./bin/01-generate/dbadmin.env` 里定义的 $BK_RABBITMQ_ADMIN_USER 和 $BK_RABBITMQ_ADMIN_PASSWORD 创建一个 administrator 角色的账号

administrator 拥有最高权限，这个账号密码在注册 rabbitmq 给 paas 平台时，传递给 paas 的接口。

```bash
rabbitmqctl add_user "$BK_RABBITMQ_ADMIN_USER" "$BK_RABBITMQ_ADMIN_PASSWORD"
rabbitmqctl set_user_tags "$BK_RABBITMQ_ADMIN_USER" administrator
```

然后为后台模块创建对应的 vhost 和用户，并分配 management 的 tag

```bash
rabbitmqctl add_user "$app_code" "$app_token"
rabbitmqctl set_user_tags $app_code management
rabbitmqctl add_vhost $app_code
# 表示给$app_code用户授予$app_code这个vhost的所有资源的读写和配置权限
rabbitmqctl set_permissions -p $app_code $app_code ".*" ".*" ".*"
```

## WebUI

如果网络策略允许，可以直接用浏览器访问 rabbitmq 所在机器的 15672 端口。
如果网络策略只允许 nginx 访问，我们可以用以下配置做代理转发：

```nginx
server {
    listen 80;
    server_name rabbitmq.bktencent.com;

    location / {
        proxy_pass http://10.0.0.1:15672;
    }
}
```

然后配置 rabbitmq.bktencent.com 的 hosts 文件解析到 Nginx 的 IP，直接访问 80 端口即可。

打开后，需要输入用户名和密码。你可以选择输入管理员的，也就是上一节中，添加的为 administrator 角色的 $BK_RABBITMQ_ADMIN_USER 和 $BK_RABBITMQ_ADMIN_PASSWORD

也可以使用需要观察的 vhost 对应的用户名和密码，比如对于作业平台就是 bk_job 和对应的密码。

## 管理

rabbitmqadmin 这个脚本通过 http api 和集群交互，可以做一些日常管理操作：

- 下载 rabbitmqadmin:

    ```bash
    wget -O /usr/local/bin/rabbitmqadmin http://server-name:15672/cli/rabbitmqadmin
    chmod +x /usr/local/bin/rabbitmqadmin
    ```

## 网络故障后恢复集群

假设有两台 rabbitmq 组成的集群，设为 rbtnode1 和 rbtnode2。因为某些原因 rbtnode1 和 rbtnode2 之间丢包率超过 50%导致集群状态异常。

这时，先确认两台是否已经脱离集群模式，分别在两台机器上运行 `rabbitmqctl cluster_status` 会发现各自的 running nodes 都只是自身。

这时，选择一台作为 master，另外一台则为 slave。譬如我们选 rbtnode1 为 master，那么现在登录到 rbtnode2，运行以下命令：

```bash
# 停app
rabbitmqctl stop_app
# 重置
rabbitmqctl reset
# 加入集群
rabbitmqctl join_cluster rabbit@rbtnode1
# 启动app
rabbitmqctl start_app
```

如果在 join_cluster 时，报错 "inconsistent_cluster, 'Node rabbitq@rbtnode1 thinks it\s' cluster with node rabbit@rbtnode2, but rabbit@rbtnode2 disagrees'"

这时在 rbtnode1 上，执行以下命令：

```bash
# 忘掉rbtnode节点
rabbitmqctl forget_cluster_node rabbit@rbtnode2
```

再到 rbtnode2 上，重新执行 join_cluster 和 start_app 即可。

详细说明参考官方文档：https://www.rabbitmq.com/partitions.html

然后两台机器都看一下，集群状态正常 `rabbitmqctl cluster_status`

## 常用命令

- 查看当前的所有 vhosts 中，messages 最多的：`rabbitmqctl list_vhosts -q  | xargs -I vhost -P0 -n1 sh -c 'rabbitmqctl list_queues -q -p vhost| awk -v vh=vhost "{print vh,\$0}"' | sort -n -k3`