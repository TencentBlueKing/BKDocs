# 环境验证

## 基础套餐后台验证

- 加载环境变量和蓝鲸安装维护的函数

    ```bash
    source /data/install/utils.fc
    ```

- 执行以下命令，检查蓝鲸的服务状态

    ```bash
    echo bkssm bkiam usermgr paas cmdb gse job consul | xargs -n 1 ./bkcli check
    ```

- 检查脚本可用性

    ```bash
    # 安装 dbcheck 环境
    ./bkcli install dbcheck
    ./bkcli check dbcheck
    ```

- 检查开源组件状态， 可以使用 bkcli 或者 systemctl 查看运行的状态

  - bkcli

    ```bash
    echo redis rabbitmq mongodb consul zk | xargs -n 1 ./bkcli status
    ```

  - systemctl 相关组件服务名称可见 [组件维护](../../MaintenanceManual/DailyMaintenance/start_stop.md)

    ```bash
    # 这里以 rabbitmq 为例，其余同理
    # 需要登录至模块分布的机器上
    ssh $BK_RABBITMQ_IP
    systemctl status rabbitmq-server.service 
    ```

## 基础套餐前台验证

请先 **配置 host 或者 DNS** 解析后，确认访问社区版域名是否正常。

查看相关域名请查看部署脚本下的 $CTRL_DIR/bin/04-final/global.env 文件 \< $CTRL_DIR 为实际的部署脚本目录 \> 。

- 从【蓝鲸工作台】-【开发者中心】-【服务器信息】中检查 `正式服务器` 是否激活。

    ![APPO状态检查图](../../assets/paas_appostatuscheck.png)

- 从【蓝鲸工作台】-【开发者中心】-【第三方服务】中检查 **RabbitMQ 服务** 是否激活。

    ![RabbitMQ状态检查图](../../assets/paas_rabbitmqstatuscheck.png)

- 打开节点管理，安装部署环境机器的 Agent。
  
    ![install_agent](../..assets/../../assets/install_agent.png)

## 增强套餐后台验证

- 执行以下命令，检查蓝鲸的服务状态

    ```bash
    echo bklog bkmonitorv3 | xargs -n 1 ./bkcli check
    ```

## 增强套餐前台验证

- 打开蓝鲸监控平台，查看蓝鲸的数据链路是否正常

  如果只有 bk_data \<社区版不含计算平台\> 为红色则正常 。否则需要针对显红的地方进行排查直至显绿。

![bkmonitorv3](../../assets/bkmonitorv3_status.png)

最后在蓝鲸工作台打开各个 SaaS 验证各产品功能是否能运行正常。
