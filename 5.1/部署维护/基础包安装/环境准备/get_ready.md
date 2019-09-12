## 安装环境准备

开始安装蓝鲸社区版前，需按以下文档指南，做好准备工作。

**注意：所有待安装蓝鲸的机器均需要按以下清单检查和操作。**

### 获取安装包

蓝鲸社区版包含部署脚本、产品软件和开源组件。蓝鲸提供完整包与分包的下载通道，请自行到下载地址按需获取。新装环境及新用户建议下载完整包使用。

下载地址：https://bk.tencent.com/download/

下载完成后，请核对 MD5 码。


### CentOS 系统设置

准备好硬件，安装完原生 CentOS 系统后。我们需要对初始系统做一些配置，保证后续安装过程的顺畅和蓝鲸平台的运行。

**系统版本：** 要求 CentOS-7.0 以上版本，推荐 CentOS-7.5。

1. 关闭 SELinux

    ```bash
    # 检查 SELinux 的状态，如果它已经禁用，可以跳过后面的命令
    sestatus
    ```

    可以使用以下命令禁用 SELinux，或者修改配置文件。
    ```bash
    # 通过命令禁用 SELinux
    setenforce 0

    # 或者修改配置文件
    sed -i 's/^SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    ```
    接着，重启机器：
    ```plain
    reboot
    ```
2. 安装 rsync 命令

    安装脚本依赖 rsync 分发同步文件。

    ```bash
    # 检查是否有 rsync 命令，如果有返回 rsync 路径，可以跳过后面的命令
    which rsync

    # 安装 rsync
    yum -y install rsync
    ```
3. 关闭默认防火墙（firewalld）

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
4. 调整最大文件打开数

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

5. 确认服务器时间同步

    服务器后台时间不同步会对时间敏感的服务带来不可预见的后果。务必在安装和使用蓝鲸时保证时间同步。

    ```bash
    # 检查每台机器当前时间和时区是否一致，若相互之间差别大于3s（考虑批量执行时的时差），建议校时。
    date -R

    # 查看和ntp server的时间差异(需要外网访问，如果内网有ntpd服务器，自行替换域名为该服务的地址)
    ntpdate -d cn.pool.ntp.org
    ```

    如果输出的最后一行 offset 大于 1s 建议校时。
    ```bash
    # 和 ntp 服务器同步时间
    ntpdate cn.pool.ntp.org
    ```

    更可靠的方式包括通过运行 ntpd 或者 chrony 等服务在后台保持时间同步。具体请参考官方文档 [使用 ntpd 配置 NTP](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/ch-configuring_ntp_using_ntpd) 或 [使用 chrony 配置 NTP](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/ch-Configuring_NTP_Using_the_chrony_Suite)。

6. 检查是否存在全局 HTTP 代理

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
tar xf bkce_src-5.0.3.tar.gz  -C /data
```

解压之后，得到两个目录：src，install

- src：存放蓝鲸产品软件，以及依赖的开源组件

- install：存放安装部署脚本、安装时的参数配置、日常运维脚本等

### 配置 YUM 源

在所有蓝鲸服务器上配置好 YUM 源，要求该 YUM  源包含 EPEL。

不能连外网 YUM 源的环境，可以配置一个内部的 YUM  源 或者本地 YUM 源。

### 本地 YUM 源

参考附录中的 [离线安装的配置方法](../../场景案例/离线部署/offline_setup.md)。

### 在线 YUM 源

推荐使用以下 YUM 源：

- [腾讯云 CentOS](https://mirrors.cloud.tencent.com/help/centos.html)
- [腾讯云 EPEL](https://mirrors.cloud.tencent.com/help/epel.html)

### 配置文件

在 install 目录下，共有三个配置：

- install.config
- globals.env
- ports.env

#### install.config

`install.config` 是模块和服务器对应关系的配置文件，描述在哪些机器上安装哪些模块。
每行两列，第一列是 IP 地址；第二列是以英文逗号分隔的模块名称。
详情参考`install.config.3IP.sample`文件（可将 install.config.3IP.sample 复制为 install.config）。

```bash
[bkce-basic]
10.0.0.1 nginx，rabbitmq，kafka(config)，zk(config)，es，appt，fta，consul，bkdata(databus)
10.0.0.2 mongodb，appo，kafka(config)，zk(config)，es，mysql，consul，bkdata(dataapi)，beanstalk
10.0.0.3 paas，cmdb，job，gse，license，kafka(config)，zk(config)，es，redis，influxdb，consul，bkdata(monitor)
```

> 说明:
- 该配置文件，ip 后面使用空格与服务名称隔开，含有多个内网 ip 的机器，默认使用 /sbin/ifconfig 输出中的第一个内网 ip，在 ip 后面写上该机器要安装的服务列表即可，部署过程中默认使用标准私有地址，若企业环境使用非标准私有地址，请参考 **本章后续内容 - 非标准私有地址处理方法** 的处理方法。
- zk 表示 zookeeper， es 表示 elasticsearch。
- gse 与 redis 需要部署在同一台机器上。
- 增加机器数量时， 可以将以上配置中的服务挪到新的机器上，分担负载。 要保证：kafka， es， zk 的每个组件的总数量为 3。

#### globals.env

该文件定义了各类组件的账号密码信息。 功能开关控制选项等。可根据实际情况进行修改。
配置项含义，请查看文件中的注释。

- 该文件含密码信息，请保证除了 root 用户外，其他用户不可读。
- 各类账号密码建议修改，注意设置的各类密码不能有 / $  \` &lt; &gt; & 等特殊字符。
- 配置 HTTP 代理：若公司不能访问外网，但有自己的 proxy，在该配置文件的 BK_PROXY 选项中指定代理地址。
- 若需要跨云管理功能(服务器在不同的 IDC，内网不互通的情况):
  - 需要将 gse 所在机器的外网 IP 填到该文件中 GSE_WAN_IP 配置项中的括号里 如：`export GSE_WAN_IP=(1.2.3.4)`，若没有外网 IP 则留空。
- `HAS_DNS_SERVER` 配置默认为 0，表示配置的蓝鲸域名需要通过 /etc/hosts 来解析，此时部署脚本会自动修改每台机器的 /etc/hosts 添加相关域名。如果想走自己的 dns 配置，改为非 0 即可。
- `HTTP_SCHEMA=http`  默 认 HTTP_SCHEMA 设置为  HTTP 即蓝鲸软件全站为  HTTP，若设置为 HTTPS 则蓝鲸软件全站为 HTTPS，可支持 HTTP 和 HTTPS 的切换。
- 该配置文件中提供了访问蓝鲸三大平台的域名配置，需要提前准备好。

  ```bash
  export BK_DOMAIN="bk.com"                # 蓝鲸根域名(不含主机名)
  export PAAS_FQDN="paas.$BK_DOMAIN"       # PAAS 完整域名
  export CMDB_FQDN="cmdb.$BK_DOMAIN"       # CMDB 完整域名
  export JOB_FQDN="job.$BK_DOMAIN"         # JOB 完整域名
  ```

> 说明：
1. BK_DOMAIN 的值不能为 "com" "net" 这种顶级域名，至少二级域名开始。
2. FQDN 的选择需要遵循 DNS 的命名规范，可选的字符集是 [A-Za-z0-9.] 以及 "-"，特别要注意，下划线 (_) 是不允许的。
3. PAAS_FQDN CMDB_FQDN JOB_FQDN 的值都必须在 BK_DOMAIN 定义的根域名之下，保证登陆鉴权的 cookie 文件有效。

#### ports.env

端口定义。 默认情况下，不用修改。特殊场景下，若有端口冲突，可以自行定义。

### 非标准私有地址处理方法

蓝鲸社区版部署脚本中(install 目录)下有以下文件中有获取 ip 的函数 get_lan_ip，非标准地址，均需要在安装部署前完成修改。


```bash
./appmgr/docker/saas/buildsaas
./appmgr/docker/build
./functions
./scripts/gse/server/gsectl
./scripts/gse/plugins/reload.sh
./scripts/gse/plugins/start.sh
./scripts/gse/plugins/stop.sh
./scripts/gse/agent/gsectl
./scripts/gse/proxy/gsectl
./scripts/gse/agentaix/gsectl.ksh
./agent_setup/download#agent_setup_pro.sh
./agent_setup/download#agent_setup_aix.ksh
./agent_setup/download#agent_setup.sh
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
          }'

   return $?
}
```

### pip.conf

在线安装时，依赖 pip，需要配置可用的 pip 源。

```bash
vim /data/src/.pip/pip.conf

[global]
index-url = https://mirrors.cloud.tencent.com/pypi/simple
trusted-host = mirrors.cloud.tencent.com

```

- 设置为能连上的 pip 源，以腾讯云镜像源加速 pip 为例。默认的 pip 源配置通常无法使用，验证方式如下。

- 在每台机器上对 `pip.conf` 中配置的 url 进行操作：`curl http://xxxxxxx`，若能正常返回列表信息则为成功。

### 获取证书

1. 通过 `ifconfig` 或者 `ip addr` 命令获取 install.config 文件中，license 和 gse 模块所在服务器的第一个内网网卡的 MAC 地址。如果分别属于两台服务器，那么两个的 MAC 地址以英文;分隔。

2. 在官网 [证书生成页面](https://bk.tencent.com/download_ssl/) 根据输入框提示填入 MAC 地址，生成并下载证书。

3. 上传证书到中控机，并解压到 `src/cert` 目录下。

    ```bash
    tar xf ssl_certificates.tar.gz -C /data/src/cert/
    ```

### 配置 SSH 免密登陆

登录到中控机，执行以下操作：

```bash
cd /data/install
bash configure_ssh_without_pass  # 根据提示输入各主机的 root 密码完成免密登陆配置
```

## 安装前校验环境是否满足

按文档要求做完环境和部署的配置后，准备开始安装前，请运行以下脚本，来校验是否满足：

```bash
cd /data/install
bash precheck.sh
```

正常输出如下图所示：

```plain
start <<check_ssh_nopass>> ... [OK]
start <<check_password>> ... [OK]
start <<check_cert_mac>> ... [OK]
start <<check_get_lan_ip>> ... [OK]
start <<check_install_config>> ... [OK]
start <<check_selinux>> ... [OK]
start <<check_umask>> ... [OK]
start <<check_rabbitmq_version>> ... [OK]
start <<check_http_proxy>> ... [OK]
start <<check_open_files_limit>> ... [OK]
start <<check_domain>> ... [OK]
start <<check_rsync>> ... [OK]
start <<check_service_dir>> ... [OK]
start <<check_networkmanager>> ... [OK]
start <<check_firewalld>> ... [OK]
```

如果发现有 [FAIL] 的报错，按照提示和本文档修复。修复后，可继续跑 precheck.sh 脚本，直到不再出现 [FAIL]。如果需要从头开始检查，请使用 `precheck.sh -r` 参数。
