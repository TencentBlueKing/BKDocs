# 部署监控日志套餐

## 部署监控平台
在 中控机 执行
``` bash
cd ~/bkhelmfile/blueking
helmfile -f 04-bkmonitor.yaml.gotmpl sync
```

## 访问监控平台
配置本地 hosts 进行访问
``` bash
# 请注意替换为实际的 BK_DOMAIN
BK_DOMAIN=bkce7.bktencent.com
IP1=$(kubectl get pods -n blueking -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].status.hostIP}')
IP1=$(ssh "$IP1" 'curl ip.sb')
echo $IP1 bkmonitor.$BK_DOMAIN
```

## 部署日志平台
在 中控机 执行
``` bash
cd ~/bkhelmfile/blueking
helmfile -f 04-bklog-search.yaml.gotmpl sync
```

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
容器监控功能依赖 **容器管理平台** （BCS），请先完成 [容器管理套餐部署](bcs_package_installing.md) 。

容器监控功能依赖 **监控平台** ，请先完成本文档 “部署监控平台” 章节。

容器监控功能需要在所有 k8s node （包括 master ）部署 gse-agent。请先在 “节点管理” 中完成 agent 安装。

在部署完成 “监控平台” 后，`bk-monitor-alarm-cron-worker` pod 每 10 分钟会同步一次 `dataid`。在 中控机 执行：
``` bash
kubectl get dataids
```
预期出现如下如下 4 项：
``` plain
NAME                 AGE
customeventdataid    22m
custommetricdataid   22m
k8seventdataid       22m
k8smetricdataid      22m
```
如果 20 分钟（2 个周期）依旧没有出现，需要检查日志：
``` bash
kubectl logs -n blueking bk-monitor-alarm-cron-worker-补全名称 bk-monitor-alarm-cron-worker
```

### 调整 bkmonitor
需要能读取 bcs 管理接口。
``` bash
cd ~/bkhelmfile/blueking
./scripts/config_monitor_bcs_token.sh
helmfile -f 04-bkmonitor.yaml.gotmpl apply   # apply 仅增量更新
```

### 部署 bkmonitor-operator
``` bash
helmfile -f 04-bkmonitor-operator.yaml.gotmpl sync
helmfile -f 04-bklog-collector.yaml.gotmpl sync  # 部署日志采集器
```

如果部署中出错，请检查 pod 的日志。

如果未在 “节点管理” 中安装 agent，则日志中会出现如下报错：
``` plain
Init filed with error: failed to initialize libbeat: error initializing publisher: dial unix /data/ipc/ipc.state.report: connect: no such file or directory
```
