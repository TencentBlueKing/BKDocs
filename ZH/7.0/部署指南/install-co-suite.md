蓝鲸监控日志套餐由监控平台及日志平台组成。


# 监控平台

## 部署监控平台
在 中控机 执行
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
helmfile -f monitor-storage.yaml.gotmpl sync  # 部署监控依赖的存储
helmfile -f 04-bkmonitor.yaml.gotmpl sync  # 部署监控后台和saas以及监控数据链路组件
# 在admin桌面添加应用，也可以登录后自行添加。
scripts/add_user_desktop_app.sh -u "admin" -a "bk_monitorv3"
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
在桌面可以看到刚才添加的 “监控平台” 应用，访问前需先行配置 `bkmonitor.$BK_DOMAIN` 域名的解析。

在 **中控机** 执行如下命令生成 hosts 文件的内容：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get pods -A -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].status.hostIP}')
IP1=$(ssh "$IP1" 'curl ip.sb')
echo $IP1 bkmonitor.$BK_DOMAIN
```

此时访问 “观测场景” —— “Kubernetes” 界面会出现报错。为未启用容器监控所致，完成下文的 “配置容器监控” 章节即可正常使用。


## 配置容器监控

### 前置检查
容器监控功能需要在所有 k8s node （包括 master ）部署 gse-agent。请先在 “节点管理” 中完成 agent 安装。

容器监控功能依赖 **容器管理平台** （BCS），请先完成 [容器管理平台部署](install-bcs.md) 。

容器监控功能依赖 **监控平台** ，请先完成 “部署监控平台” 章节。

### 调整 bkmonitor
需要能读取 bcs 管理接口。
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
./scripts/config_monitor_bcs_token.sh  # 获取bcs token，写入monitor及log的custom.yaml文件。
helmfile -f 04-bkmonitor.yaml.gotmpl apply   # apply 仅增量更新
```

### 部署 bkmonitor-operator

``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
helmfile -f 04-bkmonitor-operator.yaml.gotmpl sync
```

然后在新窗口中检查 pod 稳定状态为 `Running` 即可：
``` bash
kubectl get pod -n bkmonitor-operator -w
```

未在 “节点管理” 中为所有 node 安装 agent 时，`bkmonitor-operator-bkmonitorbeat-daemonset` 系列 pod 的日志中会出现如下报错：
``` plain
failed to initialize libbeat: error initializing publisher: dial unix /data/ipc/ipc.state.report: connect: no such file or directory
```

在部署 gse agent 成功后，上述 pod 会逐步自动恢复。也可直接删除出错的 pod，会立刻重新创建。


## 启用蓝鲸 SLI 仪表盘
在配置了容器监控后，我们可以看到各 node 及各 pod 的一些基础监控属性。

您可能期望或者一些更详细的数据，则可以考虑启用 SLI Metrics。

>**提示**
>
>启用 SLI 后，会大幅提高 influxdb 及 elasticsearch 的磁盘及内存开销。建议额外准备 300G 磁盘及 4GB 内存余量。

### 检查 servicemonitor 资源
在 **中控机** 执行如下命令，预期看到 `bkmonitor-operator` 命名空间下的多个资源：
``` bash
kubectl get servicemonitors.monitoring.coreos.com -A
```
如果没有输出，请先配置容器监控。


### 配置指标上报

修改全局配置文件，启用指标上报。
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
# 启用指标上报：
case $(yq e '.serviceMonitor.enabled' environments/default/custom.yaml) in
  null)
    tee -a environments/default/custom.yaml <<< $'serviceMonitor:\n  enabled: true'
  ;;
  true)
    echo "environments/default/custom.yaml 中配置了 .serviceMonitor.enabled=true, 无需修改."
  ;;
  *)
    echo "environments/default/custom.yaml 中配置了 .serviceMonitor.enabled 为其他值, 请手动修改值为 true."
  ;;
esac
```

### 重启待上报指标的平台
为了实现指标上报，需要调整对应平台的 helm release。

在 中控机 执行如下命令：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
helmfile -f base-blueking.yaml.gotmpl apply  # 变更蓝鲸基础套餐
helmfile -f 03-bcs.yaml.gotmpl apply  # 变更容器管理平台
helmfile -f 04-bkmonitor.yaml.gotmpl apply  # 变更监控平台
helmfile -f 04-bklog-search.yaml.gotmpl apply  # 变更日志平台
```

如果看到如下报错，说明没有正确配置容器监控功能，请重新配置。
``` plain
Error: unable to build kubernetes objects from release manifest: unable to recognize "": no matches for kind "ServiceMonitor" in version "monitoring.coreos.com/v1"
```

### 导入仪表盘
登录监控平台，并切换到“仪表盘”界面。

点击左侧导航栏的“批量导出和导入”菜单，点击“点击导入”按钮，进入导入界面。

请下载我们如下文件导入:
* [bk_monitor-dashboards-sli-20221008.tar.gz](https://bkopen-1252002024.file.myqcloud.com/ce7/files/bk_monitor-dashboards-sli-20221008.tar.gz)

导入成功后，无需配置监控目标，点击完成结束整个导入流程。

然后请回到“仪表盘”界面，找到并进入 “[BlueKing] 各产品看板入口” 仪表盘。您可以从这里快速访问蓝鲸各平台的仪表盘。

>**提示**
>
>您可以收藏此仪表盘。刷新页面后，即可在左侧导航栏看到。

### 已知问题
目前部分 panel 加载时可能出现报错，请等待我们后续优化。
``` plain
请求系统'unify-query'错误，返回消息: {"error":"expanding series: db: process, err:[get cluster failed]"}，请求URL: http://bk-monitor-unify-query-http:10205/query/ts
```


# 日志平台

## 部署日志平台
在 中控机 执行
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
helmfile -f 04-bklog-search.yaml.gotmpl sync
# 在admin桌面添加应用，也可以登录后自行添加。
scripts/add_user_desktop_app.sh -u "admin" -a "bk_log_search"
```

## 访问日志平台
在桌面可以看到刚才添加的 “日志平台” 应用，访问前需先行配置 `bklog.$BK_DOMAIN` 域名的解析。

在 **中控机** 执行如下命令生成 hosts 文件的内容：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get pods -A -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].status.hostIP}')
IP1=$(ssh "$IP1" 'curl ip.sb')
echo $IP1 bklog.$BK_DOMAIN
```

## 配置容器日志采集

### 前置检查
容器日志采集功能需要在所有 k8s node （包括 master ）部署 gse-agent。请先在 “节点管理” 中完成 agent 安装。

容器日志采集功能依赖 **容器管理平台** （BCS），请先完成 [容器管理平台部署](install-bcs.md) 。

容器日志采集功能依赖 **日志平台** ，请先完成 “部署日志平台” 章节。

### 配置 bcs token
>**提示**
>
>如果此前已经完成了“配置容器监控”章节，则可跳过本步骤。

需要能读取 bcs 管理接口。
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
./scripts/config_monitor_bcs_token.sh  # 获取bcs token，写入monitor及log的custom.yaml文件。
```

### 部署 bklog-collector
修改全局配置文件，启用日志采集。
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
# 启用日志采集：
case $(yq e '.bkLogConfig.enabled' environments/default/custom.yaml) in
  null)
    tee -a environments/default/custom.yaml <<< $'bkLogConfig:\n  enabled: true'
  ;;
  true)
    echo "environments/default/custom.yaml 中配置了 .bkLogConfig.enabled=true, 无需修改."
  ;;
  *)
    echo "environments/default/custom.yaml 中配置了 .bkLogConfig.enabled 为其他值, 请手动修改值为 true."
  ;;
esac
```

部署或重启日志采集器：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
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
failed to initialize libbeat: error initializing publisher: dial unix /data/ipc/ipc.state.report: connect: no such file or directory
```

在部署 gse agent 成功后，上述 pod 会逐步自动恢复。也可直接删除出错的 pod，会立刻重新创建。

### 重启日志平台
1. 为了显示 “检索” -- “数据查询” 里的索引集。
2. 为了实现上述索引集里的 bklogsearch 采集项上报。

``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
helmfile -f 04-bklog-search.yaml.gotmpl apply
```

### 重启待采集日志的平台
为了实现采集项上报，需要调整对应平台的 helm release。

``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
helmfile -f base-blueking.yaml.gotmpl apply  # 变更蓝鲸基础套餐
helmfile -f 03-bcs.yaml.gotmpl apply  # 变更容器管理平台
helmfile -f 04-bkmonitor.yaml.gotmpl apply  # 变更监控平台
```

注：
1. 如需重启蓝鲸基础套餐的指定 helm release，请使用此命令： `helmfile -f base-blueking.yaml.gotmpl -l name=release名字 sync`。
2. bk-ci 的日志采集还在调试中，暂未预置采集项。
