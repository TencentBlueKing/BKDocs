# 部署 bkbase-v4

## 前置配置

创建自定义配置文件
```bash
install -d -m 0755 -v $INSTALL_DIR/bkbase-helmfile/environments/custom
touch $INSTALL_DIR/bkbase-helmfile/environments/custom/{keys.yaml,values.yaml}
```

### 配置蓝鲸 app code 对应的 secret

检查是否已生成蓝鲸 app code 对应的 secret
```bash
kubectl -n blueking get cm bkauth-config -ojsonpath='{.data.config\.yaml}' | yq .accessKeys.bk_bkdata
```
>如果输出为null，则需要执行以下 `【可选】生成蓝鲸 app code 对应的 secret` 部分

>**【可选】**生成蓝鲸 app code 对应的 secret
```bash
cd $INSTALL_DIR/blueking  # 进入工作目录
./scripts/generate_app_secret.sh environments/default/app_secret.yaml bk_bkdata
# 重新部署bkauth
helmfile -f base-blueking.yaml.gotmpl -l name=bk-auth sync
```

配置 appSecret
```bash
bkbase_token=$(yq '.appSecret.bk_bkdata' $INSTALL_DIR/blueking/environments/default/app_secret.yaml)
yq -i ".appToken=\"$bkbase_token\"" $INSTALL_DIR/bkbase-helmfile/environments/custom/keys.yaml
# 验证
yq ".appToken" $INSTALL_DIR/bkbase-helmfile/environments/custom/keys.yaml
```

### 配置 apigw 所需的 keypair

```bash
cd $INSTALL_DIR/blueking  # 进入工作目录
./scripts/generate_rsa_keypair.sh ./environments/default/bkapigateway_builtin_keypair.yaml
```
重新部署 API 网关
```bash
# 先删掉 job
kubectl -n blueking delete job bk-apigateway-wait-storages

cd $INSTALL_DIR/blueking  # 进入工作目录
# 部署
helmfile -f base-blueking.yaml.gotmpl -l name=bk-apigateway sync
```

配置公钥
```bash
jwtPubKeyB64=$(yq '.builtinGateway.bk-base.publicKeyBase64' $INSTALL_DIR/blueking/environments/default/bkapigateway_builtin_keypair.yaml)
yq -i ".jwtPubKeyB64=\"$jwtPubKeyB64\"" $INSTALL_DIR/bkbase-helmfile/environments/custom/keys.yaml
# 验证
yq ".jwtPubKeyB64" $INSTALL_DIR/bkbase-helmfile/environments/custom/keys.yaml
```

### 自定义配置

请根据自身环境信息修改对应的配置
#### values.yaml
```bash
BK_DOMAIN=$(yq e '.domain.bkDomain' $INSTALL_DIR/blueking/environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值

cat >> $INSTALL_DIR/bkbase-helmfile/environments/custom/values.yaml <<EOF
# paas url
paasUrl: $BK_DOMAIN

# image registry
registry: "hub.bktencent.com/dev"

# cmdb sync username。单租户为admin，多租户为bk_admin
cmdbUsername: "bk_admin"

# tenant，单租户可以把下面的 tenant 配置都注释掉
tenant:
  enabled: true
  default: "system"

# 配置库地址
configDb:
  host: "bk-mysql8.blueking.svc.cluster.local"
  port: 3306
  user: root
  password: "blueking"

# 指标链路维度发现使用的 redis
ddRedis:
  host: "bk-redis-master.blueking.svc.cluster.local"
  port: 6379
  user: ""
  password: "blueking"

# 默认kafka集群
kafka:
  host: bk-kafka.blueking.svc.cluster.local
  port: 9092
  user: ""
  password: ""

# 这里需要单独设置 bklog 的 es 集群, 用于租户初始化，这个集群不在bkbase的管辖范围内，bkbase仅写入
# es 索引生命周期管理由 bklog处理
bklogDefaultEs:
  host: "bk-elastic-elasticsearch-master.blueking.svc.cluster.local"
  user: "elastic"
  password: "blueking"
  port: "9200"

EOF
```

检查配置
```bash
yq . $INSTALL_DIR/bkbase-helmfile/environments/custom/values.yaml
```

### 确认 storageClass

在 中控机 检查当前 k8s 集群所使用的存储：
```bash
kubectl get sc
```

预期输出为：
```
NAME                      PROVISIONER                    RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
local-storage (default)   kubernetes.io/no-provisioner   Delete          WaitForFirstConsumer   false                  3d21h
```

如果输出的名称不是 local-storage，则需通过创建 custom.yaml 实现修改：
```bash
storageClassName="" # 填写上面的查询到的名称

cd $INSTALL_DIR/bkbase-helmfile
touch ./environments/custom/vm-values.yaml.gotmpl
yq -i ".vmstorage.persistentVolume.storageClass=\"$storageClassName\"" ./environments/custom/vm-values.yaml.gotmpl
```

## 部署

部署 kafka
```bash
cd $INSTALL_DIR/blueking  # 进入 工作目录
helmfile -f monitor-storage.yaml.gotmpl -l name=bk-kafka sync
```

部署 bkbase-v4
```bash
cd $INSTALL_DIR/bkbase-helmfile  # 进入 bkbase 部署目录
helmfile -f helmfile.yaml sync # 部署
```

## 租户初始化
```bash
cd $INSTALL_DIR/blueking
./scripts/bk-tenant-admin.sh init bkbase4 system
```

## 授权网关权限

```bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
./scripts/bk-tenant-admin.sh grant $tenant_supermanager_userid gw bk-base
```

# 部署监控日志套餐

## 监控平台

**监控「不」依赖 BKBase 场景有：**容器监控、业务监控（在线、对局等四线）、日志、APM。  

**监控跟 BKBase 相关的场景：**主机性能数据、进程数据、Agent失联告警、进程托管告警。

### 依赖

- bkmonitorbeat：>= 3.71.3653
- 节点管理：>= 2.4.8-pre-alpha.1950

### 启动监控存储服务

请在 **中控机** 执行：
```bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
helmfile -f monitor-storage.yaml.gotmpl -l name=bk-consul sync  # 部署监控依赖的存储
```

### 推荐：对接容器管理平台

容器监控功能依赖 **容器管理平台** （BCS），请先完成 [部署容器管理平台](#部署容器管理套餐) 。
```bash
./scripts/config_monitor_bcs_token.sh  # 获取bcs token，写入监控和日志的 custom-values 文件。
```

### 部署前配置

获取 gse slot
```bash
kubectl -n blueking exec deploy/bk-apigateway-dashboard -- curl -s http://bk-gse-cluster:28808/api/v2/cluster/service/register/slot -d '{"bk_plugin_name":"bkmonitorbeat","http_callback":"http://bk-monitor-api/api/v4/bk_gse_slot/","remark":"bkmonitorbeat http callback slot"}'
```

输出结果参考如下：
```
{"code":0,"message":"success","data":{"slot_id":**,"token":"TOKEN-***"}}
```

配置 gse slot

```bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
touch environments/default/bkmonitor-custom-values.yaml.gotmpl

gseSlotId=""
gseSlotToken=""

yq -i "
  .monitor.config.gseSlotId=\"$gseSlotId\" |
  .monitor.config.gseSlotToken=\"$gseSlotToken\"
" environments/default/bkmonitor-custom-values.yaml.gotmpl

# 检查结果
yq ".monitor.config.gseSlotId,.monitor.config.gseSlotToken" environments/default/bkmonitor-custom-values.yaml.gotmpl
```

获取基础计算平台 redis 信息
```bash
cd $INSTALL_DIR/blueking/  # 进入工作目录

# 提取配置
HOST=$(yq '.ddRedis.host' ../bkbase-helmfile/environments/custom/values.yaml)
PORT=$(yq '.ddRedis.port' ../bkbase-helmfile/environments/custom/values.yaml)
PASSWORD=$(yq '.ddRedis.password' ../bkbase-helmfile/environments/custom/values.yaml)

# 监控 values 配置
yq -i ".config.bkBaseRedisHost = \"$HOST\"" environments/default/bkmonitor-custom-values.yaml.gotmpl
yq -i ".config.bkBaseRedisPort = $PORT" environments/default/bkmonitor-custom-values.yaml.gotmpl
yq -i ".config.bkBaseRedisPassword = \"$PASSWORD\"" environments/default/bkmonitor-custom-values.yaml.gotmpl
```

### 部署监控

部署监控后台和 saas 以及监控数据链路组件：
```bash
helmfile -f 04-bkmonitor.yaml.gotmpl sync
```

### 授权网关权限

```bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
./scripts/bk-tenant-admin.sh grant $tenant_supermanager_userid gw bk-monitor
```

### 再次执行租户权限初始化动作
```bash
./scripts/bk-tenant-admin.sh init monitor system 
```

### 添加桌面图标

在  桌面添加应用，也可以登录后自行添加。同时设置为默认应用，所有新登录的用户都会自动添加此应用到桌面。
```bash
./scripts/add_user_desktop_app.sh -u $tenant_supermanager_userid -a 'bk_monitorv3,bk_fta_solution' # 现有用户添加桌面应用
./scripts/set_desktop_default_app.sh -a 'bk_monitorv3,bk_fta_solution' # 默认应用
```
### 推荐：容器监控数据上报

容器监控数据由 `bkmonitor-operator` release 采集，它提供了 daemonset 工作负载，在所有 k8s node （包括 master ）运行。数据上报由这些主机的 gse-agent 完成，故请先在 “节点管理” 中完成 agent 安装并确保状态正常。
```bash
helmfile -f 04-bkmonitor-operator.yaml.gotmpl sync  # 部署 k8s operator 提供容器监控数据
```

## 日志平台

注：多租户版本日志强依赖 elasticsearch 的状态为 `green`。否则会导致索引轮转失败

### 配置 ElasticSearch

>**提示**
为了快速部署，我们默认使用了蓝鲸共享的 `bk-elasticsearch` 单副本集群。 建议你自备多副本集群，并根据采集的原始日志量配置充足的存储。

目前由监控统一定时创建 ElasticSearch 索引，每 10 分钟执行一次。如果 es 自动创建了 `write_` 开头的索引，则会导致搜索时找不到预期的索引，因此需要禁止此行为。
可以在 **中控机** 执行如下命令配置蓝鲸预置 es 服务：
```bash
kubectl exec -it -n blueking bk-elastic-elasticsearch-master-0 -- curl -X PUT -u elastic:blueking http://127.0.0.1:9200/_cluster/settings -H 'Content-Type: application/json' -d '{"persistent":{"action":{"auto_create_index":"-write_*,*"}}}'
```
>**提示**
如果已经自动创建了 write_ 开头的索引，可以使用如下命令删除：
```bash
kubectl exec -it -n blueking bk-elastic-elasticsearch-master-0 -- curl -u elastic:blueking -X DELETE 'http://localhost:9200/write_*'
```

### 推荐：对接容器管理平台

之前在部署监控时已经写过配置文件了。可以检查下：
```bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
yq e '.configs.bcsApiGatewayToken' environments/default/bklog-search-custom-values.yaml.gotmpl
```
如果显示 `null`，请先 **部署监控平台** 并 **启用容器监控**。
### 部署日志采集器

`bklog-collector` release 定义了 CR： `bklogconfigs.bk.tencent.com`，并提供了 daemonset 工作负载，在所有 k8s node （包括 master ）运行。日志上报经由这些主机的 gse-agent 传递，故请先在 “节点管理” 中完成 agent 安装并确保状态正常。
```bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
helmfile -f 04-bklog-collector.yaml.gotmpl sync
```
如果启动失败，请在节点管理中检查 k8s 各 node 上的 GSE Agent 状态是否正常。

### 部署前配置

请根据自己环境 ES 副本数来修改采集项默认分片数和副本分片数（可选）

如果使用的是蓝鲸部署自带的 Elasticsearch 则可以忽略以下配置：
```bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
touch environments/default/bklog-search-custom-values.yaml.gotmpl

BKAPP_ES_SHARDS=1 # 分片数
BKAPP_ES_REPLICAS=0 # 副本分片数

yq e '.extraEnvVars = [
  {"name": "BKAPP_ES_REPLICAS", "value": "'${BKAPP_ES_REPLICAS}'"},
  {"name": "BKAPP_ES_SHARDS", "value": "'${BKAPP_ES_SHARDS}'"}
]' -i environments/default/bklog-search-custom-values.yaml.gotmpl
```

### 部署日志平台

>**提示**
请先确保 **监控平台** 正常运行，才能继续部署日志平台。

请在 **中控机** 执行：
```bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
helmfile -f 04-bklog-search.yaml.gotmpl sync  # 部署
./scripts/add_user_desktop_app.sh -u $tenant_supermanager_userid -a 'bk_log_search' # 现有用户添加桌面应用
./scripts/set_desktop_default_app.sh -a 'bk_log_search' # 默认应用
```

### 授权网关权限

```bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
./scripts/bk-tenant-admin.sh grant $tenant_supermanager_userid gw bk-log-search
```

### 访问日志平台

可以在桌面打开 “日志平台” 应用，此时位于 “检索” 界面，如果左上角 “索引集” 下拉列表为空。可以：
- 启用蓝鲸各平台预置的日志采集项

访问该链接 [蓝鲸各平台容器日志上报](https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.2/install-co-suite.md) 
，完成 “蓝鲸各平台容器日志上报” 章节。

- 采集日志

访问该链接 [日志平台](https://bk.tencent.com/docs/markdown/ZH/LogSearch/4.7/UserGuide/ProductFeatures/integrations-logs/logs_overview.md) , 查看 “日志数据接入概述” 章节

### 日志提取链路

开启步骤：
1. 通过脚本授权为 `django admin`。
```bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
./scripts/bk-tenant-admin.sh su $tenant_supermanager_userid log
```
2. 访问日志平台主页 `${BK_DOMAIN}/bklog`，点击管理即可看到 `提取链路管理` 选项。
3. 新增提取链路。

### 日志归档

参考文档 [日志归档](https://bk.tencent.com/docs/markdown/ZH/LogSearch/4.7/UserGuide/ProductFeatures/tools/log_archive.md)

### 更多功能

参考文档 https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.2/install-co-suite.md
