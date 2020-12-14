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