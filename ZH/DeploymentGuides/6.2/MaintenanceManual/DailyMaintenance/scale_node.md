# 蓝鲸后台扩容

蓝鲸后台扩容分为，在已有机器上扩容模块和新增机器扩容模块，区别在是否涉及新机器的初始化。

本文假设待扩容的新机器 IP 为 10.0.0.4 ，且每次只扩容一台。如果扩容多台，请根据实际情况批量执行，或者多次重复执行即可。

## 新机器初始化

1. 对中控机配置 ssh 免密登录

    ```bash
    ssh-copy-id 10.0.0.4
    ```

2. 使用节点管理，在《蓝鲸》业务下，给 10.0.0.4 安装 gse agent。方便通过《蓝鲸》自维护。
3. 机器初始化。根据初次安装蓝鲸的一些环境要求，和本公司的实际情况，对机器完成初始化。需要注意的是，待扩容机器的主机名不能和原有机器冲突。（这一步不涉及蓝鲸相关的初始化）
4. 修改 install.config 增加扩容的服务器 ip 和对应的模块
5. 生成更新后的主机变量文件，并同步脚本到所有机器（包括新机器）

    ```bash
    ./bkcli sync common
    ```

6. 同步蓝鲸 repo

    ```bash
    rsync -av /etc/yum.repos.d/Blueking.repo root@10.0.0.4:/etc/yum.repos.d/
    ```

7. 新机器初始化。

    ```bash
    pcmd -H 10.0.0.4 /data/install/bin/init_new_node.sh
    sleep 10
    consul members | grep 10.0.0.4 # 确认新机器加入了consul集群
    ```

## 模块扩容

执行完新节点初始化后，根据不同模块，扩容的方式有所区别。分模块列举如下：

### APPO

APPO 的扩容步骤分为：

1. 同步必要文件

    ```bash
    ./bkcli sync cert 
    ./bkcli install cert
    ./bkcli sync appo
    ```

2. 安装并配置 appo 上的 docker

    ```bash
    pcmd -H 10.0.0.4 '$CTRL_DIR/bin/install_docker_for_paasagent.sh'
    ```

3. 安装 paas_agent

    ```bash
    pcmd -H 10.0.0.4 '${CTRL_DIR}/bin/install_paasagent.sh -e ${CTRL_DIR}/bin/04-final/paasagent.env -b $LAN_IP -m prod -s ${BK_PKG_SRC_PATH} -p ${INSTALL_PATH}'
    ```

4. 安装 Openresty

    ```bash
    pcmd -H 10.0.0.4 '${CTRL_DIR}/bin/install_openresty.sh -p ${INSTALL_PATH} -d ${CTRL_DIR}/support-files/templates/nginx/'
    ```

5. 安装 consul-template

    ```bash
    pcmd -H 10.0.0.4 '${CTRL_DIR}/bin/install_consul_template.sh -m paasagent'
    ```

6. 有 NFS 共享目录时，需要挂载 NFS：

    ```bash
    ssh 10.0.0.4
    source $CTRL_DIR/tools.sh
    _mount_shared_nfs appo
    ```

### bkmonitorv3 后台扩容

扩容的主要步骤如下：

1. 中控机对新增机器配置 ssh 免密登录

    ```bash
    # 以实际 IP 为准
    ssh-copy-id 10.0.0.4
    ```

2. 使用节点管理，在「蓝鲸」业务下，给新增机器安装 gse agent。

3. 在「蓝鲸」业务下，导入监控平台 monitor 扩容标准运维流程。[下载链接](https://bkopen-1252002024.file.myqcloud.com/ce/bk_sops_scale_monitor_transfer.dat)

4. 执行 `[common][scale] add blueking node` 流程对新增机器进行初始化操作。`如果是复用蓝鲸环境的机器，可忽略该步骤`

5. 执行 `[bkmonitor][scale]monitor` 流程进行监控平台的扩容。

    - ctrl_ip：蓝鲸中控机 IP
    - refer_ip：扩容参考机 IP (monitor 在的机器，可使用下述命令查看)，和待扩容的 monitor 同类型同集群

    ```bash
    source /data/install/utils.fc && echo $BK_MONITORV3_IP
    ```

    - mysql_ip：蓝鲸 MySQL IP 地址。

    ```bash
    # 如果 MySQL 使用的是自建数据库，授权需要用户自行处理。自行处理的用户，可使用下述命令获取相关 MySQL 帐户以及密码，然后自行授权，反之请忽略该步骤
    source /data/install/utils.fc

    # bkmonitorv3 账户以及密码
    echo $BK_MONITOR_MYSQL_USER $BK_MONITOR_MYSQL_PASSWORD

    # paas 账户以及密码
    echo $BK_PAAS_MYSQL_USER $BK_PAAS_MYSQL_PASSWORD
    ```

    - scale_iplist：扩容 monitor 的机器 IP

6. 填写并确认参数无误后，开始执行流程。

7. 流程执行期间会有暂停步骤，需要手动确认执行。该步骤主要是用户自行检查确认扩容配置，确认访问数据库权限 `新增机器上执行`

    1. 检查  `/data/bkce/bkmonitorv3/` 目录的属组属主是否为 `blueking`

    2. 检查后台环境变量文件对应 IP 是否替换正确

    ```bash
    source ~/.bashrc && grep "$LAN_IP" $BK_HOME/bkmonitorv3/monitor/bin/environ.sh
    ```

8. 上述第 6 步检查无误后，请继续执行流程直至结束。

9. 查看【监控平台】-【自监控】后台服务器性能指标是否有新增机器。

    ![scale_monitor](../../assets/scale_monitor.png)

10. 检查 bkmonitorv3 的 consul 中是否有新增机器的 IP

```bash
dig bkmonitorv3.service.consul
```

### transfer 扩容

扩容的主要步骤如下：

1. 中控机对新增机器配置 ssh 免密登录

    ```bash
    # 以实际 IP 为准
    ssh-copy-id 10.0.0.4
    ```

2. 使用节点管理，在「蓝鲸」业务下，给新增机器安装 gse agent。

3. 在「蓝鲸」业务下，导入监控平台 transfer 扩容标准运维流程。[下载链接](https://bkopen-1252002024.file.myqcloud.com/ce/bk_sops_scale_monitor_transfer.dat)

4. 执行 `[common][scale] add blueking node` 流程对新增机器进行初始化操作。`如果是复用蓝鲸环境的机器，可忽略该步骤`

5. 执行 `[bkmonitor][scale]transfer` 流程进行监控平台的扩容。

    - ctrl_ip：蓝鲸中控机 IP

    - refer_ip：扩容参考机 IP (transfer 在的机器，可使用下述命令查看)，和待扩容的 transfer 同类型同集群

    ```bash
    source /data/install/utils.fc && echo $BK_MONITORV3_TRANSFER_IP
    ```

    - scale_iplist：扩容 transfer 的机器 IP

6. 填写并确认参数无误后，开始执行流程。

7. 流程执行期间会有暂停步骤，需要手动继续执行。该步骤主要是用户自行检查确认扩容配置，确认访问数据库权限 `新增机器上执行`

   1. 检查  `/data/bkce/bkmonitorv3/` 目录的属组属主是否为 `blueking`

   2. 检查 transfer 环境变量文件对应 IP 是否替换正确

    ```bash
    source ~/.bashrc && grep "$LAN_IP" $BK_HOME/bkmonitorv3/transfer/transfer.yaml
    ```

8. 上述第 6 步检查无误后，请继续执行流程直至结束。

9. 查看【监控平台】-【自监控】transfer 是否有新增机器。

    ![scale_transfer](../../assets/scale_transfer.png)

10. 检查 transfer 的 consul 中是否有新增机器的 IP

```bash
dig transfer.bkmonitorv3.service.consul
```
