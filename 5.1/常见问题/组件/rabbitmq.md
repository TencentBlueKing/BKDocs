# RabbitMQ 常见问题

## RabbitMQ 启动失败

4.1 社区版本 RabbitMQ 启动失败问题处理

**表象**：在部署蓝鲸 JOB 过程中需要进行 RabbitMQ 的安装，数据初始化，激活步骤，此问题多发生在此过程

**思路方法**：如果是在添加用户和 vhost 时报错，那么说明启动 rabbitmq-server 没有成功，通过以下方式确认

```bash
# 查看进程是否存在
$ ps -ef | grep beam

# 查看监听端口是否存在(5672, 15672, 25672 三个端口必须都在）
$ netstat -tnlpu | grep 5672  
```

若没有启动，通过 `systemctl start rabbitmq-server` 启动。若系统没有 systemctl 命令，通过 `service rabbitmq start`启动

首先排查 `/data/bkce/etc/rabbitmq` 目录，对 RabbitMQ 用户是否有读权限，`/data/bkce/public/rabbitmq`目录对 RabbitMQ 用户是否有写权限

自己处理好目录的权限问题后，再尝试重启 `rabbitmq-server`

## rabbitmq activate 失败

**表象**：此问题发生在 `./bk_install app_mgr`，会发生如下报错

```bash
$ [X.X.X.X] register and activate rabbitmq failed. requrest env: .
$ [X.X.X.X] api reponse: {"msg": "HTTPConnectionPool(host='X.X.X.X', port=15672): Max retries exceeded with url: /api/overview (caused by NewConnectionError('<requests.packages.urllibs.connecion.HTTPConnection object at ox7fc5175c4e10>: Failed to establish a new connection: [Errno lll] Connection refused',))"}
```

**思路方法**：

1. 确认 umask，若不是 022，修改 `/etc/profile`，然后 `source /etc/profile`，再卸载 RabbitMQ，重新安装
2. 确认在安装过程，或在 `rabbitmq activate` 前主机域名是否做过调整修改

## rabbitmq initdata 失败

**表象**：在部署蓝鲸 JOB 过程中需要进行 RabbitMQ 的安装，数据初始化，激活步骤，此问题多发生在此过程


```bash
[ root@rbtnodel install)# ．/bkcec initdata rabbitmq
Warning： Permanently added '10.x.x.x' (RSA) to the list Of known hosts.
bash： line 5： systemctl： command not found

Creating u se r "admin"
Error: unable to connect to node rabbit@rbtnode1 ： nodedown
DIAGNOSTICS
============

nodes in question： [ rabbit@rbtnode1 }
hosts, their running n Odes an d ports ：
 - rbtnodel： Hrabbitmqct127684,36040))

current node details ：
 - node name： rabbitmqctl27684@rbtnode1
 - home dir： /var/lib/rabbitmq
 - cookie hash： UgOyBrCIoJjXfjMxhu7+Dg::
add rabbitmq u se r admin failed ．
[10.x.x.x] 20180828．130149 337     add rabbitmq user admin failed
```

**思路方法**：通过以下方式来尝试解决

> 注意：若系统没有 systemctl 命令，注意修改下`/data/install/utils.fc`文件，查找到`init_rabbitmq_cluster ()`函数，把`systemctl start rabbitmq-server`修改为`service rabbitmq-server start`

```bash
# rabbitmq现在是运行状态？是的话。
./bkcec stop rabbitmq
rm -rf /root/.erlang.cookie /var/lib/rabbitmq/* /data/bkce/public/rabbitmq/*
# 确认rabbitmq进程真正停掉，若存在未停掉的，使用如下强制停掉
ps -ef | grep rabbitmq | awk '{print $2}' | xargs -n 1 kill -9

# 若系统没有systemctl命令，注意修改下/data/install/utils.fc文件，查找到init_rabbitmq_cluster ()函数，把systemctl start rabbitmq-server修改为service rabbitmq-server start
1773 init_rabbitmq_cluster () {
1774     ckv=$(uuid -v4)
1775     cookie=/var/lib/rabbitmq/.erlang.cookie
1776     rcmd root@$RABBITMQ_IP "
1777             echo -n $ckv >$cookie;
1778             echo -n $ckv >/root/${cookie##*/};
1779         chown rabbitmq.rabbitmq $cookie;
1780         chmod 400 $cookie /root/${cookie##*/};
1781         systemctl start rabbitmq-server"

# 再手动重新进行数据初始化
./bkcec initdata rabbitmq

# 初始化成功后，在/data/install/.bk_install.step文件里面，把下面的加进去，防止安装时再报错
initdata rabbitmq
```

## rabbitmq 15672 不存在

如果是在激活 RabbitMQ 时报错**15672** 端口拒绝链接，那说明 `rabbitmq-server`没有成功加载`rabbitmq_management`插件

原因可能有 2 种：

1. umask 不正确，导致无法访问对应目录
2. 主机名发生变更，导致节点发现异常
