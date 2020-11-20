# 蓝鲸社区版 5.1 mini 版容器制作

## 蓝鲸社区版容器准备

- 下载 [蓝鲸社区版 5.1 安装包](https://bk.tencent.com/download/)，把安装包放入 **/mnt/soft** 下，待会共容器内安装社区版 5.1 使用。详细部署步骤，请前往 [蓝鲸文档中心-部署维护](https://bk.tencent.com/docs/document/5.1/20/654?r=1)

- 创建自定义容器网络，以免与用户现有网络冲突
```shell
docker network create --subnet=172.29.144.0/24 bk-network
# --subnet=172.29.144.0/24：设置自定义网段，默认使用网桥
# bk-network：自定义网络名称，可以用docker network查看
```
- docker pull 镜像
```shell
docker pull centos
```

- 启动容器
```shell
docker run -d --rm --privileged=true --name bk5.1-relese --network bk-network --hostname rbtnode1 \
--ip 172.29.144.251 --add-host paas.bk.com:172.29.144.251 \
--add-host job.bk.com:172.29.144.251 --add-host cmdb.bk.com:172.29.144.251 -v /mnt/soft:/soft \
--mac-address 02:d0:c8:0b:37:c3 -p 80:80 -p 58625:58625 -p:10020:10020 -p:10020:10020/udp \
-p:10030:10030/udp -p 48533:48533 -p 59173:59173 <IMAGE ID> /sbin/init
```

> 参数解释：
>- -d：后台进程启动
>- --rm：容器停止时删除容器，防止下次启动时容器名重复，启动失败
>- --privileged=true：开启特权模式，我们后面所做操作需要某些特权，例如设置网卡信息等，否则会失败
>- --name bk5.1-relese：容器名称命名为 bk5.1-relese，方便后续操作
>- --network bk-network：使用特定用户网络，以免与用户现有容器环境冲突
>- --hostname rbtnode1：设置容器主机名，rbtnode1 为社区版 5.1 特定主机名，里面某些服务会与之绑定
>- --ip 172.29.144.251：设置特定 IP 地址，以免与用户现有容器环境冲突
>- --add-host paas|cmdb|job.bk.com:172.29.144.251:添加/etc/hosts 解析，社区版所需
>- -v /mnt/soft:/soft：挂载 host 上的/mnt/soft 上的文件，里面有安装社区版 5.1 所需的安装文件
>- --mac-address 02:d0:c8:0b:37:c3：绑定特定 MAC 地址，以免重新生成 gse 证书
>- -p xxx:xxx：端口映射，让 host 上的端口映射到容器内,80 是 http 服务，其余端口均用于 gse_agent 通讯
>- docker.oa.com:8080/public/centos-7.2： 使用公司内 centos7.2 的镜像作为容器基础源
/sbin/init：使用 systemd 托管容器进程

- 进入容器
```shell
docker exec -it bk5.1-relese /bin/bash
```

## 容器环境初始化
### 环境配置
- 修改时区为中国时间
```shell
echo y|cp -a /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```

- /root/.bashrc 设置
```shell 
alias vim='vi'
if [[ -d /data/install ]];then
	cd /data/install
fi
# 删除3个alias
export PATH=${PATH}:/data/bkce/service/mysql/bin
```
```shell
source /root/.bashrc
```
- 设置容器 dns，替代 host 上 的 `/etc/resolv.conf` 里的内容，127.0.0.1 是使用容器内 consul 监听的 DNS 服务
```shell
echo 'nameserver 127.0.0.1
nameserver 8.8.8.8' >/etc/resolv.conf
```

- 安装蓝鲸社区版环境所需组件

  ```shell
  yum -y install net-tools openssh-clients openssh-server cronie initscripts epel-release rsync openssl which deltarpm 

  systemctl enable sshd && systemctl start sshd
  systemctl enable crond && systemctl start crond
  ```

## 社区版安装
- 解压安装包
```shell
cd /soft 
tar zxf bkce_src-5.1.26.tar.gz
mkdir /data
cp -a /soft/install /data/install
cd /data && ln -s /soft/src .
```

- 证书下载
  - 进入：https://bk.tencent.com/download_ssl/
  - 使用特定 MAC 地址：02:d0:c8:0b:37:c3 生成证书 ssl_certificates.tar.gz，并将证书上传到宿主机 `/mnt/soft/src/cert` 下
  - 宿主机上执行
    ```shell
    cd /data/src/cert
    tar zxf ssl_certificates.tar.gz
    ```
- 开始安装
```shell
cd /data/install
./install_minibk（选择默认路径/data/bkce）
```

- 因为更新过 glibc，需要重新加载字符集
```shell
localedef -c -i en_US -f UTF-8 en_US.UTF-8
```

- 安装 paas：
```shell
./bk_install paas  # 中途输入 yes
```
如果以上步骤没有报错, 你现在可以通过 http://paas.bk.com:80 访问 PaaS 平台，帐户信息会在终端中显示。或者通过以下文件查看相关信息：
```shell
vim /data/install/globals.env
# 找到下列两行信息
export PAAS_ADMIN_USER=admin
export PAAS_ADMIN_PASS='xxxxx'
```

- 测试看看是否能通
```shell
ping paas.service.consul
```
- 安装配置平台
```shell
./bk_install cmdb
```
- 安装 作业平台
```shell
./bk_install job
```
- 安装标准运维：
```shell
./bk_install app_mgr 
./bk_install saas-o bk_sops
cd /data/bkce/paas_agent/apps/Envs/bk_sops/bin
cp -a /data/bkce/.envs/open_paas-appengine/bin/supervisorctl .
cp -a /data/bkce/.envs/open_paas-appengine/bin/supervisord .
sed -i '/stop_installed_service consul/a\    stop_installed_service saas-o' /data/install/control.rc
```
- 停止所有进程
```shell
cd /data/install && ./bkcec stop all
cd /data && echo y|rm src && mkdir src
cd /data/bkce/gse/server/bin && rm core.*
cd /var/lib/docker/overlay2/容器ID/diff/data/bkce/gse/server && rm core.*
```

- 在 host 上 export 该容器，并导入镜像
```shell
docker export bk5.1-relese -o bk5.1-relese.tar
docker import bk5.1-relese.tar bk5.1-relese
```

## 验证镜像可用性
- 停止镜像
```shell
docker kill bk5.1-relese
```
- 重新启动容器：
```shell
docker run -d --rm --privileged=true --name bk5.1-relese --network bk-network --hostname rbtnode1 \
--ip 172.29.144.251 --add-host paas.bk.com:172.29.144.251 \
--add-host job.bk.com:172.29.144.251 --add-host cmdb.bk.com:172.29.144.251 -v /mnt/soft:/soft \
--mac-address 02:d0:c8:0b:37:c3 -p 80:80 -p 58625:58625 -p:10020:10020 -p:10020:10020/udp \
-p:10030:10030/udp -p 48533:48533 -p 59173:59173 bk5.1-relese /sbin/init
```
- 进入容器：
```shell
docker exec -it bk5.1-relese /bin/bash
```
- 启动 mysql 时需要
```shell
chown -R mysql:mysql /data/bkce/public/mysql
echo 'nameserver 127.0.0.1
nameserver 8.8.8.8' >/etc/resolv.conf
```
- 启动容器
```shell
./bkcec start all
```
- 验证 PaaS 平台、配置平台、作业平台、标准运维可用性。

## 裁剪镜像大小

- 启动容器
```shell
docker run -d --rm --privileged=true --name bk5.1-relese --network bk-network --hostname rbtnode1 \
--ip 172.29.144.251 --add-host paas.bk.com:172.29.144.251 \
--add-host job.bk.com:172.29.144.251 --add-host cmdb.bk.com:172.29.144.251 -v /mnt/soft:/soft \
--mac-address 02:d0:c8:0b:37:c3 -p 80:80 -p 58625:58625 -p:10020:10020 -p:10020:10020/udp \
-p:10030:10030/udp -p 48533:48533 -p 59173:59173 bk5.1-relese /sbin/init
```
- 进入容器：
```shell
docker exec -it bk5.1-relese /bin/bash
```

- 清理日志：
```shell
find /data/bkce/logs -type f|xargs rm -f
```

- 清理 GSE

  ```shell
  cd /data/bkce/gse && rm -rf agent_aix_powerpc agent_linuxone agent_linux_x86 agent_linux_x86_64 \
  agent_win_x86_64 agent_win_x86 plugins_linux_x86 plugins_windows_x86_64 plugins_windows_x86 plugins_linux_x86_64
  ```
  ```shell
  sed -i 's/gse_alarm //g' /data/install/watch.rc
  sed -i 's/gse_alarm //g' /data/install/status.rc
  sed -i 's/alarm //g' /data/bkce/gse/server/bin/gsectl
  rm /data/bkce/gse/server/bin/gse_alarm
  sed -i 's/auto_launch: 1/auto_launch: 0/g' /usr/local/gse/plugins/project.yaml
  /data/install/bkcec stop gse_agent
  cd /var/log/gse && rm *
  cd /usr/local/gse/plugins/bin && rm * && /data/install/bkcec start gse_agent
  ```

- 清理 miniweb
```shell
cd /data/bkce/miniweb/download && rm -rf *
```

- 清理 paas 与 paas_agent
```shell
rm /data/bkce/paas_agent/apps/logs/bk_sops/*
cd /data/bkce/paas_agent/apps/Envs/bk_sops/bin && rm python2.7_e &&ln -s python python2.7_e
cd /data/bkce/paas_agent/apps/Envs/bk_sops/man/man1 && rm nosetests.1
cd /data/bkce/open_paas/paas/media/saas_files && rm *
```

- 清理 public
```plain
cd /data/bkce/public/mongodb/journal && rm *
/data/bkce/public/mysql && rm ib_logfile* && rm rbtnode1.err
cd /data/bkce/service/mysql/docs && rm *
cd /data/bkce/service/mysql/man && rm -rf *
rpm -e mariadb-devel mariadb mariadb-libs
cd /data/bkce/service/java/man && rm -rf * 
cd /data/bkce/service/java && rm javafx-src.zip && rm src.zip
cd /data/bkce/service/zk/docs && rm -rf *
```

- 清理 mysql
```shell
cd /bin && rm mysql_config_editor mysqld_multi mysqldumpslow mysql_plugin mysql_secure_installation \
mysql_tzinfo_to_sql mysqld mysqld_safe mysql_install_db mysqlpump mysql_ssl_rsa_setup mysql_upgrade
# 编辑/data/install/base.rc
# 注释以下行：
    #if [ ! -f /usr/bin/mysql ]; then
    #    _rsync -a $PKG_SRC_PATH/service/mysql/bin/mysql* /usr/bin/
    #    _rsync -a $PKG_SRC_PATH/service/mysql/include  /usr/include/mysql/
    #fi
```
- 杂项清理
```shell
cd /usr/local/share/doc && rm -rf *
cd /usr/share/backgrounds && rm *
cd /data/install/agent_setup && rm *
cd /data/install/pip && rm *.tar.gz *.zip
```

## 制作最终镜像
- 处理 /data/bkce/logs 和 /data/bkce/public，后面给主机挂载腾让位置
```shell
mv /data/bkce/logs /data/bkce/logs_bak
mv /data/bkce/public /data/bkce/public_bak
```

- 导出容器，生成新的镜像
```shell
docker export bk5.1-relese|docker import - bk5.1-relese:v1
```

- 用新的镜像启动
```shell
# 杀掉旧镜像：
docker kill bk5.1-relese
```

- 创建 bk 数据目录
```shell
mkdir -p /data/bk_data/logs /data/bk_data/public
```

- 启动新镜像，并绑定新数据目录，-v /data/bk_data/logs:/data/bkce/logs -v /data/
bk_data/public:/data/bkce/public，并去掉 /soft 目录绑定
```shell
docker run -d --rm --privileged=true --name bk5.1-relese-v1 --network bk-network --hostname rbtnode1 \
--ip 172.29.144.251 --add-host paas.bk.com:172.29.144.251 -v /data/bk_data/logs:/data/bkce/logs \
-v /data/bk_data/public:/data/bkce/public --add-host job.bk.com:172.29.144.251 --add-host cmdb.bk.com:172.29.144.251  \
--mac-address 02:d0:c8:0b:37:c3 -p 80:80 -p 58625:58625 -p:10020:10020 -p:10020:10020/udp \
-p:10030:10030/udp -p 48533:48533 -p 59173:59173 bk5.1-relese:v1 /sbin/init
```

- 进入容器.
```shell
docker exec -it bk5.1-relese-v1 /bin/bash
```

- 复制初始化 public 目录内容
```shell
cp -a /data/bkce/public_bak/* /data/bkce/public/
cp -a /data/bkce/logs_bak/* /data/bkce/logs/
```

- 停止 gse_agent
```shell
/data/install/bkcec stop gse_agent
```

- 启动 mysql 时需要
```shell
chown -R mysql:mysql /data/bkce/public/mysql
```
- 修改 DNS
```shell
echo 'nameserver 127.0.0.1
nameserver 8.8.8.8' >/etc/resolv.conf
```

- 启动容器
```shell
cd /data/install && ./bkcec start all
```

## 编写容器社区 5.1 mini 版部署脚本

### Agent 安装包制作及部署

- 解压 host 服务器上的社区版 src 目录，找到 gse_client-linux-x86_64.tgz，并解压到 gse 目录
```shell
mkdir gse && tar zxvf gse_client-linux-x86_64.tgz -C ./gse/
```

- 精简 gse_agent
```plain
rm gse/plugins/bin/*
sed -i 's/auto_launch: 1/auto_launch: 0/g' gse/plugins/project.yaml
```
- 编辑 gse/agent/etc/agent.conf

  ```shell
  vim gse/agent/etc/agent.conf

  {
  "log":"/var/log/gse",
  "cert":"/usr/local/gse/agent/cert",
  "proccfg":"/usr/local/gse/agent/etc/procinfo.json",
  "alarmcfgpath":"/usr/local/gse/plugins/etc",
  "dataipc":"/var/run/ipc.state.report",
  "runmode":1,
  "alliothread":8,
  "workerthread":24,
  "level":"error",
  "ioport":48533,
  "filesvrport":59173,
  "dataport":58625,
  "taskserver":[{"ip":"{{gse_server_ip}}","port":48533}],
  "btfileserver":[{"ip":"{{gse_server_ip}}","port":59173}],
  "dataserver":[{"ip":"{{gse_server_ip}}","port":58625}],
  "btportstart": 60020,
  "btportend": 60030,
  "btSpeedLimit":100,
  "agentip":"{{local_server_ip}}",
  "dftregid":"test",
  "dftcityid":"test"
  }
  ```

- 编写 systemd 服务器托管

  ```shell
  vim  gse/agent/bin/gse_agent_watch.sh

  #!/bin/bash
  cu_dir=$(cd "$(dirname "$0")";pwd)
  cd $cu_dir
  action=$1
  if [[ "$action" == "start" ]];then
    ./gsectl start agent
    sleep 5
    ./gsectl status agent
    if [[ $? -ne 0 ]];then
      echo "start gse_agent fail."
      exit 1
    fi
    while true
    do
      result=$(ps -ef|grep 'gse_agent -f /usr/local/gse/agent/etc/agent.conf'|grep -v 'grep')
      if [[ -z "$result" ]];then
        echo 'gse_agent stopped'
        exit 1
      fi
      sleep 5
    done
  elif [[ "$action" == "stop" ]];then
    ./gsectl stop agent
  else
    echo "action must be start or stop,error"
    exit 1
  fi
  ```
  ```shell
  chmod +x /usr/local/gse/agent/bin/gse_agent_watch.sh
  ```

- 编写 systemd 服务配置文件

  ```shell
  vim gse/agent/etc/gse_agent.service

  [Unit]
  Description=GSE Agent

  [Service]
  User=root
  Environment=WORK_HOME=/usr/local/gse/agent
  WorkingDirectory=/usr/local/gse/agent/bin
  ExecStart=/usr/local/gse/agent/bin/gse_agent_watch.sh start
  ExecStop=/usr/local/gse/agent/bin/gse_agent_watch.sh stop
  Restart=always
  RestartSec=10

  [Install]
  WantedBy=multi-user.target
  ```
- GSE Agent 部署及管理脚本编写（请见实际脚本）
  - 安装包：bkce_mini_gse_agent-5.1.26.tar.gz

  - 安装脚本：gse_agent_install.sh

### 验证 PaaS 平台、配置平台、作业平台、标准运维可用性

- 如果经验证各平台均能正常使用，可按下面步骤将镜像导出。

### 镜像导出

- 停止当前容器
```shell
docker kill bk5.1-relese:v1
```

- 重新启动容器，不需要挂载数据目录：logs 和 public
```shell
docker run -d --rm --privileged=true --name bk5.1-relese-v1 --network bk-network --hostname rbtnode1 \
--ip 172.29.144.251 --add-host paas.bk.com:172.29.144.251 \
--add-host job.bk.com:172.29.144.251 --add-host cmdb.bk.com:172.29.144.251  \
--mac-address 02:d0:c8:0b:37:c3 -p 80:80 -p 58625:58625 -p:10020:10020 -p:10020:10020/udp \
-p:10030:10030/udp -p 48533:48533 -p 59173:59173 bk5.1-relese:v1 /sbin/init
```

- 导出镜像
```shell
docker export -o bk5.1-relese-latest.tar bk5.1-relese-v1
```

### 蓝鲸社区 5.1 mini 版部署及管理脚本编写（请见实际脚本）
- 安装包：bkce_docker_install-5.1.26.tar.gz

- 安装脚本：install_bkce5.1-mini_for_docker.sh

- 管理脚本：bk_container_ctl