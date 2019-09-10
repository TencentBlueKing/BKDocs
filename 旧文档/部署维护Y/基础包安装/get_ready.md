## 安装环境准备

开始安装蓝鲸社区版前，需按以下文档做好准备工作。

### 一. 获取安装包 {#download}

蓝鲸社区版基础包含部署脚本包、软件包（产品软件和开源组件）。由于基础包体积较大，为便于用户私有化部署和产品升级，官网提供完整包与分包的 [下载地址](https://bk.tencent.com/download/)  按需获取

新装环境及新用户建议下载完整包进行安装，升级用户可单独下载部署脚本、产品软件、开源组件进行升级。

温馨提示：**下载完成后请核对 MD5**

### 二. 硬件选择 {#hardware}

对于蓝鲸部署所需的硬件配置选型并无定规，蓝鲸由众多开源组件和自研组件构成。

开源组件的硬件选型可以参考相应的官方文档，参见附录 - [蓝鲸产品及开源组件版本](/12.附录/蓝鲸组件配置文件/configuration.md)。

安装主机系统官方推荐 CentOS 7.0 或以上。

蓝鲸产品本身的建议配置如下：

<table border="0" cellpadding="0" cellspacing="0" width="575" style="border-collapse:
 collapse;table-layout:fixed;width:431pt">
 <colgroup><col width="72" style="width:54pt">
 <col width="295" style="mso-width-source:userset;mso-width-alt:9440;width:221pt">
 <col width="104" span="2" style="mso-width-source:userset;mso-width-alt:3328;
 width:78pt">
 </colgroup><tbody><tr height="20" style="height:15.0pt">
  <td height="20" class="xl72" width="72" style="height:15.0pt;width:54pt">部署方式</td>
  <td class="xl72" width="295" style="border-left:none;width:221pt">产品</td>
  <td class="xl72" width="104" style="border-left:none;width:78pt">建议资源分配</td>
  <td class="xl72" width="104" style="border-left:none;width:78pt">建议满足配置</td>
 </tr>
 <tr height="36" style="mso-height-source:userset;height:27.0pt">
  <td rowspan="5" height="124" class="xl65" style="border-bottom:.5pt solid black;
  height:93.0pt;border-top:none">标准部署</td>
  <td class="xl66" style="border-top:none;border-left:none">PaaS</td>
  <td class="xl66" style="border-top:none;border-left:none">2核4G</td>
  <td rowspan="5" class="xl67" width="104" style="border-bottom:.5pt solid black;
  border-top:none;width:78pt">1台 4核16G<br>
    2台 4核8G</td>
 </tr>
 <tr height="22" style="height:16.5pt">
  <td height="22" class="xl66" style="height:16.5pt;border-top:none;border-left:
  none">CMDB</td>
  <td class="xl66" style="border-top:none;border-left:none">2核4G</td>
 </tr>
 <tr height="22" style="height:16.5pt">
  <td height="22" class="xl66" style="height:16.5pt;border-top:none;border-left:
  none">JOB</td>
  <td class="xl66" style="border-top:none;border-left:none">2核4G</td>
 </tr>
 <tr height="22" style="height:16.5pt">
  <td height="22" class="xl66" style="height:16.5pt;border-top:none;border-left:
  none">BKDATA</td>
  <td class="xl66" style="border-top:none;border-left:none">2核4G</td>
 </tr>
 <tr height="22" style="height:16.5pt">
  <td height="22" class="xl66" style="height:16.5pt;border-top:none;border-left:
  none">FTA</td>
  <td class="xl66" style="border-top:none;border-left:none">1核2G</td>
 </tr>
 <tr height="22" style="height:16.5pt">
  <td rowspan="2" height="44" class="xl65" style="border-bottom:.5pt solid black;
  height:33.0pt;border-top:none">单机部署</td>
  <td class="xl66" style="border-top:none;border-left:none">包含CMDB、JOB、PaaS、GSE、节点管理</td>
  <td class="xl66" style="border-top:none;border-left:none">　</td>
  <td class="xl66" style="border-top:none;border-left:none">1核4G</td>
 </tr>
 <tr height="22" style="height:16.5pt">
  <td height="22" class="xl66" style="height:16.5pt;border-top:none;border-left:
  none">与标准部署相同</td>
  <td class="xl66" style="border-top:none;border-left:none">　</td>
  <td class="xl66" style="border-top:none;border-left:none">2核16G</td>
 </tr>
 <!--[if supportMisalignedColumns]-->
 <tr height="0" style="display:none">
  <td width="72" style="width:54pt"></td>
  <td width="295" style="width:221pt"></td>
  <td width="104" style="width:78pt"></td>
  <td width="104" style="width:78pt"></td>
 </tr>
 <!--[endif]-->
</tbody></table>

> 注：单机部署-配置一可以满足最基础的运维场景，单机部署-配置二与标准部署相同，但是只有单台主机，运行效率与标准部署相比较低，出于业务的稳定性考虑，仅建议用于安装测试环境体验蓝鲸，具体请参考后续的单机部署文档。


### 三. CentOS系统设置 {#hosts}

为保证安装的顺畅和后续蓝鲸平台的运行，在安装完原生 CentOS 系统后，需要对初始系统做一些配置，**请注意：所有待安装蓝鲸的机器均需要按以下清单检查和操作**。

1. 关闭 SELinux：
    ```bash
    # 检查 SELinux 的状态，如果它已经禁用，可以跳过后面的命令
    $ sestatus
    ```
    可以使用以下命令禁用 SELinux ，或者修改配置文件：
    ```bash
    # 通过命令禁用SELinux
    $ setenforce 0
    # 或者修改配置文件
    $ sed -i 's/^SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
    ```
    接着，重启机器：
    ```
    $ reboot
    ```

2. 安装 rsync 命令：
    安装脚本依赖 rsync 分发同步文件：
    ```bash
    # 检查是否有 rsync 命令，如果有返回 rsync 路径，可以跳过后面的命令
    $ which rsync
    # 安装rsync
    $ yum -y install rsync
    ```

3. 关闭默认防火墙（firewalld）：
    安装和运行蓝鲸时，模块之间互相访问的端口策略较多，建议对蓝鲸后台服务器之间关闭防火墙：
    ```bash
    # 检查默认防火墙状态, 如果返回not running，可以跳过后面的命令
    firewall-cmd --state
    ```
    停止并禁用firewalld:
    ```bash
    systemctl stop firewalld    # 停止 firewalld
    systemctl disable firewalld # 禁用 firewall 开机启动
    ```

4. 调整最大文件打开数：
    ```bash
    # 检查当前 root 账号下的 max open files 值
    ulimit -n
    ```

    如果为默认的1024，建议通过修改配置文件调整为 102400 或更大：
    ```bash
    cat <<EOF > /etc/security/limits.d/99-nofile.conf
    root soft nofile 102400
    root hard nofile 102400
    EOF
    ```

    这里使用的单独的配置文件覆盖 `/etc/security/limits.conf` 默认值的方式，请根据系统环境自行调整

    修改后，重新使用 root 登录检查是否生效

5. 确认服务器时间同步：
    服务器后台时间不同步会对时间敏感的服务带来不可预见的后果。务必在安装和使用蓝鲸时保证时间同步：
    ```bash
    # 检查每台机器当前时间和时区是否一致，若相互之间差别大于3s（考虑批量执行时的时差），建议校时。
    date -R
    # 查看和 NTP Server 的时间差异(需要外网访问,如果内网有 ntpd 服务器，自行替换域名为该服务的地址)
    ntpdate -d cn.pool.ntp.org
    ```

    如果输出的最后一行 offset 大于 1s 建议校时：
    ```bash
    # 和 NTP 服务器同步时间
    ntpdate cn.pool.ntp.org
    ```

    更可靠的方式包括通过运行 ntpd 或者 chrony 等服务在后台保持时间同步。具体请参考官方文档[使用 ntpd 配置NTP](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/ch-configuring_ntp_using_ntpd)或[使用 chrony 配置NTP](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/ch-Configuring_NTP_Using_the_chrony_Suite)。

6. 检查是否存在全局 HTTP 代理：
    蓝鲸服务器之间会有的 HTTP 请求，如果存在 HTTP 代理，且未能正确代理这些请求，会发生不可预见的错误。

    ```bash
    # 检查 http_proxy https_proxy 变量是否设置，若为空可以跳过后面的操作
    $ echo "$http_proxy" "$https_proxy"
    ```

    对于本机配置 http_proxy 变量的方式，请依次查找文件 /etc/profile、/etc/bashrc、$HOME/.bashrc 等是否有设置，或者咨询网络管理员/IT部门协助处理。


7. 设置中控机并解压安装包：
    在准备的主机中，选择任意一台机器作为蓝鲸的运维中控机。之后的安装命令执行，如果没有特别说明，均在这台中控机上执行。

    将下载的蓝鲸社区版完整包上传到中控机，并解压到 **同级** 目录下。以解压到 `/data` 目录为例：
    ```bash
    tar xf bkce_src-5.0.4.tar.gz  -C /data
    ```

    解压之后, 得到两个目录:  `src` , `install`
    - src: 存放蓝鲸产品软件, 以及依赖的开源组件
    - install: 存放安装部署脚本、安装时的参数配置、日常运维脚本等

### 四. 配置 YUM 源 {#yum}

在所有蓝鲸服务器上配置好 YUM 源，要求该 YUM 源包含 EPEL，不能连外网 YUM 源的环境, 可以配置一个内部的 YUM 源 或者本地 YUM 源。
- 本地 YUM 源 参考附录中的 [离线安装的配置方法](/8.场景案例/离线部署/offline_setup.md)
- 在线 YUM 源
  推荐使用以下源：
  - [腾讯云 CentOS ](https://mirrors.cloud.tencent.com/help/centos.html)
  - [腾讯云 EPEL ](https://mirrors.cloud.tencent.com/help/epel.html)


### 五. 配置参数 {#configs}

在 install 目录下, 共有三个配置：
  - install.config
  - globals.env
  - ports.env

#### 5.1 配置 install.config

说明：`install.config` 是**模块和服务器对应关系**的配置文件，描述在哪些机器上安装哪些模块。

资源规划说明：
如果硬件资源富余，可以一开始拆分搭建部署。若硬件资源不足，一开始可以混合搭建，注意观测资源消耗情况，可以适时增加机器，迁移模块的方式来保证整体的可用性。

这里给出的一个比较合理的初始配置，基于以下考虑：
1. **分布式模块** 达到高可用至少三个节点，所以至少需要三个 OS (物理机或虚拟机均可)。
2. BKDATA 是耗费资源最多的蓝鲸组件。请分配到4核16G以上的机器。
3. 若日志检索，蓝鲸监控是主要使用场景，请给 InfluxDB 和 Elasticsearch 模块更多的内存，更好磁盘性能比如 SSD 。
4. Nginx 模块所在的机器需要有对外提供服务，可访问的 IP ，这是蓝鲸平台的总入口。
5. 如果需要有跨云管理需求， GSE 部署的机器需要有跨云的网络条件。

根据资源规划建议的模块分布如下：
每行两列，第一列是 IP 地址；第二列是以英文逗号分隔的模块名称。

详情参考 `install/install.config.3IP.sample` 文件（可将 install.config.3IP.sample 复制为 install.config ）：
```bash
# install.config.3IP.sample 示例文件：
10.0.1.1 nginx,appt,rabbitmq,kafka,zk,es,bkdata,consul,fta #建议配置：4核16G
10.0.1.2 mongodb,appo,kafka,zk,es,mysql,beanstalk,consul #建议配置：4核8G
10.0.1.3 paas,cmdb,job,gse,license,kafka,zk,es,redis,consul,influxdb #建议配置：4核8G
```

> - 该配置文件， 后面使用空格与服务名称隔开,含有多个内网 IP 的机器，默认使用 `/sbin/ifconfig` 输出中的第一个内网 IP  , 在 IP 后面写上该机器要安装的服务列表即可, 部署过程中默认使用标准私有地址, 若企业环境使用非标准私有地址, 请参考 [非标准内网IP处理](#non_std_lan_ip) 的处理方法。
> - zk 表示 ZooKeeper， es 表示 Elasticsearch 。
> - GSE 与 Redis 需要部署在同一台机器上，否则会导致配置平台进程启动失败。
> - GSE 若需要跨云支持，所在机器必须有外网 IP 。
> - 增加机器数量时， 可以将以上配置中的服务挪到新的机器上，分担负载。 要保证: Kafka ， ZooKeeper ， Elasticsearch 的每个组件的总数量为3。

#### 5.2 配置 globals.env

说明：该文件定义了各类组件的账号密码信息. 功能开关控制选项等. 可根据实际情况进行修改
配置项含义, 请查看文件中的注释。

- 该文件含密码信息，请保证除了 root 用户外，其他用户不可读。
- 各类账号密码建议修改, 注意设置的各类密码不能有  / $  \` &lt; &gt; &等特殊字符。
- 配置 HTTP 代理: 若公司不能访问外网, 但有自己的 Proxy , 在该配置文件的  BK\_PROXY 选项中指定代理地址。
- 若需要跨云管理功能\(服务器在不同的 IDC , 内网不互通的情况\):
  - 需要将 GSE 所在机器的外网 IP 填到该文件中 GSE\_WAN\_IP 配置项中的括号里 如： `export GSE_WAN_IP=(1.2.3.4)` , 若没有外网 IP 则留空。
- `HAS_DNS_SERVER` 配置默认为0，表示配置的蓝鲸域名需要通过 `/etc/hosts` 来解析，此时部署脚本会自动修改每台机器的 `/etc/hosts` 添加相关域名。如果想走自己的 DNS 配置，改为非 0 即可。
- `HTTP_SCHEMA=http`  默认 HTTP_SCHEMA 设置为 HTTP 即蓝鲸软件全站为 HTTP  ,若设置为 HTTPS 则蓝鲸软件全站为 HTTPS ，可支持 HTTP 和 HTTPS 的切换。
- 该配置文件中提供了访问蓝鲸三大平台的域名配置, 需要提前准备好。
  ```bash
  export BK_DOMAIN="bk.com"                # 蓝鲸根域名(不含主机名)
  export PAAS_FQDN="paas.$BK_DOMAIN"       # 浏览器访问 PaaS 的完整域名
  export CMDB_FQDN="cmdb.$BK_DOMAIN"       # 浏览器访问 CMDB 的完整域名
  export JOB_FQDN="job.$BK_DOMAIN"         # 浏览器访问 JOB 的完整域名
  ```

> 说明:  
> 1. BK_DOMAIN 的值不能为 "com"  "net" 这种顶级域名, 至少从二级域名开始。
> 2. FQDN 的选择需要遵循 DNS 的命名规范，可选的字符集是[A-Za-z0-9.]以及"-", 特别要注意，下划线(\_)是不允许的。
> 3. PAAS_FQDN CMDB_FQDN JOB_FQDN 的值都必须在 BK_DOMAIN定义 的根域名之下，保证登陆鉴权的 cookie 文件有效。

#### 5.3 配置 ports.env

说明：端口定义文件，默认情况下,不用修改。若有端口冲突，可以自行定义。

### 六. 非标准私有地址处理方法 {#non_std_lan_ip}

说明：蓝鲸社区版部署脚本中\(install目录\)下有以下文件中有获取 IP 的函数 get\_lan\_ip ，非标准地址, 均需要在安装部署前完成修改。

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
假设服务器的的 IP 是：138.x.x.x，它不在标准的私有地址范围，那么你需要修改get_lan_ip ()函数为：
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

#### 七. 配置 pip 源 {#pip}

在线安装时需要配置可用的 pip 源：
```bash
# 安装包中预留了三个 pip.conf
install/.pip/pip.conf
src/.pip/pip.conf
src/service/.pip/pip.conf
```
- 将上述配置文件设置为能连上的 pip 源，默认的pip源配置通常无法使用，验证方式如下：
- 在每台机器上对 `pip.conf` 中配置的url进行操作：`curl http://xxxxxxx`，若能正常返回列表信息则为成功。

### 八. 获取证书 {#cert}

1. 通过 `ifconfig` 或者 `ip addr` 命令获取 `install.config` 文件中，**License 和 GSE 模块所在服务器的第一个内网网卡的 MAC 地址**。如果分别属于两台服务器，那么两个的 MAC 地址以英文分号 `;` 分隔。
2. 在官网 [证书生成页面](https://bk.tencent.com/download_ssl/) 根据输入框提示填入 MAC 地址，生成并下载证书。
3. 上传证书到中控机，并解压到 `src/cert` 目录下：
    ```bash
    tar xf ssl_certificates.tar.gz -C /data/src/cert/
    ```

### 配置 SSH 免密登陆 {#sshnopass}

登录到中控机，执行以下操作：
```bash
cd /data/install
bash configure_ssh_without_pass  # 根据提示输入各主机的 root 密码完成免密登陆配置
```

### 安装前校验环境是否满足 {#chek_before_insatll}

按文档要求做完环境和部署的配置后，准备开始安装前，请运行以下脚本，来校验安装环境是否满足需求：
```bash
cd /data/install
bash precheck.sh
```

正常输出如下图所示：
```bash
start <<check_ssh_nopass>> ... [OK]
start <<check_password>> ... [OK]
start <<check_cert_mac>> ... [OK]
start <<check_selinux>> ... [OK]
start <<check_umask>> ... [OK]
start <<check_get_lan_ip>> ... [OK]
start <<check_rabbitmq_version>> ... [OK]
start <<check_http_proxy>> ... [OK]
start <<check_open_files_limit>> ... [OK]
start <<check_domain>> ... [OK]
start <<check_rsync>> ... [OK]
start <<check_service_dir>> ... [OK]
start <<check_networkmanager>> ... [OK]
start <<check_firewalld>> ... [OK
```

**如果发现有 [FAIL] 的报错，按照提示和本文档修复，如本文档没有给您提供到足够帮助，请在文档中心反馈或者直接通过官网底部方式联系蓝鲸客服，修复后可继续跑precheck.sh脚本,直到不再出现 [FAIL] 。如果需要从头开始检查，请使用 `precheck.sh -r` 参数**。
