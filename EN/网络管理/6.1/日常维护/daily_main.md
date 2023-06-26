# 维护指引

## 查看服务

网络管理使用 systemd 进行托管，进程启动过程中如果有打印标准输出和标准错误日志，会定向到 systemd-journald 服务，通过 journactl 命令来查看。定位时常用的命令行参数如下：

- 查看服务状态

```bash
source /data/install/utils.fc
ssh $BK_NETWORK_IP

# 服务端
systemctl status bk-network-nop.service

# 采集端
systemctl status bk-network-nopcollector.service
```

## 进程启动日志

- 查看服务端/采集端的日志

```bash
source /data/install/utils.fc
ssh $BK_NETWORK_IP

# 服务端
journalctl -u bk-network-nop.service

# 采集端
journalctl -u bk-network-nopcollector.service
```

## 后台日志

网络管理运行日志在 $BK_HOME/logs/bknetwork 下，按模块名，组件名分目录存放。

```bash
source /data/install/utils.fc
ssh $BK_NETWORK_IP

cd $BK_HOME/logs/bknetwork
```
