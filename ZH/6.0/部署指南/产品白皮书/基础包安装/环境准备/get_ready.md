# 安装环境准备

开始安装蓝鲸社区版前，需按以下文档指南，做好准备工作。

**注意：所有待安装蓝鲸的机器均需要按以下清单检查和操作。**


## CentOS 系统设置

准备好硬件，安装完原生 CentOS 系统后。我们需要对初始系统做一些配置，保证后续安装过程的顺畅和蓝鲸平台的运行。

**系统版本：** 要求 CentOS-7.0 以上版本，推荐 CentOS-7.6。

1\. 关闭 SELinux

```bash
# 检查 SELinux 的状态，如果它已经禁用，可以跳过后面的命令
sestatus
```

可以使用以下命令禁用 SELinux，或者修改配置文件。

```bash
# 通过命令临时禁用 SELinux
setenforce 0

# 或者修改配置文件
sed -i 's/^SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
```

接着，重启机器：

```bash
reboot
```
2\. 关闭默认防火墙(firewalld)

安装和运行蓝鲸时，模块之间互相访问的端口策略较多，建议对蓝鲸后台服务器之间关闭防火墙。

```bash
# 检查默认防火墙状态，如果返回 not running，可以跳过后面的命令
firewall-cmd --state
```

停止并禁用 firewalld
```bash
systemctl stop firewalld    # 停止 firewalld
systemctl disable firewalld # 禁用 firewall 开机启动
```

3\. 安装 rsync 命令

安装脚本依赖 rsync 分发同步文件。

```bash
# 检查是否有 rsync 命令，如果有返回 rsync 路径，可以跳过后面的命令
which rsync

# 安装 rsync
yum -y install rsync
```


4\. 停止并禁用 NetWorkManager
```bash
systemctl stop NetworkManager
systemctl disable NetworkManager
```
> 备注说明：该操作前提需确保主机为静态 IP，若为 DHCP 获取的 IP，则无法直接 disable NetworkManager，否则会出现主机重启后，或者主机运行一段时间 IP 租约地址到期后，网卡无法从网络重新正常获取 IP 地址的情况。

5\. 调整最大文件打开数

```bash
# 检查当前 root 账号下的 max open files 值
ulimit -n
```

如果为默认的 1024，建议通过修改配置文件调整为 102400 或更大。

**注意：** limits.conf 初始文件的备份。
```bash
cat << EOF >> /etc/security/limits.conf
root soft nofile 102400
root hard nofile 102400
EOF
```

修改后，重新使用 root 登录检查是否生效。

6\. 确认服务器时间同步

服务器后台时间不同步会对时间敏感的服务带来不可预见的后果。务必在安装和使用蓝鲸时保证时间同步。

```bash
# 检查每台机器当前时间和时区是否一致，若相互之间差别大于3s(考虑批量执行时的时差)，建议校时。
date -R

# 查看和ntp server的时间差异(需要外网访问，如果内网有ntpd服务器，自行替换域名为该服务的地址)
ntpdate -d cn.pool.ntp.org
```

如果输出的最后一行 offset 大于 1s 建议校时。
```bash
# 和 ntp 服务器同步时间
ntpdate cn.pool.ntp.org
```

更可靠的方式包括通过运行 ntpd 或者 chrony 等服务在后台保持时间同步。
具体请参考官方文档 [使用 ntpd 配置 NTP](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/ch-configuring_ntp_using_ntpd) 或 [使用 chrony 配置 NTP](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/ch-Configuring_NTP_Using_the_chrony_Suite)。

7\. 检查是否存在全局 HTTP 代理

蓝鲸服务器之间会有的 HTTP 请求，如果存在 HTTP 代理，且未能正确代理这些请求，会发生不可预见的错误。

```bash
# 检查 http_proxy https_proxy 变量是否设置，若为空可以跳过后面的操作。
echo "$http_proxy" "$https_proxy"
```
对于本机配置 http_proxy 变量的方式，请依次查找文件 /etc/profile、/etc/bashrc、$HOME/.bashrc 等是否有设置。
或者咨询网络管理员/IT 部门协助处理。

在这些主机中，选择任意一台机器作为蓝鲸的运维中控机。之后的安装命令执行，如果没有特别说明，均在这台中控机上执行。

将下载的蓝鲸社区版完整包上传到中控机，并解压到 **同级** 目录下。以解压到 `/data` 目录为例：

```bash
tar xf bkce_src-6.0.0.tgz -C /data
```

解压之后，得到两个目录：src，install

- src：存放蓝鲸产品软件，以及依赖的开源组件

- install：存放安装部署脚本、安装时的参数配置、日常运维脚本等

8\. 检查 resolv.conf 是否有修改权限

检查 /etc/resolv.conf 是否被加密无法修改(即便是 root)，执行如下命令，检查是否有 “i” 加密字样：

```bash
lsattr /etc/resolv.conf
----i--------e-- /etc/resolv.conf
```

如果有则执行命令，临时解密处理，执行如下命令：

```bash
chattr -i /etc/resolv.conf
```

需要注意，在 resolv.conf 配置文件的首行，即第一个 DNS 地址需为 127.0.0.1，如下所示：

```bash
nameserver 127.0.0.1
nameserver 192.168.1.100
nameserver 192.168.2.100
```

> 备注说明：resolv 配置文件无需人工修改内容，后续安装脚本会自动为主机进行配置 127.0.0.1，因此只需检查是否允许修改即可。关于首行需要 127.0.0.1，这是由于后面蓝鲸内部组件的调用所需，域名通过 consul 解析，会探测服务运行状态，然后返回 IP 地址，
> 例如访问 es，那么内部需要解析 es.service.consul 等，若首行不是 127.0.0.1，否则这些域名就通过外网去解析，无法返回正确的响应，导致服务运行异常，或者 SaaS 无法正常打开等情况。

9. 检查部署机器的主机名

请检查准备用于部署蓝鲸的 3 台机器的主机名是否相同。如果存在同名请进行修改。

```bash
hostname
```

## 配置文件

### install.config

`install.config` 是模块和服务器对应关系的配置文件，描述在哪些机器上安装哪些模块。

每行两列，第一列是 IP 地址；第二列是以英文逗号分隔的模块名称。

详情参考`install.config.3IP.sample`文件(可将 install.config.3IP.sample 复制为 install.config)。

```bash
10.0.0.1 iam,ssm,usermgr,gse,license,redis,consul,es7,monitorv3(influxdb-proxy),monitorv3(monitor),monitorv3(grafana)
10.0.0.2 nginx,consul,mongodb,rabbitmq,appo,influxdb(bkmonitorv3),monitorv3(transfer),fta,beanstalk
10.0.0.3 paas,cmdb,job,mysql,zk(config),kafka(config),appt,consul,log(api),nodeman(nodeman)
```

说明:
- 该配置文件，IP 后面使用空格与服务名称隔开，含有多个内网 IP 的机器，默认使用 /sbin/ifconfig 输出中的第一个内网 IP，在 IP 后面写上该机器要安装的服务列表即可，部署过程中默认使用标准私有地址，若企业环境使用非标准私有地址，请参考 [本章后续内容-非标准私有地址处理方法](./get_ready.md#非标准私有地址处理方法) 的处理方法。
- zk 表示 ZooKeeper， es7 表示 ElasticSearch。
- gse 与 redis 需要部署在同一台机器上。
- 增加机器数量时，可以将以上配置中的服务挪到新的机器上，分担负载。



### 非标准私有地址处理方法

蓝鲸社区版部署脚本中(install 目录)下有以下文件中有获取 IP 的函数 get_lan_ip，非标准地址，均需要在安装部署前完成修改。

```bash
/data/install/health_check/deploy_chek.py
/data/install/agent_setup/download#agent_setup_pro.sh
/data/install/agent_setup/download#agent_setup_aix.ksh
/data/install/agent_setup/download#agent_setup.sh
/data/install/appmgr/docker/saas/buildsaas
/data/install/appmgr/docker/build
/data/install/scripts/gse/agent/gsectl
/data/install/scripts/gse/plugins/stop.sh
/data/install/scripts/gse/plugins/start.sh
/data/install/scripts/gse/plugins/reload.sh
/data/install/scripts/gse/agentaix/gsectl.ksh
/data/install/scripts/gse/proxy/gsectl
/data/install/scripts/gse/server/gsectl
/data/install/precheck.sh
/data/install/functions
```

这些文件列表，可能随版本迭代变动，也可以用以下命令查找出来包含这个函数的脚本文件有哪些：

```bash
grep -l 'get_lan_ip *()' -r /data/install
```

修改方法：

假设服务器的的 ip 是：138.x.x.x，它不在标准的私有地址范围，那么你需要修改 get_lan_ip() 函数为：

```bash
get_lan_ip  () {
...省略
           if ($3 ~ /^10\./) {
               print $3
           }
           if ($3 ~ /^138\./) {
               print $3
           }
      }

return $?
}
```



