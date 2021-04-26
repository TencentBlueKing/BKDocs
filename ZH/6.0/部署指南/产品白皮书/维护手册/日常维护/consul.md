# Consul

[Consul](https://www.consul.io/) 作为蓝鲸组件的基础组件，提供了以下功能：服务发现，域名注册，动态配置渲染等功能。

1. 服务发现（通过 dns 和 http 接口）
2. 服务健康检查（通过外部脚本和 TCP 探测端口方式）
3. KV 存储
    - 蓝鲸监控后台利用 consul 来缓存元数据信息
    - SaaS 部署利用 consul 来存储部署服务器信息
    - consul-template 利用 consul 的服务配置来动态生成 nginx 配置文件

运维蓝鲸需要对 Consul 基础有一定了解。

本文从最初的安装部署到日常问题处理，描述 Consul 运维相关的内容。

关于 Consul 的基本概念和知识，建议阅读 Consul 官方的快速入门教程：<https://learn.hashicorp.com/consul>

## 安装部署

蓝鲸采用 rpm 包来安装 consul，安装后的文件列表如下：

```bash
$ rpm -ql consul
/etc/consul.d/consul.json-dist
/etc/consul.d/service
/etc/logrotate.d/consul
/etc/sysconfig/consul
/usr/bin/consul
/usr/lib/systemd/system/consul.service
/usr/share/consul
/var/lib/consul
```

根据用户环境传入的参数，自动配置并在 `/etc/consul.d/` 目录下生成 `consul.json`、`server.json`、`auto_join.json`、`recursor.json`、`telemetry.json`配置文件。

这些操作，封装为 `./bin/install_consul.sh` 脚本。该脚本无参数运行时，会输出帮助文档如下：

```bash
$ ./bin/install_consul.sh 
用法: 
    install_consul.sh [ -h --help -?  查看帮助 ]
            [ -j, --join            [必填] "集群auto join的服务器列表，逗号分隔" ]
            [ -e, --encrypt-key     [必填] "集群通信的key，用consul keygen生成，集群内必须一致" ]
            [ -d, --data-center     [选填] "datacenter名字，默认为dc" ]
            [ -r, --role            [可选] "部署的consul角色，取值server或client，默认为client" ]
            [ --dns-port            [可选] "部署的consul dns 端口号，默认为8600" ]
            [ --http-port           [可选] "部署的consul http 端口号，默认为8500" ]
            [ -b, --bind            [可选] "监听的网卡地址,默认为127.0.0.1" ]
            [ -n, --server-number   [可选] "如果是server模式，配置集群中的server数量" ]
            [ --node                [可选] "node_name，配置consul节点名，默认为hostname" ]
            [ -v, --version         [可选] "查看脚本版本号" ]
```

比较重要的参数有：

- `-e, --encrypt-key`: 它是蓝鲸部署准备阶段 `./bkcli install bkenv` 的时候，自动通过 `consul keygen`生成，并保存到 `./bin/01-generate/dbadmin.env` 中的 `BK_CONSUL_KEYSTR_32BYTES`
- `-r, --role`: 决定安装的是 consul server 还是 consul client。 consul server 是 `install.config` 中配置了 `consul` 模块的机器（$BK_CONSUL_IP[@]}）。其余的机器为 consul client
- `-j, --join`: consul 启动的时候，自动加入的集群 ip 列表。
- `-b, --bind`: consul 的 dns 和 http 协议端口监听的网卡地址，默认是 127.0.0.1。

安装并启动成功后，脚本会修改 `/etc/resolv.conf`

1. 添加 `nameserver 127.0.0.1` 配置项，并保证它位于第一行
2. 如果存在 option 的配置，且包含了 `rotate`，则删除该选项，防止轮询。因为蓝鲸依赖 consul 监听的 127.0.0.1:53 做解析。
3. 添加 `search node.consul`，因为 consul 默认会注册本机的 `<node_name>.node.consul` 这样长主机名，一些 java 应用读取本机的$HOSTNAME 后反向解析 ip 的时候，会用到。

然后停掉 `nscd` 的缓存服务。

最后通过判断 `consul.service.consul` 是否可以解析来判断本机的 consul 安装成功与否。

## Consul 配置项说明

consul 的配置读取优先级从高到低依次为：

1. 命令行参数
2. 环境变量
3. 配置文件

consul 可以不需要使用任何命令行开关和配置，都有默认值，请参考官方文档的配置项的默认值说明。见：https://www.consul.io/docs/agent/options

蓝鲸部署 consul 主要采用了命令行参数+配置文件的方式。命令行参数在下一节启停中会提到，写在 `/etc/sysconfig/consul` 中，配置文件按功能，拆分为以下几个子配置：

1. consul.json

    ```json
    {
        "bind_addr": "10.0.0.1",
        "log_level": "info",
        "log_file": "/var/log/consul/consul.log",
        "datacenter": "dc",
        "data_dir": "/var/lib/consul",
        "node_name": "bk-1",
        "disable_update_check": true,
        "enable_local_script_checks": true,
        "encrypt": "PQ97sDNs79DS6xnCmo7yAWCkBaYGqFemmo71wDkgtwU=",
        "ports": {
            "dns": 53,
            "http": 8500
        }
    }
    ```

    主配置中大部分参数都和命令行指定的参数一致，不再赘述。值得一提的是：

    - datacenter：指定的数据中心，对于跨数据中心部署有意义。
    - enable_local_script_checks: 该功能开关，允许 consul 运行本地脚本来进行健康探测。

2. server.json: 该配置只有安装时角色为 `server` 的主机上才存在。

    ```json
    {
        "server": true,
        "bootstrap_expect": 3
    }
    ```

    - `bootstrap_expect`: 表示集群初次选举 leader 时最少应该有多少个节点。

3. auto_join.json: 配置 consul 启动后自动加入的集群的 ip 列表
4. recursors.json: 从 `/etc/resolv.conf` 中读取已有的 nameserver ip，并写入到该配置。如果原本没有配置 nameserver，则不存在该配置文件。
5. telemetry.json: 配置监控 metrics 接口相关的参数。详见：<https://www.consul.io/docs/agent/telemetry>

配置文件全部准备妥当后，可以通过命令 `consul validate /etc/consul.d` 来校验所有的 `*.json` 合并后的语法/语义是否符合 `consul agent` 启动所需。注意该命令需要接受完整的配置定义，而不能只传递部分配置，譬如 `consul validate /etc/consul.d/server.json` 会报错。

## Consul 启停

consul 通过 rpm 安装的 `/usr/lib/systemd/system/consul.service` 注册了 consul.service 的服务。并在 `./bin/install_consul.sh` 脚本中，设置了开机启动。

启动用户是 rpm 安装时，自动创建的 `consul` 用户。启动命令是 `/usr/bin/consul $CMD_OPTS`。`$CMD_OPTS`是从 `/etc/sysconfig/consul` 中定义的。
如果想自定义启动参数，比如添加 `-ui` 参数打开 consul 的 web 管理端界面，需要修改 `/etc/sysconfig/consul` 文件，然后通过 `systemctl restart consul` 来生效。

默认的参数是：`agent -config-dir=/etc/consul.d -config-dir=/etc/consul.d/service -data-dir=/var/lib/consul`，这里指定了两个 `-config-dir`，因为 consul 不支持递归找目录下的所有配置。
只扫描第一层目录的 `*.json` 和 `*.hcl` 后缀的配置文件。`/etc/consul.d/*.json` 存放 consul 本身启动需要的配置。 `/etc/consul.d/service/*.json` 存放服务定义的配置文件。

极少的情况下，需要停止 `consul` 服务，停止 consul 服务使用 `systemctl stop consul` 命令。但往往需要的是屏蔽某个域名服务解析到本机，特别是滚动更新一个后台模块的时候。
这种情况，请使用：`consul maint -enable` 将本机设置为维护模式。这样该节点的所有服务，都不会通过 consul 的 dns 或者 http 接口返回。更新完毕后，使用`consul maint -disable`解除维护模式。

还有一种情况，是需要下架该机器，回收机器。这时应该使用 `consul leave` 来优雅退出，再通过 `systemctl disable consul` 去掉开机启动。

## 服务发现

consul 的服务发现功能，从三个方面来介绍：

- 注册服务
- 查询服务
- 更新服务

### 注册服务

consul 支持两种形式来注册服务：

- 服务定义文件(位于/etc/consul.d/service/*.json)
- HTTP API

蓝鲸目前两种方式均有采用。除了 `rabbitmq` 和 `bkmonitorv3`相关模块是后台启动后调用 HTTP API 自动注册服务外，其余均是通过自动生成`/etc/consul.d/service/*.json`的服务定义文件，在 consul 启动时自动加载注册。

本节介绍通过第一种方式注册服务的细节。

假设我们为蓝鲸的 MySQL 服务定义一个名为 mysql-default 的服务，它指定：

1. 服务名称为 `mysql-default`
2. 服务端口为 3306
3. 健康探测为: 通过 TCP 协议检测 `本机内网IP:3306` 端口

```bash
cat <<EOF > /etc/consul.d/service/mysql-default.json
{
  "service": {
    "id": "mysql-default-45e3b960-45df-11eb-b0bd-5254006f5633",
    "name": "mysql-default",
    "address": "10.0.0.1",
    "port": 3306,
    "check": {
      "tcp": "10.0.0.1:3306",
      "interval": "10s",
      "timeout": "3s"
    }
  }
}
EOF
```

配置项说明如下：

- name: 对应服务名称
- id: 为了避免同名冲突，根据 uuid 生成一个随机串
- address: 该服务对外暴露的访问 ip 地址
- port: 该服务对外暴露的访问端口
- check: 定义健康检查机制
  - tcp: 通过 tcp 进行探测，参数为探测的 ip 和端口
  - interval: 检查间隔时间，蓝鲸统一设定为 10s
  - timeout: tcp 探测的超时时间为 3s

运行 `consul reload` 加载配置，让上述配置生效。

### 查询服务

consul agent 启动，且成功注册服务后，可以通过两种方式来查询服务。

1. DNS
2. HTTP API

对于第一种 DNS 方式，服务的 DNS 域名是 **`NAME`.service.consul**。

默认情况下，所有的 DNS 域名都是以`.consul`结尾的，虽然这也是可以配置的（-domain 命令行开关，或者 domain 配置选项指定）。service 这个子域名，告诉 consul，我们需要查询的是服务，最后 NAME 对应这个服务的名字。

对于刚才定义的 `mysql-default` 服务，组合起来的域名为：mysql-default.service.consul

使用 dig 命令查询：

```bash
$ dig mysql-default.service.consul

...
;; QUESTION SECTION:
;mysql-default.service.consul.		IN	A

;; ANSWER SECTION:
mysql-default.service.consul.	0	IN	A	10.0.0.1
...
```

可以看到，consul 返回了一个 A 记录，A 记录包含一个 IP 地址，而这个 IP 地址是对应的 mysql-default 服务所在节点的 IP 地址。

该节点返回的 IP 地址为什么恰好是 10.0.0.1，而不是 127.0.0.1，或者那台主机上其他网卡的地址（如果存在多网卡私有 IP）呢？

这是由 consul 启动时的 `-advertise` 参数，或者配置文件的 `address` 参数指定的。consul 启动时，可以通过观察标准输出的 "Cluster Addr: " 来确定这个信息。

通过 dns 接口，除了 A 记录，还可以查询 `SRV` 记录来获取这个服务的地址/端口对：

```bash
$ dig mysql-default.service.consul SRV

...
;; QUESTION SECTION:
;mysql-default.service.consul.	IN	SRV

;; ANSWER SECTION:
mysql-default.service.consul. 0	IN	SRV	1 1 3306 0a00057f.addr.dc.consul.

;; ADDITIONAL SECTION:
0a00057f.addr.dc.consul. 0	IN	A	10.0.0.1
bk-1.node.dc.consul.	0 IN	TXT	"consul-network-segment="
...
```

SRV 记录的 ANSWER SECTION 字段含义从左到右依次为：

- 域名
- TTL
- Class(IN)
- Record Type(SRV)
- Priority(优先级)
- 权重(weight)
- 服务端口
- 服务主机名

注意 SRV 记录还返回额外信息，也就是主机名的 A 记录，包含对应的 IP 地址。

除了 DNS API，也可以使用 HTTP API 来查询服务：

```bash
curl -s http://127.0.0.1:8500/v1/catalog/service/mysql-default | jq 
```

8500 端口是 consul 监听的 http-port，处于安全考虑，默认只监听本机的回环地址（127.0.0.1）。

catalog API 是列出所有提供该服务名称的的节点。

后面我们提到健康检查时，会用到只查询当前能提供服务的健康节点的 API。

对于 DNS API 来说，查询健康的节点是默认的行为。而 HTTP 则需要加上参数：

```bash
curl -s http://127.0.0.1:8500/v1/health/service/mysql-default?passing | jq
```

### 更新服务

通过修改服务定义文件，然后发送 SIGHUP 信号给 consul，来达到更新服务定义的目的。

运行 `consul reload` 相当于发送 `SIGHUP` 信号。

### 脚本封装

部署脚本目录下因为注册 consul 服务是一个很常见的操作，封装了一个原子脚本 `./bin/reg_consul_svc` 来协助生成 consul 服务定义文件到标准输出。安装部署脚本再根据一定的规则，生成落地文件到 `/etc/consul.d/service/NAME.json` 中。

该脚本的用法：

```bash
$ ./bin/reg_consul_svc 
用法: 
    reg_consul_svc [ -h --help -?  查看帮助 ]
            [ -n, --name        [必选] "注册到consul的服务名(service name)" ]
            [ -p, --port        [必选] "注册到consul的服务端口" ]
            [ -a, --address     [必选] "注册到consul的服务地址，一般与服务的bindip一致" ]
            [ -t, --tag         [可选] "注册到consul的服务的tag" ]
            [ -i, --url         [可选] "consul的api地址，默认为：http://127.0.0.1:8500" ]
            [ -D, --dry-run     [可选] "打印出生成的consul服务定义文件到标准输出" ]
            [ -v, --version     [可选] 查看脚本版本号 ]

```

可以根据上文注册服务中生成的 json 文件来对应下参数和实际配置的关系。
需要提到的是：

- `-t, --tag`: 服务 tag 可以管理同一类服务的不同具体用途。
- `-D, --dry-run`: 默认不加该参数，则直接通过 HTTP API 注册服务，如果加了该参数，才会打印生成的 json 配置到标准输出，然后自行重定向到对应的配置文件。

## KV 操作

- 设定键值

    ```bash
    consul kv put bkapps/upstreams/prod/bk_sops '["10.0.0.1"]'
    ```

- 更新键值

    ```bash
    consul kv put bkapps/upstreams/prod/bk_sops '["10.0.0.1","10.0.0.2"]'
    ```

- 查询键值

    ```bash
    consul kv get bkapps/upstreams/prod/bk_sops
    ```

- 递归查询键值

    ```bash
    consul kv get -recurse bkapps/upstreams
    ```

- 删除键值

    ```bash
    consul delete bkapps/upstreams/prod/bk_sops
    ```

- 递归删除

    ```bash
    consul delete -recurse bkapps
    ```

## 备份

consul 提供 snapshot 命令，可以通过 cli 或者 http api 来调用。snapshot 命令，会将以下 consul server 的状态数据进行备份，包括但不限于：

1. KV 数据
2. 服务目录（service catalog）
3. 会话
4. ACLs

在任一 consul server 节点运行：

```bash
consul snapshot save backup.snap
```

备份后可以使用以下命令查看备份数据的元信息

```bash
consul snapshot inspect backup.snap
```

从备份中恢复：

```bash
consul snapshot restore backup.snap
```

## 开启 Web 管理界面

1. 选择部署 nginx 的服务器，修改 consul 的启动命令行参数 （/etc/sysconfig/consul），在 `CMD_OPTS` 中追加命令行参数 `-ui`
2. 重启 consul: `systemctl restart consul`
3. 验证是否生效：`curl -sL http://127.0.0.1:8500/ | grep CONSUL_VERSION` 如果有返回说明 webUI 正常开启
4. 配置 nginx 将请求代理转发给本机 127.0.0.1:8500，这样能方便通过浏览器访问，假设我们使用 `consul.bktencent.com` 这个域名来访问。添加以下 nginx 配置，并重新加载生效。

    ```bash
    source ./load_env.sh
    cat > /usr/local/openresty/nginx/conf/conf.d/consul.conf <<EOF
    server {
        listen 80;
        server_name consul.bktencent.com;

        access_log $BK_HOME/logs/nginx/consul_ui_access.log main;

        location / {
            proxy_pass http://127.0.0.1:8500;
        }
    }
    EOF
    systemctl reload openresty
    ```

5. 在本机配置 hosts 文件，添加域名解析，假设 nginx 所在服务器对应的外网 ip 是 100.0.0.1

    ```bash
    100.0.0.1 consul.bktencent.com
    ```

6. 浏览器输入 `http://consul.bktencent.com` 来访问 Consul 的 WebUI

## 常用操作

- 查询 leader：`curl -s http://127.0.0.1:8500/v1/status/leader`
- 查询集群节点：`consul members [-detailed]`
- 查看当前日志：`consul monitor [-log-level debug]`
- 查看当前节点运行信息：`consul info`
- 查看 leader 和 follower：`consul operator raft list-peers`
- 查看当前节点注册的服务：`curl -s http://127.0.0.1:8500/v1/agent/services`
- 取消当前节点注册的服务：
  - 1.0 以上的版本使用命令行：`consul services deregister <my-service-id>`
  - 1.0 以下的使用 httpapi：`curl --request PUT http://127.0.0.1:8500/v1/agent/service/deregister/<my-service-id>`

## 常见问题

### Consul 域名无法解析

**表象**：

在部署和使用时，如果遇到类似这样的日志信息："xx.service.consul Name or service not known" 

意味着域名无法解析的问题。consul 域名，指的是蓝鲸集群模块之间使用 consul 模块注册的以".service.consul"结尾 的域名。它由每台机器上运行的 consul 进程监听的 53 端口提供解析服务

**思路方法**：

1. 在中控机上运行命令检查所有节点的 consul 服务状态

    ```bash
    ./bkcli check consul
    ```

    - check_consul_process: 检查 consul 服务进程是否存活
    - check_consul_listen_udp_53： 检查 consul 服务是否监听了 udp 53
    - check_consul_listen_tcp_8500: 检查 consul 服务是否监听了 tcp 8500
    - check_consul_warning_svc: 检查 consul 服务有哪些状态为 warnning 的
    - check_consul_critical_svc: 检查 consul 服务有哪些状态为 critical 的
    - check_resolv_conf_127.0.0.1: 检查 consul 节点上/etc/resolv.conf 中 nameserver 配置不正确的

2. 一般情况下，check_consul_critical_svc 会列出故障的服务名。
3. 根据服务名需要确认对应的进程是否正常启动并成功监听了指定的端口（结合本文档中，注册服务章节的知识）
4. 重新启动对应服务模块的进程，等待 10s 后再次运行 `./bkcli check consul` 来判断服务是否健康
5. 对于 check_resolv_conf_127.0.0.1 失败的节点。请配置好 /etc/resolv.conf 并持久化它。

### 持久化/etc/resolv.conf
