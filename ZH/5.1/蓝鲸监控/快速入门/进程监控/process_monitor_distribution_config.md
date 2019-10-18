# 自动下发采集器配置 

在配置平台上对进程的修改，会通过配置平台的事件推送功能自动下发至 Agent 上的 `/etc/gse/host/hostid` ，监控的进程端口采集器会捕获文件变化，做异常检测，并且将内容更新到采集器中，下发时间预计在 2 分钟内，页面进程端口更新信息在 5 分钟内。

配置平台事件推送说明：

  - 检查推送：gse_agentID 是否存在（推送人应为：migrate）

  ![](../../media/process_monitor_cmdb_gse_push.png)

  - 修改进程管理信息后，该推送会在 1 分钟内将修改的配置推送到 Agent 端，因此每次修改完进程管理信息后，可到此处确认推送数是否有新增。

  - 到 Agent 端检查配置是否及时下发至正确目录：

    ```bash
    # Linux Agent 配置文件路径
    /var/lib/gse/host/hostid
    # Windows Agent 配置文件路径
    /gse/data/host/hostid
    # 检查文件内容，如果是 base64 编码，不可直接识别，说明推送异常，配置内容不符合进程管理页面的配置内容或者推送时间超过3分钟说明推送异常

    # 确认hostid更新正常后，切换到以下目录检查processbeat.conf是否跟随hostid更新配置内容
    # Linux
    /usr/local/gse/plugins/etc/processbeat.conf
    # Windows
    C:/gse/plugins/etc/processbeat.conf
    ```
