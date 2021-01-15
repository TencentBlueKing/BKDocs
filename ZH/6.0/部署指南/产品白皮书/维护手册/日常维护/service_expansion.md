# 服务扩容

蓝鲸后台的扩容，首先需要做一些通用的初始化操作，这部分操作建议固化到《标准运维》模板中。初始化的示例模板在建设中。

1. 在 install.config 中增加对应的主机和在该主机上要部署的模块列表，英文逗号分隔。

2. 中控机对新增主机配置 SSH 免密（可参考 `configure_ssh_without_pass` 脚本）。
   
3. 使用节点管理在新增主机上安装蓝鲸 gse_agent，便于之后使用用作业平台执行命令。
   
4. 同步中控机的脚本到新主机 `./bkcli sync common` 。
   
5. 新增主机上运行脚本：`bin/init_new_node.sh`，它主要封装了以下几个步骤操作，下面步骤无需手动运行。
   1. 新增主机上运行 `bin/update_bk_env.sh` 脚本（可通过作业平台，或者中控机pcmd）。
   
   2. 新增主机上配置中控机上搭建的yum源：`$CTRL_DIR/bin/setup_local_yum.sh -l http://<中控机ip>:8080 -a` 。
   
   3. 安装consul client：`source ./load_env.sh; $CTRL_DIR/bin/install_con  sul.sh -j $BK_CONSUL_IP_COMMA -r client -b "$LAN_IP" --dns-port 53 -e "$BK_CONSUL_KEYSTR_32BYTES"` 。
