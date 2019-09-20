## 蓝鲸日常维护

### 迁移服务

假设想将 BKDATA 模块从目前混搭的服务器上，迁移到一台新机器，可以按如下步骤操作：

- 停掉原来服务器上的 BKDATA 进程 `./bkcec stop bkdata`
- 修改 install.config 文件，新增一行 `$ip bkdata` IP 为待迁移的机器 IP ，删除原 ip 所在行的 `bkdata`
- 新机器配置好中控机的 SSH 免密登陆

除非特别指出，在中控机上依次执行以下命令，每一个命令成功后，再继续下一个：

```bash
# 同步 install.config 更改
./bkcec sync common

#  同步基础依赖 Consul
./bkcec sync consul

# 同步 BKDATA 模块
./bkcec sync bkdata

# 安装 Consul
./bkcec install consul

# 重启 Consul
./bkcec stop consul
./bkcec start consul

# 安装 BKDATA
./bkcec install bkdata

# 给新机器授予 MySQL 权限
./bkcec initdata mysql

#  给新的 BKDATA 补上初始化标记文件
ssh $BKDATA_IP 'touch /data/bkce/.dataapi_snaphost'

# 启动新的 BKDATA
./bkcec start bkdata
```

登陆到老的 BKDATA 机器，将标记文件 /data/bkce/.installed_module 文件中的 BKDATA 行删除：

```bash
sed -i '/bkdata/d' /data/bkce/.installed_module
```

其余模块的迁移流程大致和 BKDATA 类似。只是部分模块有一些特殊注意事项需要额外做一些操作。列举如下：

- PaaS 迁移。因为 PaaS IP 地址发生了改变，而作业平台的配置文件 job.conf 中，有一项 api.ip.whitelist 配置，需要随之修改。可以在迁移完 PaaS 后运行如下命令自动修改生效
  ```bash
  ./bkcec render job
  ./bkcec stop job
  ./bkcec start job
  ```
  PaaS 迁移后，Nginx 上对 PaaS 的反向代理配置也需要跟随改变，Nginx 需要重新渲染配置，重新加载配置。