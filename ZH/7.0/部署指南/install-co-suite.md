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
bklogconfig_enabled="$(yq e '.bkLogConfig.enabled' environments/default/custom.yaml)"
if [ "$bklogconfig_enabled" = null ]; then
  tee -a environments/default/custom.yaml <<EOF
bkLogConfig:
  enabled: true
EOF
elif [ "$bklogconfig_enabled" = true ]; then
  echo "environments/default/custom.yaml 中配置了 .bkLogConfig.enabled=true, 无需修改."
else
  echo "environments/default/custom.yaml 中配置了 .bkLogConfig.enabled=$bklogconfig_enabled, 请手动修改值为 true."
fi
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
