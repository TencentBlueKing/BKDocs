# 管控平台常见问题

## GSE initdata 失败

**表象**：在`./bkcec initdata gse`时，会出现如下 2 种报错

1. `parse cc response error`
2. `parse dataid error`
```bash
# 提示解析CC响应失败，或者解析dataid失败
$ parse dataid failed, [{"server_id": -1, "data_set": "snapshot", "partition": 1, "cluster_index": 0, "biz_id": 2, "msg_system": 1}, {"server_id": -1, "data_set": "snapshot", "partition": 0, "cluster_index": 1, "biz_id": 2, "msg_system": 4}]
migrate failed for gse (server)
```
**出现版本**：4.1.X

**原因**

1. GSE 对应初始化数据的程序及脚本不正确；

2. cmdb 未正常安装，或 cmdb-nginx 启动不正常/未启动；

**解决办法**

原因 1

* 需要更新 GSE 版本中的初始化程序文件 on_migrate 和 parse_bizid，路径`/data/bkce/gse/server/bin`

	```bash
	[root@rbtnode1 /data/install]# md5sum /data/bkce/gse/server/bin/on_migrate /data/bkce/gse/server/bin/parse_bizid
	addc6eeec6e72e73cc330cc7fa69e9b4  /data/bkce/gse/server/bin/on_migrate
	7ba79e36b731ef9678a3b8bfb41dc2ef  /data/bkce/gse/server/bin/parse_bizid
	```
* 用户操作方法：

  * 把这 2 个文件放到中控机`/data/src/gse/server/bin`下面；

  * 在中控机，进行如下操作

     ```bash
     source /data/install/utils.fc
     cd /data/install
     ./bkcec sync all
     ./bkcec stop gse
     ./bkcec install gse 1
     ./bkcec initdata gse
     ```

原因 2

- 确定 cmdb 上 nginx 是否安装，若没安装，根据用户的设置源，让用户安装 nginx，同时需确认`/etc/nginx/nginx.conf`配置文件是否包含`/data/bkce/etc/nginx/*.conf`

- 需确认 cmdb 的状态，包括 cmdb-nginx，确定`./bkcec status cmdb`结果里面`cmdb-nginx`的状态不是 EXIT

- 测试`curl http://cmdb.service.consul`，是否有`502 Bad Gateway`错误返回

- 检查失败时，生成在`/tmp/gse.tmp`的文件， 不能出现有`502 bad gateway`的错误提示，若出现，注意检查 cmdb 的 8029 端口是否 OK

## GSE 启动失败

**内网 IP 自动获取不对时**

LAN_IP 表示 GSE 服务器真实可用的内网 IP(ip addr 输出查看)，需要根据实际 IP 替换 修改以下配置文件项，新增相关配置，注意 json 格式，逗号问题。

- data.conf

```json
"datasvrip":"LAN_IP",
```

- task.conf

```json
"tasksvrip":"LAN_IP",
"tasksvrthirftip":"LAN_IP",
"tasksvrtrunkip":"LAN_IP",
```

- dba.conf

```json
"servers":[{"ip":"LAN_IP","port":58817}],
```

- btsvr.conf

```json
"filesvrthriftip":"LAN_IP",
"btServerOuterIP":[{"ip":"LAN_IP","port":59173}],
"btServerInnerIP":[{"ip":"LAN_IP","port":59173}],
Copy
```

- api.conf

```json
"cacheApiAddr":[{"ip":"LAN_IP", "port":59313}],
Copy
```

- agent.conf

```json
"agentip":"LAN_IP",
```

## GSE agent 状态异常

节点管理 app 或 Job 显示 agent 状态异常:

1. 检查对应 ip 机器上的 gse_agent 进程是否正常 `ps -ef |grep gse_agent`
2. 检查 gse_agent 的 48533 连接是否正常
3. 检查 gse_agent 与 gse server 的证书是否匹配
4. 检查该 ip 在 CC 上的业务及云区域 id 是否正确
5. 检查 gse_api 日志，查看启动时是否有`UPDATE_REDIS_FAILED`信息，若有则重启 gse_api

**直连的 agent**

- 查看 agent 机器上的 gse_agent 进程是否成对出现

~~~bash
* 查看是否和gse_task的48533端口建立链接：`netstat -antp | grep :48533`

```bash
[root@nginx-1 ~]# netstat -antp |grep :48533
tcp        0      0 10.0.1.2:35544          10.0.1.226:48533        ESTABLISHED 26714/./gse_agent
~~~

- 登陆到第一步显示链接的 gse_task 的 IP(10.X.X.X)，继续查看链接：`netstat -antp | grep :48533 | grep 10.0.1.2` 确认 gse_task 上看到的 ip 和 agent 的 ip 一致。若不一致，可能 agent->gse_task 时发生了 NAT 转换

**Proxy 下的 agent**

- 查看 agent 是否和 proxy(gse_agent)的 48533 建立链接：`netstat -antp | grep :48533`
- 和直连 agent 的排查同理，到 proxy 上查看建立链接的 ip 是否一致

## GSE 相关组件自动获取 IP 失败

下文 `__LAN_IP__` 均表示 GSE 服务器真实可用的内网 IP

gse 相关组件默认会自动尝试获取内网网卡 ip 去监听，但是有些网卡复杂的情况下 会监听到不正确的网卡时，可以尝试修改配置文件里的 IP 来解决

如果配置文件不包含以下配置段，可以自己新增相关配置，要注意配置文件都是 json 格式，留意逗号问题

- GSE 后台服务

GSE 后台服务的配置文件路径默认在 /data/bkce/etc/gse/ 下

譬如 gse_task 进程对应的配置是 task.conf ，修改后，使用 `cd /data/bkce/gse/server/bin/ && ./gsectl restart task` 来重启。其他进程以此类推。

- data.conf

```json
"datasvrip":"LAN_IP",
```

- task.conf

```json
"tasksvrip":"LAN_IP",
"tasksvrthirftip":"LAN_IP",
"tasksvrtrunkip":"LAN_IP",
```

- dba.conf

```json
"servers":[{"ip":"LAN_IP","port":58817}],
```

- btsvr.conf

```json
"filesvrthriftip":"LAN_IP",
"btServerOuterIP":[{"ip":"LAN_IP","port":59173}],
"btServerInnerIP":[{"ip":"LAN_IP","port":59173}],
```

- api.conf

```json
"cacheApiAddr":[{"ip":"LAN_IP", "port":59313}],
```

- Gse Proxy 模块

proxy 的配置文件在 /usr/local/gse/proxy/etc/ 下，修改配置后使用 `cd /usr/local/gse/proxy/bin/ && ./gsectl restart` 来重启。

- agent.conf

```json
"agentip":"LAN_IP",
"proxylistenip":"LAN_IP",
```

##  日志采集问题排查

### 查看源日志是否有更新

确保采集的数据源有日志持续输出 注意：文件内容不可直接清空，文件轮转可采用删除或者移动 MV。

### 检测日志采集器进程

```bash
ps -ef | grep unifytlogc
Copy
```

若进程不存在，进入采集器目录，手动尝试启动采集器查看是否有错误信息

```bash
cd /usr/local/gse/plugins/bin/
./unifytlogc -c ../etc/unifytlogc.conf
Copy
```

### 检查连接

agent 机器：有正常 ESTABLISHED 的链接则 ok

- Linux `netstat -antp | grep 58625 | grep ESTABLISHED`
- Windows `netstat -ano | grep 58625`

若存在 proxy，登陆 proxy 机器：检测 58625 端口同上。

- Linux `netstat -tnp | grep 58625`

登陆 GSE 后台服务器，检测 gse_data 是否连上 9092 端口:

- Linux: `lsof -nP -c dataWorker | grep :9092`
- Windows: `netstat -ano | grep 9092`

### 检测日志采集配置

```bash
cat /usr/local/gse/plugins/etc/unifytlogc.conf
Copy
```

找到对应任务的 dataid，(在 tlogcfg->fileds->dataid)

```json
{
    "tlogcfg":[
        {
            "fileds":[
                {
                    "dataid":123,
                    "condition":[
                    ]
                }
            ],
            "dataid":123
            "isNotPack":0,
            "beJson":1,
            "ignore_file_end_with":...,
            "private":{
                "_plat_id_":1
            },
            "dataset":"datatest",
            "clear_file_cycle":157680000,
            "file":"/tmp/datatest/ddd.log",
            "field_sep":"|",
            "log_type":"logbyline"
        }
    ],
    "ipc_socket":"/var/run/ipc.state.report",
    "log_path":"/var/log/gse",
    "data_path":"/var/lib/gse",
    "pidfile_path":"/var/run/gse/unifytlogc.pid",
    "log_level":"ERROR"
}
Copy
```

示例 dataid=123

### 在 ZK_IP 上查看 dataid 对应的 topic

$dataid 替换为上一步查询出来的 dataid

```bash
/data/bkce/service/zk/bin/zkCli.sh -server zk.service.consul:2181 (ip通常为本机内网IP)
get /gse/config/etc/dataserver/data/$dataid
Copy
```

取出 data_set 和 biz_id 两个字段，合并在一起 例如：

```json
{"server_id": -1, "data_set": "datatest", "partition": 1, "cluster_index": 0, "biz_id": 4, "msg_system": 1}
Copy
```

topic 为 datatest4

### 检测 kafka 数据

在 KAFKA 机器上

```bash
source /data/install/utils.fc
cd /data/bkce/service/kafka
topic=<上面查询的结果>
sh bin/kafka-console-consumer.sh --bootstrap-server $LAN_IP:9092 --topic $topic
Copy
```

等待有没有新的数据产生

### 若 kafka 没有数据，查看 gse_data 日志

登陆 GSE Server 的机器，看有没有 gse_data 的 pid 开头命名的日志。 若有，tail 查看日志内容

```bash
datapid=$(pgrep -x dataWorker)
ls -l /data/bkce/public/gse/data/${datapid}*
Copy
```

Copyright © 腾讯蓝鲸 2012-2018 all right reserved，powered by 

## GSE 端口列表

- 直连 agent 和 GSE 之间的互通策略

| 源地址    | 目标地址  | 协议    | 端口         | 用途             |
| --------- | --------- | ------- | ------------ | ---------------- |
| agent     | zk        | TCP     | 2181         | 获取配置         |
| agent     | gse_task  | TCP     | 48533        | 任务服务端口     |
| agent     | gse_data  | TCP     | 58625        | 数据上报端口     |
| agent     | gse_btsvr | TCP     | 59173        | bt 传输           |
| agent     | gse_btsvr | TCP,UDP | 10020        | bt 传输           |
| agent     | gse_btsvr | UDP     | 10030        | bt 传输           |
| gse_btsvr | agent     | TCP,UDP | 60020-60030  | bt 传输           |
| gse_btsvr | gse_btsvr | TCP     | 58930        | bt 传输           |
| gse_btsvr | gse_btsvr | TCP,UDP | 10020        | bt 传输           |
| gse_btsvr | gse_btsvr | UDP     | 10030        | bt 传输           |
| agent     | agent     | TCP,UDP | 60020-60030  | bt 传输           |
| agent     |           |         | 监听随机端口 | bt 传输，可不开通 |
| gse_btsvr |           |         | 监听随机端口 | bt 传输，可不开通 |

- proxy 和 GSE 之间的互通策略

| 源地址             | 目标地址         | 协议    | 端口         | 用途                 |
| ------------------ | ---------------- | ------- | ------------ | -------------------- |
| proxy(gse_agent)   | gse_task         | TCP     | 48533        | 任务服务端口         |
| proxy(gse_transit) | gse_data         | TCP     | 58625        | 数据上报端口         |
| proxy(gse_btsvr)   | gse_btsvr        | TCP     | 58930        | bt 传输               |
| proxy(gse_btsvr)   | gse_btsvr        | TCP,UDP | 10020        | bt 传输               |
| proxy(gse_btsvr)   | gse_btsvr        | UDP     | 10030        | bt 传输               |
| gse_btsvr          | proxy(gse_btsvr) | TCP     | 58930        | bt 传输               |
| gse_btsvr          | proxy(gse_btsvr) | TCP,UDP | 10020        | bt 传输               |
| gse_btsvr          | proxy(gse_btsvr) | UDP     | 10030        | bt 传输               |
| proxy(gse_btsvr)   | proxy(gse_btsvr) | TCP     | 58930        | bt 传输（同一子网）   |
| proxy(gse_btsvr)   | proxy(gse_btsvr) | TCP,UDP | 10020        | bt 传输（同一子网）   |
| proxy(gse_btsvr)   | proxy(gse_btsvr) | UDP     | 10030        | bt 传输（同一子网）   |
| proxy(gse_opts)    | gse_ops          | TCP     | 58725        | ping告警数据上报端口 |
| proxy(gse_agent)   |                  |         | 监听随机端口 | bt 传输，可不开通     |
| proxy(gse_btsvr)   |                  |         | 监听随机端口 | bt 传输，可不开通     |

- proxy 下 agent 和 proxy 之间的互通策略

| 源地址           | 目标地址           | 协议    | 端口         | 用途             |
| ---------------- | ------------------ | ------- | ------------ | ---------------- |
| agent            | proxy(gse_agent)   | TCP     | 48533        | 任务服务端口     |
| agent            | proxy(gse_transit) | TCP     | 58625        | 数据上报端口     |
| agent            | proxy(gse_btsvr)   | TCP     | 59173        | bt 传输           |
| agent            | proxy(gse_btsvr)   | TCP,UDP | 10020        | bt 传输           |
| agent            | proxy(gse_btsvr)   | UDP     | 10030        | bt 传输           |
| proxy(gse_btsvr) | agent              | TCP,UDP | 60020-60030  | bt 传输           |
| agent            | agent              | TCP,UDP | 60020-60030  | bt 传输(同一子网) |
| agent            |                    |         | 监听随机端口 | bt 传输，可不开通 |



