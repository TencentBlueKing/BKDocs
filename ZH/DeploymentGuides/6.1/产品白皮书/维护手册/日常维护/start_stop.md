# 组件维护

## 第三方组件

第三方依赖组件安装时均使用 rpm 包安装，或者二进制直接拷贝到 $PATH 目录下。下面按照安装顺序依次介绍第三方组件：

- 本地 yum 源：`bk-yum.service` 部署蓝鲸时临时用的，使用`python`临时启动的一个 http 下载服务，安装完毕后，应该使用 openresty 来替换它。
- consul： `consul.service` 是 install.config 中配置 consul 模块所在主机启动的 server 角色的 consul 服务。其余机器则为 client 角色。
- MySQL： `mysql@<实例名>.service` Mysql 的安装利用了 systemd service 的模板实例化特性，不同的 mysql 实例的实例名可能不同，服务器上具体安装的名字，可以用 `systemctl status mysql@*`来查看。
- Redis： `redis@<实例名>.service` Redis 和 Mysql 类似，使用实例化模板启动。
- Nginx：`openresty.service` Nginx 使用的 openresty 的包加上 nginx-upload 模块重新编译打包。操作启停时注意是用 openresty，而不是 nginx。
  - consul-template： `consul-template.service` 和 nginx 一并安装的还有 consul-template 的服务，蓝鲸接入层使用它来读取 consul 服务中的动态配置，然后渲染为 nginx 的子配置，渲染成功后，校验 nginx 配置，无误则重新 reload openresty 服务。
- RabbitMQ：`rabbitmq-server.service` RabbitMQ 消息队列服务。被 `PaaS`、`作业平台`、`官方SaaS`依赖。
- Zookeeper：`zookeeper.service` Zookeeper 分布式存储，被 Kafka、`配置平台`、`管控平台`依赖。
- MongoDB：`mongod.service` MongoDB 服务，被`配置平台`、`管控平台`依赖。
- Kafka： `kafka.service` 被`监控平台`的数据链路依赖。
- Elasticsearch7 `elasticsearch.service` 被`日志平台`的数据链路依赖。
- InfluxDB：`influxdb.service` 被`监控平台` 依赖，存储监控性能数据。
- BeanStalk： `beanstalkd.service` 被 `故障自愈` 依赖。

## 蓝鲸组件

下面列举出查看蓝鲸基础平台的模块以及对应的服务名和进程的方法，请注意蓝鲸组件的服务名，均含有 `bk-` 前缀。服务根据启动先后顺序列出，请格外注意。排在前面的服务一般需要先启动成功后，再启动靠后的服务。

1. 证书服务后台：`bk-license.service`
2. 权限中心后台：`bk-iam.service`
3. 凭证管理后台：`bk-ssm.service`
4. PaaS 后台：`bk-paas.target`
5. 用户管理后台：`bk-usermgr.service`
6. 配置平台后台：`bk-cmdb.target`
   1. bk-cmdb-admin.service： 需要最先启动，将配置文件刷入 zk 节点。
   2. bk-cmdb-core.service： 其次启动，因为剩余的模块会尝试去 zk 上寻找它的 ip:port 发起请求，如果请求失败，会导致进程启动失败。当前版本是一个强依赖。
   3. 其他微服务进程启动。
   4. bk-gse-dba.service 应该最先启动，其他进程启动无顺序依赖。
7. 节点管理后台：`bk-nodeman.service`
8. 监控后台：
   1. `bk-monitor.service：` 监控的 kernelapi 后台。
   2. `bk-transfer.service：` 监控链路的 transfer 服务。
   3. `bk-influxd-proxy.service：` 监控读写 influxdb 的代理服务。
   4. `bk-grafana.service` 监控的 grafana 仪表盘服务。
9. 日志平台后台：`bk-log-api.service`
10. 故障自愈后台：`bk-fta.service`

## 组件启停

组件启停的操作逻辑由 `bkcli` -> `control.sh` -> `action.rc` 这样的调用逻辑控制。例如 `bkcli restart paas` 解析命令行参数后，调用 `control.sh start paas`。接着 `control.sh` 会调用 pssh 登录到每台 paas 机器上，加载 `action.rc` 后，运行 `action_paas start` 。 最终底层都是调用 systemctl 命令来做启停。下面主要介绍 systemctl 操作组件的方法。

### 通用操作

蓝鲸和开源组件均使用 systemd 来做进程管理。下面列出当前版本注册的 systemd 服务和常用的启停方式。

所有的 service 都支持三种操作：start/stop/restart

1. 启动 paas 所有模块：`systemctl start bk-paas.target`
2. 启动 paas 单个模块：`systemctl start bk-paas-<模块名>`

- 配置了 target 的服务，可以使用 `systemctl list-dependencies bk-模块名.target` 来看它下面启用的服务有哪些。

    如 cmdb 的 target：

    ```bash
    systemctl list-dependencies bk-cmdb.target
    bk-cmdb.target
    ● ├─bk-cmdb-admin.service
    ● ├─bk-cmdb-api.service
    ● ├─bk-cmdb-auth.service
    ● ├─bk-cmdb-cloud.service
    ● ├─bk-cmdb-core.service
    ● ├─bk-cmdb-datacollection.service
    ● ├─bk-cmdb-event.service
    ● ├─bk-cmdb-host.service
    ● ├─bk-cmdb-operation.service
    ● ├─bk-cmdb-proc.service
    ● ├─bk-cmdb-task.service
    ● ├─bk-cmdb-topo.service
    ● └─bk-cmdb-web.service
    ```

- 想了解一个服务的 systemd 定义可使用 `systemctl cat 服务名`。能看到实际的启停命令，需要的环境变量配置等。

  如 cmdb 的 admin 服务：

    ```bash
    systemctl cat bk-cmdb-admin.service
    ```

- 如果需要查看服务状态，可以使用 `systemctl status 服务名`。如果机器负载较高，`status` 命令可能会因为读取 journalctl 的日志而卡住，可以使用`systemctl status 服务名 -n0`来跳过日志查看。

- 查看某一台机器上 failed 的 service 情况：`systemctl list-units --failed` 不过它的输出结果除了蓝鲸组件还包括系统的 systemd 服务，请注意分辨。

### 组件状态查询

组件的状态可以从进程运行，健康检测接口返回两个层面进行观察。

- **install/bin/bks.sh：** 脚本用于查询 systemd 管理的进程状态，如果发现 MAINPID 对应的进程名是 supervisord，会进一步通过 supervisorctl 查询 supervisord 托管的子进程的状态。
- **install/health_check/check_consul_svc_health.sh：** 脚本用于查询注册到 consul 的蓝鲸服务，且具备通过 http 接口探测健康状态。

为了便于通过中控机操作，封装了另外 2 个脚本：

- install/status.sh
- install/check.sh

分别使用 `./bkcli status <模块>` 和 `./bkcli check <模块>` 来调用，根据传入的模块名，ssh 登录到模块所在的 IP，然后在该 IP 上，运行 bks.sh 和 check_consul_svc_health.sh 的脚本。

### 启动失败定位

如果检查状态的时候，发现进程是 failed 状态，需要定位问题，通用的办法如下，下面以 bk-license.service 为例：

1. 通过 journalctl 查看该服务最近的启动日志，观察是否有线索

    ```bash
    # 查看bk-license服务的最新的50行日志，直接输出，不传入给less等PAGER
    journalctl -u bk-license.service -n 50 --no-pager
    ```

2. 如果没有可观察到的线索，查看服务的日志，日志目录位于 `$BK_HOME/logs/模块名/` 下，如果不确定看哪个日志，找到最新的几个观察

    ```bash
    cd $BK_HOME/logs/license/ && ls -lrt 
    less +F license_serverxxxx.log # +F为了直接看行尾的日志
    ```

3. 如果依然没有找到线索，可以尝试命令行直接启动。因为蓝鲸使用 blueking 账号，应使用 runuser 运行，以便发现权限相关的问题：

    ```bash
    # 查看ExecStart使用的命令行，把相关的变量替换为实际的。
    # 需要注意有一些变量是通过EnvironmentFile=来引用的
    systemctl cat bk-license.service 
    runuser -u blueking -- /data/bkce/license/license/bin/license_server -config /data/bkce/etc/license.json
    ps -ef | grep license_server
    ```

4. 上一步可能依然没有任何输出，最后的招可以使用 strace 命令观察（需要一定的 Linux 系统调用基础）

    ```bash
    strace  -f runuser -u blueking -- /data/bkce/license/license/bin/license_server -config /data/bkce/etc/license.json
    ```

以上是举的 license_server 进程例子，其他进程请根据实际命令和参数来定位。

## 进程查看

各组件对应的进程名，启动参数，启动用户，写入的日志文件路径等信息。可以用以下方式查看，本文附表汇总了
基础版的所有组件进程信息，方便对照。见[《蓝鲸社区版 6.0 进程列表》](https://docs.qq.com/sheet/DWkV5elFBemxwY3Nk?tab=BB08J2)

1. 通览本机所有组件进程，默认是用 `more` 命令来查看，可以翻页和搜索感兴趣的 service

    ```bash
    systemctl status
    ```

2. 如果已知 service 的名字，可以直接查看该服务下进程的 MAINPID 找到主进程。

    ```bash
    systemctl show -p MainPID bk-nodeman.service
    ```

3. 找到 MAINPID 后，可以通过 `pstree` 查看进程树，包含 pid, cmdline 等信息。

    ```bash
    pstree -pla <mainpid>
    ```

4. 知道进程的 pid 后，通过 `ps`、`lsof`、`/proc/<pid>/*` 等命令和文件可以了解进程有关的详细信息。

    ```bash
    # 获取 pid 进程的当前工作目录，顺便查看进程的用户、组。
    ls -l /proc/<pid>/cwd
    # 查看 pid 进程生效的 limits 相关信息：
    cat /proc/<pid>/limits
    # 查看 pid 进程生效的环境变量信息：
    tr '\0' '\n' /proc/<pid>/environ
    # 查看 pid 打开的普通文件：
    lsof -nP -p <pid> | grep REG 
    # 查看 pid 监听的端口：
    lsof -Pan -i -sTCP:LISTEN -p <pid>
    ss -nlp | grep ,pid=<pid>,
    ```

5. 有些 MAINPID 是 supervisord 的进程，说明这个 service 是 systemd 启动托管 supervisord，supervisord 再拉起相应进程，在蓝鲸基础平台中，一般是 Python 工程会这样使用。

6. 部署脚本（`./bin/bks.sh`）封装了根据 service 名查看进程相关信息的操作，日常使用中可带来便利。


关于进程启动后的 STDOUT 和 STDERR 指向哪里，这里提供一个通用定位方法：

1. 找到 pid 打开的文件句柄 1（STDOUT）和 2（STDERR）。下面以 `license_server` 为例：

    ```bash
    $ lsof -p 3518 -a -d 1,2
    COMMAND    PID     USER   FD   TYPE             DEVICE SIZE/OFF  NODE NAME
    license_s 3518 blueking    1u  unix 0xffff880423539880      0t0 31718 socket
    license_s 3518 blueking    2u  unix 0xffff880423539880      0t0 31718 socket
    ```

2. 指向的是 unix socket 类型, NODE 为 31718，使用 ss 查找对应的进程

    ```bash
    $ ss -xp | grep -w 31718
    u_str  ESTAB      0      0       * 31718                 * 15113                 users:(("license_server",pid=3518,fd=2),("license_server",pid=3518,fd=1))
    u_str  ESTAB      0      0      /run/systemd/journal/stdout 15113                 * 31718                 users:(("systemd-journal",pid=997,fd=52),("systemd",pid=1,fd=160))
    ```

    可以看出该 unix socket 的对端进程是 systemd-journald。一般使用 systemd 托管的进程，如果没有特殊配置， STDOUT 和 STDERR 都通过 unix socket 发送给 journald 进程然后通过 rsyslogd 的规则，会写入相应的磁盘文件。

3. 对于插件进程，比如 `basereport`，看到 STDERR 是重定向到 /tmp/xuoasefasd.err 文件。

    ```bash
    $ lsof -c basereport -a -d 1,2
    COMMAND     PID USER   FD   TYPE DEVICE SIZE/OFF   NODE NAME
    baserepor 21360 root    1w   CHR    1,3      0t0   1028 /dev/null
    baserepor 21360 root    2w   REG  252,1        0 399806 /tmp/xuoasefasd.err
    ```

4. 对于 supervisord 托管的进程，且配置文件中配置了 "stdout_logfile" 和 "redirect_stderr" 配置项。那么会显示如下：通过 supervisord 创建的 PIPE pair 打印。

    ```bash
    $ lsof -p 12435 -a -d 1,2
    COMMAND    PID     USER   FD   TYPE DEVICE SIZE/OFF      NODE NAME
    gunicorn 12435 blueking    1w  FIFO    0,8      0t0 427293063 pipe
    gunicorn 12435 blueking    2w  FIFO    0,8      0t0 427293063 pipe

    $ lsof -n | grep -w 427293063
    ...
    superviso 12422       blueking    8r     FIFO                0,8       0t0  427293063 pipe
    ...
    ```