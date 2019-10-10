# Consul

## Consul 解析逻辑

在部署和使用时，如果遇到类似这样的日志信息："Name or service not known" 或者 "host=xxx.service.consul port=xxxx max retries……"

意味着内部域名无法解析的问题。内部域名，指的是蓝鲸集群模块之间使用 consul 模块注册的以".service.consul"结尾 的域名。它由每台机器上运行的 consul 进程监听的 53 端口提供解析服务。

## Consul 配置说明

- 主配置

```bash
[root@rbtnode1 /data/install]# cat /data/bkee/etc/consul.conf
{
    "rejoin_after_leave": true,
    "skip_leave_on_interrupt": true,
    "recursors": [],
    "bind_addr": "10.X.X.X",
    "node_id": "8fb274be-245f-4301-926f-76e1c1abf316",
    "retry_join": [
        "10.X.X.X",
        "10.X.X.X",
        "10.X.X.X"
    ],
    "log_level": "info",
    "server": true,
    "datacenter": "dc",
    "data_dir": "/data/bkee/public/consul",
    "leave_on_terminate": false,
    "node_name": "gse-1",
    "bootstrap_expect": 3,
    "pid_file": "/data/bkee/logs/consul.pid",
    "encrypt": "uUrZvLe8gff5jNKRwH1QOw==",
    "ports": {
        "dns": 53
    }
}
```

- 服务配置

```bash
[root@rbtnode1 /data/install]# cat /data/bkee/etc/consul.d/license.json
{
    "service": {
        "id": "license-1",
        "checks": [
            {
                "service_id": "license-1",
                "interval": "10s",
                "script": "/data/bkee/bin/health_check/check_proc_exists -m license"
            }
        ],
        "name": "license",
        "enableTagOverride": false,
        "address": "10.X.X.X"
    }
}
```

## Consul 内部域名无法解析

**表象**：

在部署和使用时，如果遇到类似这样的日志信息："Name or service not known" 或者 "host=xxx.service.consul port=xxxx max retries……"

意味着内部域名无法解析的问题。内部域名，指的是蓝鲸集群模块之间使用 consul 模块注册的以".service.consul"结尾 的域名。它由每台机器上运行的 consul 进程监听的 53 端口提供解析服务

**思路方法**：

当无法解析时，第一步，在报错的机器上使用 dig 看看 consul 能否解析：

```bash
$ dig xxx.service.consul @127.0.0.1
```

@127.0.0.1 表示使用 127.0.0.1:53 这个作为 dns 服务器，也就是使用 consul 提供的 dns 服务

正常情况下，可以看到类似下图的记录。如果命令换成`dig 域名` 没出现正确的记录，说明 `/etc/resolv.conf`里没有配置上 127.0.0.1 的 namserver，确认 `/etc/resolv.conf` 里第一行是`nameserver 127.0.0.1`

```bash
;; ANSWER SECTION:
zk.service.consul.    0    IN    A    10.x.x.x
zk.service.consul.    0    IN    A    10.x.x.x
zk.service.consul.    0    IN    A    10.x.x.x

;; Query time: 1 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
```

如果出现以下信息， 说明 consul 没有正常启动。那么 使用 supervisor 启动 consul 进程

```bash
; <<>> DiG 9.9.4-RedHat-9.9.4-29.el7_2.2 <<>> zk.service.consul @127.0.0.1
;; global options: +cmd
;; connection timed out; no servers could be reached
```

如果出现以下信息 "IN A" 后面没有 ip 地址，说明 consul 启动了，但是无法解析域名

```bash
;; QUESTION SECTION:
;zk.service.consul.        IN    A

;; AUTHORITY SECTION:
consul.            0    IN    SOA    ns.consul. postmaster.consul. 1530849644 3600 600 86400 0
```

此时按照以下步骤:

- 运行 `consul monitor` 看看日志，主要确认 consul 集群状态是否正常。观察是否有"no cluster leader" 的输出。
- 针对具体的域名，譬如 zk.service.consul，那么登陆到 zk 所在机器，查看`/data/bkce/etc/consul.d/zk.json`文件 运行里面的 check 脚本，看返回的输出。

对于出现"no cluster leader"的输出时，说明 consul 之间没有成功组成集群，选举出 leader：

- 检查 consul server 节点是否都 running
- 在任意一台 consul 上输入 `consul join <另外一个consul节点>`
- 查看节点状态：`consul operator raft list-peers`

