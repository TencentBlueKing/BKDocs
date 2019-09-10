# 管控平台FAQ

## GSE initdata失败

**表象**：在`./bkcec initdata gse`时，会出现如下2种报错

1. `parse cc response error`
2. `parse dataid error`
```bash
# 提示解析CC响应失败，或者解析dataid失败
$ parse dataid failed, [{"server_id": -1, "data_set": "snapshot", "partition": 1, "cluster_index": 0, "biz_id": 2, "msg_system": 1}, {"server_id": -1, "data_set": "snapshot", "partition": 0, "cluster_index": 1, "biz_id": 2, "msg_system": 4}]
migrate failed for gse (server)
```
**出现版本**：4.1.X

**原因**

1. GSE对应初始化数据的程序及脚本不正确；

2. cmdb未正常安装，或cmdb-nginx启动不正常/未启动；

**解决办法**

原因1

* 需要更新GSE版本中的初始化程序文件on_migrate和parse_bizid，路径`/data/bkce/gse/server/bin`

	```bash
	[root@rbtnode1 /data/install]# md5sum /data/bkce/gse/server/bin/on_migrate /data/bkce/gse/server/bin/parse_bizid
	addc6eeec6e72e73cc330cc7fa69e9b4  /data/bkce/gse/server/bin/on_migrate
	7ba79e36b731ef9678a3b8bfb41dc2ef  /data/bkce/gse/server/bin/parse_bizid
	```
* 用户操作方法：

  * 把这2个文件放到中控机`/data/src/gse/server/bin`下面；

  * 在中控机，进行如下操作

     ```bash
     source /data/install/utils.fc
     cd /data/install
     ./bkcec sync all
     ./bkcec stop gse
     ./bkcec install gse 1
     ./bkcec initdata gse
     ```

原因2

- 确定cmdb上nginx是否安装，若没安装，根据用户的设置源，让用户安装nginx，同时需确认`/etc/nginx/nginx.conf`配置文件是否包含`/data/bkce/etc/nginx/*.conf`

- 需确认cmdb的状态，包括cmdb-nginx，确定`./bkcec status cmdb`结果里面`cmdb-nginx`的状态不是EXIT

- 测试`curl http://cmdb.service.consul`，是否有`502 Bad Gateway`错误返回

- 检查失败时，生成在`/tmp/gse.tmp`的文件， 不能出现有`502 bad gateway`的错误提示，若出现，注意检查cmdb的8029端口是否OK

## GSE 启动失败

**内网IP自动获取不对时**

LAN_IP表示GSE服务器真实可用的内网IP(ip addr输出查看)，需要根据实际IP替换 修改以下配置文件项，新增相关配置，注意json格式，逗号问题。

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

节点管理app或 Job 显示 agent 状态异常:

1. 检查对应 ip 机器上的 gse_agent 进程是否正常 `ps -ef |grep gse_agent`
2. 检查 gse_agent 的 48533 连接是否正常
3. 检查 gse_agent 与 gse server 的证书是否匹配
4. 检查该ip在CC上的业务及云区域id是否正确
5. 检查 gse_api 日志，查看启动时是否有`UPDATE_REDIS_FAILED`信息，若有则重启gse_api

**直连的agent**

- 查看agent机器上的 gse_agent 进程是否成对出现

~~~bash
* 查看是否和gse_task的48533端口建立链接：`netstat -antp | grep :48533`

```bash
[root@nginx-1 ~]# netstat -antp |grep :48533
tcp        0      0 10.0.1.2:35544          10.0.1.226:48533        ESTABLISHED 26714/./gse_agent
~~~

- 登陆到第一步显示链接的gse_task的IP(10.X.X.X)，继续查看链接：`netstat -antp | grep :48533 | grep 10.0.1.2` 确认gse_task上看到的ip和agent的ip一致。若不一致，可能agent->gse_task时发生了NAT转换

**Proxy下的agent**

- 查看agent是否和proxy(gse_agent)的48533建立链接：`netstat -antp | grep :48533`
- 和直连agent的排查同理，到proxy上查看建立链接的ip是否一致

## GSE 相关组件自动获取 IP 失败

下文 `__LAN_IP__` 均表示 GSE 服务器真实可用的内网IP

gse 相关组件默认会自动尝试获取内网网卡ip去监听，但是有些网卡复杂的情况下 会监听到不正确的网卡时，可以尝试修改配置文件里的IP来解决

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

- Gse Proxy模块

proxy的配置文件在 /usr/local/gse/proxy/etc/ 下，修改配置后使用 `cd /usr/local/gse/proxy/bin/ && ./gsectl restart` 来重启。

- agent.conf

```json
"agentip":"LAN_IP",
"proxylistenip":"LAN_IP",
```

##  日志采集问题排查

### 查看源日志是否有更新

确保采集的数据源有日志持续输出 注意：文件内容不可直接清空，文件轮转可采用删除或者移动MV。

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

agent机器：有正常ESTABLISHED的链接则ok

- Linux `netstat -antp | grep 58625 | grep ESTABLISHED`
- Windows `netstat -ano | grep 58625`

若存在proxy，登陆proxy机器：检测58625端口同上。

- Linux `netstat -tnp | grep 58625`

登陆 GSE后台服务器，检测 gse_data 是否连上9092端口:

- Linux: `lsof -nP -c dataWorker | grep :9092`
- Windows: `netstat -ano | grep 9092`

### 检测日志采集配置

```bash
cat /usr/local/gse/plugins/etc/unifytlogc.conf
Copy
```

找到对应任务的dataid，(在 tlogcfg->fileds->dataid)

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

### 在ZK_IP上查看dataid对应的topic

$dataid替换为上一步查询出来的dataid

```bash
/data/bkce/service/zk/bin/zkCli.sh -server zk.service.consul:2181 (ip通常为本机内网IP)
get /gse/config/etc/dataserver/data/$dataid
Copy
```

取出data_set和biz_id两个字段，合并在一起 例如：

```json
{"server_id": -1, "data_set": "datatest", "partition": 1, "cluster_index": 0, "biz_id": 4, "msg_system": 1}
Copy
```

topic为datatest4

### 检测kafka数据

在KAFKA机器上

```bash
source /data/install/utils.fc
cd /data/bkce/service/kafka
topic=<上面查询的结果>
sh bin/kafka-console-consumer.sh --bootstrap-server $LAN_IP:9092 --topic $topic
Copy
```

等待有没有新的数据产生

### 若kafka没有数据，查看gse_data日志

登陆GSE Server的机器，看有没有 gse_data 的pid 开头命名的日志。 若有，tail查看日志内容

```bash
datapid=$(pgrep -x dataWorker)
ls -l /data/bkce/public/gse/data/${datapid}*
Copy
```

Copyright © 腾讯蓝鲸 2012-2018 all right reserved，powered by 

## GSE 端口列表

- 直连agent和GSE之间的互通策略

| 源地址    | 目标地址  | 协议    | 端口         | 用途             |
| --------- | --------- | ------- | ------------ | ---------------- |
| agent     | zk        | TCP     | 2181         | 获取配置         |
| agent     | gse_task  | TCP     | 48533        | 任务服务端口     |
| agent     | gse_data  | TCP     | 58625        | 数据上报端口     |
| agent     | gse_btsvr | TCP     | 59173        | bt传输           |
| agent     | gse_btsvr | TCP,UDP | 10020        | bt传输           |
| agent     | gse_btsvr | UDP     | 10030        | bt传输           |
| gse_btsvr | agent     | TCP,UDP | 60020-60030  | bt传输           |
| gse_btsvr | gse_btsvr | TCP     | 58930        | bt传输           |
| gse_btsvr | gse_btsvr | TCP,UDP | 10020        | bt传输           |
| gse_btsvr | gse_btsvr | UDP     | 10030        | bt传输           |
| agent     | agent     | TCP,UDP | 60020-60030  | bt传输           |
| agent     |           |         | 监听随机端口 | bt传输，可不开通 |
| gse_btsvr |           |         | 监听随机端口 | bt传输，可不开通 |

- proxy和GSE之间的互通策略

| 源地址             | 目标地址         | 协议    | 端口         | 用途                 |
| ------------------ | ---------------- | ------- | ------------ | -------------------- |
| proxy(gse_agent)   | gse_task         | TCP     | 48533        | 任务服务端口         |
| proxy(gse_transit) | gse_data         | TCP     | 58625        | 数据上报端口         |
| proxy(gse_btsvr)   | gse_btsvr        | TCP     | 58930        | bt传输               |
| proxy(gse_btsvr)   | gse_btsvr        | TCP,UDP | 10020        | bt传输               |
| proxy(gse_btsvr)   | gse_btsvr        | UDP     | 10030        | bt传输               |
| gse_btsvr          | proxy(gse_btsvr) | TCP     | 58930        | bt传输               |
| gse_btsvr          | proxy(gse_btsvr) | TCP,UDP | 10020        | bt传输               |
| gse_btsvr          | proxy(gse_btsvr) | UDP     | 10030        | bt传输               |
| proxy(gse_btsvr)   | proxy(gse_btsvr) | TCP     | 58930        | bt传输（同一子网）   |
| proxy(gse_btsvr)   | proxy(gse_btsvr) | TCP,UDP | 10020        | bt传输（同一子网）   |
| proxy(gse_btsvr)   | proxy(gse_btsvr) | UDP     | 10030        | bt传输（同一子网）   |
| proxy(gse_opts)    | gse_ops          | TCP     | 58725        | ping告警数据上报端口 |
| proxy(gse_agent)   |                  |         | 监听随机端口 | bt传输，可不开通     |
| proxy(gse_btsvr)   |                  |         | 监听随机端口 | bt传输，可不开通     |

- proxy下agent和proxy之间的互通策略

| 源地址           | 目标地址           | 协议    | 端口         | 用途             |
| ---------------- | ------------------ | ------- | ------------ | ---------------- |
| agent            | proxy(gse_agent)   | TCP     | 48533        | 任务服务端口     |
| agent            | proxy(gse_transit) | TCP     | 58625        | 数据上报端口     |
| agent            | proxy(gse_btsvr)   | TCP     | 59173        | bt传输           |
| agent            | proxy(gse_btsvr)   | TCP,UDP | 10020        | bt传输           |
| agent            | proxy(gse_btsvr)   | UDP     | 10030        | bt传输           |
| proxy(gse_btsvr) | agent              | TCP,UDP | 60020-60030  | bt传输           |
| agent            | agent              | TCP,UDP | 60020-60030  | bt传输(同一子网) |
| agent            |                    |         | 监听随机端口 | bt传输，可不开通 |



