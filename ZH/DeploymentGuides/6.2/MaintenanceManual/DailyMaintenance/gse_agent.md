# GSE Agent 非标准安装方案

蓝鲸官方自带的节点管理提供了标准安装蓝鲸 agent 及其插件管理的功能。在某些特殊场景下，可以使用非标准的安装方案来达到自动化部署 agent 的目的。

本文主要阐述不使用节点管理批量安装 agent 的通用思路，用户需要结合实际部署场景，灵活使用。

## 前提

无论安装直连 agent，还是跨云区域的 agent，请先阅读节点管理的产品功能白皮书，了解相关概念，并使用节点管理成功安装一台主机。

本文档只描述，成功安装一台主机后，如何不通过节点管理，批量复制安装到其他机器（相同操作系统，相同 CPU 架构），然后注册到配置平台，进行纳管。

假设成功安装的直连区域主机 ip 为 10.0.0.1，安装路径为 `/usr/local/gse/`，运行和日志目录为默认的 `/var/run/gse`、`/var/lib/gse`、`/var/log/gse`

用户已经有现成的简易批量主机传输文件/命令执行工具（ansible、pssh 等），因为节点管理安装 agent 的核心也是 SSH 协议来批量执行命令。
那么就是假设用户已经有其他方式实现该能力。

## Linux 系统安装

1. 登录到 10.0.0.1 机器，打包安装成功的 agent 目录：

    ```bash
    cd /usr/local/gse && tar -czf /tmp/gse_client.tgz --exclude="*.pid" agent/ plugins/bin/*.sh
    ```

2. 将/tmp/gse_client.tgz 分发到 待安装的目标机器的 /tmp 目录下。
3. 在待安装的目标机器上创建必要目录后，解压客户端包：
  
   ```bash
   install -d /var/run/gse /var/lib/gse /var/log/gse /usr/local/gse
   tar -xf /tmp/gse_client.tgz -C /usr/local/gse
   ```

4. 确认目标机器需要注册到配置平台的内网 IP 地址以及本机的网卡地址，这里涉及到 agent.conf 配置文件的修改。大多数情况下这两个 ip 地址都是一样的。

    - 注册到配置平台的内网 ip 地址($display_ip)：日后在蓝鲸平台上，无论是作业平台，还是监控平台，都会用该 ip 地址来指代这台主机。
    - 本机网卡地址($agent_ip)：通过 `ip addr` 命令能看到的 ip 地址

    ```bash
    display_ip=10.0.0.2 # 请根据实际情况写命令自动获取
    agent_ip=10.0.0.2   # 请根据实际情况写命令自动获取
    sed -i '/"identityip"/c\    "identityip": "'$display_ip'",' /usr/local/gse/agent/etc/agent.conf
    sed -i '/"agentip"/c\    "agentip": "'$agent_ip'",' /usr/local/gse/agent/etc/agent.conf
    ```

5. 确认第四步修改正常后，特别是 json 语法，确认是否符合。

    ```bash
    python -m json.tool < /usr/local/gse/agent/etc/agent.conf >/dev/null && echo OK || echo FAIL
    ```

6. 启动 agent

    ```bash
    /usr/local/gse/agent/bin/gsectl start
    ```

7. 确认 agent 启动正常，并和 gse server 成功建立连接

    ```bash
    # 获取gse-agent的master pid和child pid
    pid=$(< /usr/local/gse/agent/bin/run/agent.pid )
    c_pid=$(pgrep -P $pid)
    # 根据 master pid，和child pid，并打印出启动时间和命令行参数，以下命令输出应该等于三行。
    ps -p $pid,$c_pid -o pid,lstart,args
    # 确认建立了连接（worker的pid负责建立连接），应该有一个LISTEN，两个ESTABLISHED（48533和58625）
    netstat -antp | awk -v pid=$c_pid '$NF ~ pid' 
    ```

8. 配置开机启动，根据实际的操作系统，添加到合适的位置。以 centos7 为例，添加到 /etc/rc.d/rc.local，并给它添加可执行权限。

    ```bash
    sed -i ',/usr/local/gse/agent/bin/gsectl,d' /etc/rc.d/rc.local
    echo '[ -x /usr/local/gse/agent/bin/gsectl ] && /usr/local/gse/agent/bin/gsectl start' >> /etc/rc.d/rc.local
    chmod +x /etc/rc.d/rc.local
    ```

用户根据实际情况将上述步骤，编写脚本来处理批量初始化安装 gse agent，或者在操作系统初始化阶段内置这些操作即可达到自动安装 gse agent 的目的。

## Windows 系统安装


1. 登录到 10.0.0.1 机器，打包安装成功的 agent 目录：

    ```batch
    Compress-Archive -Path C:\gse\agent\, C:\gse\plugins\bin\ -CompressionLevel Optimal -DestinationPath C:\gse_client.Zip
    ```

2. 将 C:\gse_client.Zip 分发到 待安装的目标机器的 C:\ 目录下。
3. 在待安装的目标机器上创建必要目录后，解压客户端包：
  
   ```batch
   Expand-Archive -LiteralPath C:\gse_client.Zip -DestinationPath C:\gse
   ```

4. 确认目标机器需要注册到配置平台的内网 IP 地址以及本机的网卡地址，这里涉及到 agent.conf 配置文件的修改。大多数情况下这两个 ip 地址都是一样的。

    - 注册到配置平台的内网 ip 地址(填入 identityip)：日后在蓝鲸平台上，无论是作业平台，还是监控平台，都会用该 ip 地址来指代这台主机。
    - 本机网卡地址(填入 agentip)：通过 `ipconfig` 命令能看到的 ip 地址

5. 启动 agent

    ```batch
    C:\gse\agent\bin\gsectl.bat start
    ```

6. 确认 agent 启动正常，并和 gse server 成功建立连接

    ```batch
    # 任务管理器中观察进程状态
    tasklist | findstr gse_
    ## 输出有 gse_agent_daemon.exe 和 gse_agent.exe
    
    # 确认建立了连接
    netstat -an | findstr 48533
    ## 输出有一个ESTABLISHED
    ```
7. 使用“节点管理”升级功能，恢复 agent 功能
8. 使用“节点管理”托管“插件”

用户根据实际情况将上述步骤，编写脚本来处理批量初始化安装 gse agent，或者在操作系统初始化阶段内置这些操作即可达到自动安装 gse agent 的目的。

## 导入主机到配置平台

安装并成功启动后，由于配置平台尚未导入，作业平台和节点管理均无法感知到这批主机的存在，可以通过配置平台页面或者 api 方式导入到业务的空闲机资源池。

以 api 注册为例，用部署脚本的 `esb_api_test.sh` 做导入测试，具体参数请参考 esb api 文档。

```bash
# 导入 10.0.0.2 操作系统（bk_os_type为1，linux），云区域id为0（直连区域），导入方式为api导入(3)，导入的目标业务为《蓝鲸》（bk_biz_id为2）
/data/install/bin/esb_api_test.sh post /api/c/compapi/v2/cc/add_host_to_resource/ '"bk_biz_id":2,"host_info":{"0":{"bk_host_innerip":"10.0.0.2","import_from":"3","bk_cloud_id":0,"bk_os_type":"1"}}'
```

## 节点管理启动插件

导入配置平台成功后，节点管理的周期任务会自动同步主机列表（每 10 分钟）。确认在节点管理的页面能查询到新增主机的 agent 状态为绿色再进行下一步操作。

- 如果需要接入蓝鲸监控，采集主机性能数据，请选择更新 `basereport` 插件
- 如果需要接入蓝鲸监控，采集主机的进程端口数据，请选择更新 `processbeat` 插件

