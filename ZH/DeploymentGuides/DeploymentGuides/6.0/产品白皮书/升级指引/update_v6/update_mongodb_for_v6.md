# 社区版 5.1-6.0 MongoDB 升级指引

## 升级 MongoDB

### 准备 mongo 相关 rpm 包

- 登录 mongodb 所在机器

```bash
source /data/install/utils.fc
ssh $BK_MONGODB_IP
```

- 创建 rpm 存放目录

```bash
mkdir -p /data/version_pkg/mongodb
```

- 下载 mongo rpm 包

```bash
cd /data/version_pkg/mongodb
# https://www.mongodb.com/try/download/community

cat > wget.list <<EOF
https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.0/x86_64/RPMS/mongodb-org-shell-4.0.18-1.el7.x86_64.rpm
https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.0/x86_64/RPMS/mongodb-org-server-4.0.18-1.el7.x86_64.rpm
https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.2/x86_64/RPMS/mongodb-org-shell-4.2.3-1.el7.x86_64.rpm
https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.2/x86_64/RPMS/mongodb-org-server-4.2.3-1.el7.x86_64.rpm
EOF

# 开始下载
wget -i wget.list
```

### 3.6 版本更新为 4.0 版本

```bash
yum -y install mongodb-org-shell-4.0.18-1.el7.x86_64.rpm mongodb-org-server-4.0.18-1.el7.x86_64.rpm
```

- 确认版本号

```bash
/usr/bin/mongo --version
/usr/bin/mongod --version
```

- 去掉 crontab 定时任务

```bash
crontab -e
#* * * * * export INSTALL_PATH=/data/bkce; /data/bkce/bin/process_watch mongodb >/dev/null 2>&1
#* * * * * export INSTALL_PATH=/data/bkce; /data/bkce/bin/process_watch consul >/dev/null 2>&1
```

- 停止 mongodb<3.6> 进程

```bash
# stop 后请再次回车
/data/bkce/service/mongodb/bin/mongodb.sh stop

# 查看状态
/data/bkce/service/mongodb/bin/mongodb.sh status
```

- 同步配置、更新字段

```bash
# 修改 mongod.conf 的配置项

source /data/install/utils.fc
sed -i "/bindIp/s/127.0.0.1/127.0.0.1, $LAN_IP/" /etc/mongod.conf
sed -i "/  dbPath/s,/var/lib/mongo,${INSTALL_PATH}/public/mongodb," /etc/mongod.conf
sed -i "/  path:/s,/var/log/mongodb,${INSTALL_PATH}/logs/mongodb," /etc/mongod.conf

cat >> /etc/mongod.conf << EOF
replication:
   replSetName: rs0
security:
   keyFile: "/data/bkce/public/mongodb/mongod.key"
EOF
```

- 启动 mongodb 4.0

```bash
# 启动前先检查下mongodb的数据目录以及日志目录的权限是否正确，如不正确请按照下述命令执行
chown -R mongod.mongod  /data/bkce/logs/mongodb
chown -R mongod.mongod  /data/bkce/public/mongodb

# 启动 mongodb 服务
systemctl start mongod.service
systemctl status mongod.service
```

- 下线 primary

```bash
mongo mongodb://$BK_MONGODB_IP:27017/admin -u $BK_MONGODB_ADMIN_USER -p $BK_MONGODB_ADMIN_PASSWORD

rs.stepDown()
rs.status()
```

- 开启 mongo 4.0 功能

```bash
/usr/bin/mongo mongodb://$BK_MONGODB_IP:27017/admin -u $BK_MONGODB_ADMIN_USER -p $BK_MONGODB_ADMIN_PASSWORD

db.adminCommand( { setFeatureCompatibilityVersion: "4.0" } )
rs.status()
```

### 4.0 版本更新为 4.2 版本

- 在 mongodb 机器上执行

```bash
cd /data/version_pkg/mongodb
yum -y install mongodb-org-shell-4.2.3-1.el7.x86_64.rpm mongodb-org-server-4.2.3-1.el7.x86_64.rpm
```

- 确认版本号

```bash
/usr/bin/mongo --version
/usr/bin/mongod --version
```

- 重启 mongodb 服务

```bash
systemctl restart mongod.service
```

- 持续观察 mongo 服务是否有异常

```bash
systemctl status mongod.service
```

- 下线 primary

```bash
# 连接 mongo
/usr/bin/mongo -u $BK_MONGODB_ADMIN_USER -p $BK_MONGODB_ADMIN_PASSWORD mongodb://$BK_MONGODB_IP:27017/admin?replicaSet=rs0

# 下线
rs.stepDown()
rs.status()
```

- 开启 4.2 相关功能

```bash
/usr/bin/mongo -u $BK_MONGODB_ADMIN_USER -p $BK_MONGODB_ADMIN_PASSWORD mongodb://$BK_MONGODB_IP:27017/admin?replicaSet=rs0

db.adminCommand( { setFeatureCompatibilityVersion: "4.2" } )
rs.status()
```

### 注册 mongo consul 服务

```bash
# 注册 consul 服务，中控机执行
source /data/install/tools.sh
reg_consul_svc mongodb 27017 $BK_MONGODB_IP_COMMA
```

### 写入相关标记文件

```bash
#中控机执行
source /data/install/tools.sh

pcmdrc mongodb "_sign_host_as_module mongodb"
echo "install mongodb" >> /data/install/.bk_install.step
```
