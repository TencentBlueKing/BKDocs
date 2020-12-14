## 批量查看服务状态

我们提供了 `./bin/bks.sh` 脚本，可以展示所有蓝鲸服务的状态。
此脚本仅检查启动的 systemd 服务，且默认仅展示蓝鲸相关的服务，你可以使用正则作为参数匹配服务名。
如果服务被禁用，则不会展示。 install 时会自动 enable 服务。
```bash
pcmd -m ci '${CTRL_DIR:-/data/install}/bin/bks.sh'
```

使用关键字搜索 systemd 的服务名， 如查看蓝盾及 Consul 服务：
```bash
pcmd -m ci '${CTRL_DIR:-/data/install}/bin/bks.sh bk-ci consul'
```
