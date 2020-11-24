## 重载服务

gateway 使用的是 nginx ，支持 reload。

在中控机 reload 所有的 `ci(gateway)` 服务，其 system 服务名为 `bk-ci-gateway`，而 `pcmd -m`参数则是需要 `ci_gateway` 的形式。
```bash
pcmd -m ci_gateway 'systemctl reload bk-ci-gateway'
```

如果登录到了蓝盾网关节点： 则是：
```bash
systemctl start bk-ci-gateway
```

微服务不支持 reload 。
