## 社区版 V4.1.1x 补丁包升级指南

- 适用用户：V4.1.13、V4.1.14、V4.1.15

- 备份数据

  ```bash
  cd /data/
  cp -a src src.bak #备份src目录
  cp -a install install.bak   #备份install目录
  ```
- 下载部署脚本 `install_ce-master-1.4.13.tgz` 上传到中控机并解压

  ```bash
  cd /data
  tar xf install_ce-master-1.4.13.tgz
  ```

- 下载 `bkce_patch-4.1.16.tgz`  `bkce_common-1.0.0.tgz` 上传到中控机并解压

  ```bash
  cd /data/
  #解压到src同级目录
  tar xf bkce_patch-4.1.16.tgz /data/   #补丁包
  tar xf bkce_common-1.0.0.tgz /data/   #公共组件包
  ```
- 更新脚本

  ```bash
  cd /data/install.bak
  # ports.env文件有更新，自行对比并更新
  cp -a globals.env /data/install/   #恢复配置文件

  cd /data/install
  #编辑globals.env，填写gse,nginx外网IP到括号内
  export GSE_WAN_IP=()
  export NGINX_WAN_IP=()

  # 同步脚本
  cd /data/install
  ./bkcec sync common #同步最新脚本
  ```

- 更新 RabbitMQ

  ```bash
  # 执行下面操作需要看到有done返回才算成功
  source $CTRL_DIR/utils.fc

  rcmd root@$RABBITMQ_IP "rabbitmqctl add_user "bk_monitor" "$(_app_token bk_monitor)""
  rcmd root@$RABBITMQ_IP "rabbitmqctl add_user "bk_bkdata" "$(_app_token bk_bkdata)""
  rcmd root@$RABBITMQ_IP "rabbitmqctl add_user "bk_paas_kibana" "$(_app_token bk_paas_kibana)""
  rcmd root@$RABBITMQ_IP "rabbitmqctl add_user "bk_dataadmin" "$(_app_token bk_dataadmin)""
  rcmd root@$RABBITMQ_IP "rabbitmqctl add_user "bk_dataweb" "$(_app_token bk_dataweb)""
  rcmd root@$RABBITMQ_IP "rabbitmqctl add_user "bk_appo" "$(_app_token bk_appo)""
  rcmd root@$RABBITMQ_IP "rabbitmqctl add_user "bk_appt" "$(_app_token bk_appt)""
  rcmd root@$RABBITMQ_IP "rabbitmqctl add_user "bk_sops" "$(_app_token bk_sops)""
  rcmd root@$RABBITMQ_IP "rabbitmqctl add_user "gcloud" "$(_app_token gcloud)""
  rcmd root@$RABBITMQ_IP "rabbitmqctl add_user "bk_itsm" "$(_app_token bk_itsm)""

  rcmd root@$RABBITMQ_IP "rabbitmqctl set_user_tags bk_bkdata management"
  rcmd root@$RABBITMQ_IP "rabbitmqctl add_vhost bk_bkdata"
  rcmd root@$RABBITMQ_IP 'rabbitmqctl set_permissions -p bk_bkdata bk_bkdata ".*" ".*" ".*"'
  ```

- 更新 Nginx

  ```bash
  cd /data/install
  ./bkcec stop nginx
  ./bkcec install nginx 1
  ./bkcec start nginx
  ```

- 更新 PaaS

  ```bash
  #进入脚本目录
  cd /data/install/
  ./bkcec stop paas
  ./bkcec status paas
  ./bkcec upgrade paas
  ./bkcec start paas
  ./bkcec status paas
  ```

- 更新 GSE

  ```bash
  #进入脚本目录
  cd /data/install/
  ./bkcec stop gse
  ./bkcec status gse
  ./bkcec install gse 1
  ./bkcec start gse
  ./bkcec status gse
  ```

- 更新 BKDATA

  ```bash
  #进入脚本目录
  cd /data/install/
  ./bkcec stop bkdata
  ./bkcec status bkdata
  ./bkcec upgrade bkdata
  ./bkcec start bkdata
  ./bkcec status bkdata
  ```

- 更新 FTA

  ```bash
  #进入脚本目录
  cd /data/install/
  ./bkcec stop fta
  ./bkcec status fta  
  ./bkcec upgrade fta  
  ./bkcec start fta  
  ./bkcec status fta  
  ```
