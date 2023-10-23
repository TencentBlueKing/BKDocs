# 日常维护
## 服务管理
### 启动服务

安装脚本根据 `install.config` 配置了开机自启。如果 `install.config` 变动，请手动禁用并删除旧服务，并重新执行安装操作。

我们在每个机器上提供了 systemd 的 `bk-ci.target` unit ，使用此 unit 可以控制蓝盾所有的 `.service`。

```bash
systemctl start 服务名
```

>**提示**
>
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
>
> 同节点上可能还有其他蓝盾服务，所以避免使用 `bk-ci.target` 。
> 同理，不使用 `-m ci` 来启动特定的服务，以防误启动禁用节点的蓝盾服务。
> 因为当服务被禁用时，也能手动启动。

### 停止服务

在中控机停止所有机器上的全部蓝盾服务：
```bash
cd ${CTRL_DIR:-/data/install}
pcmd -m ci 'systemctl stop bk-ci.target'
```

在中控机停止所有机器上的 `ci(gateway)` 服务，其 system 服务名为 `bk-ci-gateway`，而 `pcmd -m`参数则是需要 `ci_gateway` 的形式。
```bash
pcmd -m ci_gateway 'systemctl start bk-ci-gateway'
```

如果登录到了对应的节点： 则是：
停止全部蓝盾服务：
```bash
systemctl start bk-ci.target
```
停止特定的蓝盾服务：如网关
```bash
systemctl start bk-ci-gateway
```
### 重载服务

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

### 重启服务

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

## 检查状态
### 查看单个服务状态
在中控机查看所有的 `ci(gateway)` 服务，其 system 服务名为 `bk-ci-gateway`，而 `pcmd -m`参数则是需要 `ci_gateway` 的形式。
```bash
pcmd -m ci_gateway 'systemctl status bk-ci-gateway'
```

如果登录到了对应的节点：
查看特定的蓝盾服务：如网关
```bash
systemctl status bk-ci-gateway
```

### 批量查看服务状态

我们提供了 `./bin/bks.sh` 脚本，可以概览展示所有蓝鲸服务的状态。
此脚本仅检查启动的 systemd 服务，且默认仅展示蓝鲸相关的服务，你可以使用正则作为参数匹配服务名。
如果服务被禁用，则不会展示。 install 时会自动 enable 服务。
```bash
pcmd -m ci '${CTRL_DIR:-/data/install}/bin/bks.sh'
```

使用关键字搜索 systemd 的服务名， 如查看蓝盾及 Consul 服务：
```bash
pcmd -m ci '${CTRL_DIR:-/data/install}/bin/bks.sh bk-ci consul'
```

### 检查服务的 stdout 和 stderr

服务使用 systemd 启动，启动过程中会输出提示信息。
需登录到对应的机器上操作。

```bash
journalctl -xeu 服务名
```
### 检查微服务域名

蓝盾的微服务在启动后，会自动注册 Consul 。域名格式如下： `微服务名-标签.service.consul`。标签即 env 文件里的 `BK_CI_CONSUL_DISCOVERY_TAG`，默认 `devops`。

例如：查询 dispatch 的 DNS 解析结果：
```bash
getent hosts dispatch-devops.service.consul  # 会输出DNS解析结果, 格式为: IP  域名. 如果无输出, 则说明无解析, 需要检查对应服务是否正常.
```
>**提示**
>
>`getent` 命令来自 `glic-common` 包，一般无需安装。

### SpringBoot Health 接口
java 微服务提供了 health 接口，可以输出服务状态。
```bash
API_PORT=  # 填写对应微服务的API PORT。可以查看 /data/bkce/ci/微服务/start.env 文件获取。
curl -m 1 -sf "http://127.0.0.1:$API_PORT/management/health"
```

## 检查日志

> 日志目录默认位于 `/data/bkce/logs/ci/`，其下以组件命名。 gateway 的日志名为 nginx 。

### 网关日志

错误日志（ error.log ）：我们可以使用 pcmd 检查 `ci(gateway)` 节点上的 `/data/bkce/logs/ci/nginx/devops.error.log`
```bash
pcmd -m ci_gateway 'tail ${BK_HOME:-/data/bkce}/logs/ci/nginx/devops.error.log'
```
至于访问日志（ access.log ），命名则是 `devops-access.YYYY-mm-dd.log` 格式。例如查看当天的 access.log 结尾：
```bash
pcmd -m ci_gateway 'tail ${BK_HOME:-/data/bkce}/logs/ci/nginx/devops.access.$(date +%Y-%m-%d).log'
```

### 微服务日志

默认： `/data/bkce/logs/ci/服务名/服务名-devops.log`。
参考查看 project 的日志：
```bash
ms=project  # 在此修改微服务的名称。
pcmd -m ci_$ms "tail ${BK_HOME:-/data/bkce}/logs/ci/$ms/$ms-${BK_CI_CONSUL_DISCOVERY_TAG:-devops}.log"
```
或者搜索 `Exception` 及 `Caused by`等关键词：
```bash
ms=project  # 在此修改微服务的名称。
pcmd -m ci_$ms "grep --color=yes -E '^Caused by|[.][a-zA-Z]*Exception' ${BK_HOME:-/data/bkce}/logs/ci/$ms/$ms-${BK_CI_CONSUL_DISCOVERY_TAG:-devops}.log"
```

### 构建容器日志

公共构建机（dockerhost）在每个容器启动后开始记录日志。
路径为 `$BK_HOME/logs/ci/docker/BUILD_ID/RETRY/docker.log`。
`BUILD_ID`是流水线 URL 里 `b-` 开头的整段内容（包含 `b-`），每次 “执行” 流水线则生成一个新的 ID 。
`RETRY`则是重试次数，第一次运行即为 1 ，在流水线出错时，可以点击插件或 job 右侧的重试链接，此时 `RETRY`计数增加。
假设 `BUILD_ID`为 `b-ca389ac9a9b3426687f0b7f63dc02532`，初次运行，则其路径如下 （仅在调度到的构建机上存在。）：

```bash
/data/bkce/logs/ci/docker/b-ca389ac9a9b3426687f0b7f63dc02532/1/docker.log
```

## 依赖服务升级
蓝盾依赖着 MySQL、RabbitMQ、Redis、consul 等第三方软件。

修订版及小版本下的安全更新建议持续进行。理论上无稳定性风险。但建议做好预案。
不建议升级大版本。如果必须大版本升级依赖的服务，请关注蓝鲸官方公告。并自行测试可用性。

## 数据迁移
迁移数据库及蓝盾的数据目录（变量`BK_CI_DATA_DIR`）。
以及用户自定义 env 文件: `${CTRL_DIR:-/data/install}/bin/03-userdef/ci.env` (如果新环境密码发生变动, 记得更新此文件. )

## 拉取镜像
提前在构建机拉取镜像，避免在构建时临时拉取镜像导致任务超时。

注意：构建机需要能访问 Docker hub 。用户亦可自行修改 `/etc/docker/daemon.json` 指定私有 registry 。
```bash
pcmd -m ci_dockerhost 'docker pull bkci/ci'
```
