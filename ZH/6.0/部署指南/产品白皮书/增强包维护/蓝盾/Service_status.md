## 查看服务状态

在中控机查看所有机器上的全部蓝盾服务：
```bash
cd ${CTRL_DIR:-/data/install}
pcmd -m ci 'systemctl status bk-ci.target'
```

在中控机查看所有的 `ci(gateway)` 服务，其 system 服务名为 `bk-ci-gateway`，而 `pcmd -m`参数则是需要 `ci_gateway` 的形式。
```bash
pcmd -m ci_gateway 'systemctl status bk-ci-gateway'
```

如果登录到了对应的节点： 则是：
查看全部蓝盾服务：
```bash
systemctl status bk-ci.target
```
查看特定的蓝盾服务：如网关
```bash
systemctl status bk-ci-gateway
```
