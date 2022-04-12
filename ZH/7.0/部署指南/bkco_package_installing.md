# 部署监控日志套餐

## 部署监控平台
在 中控机 执行
``` bash
cd ~/bkhelmfile/blueking
helmfile -f 04-bkmonitor.yaml.gotmpl sync
```
约等待 5 ~ 10 分钟，期间 `bk-monitor-consul` pod 可能 `Error` 且自动重启。

如果部署中报错：
``` plain
hook[presync] logs | bkrepo没有blueking项目，请检查bkrepo安装是否正确
hook[presync] logs |
in ./04-bklog-search.yaml.gotmpl: failed processing release bk-logsearch: hook[./scripts/add_bkrepo_bucket.sh]: command `./scripts/add_bkrepo_bucket.sh` failed: command "./scripts/add_bkrepo_bucket.sh" exited with non-zero status:
```
请检查中控机解析到的 `bkrepo` 域名是否正确，以及 `scripts/add_bkrepo_bucket.sh` 脚本中的 `BKREPO_ADMIN_PASSWORD` 是否正确。

## 访问监控平台
配置本地 hosts 进行访问
``` bash
# 请注意替换为实际的 BK_DOMAIN
BK_DOMAIN=bkce7.bktencent.com
IP1=$(kubectl get pods -n blueking -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].status.hostIP}')
IP1=$(ssh "$IP1" 'curl ip.sb')
echo $IP1 bkmonitor.$BK_DOMAIN
```

此时访问 “观测场景” —— “Kubernetes” 界面会出现报错。为未启用容器监控所致，完成 “配置容器监控” 章节可正常使用。

## 部署日志平台
在 中控机 执行
``` bash
cd ~/bkhelmfile/blueking
helmfile -f 04-bklog-search.yaml.gotmpl sync
```

## 访问日志平台
配置本地 hosts 进行访问
``` bash
# 请注意替换为实际的 BK_DOMAIN
BK_DOMAIN=bkce7.bktencent.com
IP1=$(kubectl get pods -n blueking -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].status.hostIP}')
IP1=$(ssh "$IP1" 'curl ip.sb')
echo $IP1 bklog.$BK_DOMAIN
```

## 配置容器监控

### 前置检查
容器监控功能需要在所有 k8s node （包括 master ）部署 gse-agent。请先在 “节点管理” 中完成 agent 安装。

容器监控功能依赖 **容器管理平台** （BCS），请先完成 [容器管理套餐部署](bcs_package_installing.md) 。

容器监控功能依赖 **监控平台** ，请先完成 “部署监控平台” 章节。

### 调整 bkmonitor
需要能读取 bcs 管理接口。
``` bash
cd ~/bkhelmfile/blueking
./scripts/config_monitor_bcs_token.sh
helmfile -f 04-bkmonitor.yaml.gotmpl apply   # apply 仅增量更新
```

### 部署 bklog-collector
部署日志采集器。

``` bash
cd ~/bkhelmfile/blueking
helmfile -f 04-bklog-collector.yaml.gotmpl sync
# 等待1分钟，如果 pod 稳定状态为 Running ，则部署完成。
timeout 60 kubectl get pods -n blueking -w | grep bklog-collector
```

如果 pod 状态异常，请检查 pod 的日志。
``` bash
kubectl logs -n blueking bklog-collector-bk-log-collector-补全名称 bkunifylogbeat-bklog
```

未在 “节点管理” 中为所有 node 安装 agent 时，`bklog-collector-bk-log-collector` 系列 pod 的日志中会出现如下报错：
``` plain
Init filed with error: failed to initialize libbeat: error initializing publisher: dial unix /data/ipc/ipc.state.report: connect: no such file or directory
```

此时部署 gse agent 成功后，pod 会逐步自动恢复。也可直接重新部署此 charts：
``` bash
helmfile -f 04-bklog-collector.yaml.gotmpl destroy
helmfile -f 04-bklog-collector.yaml.gotmpl sync
```

### 部署 bkmonitor-operator

``` bash
cd ~/bkhelmfile/blueking
helmfile -f 04-bkmonitor-operator.yaml.gotmpl sync
```

然后在新窗口中检查 pod 稳定状态为 `Running` 即可：
``` bash
kubectl get pod -n bkmonitor-operator -w
```

未在 “节点管理” 中为所有 node 安装 agent 时，`bkmonitor-operator-bkmonitorbeat-daemonset` 系列 pod 的日志与 `bklog-collector` 相似，请参考 “部署 bklog-collector” 章节处理。
