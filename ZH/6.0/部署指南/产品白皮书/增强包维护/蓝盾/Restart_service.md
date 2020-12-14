## 重启服务

在中控机重启所有机器上的全部蓝盾服务：
```bash
cd ${CTRL_DIR:-/data/install}
pcmd -m ci 'systemctl restart bk-ci.target'
```

在中控机重启所有的 `ci(gateway)` 服务，其 system 服务名为 `bk-ci-gateway`，而 `pcmd -m`参数则是需要 `ci_gateway` 的形式。
```bash
pcmd -m ci_gateway 'systemctl restart bk-ci-gateway'
```

如果登录到了对应的节点： 则是：
重启全部蓝盾服务：
```bash
systemctl restart bk-ci.target
```
重启特定的蓝盾服务：如网关
```bash
systemctl restart bk-ci-gateway
```
