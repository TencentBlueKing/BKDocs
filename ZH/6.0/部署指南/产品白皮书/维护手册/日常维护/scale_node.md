# 蓝鲸后台扩容

蓝鲸后台扩容分为，在已有机器上扩容模块和新增机器扩容模块，区别在是否涉及新机器的初始化。

本文假设待扩容的新机器IP为 10.0.0.4 ，且每次只扩容一台。如果扩容多台，请根据实际情况批量执行，或者多次重复执行即可。

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

4. 新机器初始化。

    ```bash
    pcmd -H 10.0.0.4 /data/install/bin/init_new_node.sh
    sleep 10
    consul members | grep 10.0.0.4 # 确认新机器加入了consul集群
    ```

## 模块扩容

执行完新节点初始化后，根据不同模块，扩容的方式有所区别。分模块列举如下：

### APPO

APPO的扩容步骤分为：

1. 同步必要文件

    ```bash
    ./bkcli sync cert 
    ./bkcli install cert
    ./bkcli sync appo
    ```

2. 安装并配置 appo 上的docker

    ```bash
    pcmd -H 10.0.0.4 '$CTRL_DIR/bin/install_docker_for_paasagent.sh'
    ```

3. 安装 paas_agent

    ```bash
    pcmd -H 10.0.0.4 '${CTRL_DIR}/bin/install_paasagent.sh -e ${CTRL_DIR}/bin/04-final/paasagent.env -b $LAN_IP -m prod -s ${BK_PKG_SRC_PATH} -p ${INSTALL_PATH}'
    ```

4. 安装 Openresty

    ```bash
    pcmd -H 10.0.0.4 '${CTRL_DIR}/bin/install_openresty.sh -p ${INSTALL_PATH} -d ${CTRL_DIR}/support-files/templates/nginx/"
    ```

5. 安装 consul-template

    ```bash
    pcmd -H 10.0.0.4 '${CTRL_DIR}/bin/install_consul_template.sh -m paasagent"
    ```

6. 有NFS共享目录时，需要挂载NFS：

    ```bash
    ssh 10.0.0.4
    source $CTRL_DIR/tools.sh
    _mount_shared_nfs appo
    ```