## 服务管理方式

容器管理平台使用 systemd 组件托管，具备以下特性与操作：

1. 服务器重启或进程异常 crash 后会自动拉起
2. 服务启动命令：systemctl start <service_name>
3. 查看服务状态：systemctl status <service_name>
4. 查看服务配置：systemctl cat <service_name>
5. 服务停止命令：systemctl stop <service_name>
6. 服务重启命令：systemctl restart <service_name>

## 服务简介与部署路径

### 存储组件

1. MYSQL
- 组件简介：为 bcs-api、bcs-cc、web_console、容器管理平台 SaaS、容器监控提供数据存储服务
- 服务名称：mysql@bcs
- BIN 文件：/sbin/mysqld
- 配置文件：/etc/mysql/bcs.my.cnf
- 部署路径：rpm -ql mysql-community-server
- 日志路径：/data/bkce/logs/mysql/bcs.mysqld.log
2. Redis
- 组件简介：bcs-cc、web_console、容器管理平台 SaaS、容器监控提供数据缓存服务
- 服务名称：redis@bcs
- 部署路径：rpm -ql redis
- BIN 文件：/usr/bin/redis-server
- 配置文件：service 参数
- 日志路径：/var/log/redis/bcs.log
3. MongoDB
- 组件简介：为 bcs-storage 提供数据存储服务
- 服务名称：mongod
- 部署路径：/usr/bin
- BIN 文件：/usr/bin/mongod
- 配置文件：/etc/mongod.conf
- 日志路径：/data/bkce/logs/mongodb/mongod.log
4. Harbor
- 组件简介：Harbor 是 Vmware 公司开源的企业级 Docker Registry 管理项目，为 K8S 集群提供镜像仓库功能
- 服务名称：/data/bkce/harbor/server/start.sh、/data/bkce/harbor/server/stop.sh
- 部署路径：/data/bkce/harbor/server
- BIN 文件：docker 容器
- 配置文件：docker 容器
- 日志路径：docker 容器
5. Etcd
- 组件简介：为 bcs-dns-service、K8S 集群提供数据存储服务
- 服务名称：etcd
- 部署路径：/usr/local/bin
- BIN 文件：/usr/local/bin/etcd
- 配置文件：service 参数
- 日志路径：/var/log/messages
6. Zookpeer
- 组件简介：为 bcs-api、bcs-storage、bcs-cc 提供服务发现服务
- 服务名称：zookeeper
- 部署路径：rpm -ql zookeeper
- BIN 文件：/usr/bin/java
- 配置文件：/etc/zookeeper/zoo.cfg
- 日志路径：/var/log/zookeeper/zookeeper.log