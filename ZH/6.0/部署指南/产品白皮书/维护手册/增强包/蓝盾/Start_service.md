## 启动服务

安装脚本根据 `install.config` 配置了开机自启。如果 `install.config` 变动，请手动禁用并删除旧服务，并重新执行安装操作。

我们在每个机器上提供了 systemd 的 `bk-ci.target` unit ，使用此 unit 可以控制蓝盾所有的 `.service`。

```bash
systemctl start 服务名
```

>**提示**
> 在 systemctl 命令时，如果无特指， `服务名` 一般指蓝盾的服务，以 `bk-ci-工程名` 命名。

大部分场景下，蓝盾的服务会分布到多个节点。所以使用 `pcmd` 在多个节点批量执行这些命令。

示例：
在中控机启动所有机器上的全部蓝盾服务：
```bash
cd ${CTRL_DIR:-/data/install}
pcmd -m ci 'systemctl start bk-ci.target'
```

在中控机仅启动所有的 `ci(gateway)` 服务，其 system 服务名为 `bk-ci-gateway`，而 `pcmd -m`参数则是需要 `ci_gateway` 的形式。
```bash
pcmd -m ci_gateway 'systemctl start bk-ci-gateway'
```

如果登录到了对应的节点，则是：
启动全部蓝盾服务：
```bash
systemctl start bk-ci.target
```
启动特定的蓝盾服务：如网关
```bash
systemctl start bk-ci-gateway
```

>**注意**
> 同节点上可能还有其他蓝盾服务，所以避免使用 `bk-ci.target` 。
> 同理，不使用 `-m ci` 来启动特定的服务，以防误启动禁用节点的蓝盾服务。
> 因为当服务被禁用时，也能手动启动。
