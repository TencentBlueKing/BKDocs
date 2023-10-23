# 机器重启

如果服务器发生了重启，正常情况下组件会由 systemd 自动拉起（因为安装配置了 `systemctl enable`）。由于组件分布在单台机器上的实际情况较为复杂，并发启动时存在重连次数的限制导致部分进程自启动会有失败的情况。

如果服务器重启后，`systemctl list-units --failed` 依然有 failed 状态的进程 <输出结果除了蓝鲸组件还包括系统的 systemd 服务，请注意分辨>，可根据它们的依赖关系，重新启动底层服务，确认成功后，再启动蓝鲸组件来解决。以下是几种常见场景：

- kafka 启动依赖 zookeeper 可用
- cmdb 启动依赖 zookeeper 可用
- 监控链路的 bk-influxdb-proxy 和 bk-transfer 依赖 kafka 可用

## 注意事项

以往的脚本提供了 `stop all` 和 `start all` 的操作，容易引发误操作，日常维护中，并不需要经常做全部服务的停止和启动。对于第三方组件尽量保证它们稳定运行，但是混搭进程的情况下，有时会因为内存不足导致不断 OOM 触发一系列异常。此刻应该按实际情况重启相关进程，避免全部进程重启的粗暴操作。

## 检查思路

### 检查 DNS 配置文件

- 在部署的 3 台机器上检查 `/etc/resolv.conf` 文件首行是否存在 `nameserver 127.0.0.1` 记录。如不存在，请自行加入该文件的首行。

### 检查相关服务

```bash
# 中控机执行命令
echo bkssm bkiam usermgr paas cmdb gse job consul bklog | xargs -n 1 ./bkcli check
```

如果 check 输出的状态为非 `true`，那么可以使用 `./bkcli start|restart <module>` 拉起。 **module** 为 check 状态非 `true` 的模块。

假设 paas，job，gse，bkmonitorv3 自启动失败，可以参考下述命令：

```bash
# 中控机执行
echo paas job gse bkmonitorv3 | xargs -n 1 ./bkcli restart

# 如果是模块的某个服务自启动失败，以 gse data 为例
./bkcli restart gse data
```

 job 启动稍微有点慢，可等待 10s~30s 再执行 check 命令。

此外，还可以登录至模块所在的服务器，通过 `systemctl start|restart <module>` 拉起服务。以 PaaS 为例：

```bash
# 登录 paas 模块所在的机器
source /data/install/utils.fc
ssh $BK_PAAS_IP

# 重启 paas 服务
systemctl restart bk-paas.target
```

### 启动蓝鲸所有 SaaS

```bash
./bkcli start saas-o 
```
