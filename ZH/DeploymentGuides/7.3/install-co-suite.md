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
yq -i ".appToken=\"$bkbase_token\"" $INSTALL_DIR/bkbase-helmfile/environments/default/keys.yaml
# 验证
yq ".appToken" $INSTALL_DIR/bkbase-helmfile/environments/default/keys.yaml
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
yq -i ".jwtPubKeyB64=\"$jwtPubKeyB64\"" $INSTALL_DIR/bkbase-helmfile/environments/default/keys.yaml
# 验证
yq ".jwtPubKeyB64" $INSTALL_DIR/bkbase-helmfile/environments/default/keys.yaml
```

### 自定义配置

请根据自身环境信息修改对应的配置

```bash
BK_DOMAIN=$(yq e '.domain.bkDomain' $INSTALL_DIR/blueking/environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值

cat >> $INSTALL_DIR/bkbase-helmfile/environments/custom/values.yaml <<EOF
# paas url
paasUrl: bkapi.$BK_DOMAIN

# image registry
registry: "hub.bktencent.com/dev"
# charts namespace

# tenant
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

## 验证数据流

部署完 bkbase 后，执行以下命令验证 `核心的指标链路`

```bash
# 本质上就是构造了一个数据，模拟蓝鲸监控调用的流程，然后模拟他们通过 apigw 访问 bkbase 的接口能查到数据
kubectl -n bkbase exec deploy/bkbase-v4-api-deployment -c bkbase-v4-api-container -- ./bkbase_cli install-test vmraw
```

参考输出如下：
```
Creating resources...
2025-09-15T08:34:52.880172Z  INFO clients::api::client: 214: Resp url=http://bkapi.bkce7.bktencent.com/api/bk-base/prod/v4/apply/ status=200 OK text={"result":true,"code":"00","data":null,"message":null,"errors":null,"trace_id":"485fb3fccaeda957dad9ff83815bd041","span_id":""}
Done
Waiting resources to be ready...
2025-09-15T08:34:52.883061Z  INFO controller_client::resource: 138: Wait for kind: DataId ObjectMeta { tenant: "system", namespace: "bkmonitor", name: "bkbase_test_env_vmraw", labels: {}, annotations: {"dataId": "524288", "index0": "524288"} } to be ready
2025-09-15T08:34:54.885977Z  INFO controller_client::resource: 138: Wait for kind: DataId ObjectMeta { tenant: "system", namespace: "bkmonitor", name: "bkbase_test_env_vmraw", labels: {}, annotations: {"dataId": "524288", "index0": "524288"} } to be ready
2025-09-15T08:34:56.888992Z  INFO controller_client::resource: 138: Wait for kind: DataId ObjectMeta { tenant: "system", namespace: "bkmonitor", name: "bkbase_test_env_vmraw", labels: {}, annotations: {"dataId": "524288", "index0": "524288"} } to be ready
2025-09-15T08:34:58.891641Z  INFO controller_client::resource: 138: Wait for kind: DataId ObjectMeta { tenant: "system", namespace: "bkmonitor", name: "bkbase_test_env_vmraw", labels: {}, annotations: {"dataId": "524288", "index0": "524288"} } to be ready
2025-09-15T08:34:58.892349Z  INFO controller_client::resource: 138: Wait for kind: ResultTable ObjectMeta { tenant: "system", namespace: "bkmonitor", name: "bkbase_test_env_vmraw", labels: {}, annotations: {"ResultTableId": "591_bkbase_test_env_vmraw", "index0": "591_bkbase_test_env_vmraw"} } to be ready
2025-09-15T08:34:58.893071Z  INFO controller_client::resource: 138: Wait for kind: VmStorageBinding ObjectMeta { tenant: "system", namespace: "bkmonitor", name: "bkbase_test_env_vmraw", labels: {}, annotations: {"index0": "ResultTable/bkmonitor/bkbase_test_env_vmraw", "index1": "VmStorage/bkmonitor/vm_default"} } to be ready
2025-09-15T08:34:58.893748Z  INFO controller_client::resource: 138: Wait for kind: Databus ObjectMeta { tenant: "system", namespace: "bkmonitor", name: "bkbase_test_env_vmraw", labels: {}, annotations: {"Cluster": "DatabusCluster/bkmonitor/vmraw-1"} } to be ready
Done
Sending test data to Kafka...
Done
Waiting for 5 seconds...
2025-09-15T08:35:04.035265Z  INFO clients::api::client: 214: Resp url=http://bkapi.bkce7.bktencent.com/api/bk-base/prod/v3/queryengine/query_sync/ status=200 OK text={"result":true,"code":"00","data":{"total_records":1,"totalRecords":1,"result_table_scan_range":null,"total_record_size":0,"select_fields_order":[],"device":"vm","cluster":"vm_default","sql":"{result_table_id='591_bkbase_test_env_vmraw'}","result_table_ids":["591_bkbase_test_env_vmraw"],"resource_use_summary":null,"source":null,"list":[{"stats":{"seriesFetched":"1","executionTimeMsec":1},"data":{"resultType":"matrix","result":[{"metric":{"__name__":"test_metric_value","bcs_cluster_id":"BCS-K8S-11111","db":"default","result_table_id":"591_bkbase_test_env_vmraw","src":"127.0.0.1"},"values":[[1757924704,"1"],[1757925304,"1"]]}]},"isPartial":false,"status":"success"}],"bksql_call_elapsed_time":0,"result_schema":[],"timetaken":0.006,"stage_elapsed_time_mills":{"check_forbidden":0,"check_permission":0,"execute_task":2,"check_syntax":0,"match_connector":0,"check_semantic":0,"match_route_rule":0,"match_storage":4},"external_api_call_time_mills":{"bkbase_meta_api":4.38194},"trino_cluster_host":"","bk_biz_ids":[]},"message":null,"errors":null,"trace_id":"80cfbb9d062f7a3b3c9f1eff7e4daa30","span_id":""}
Query result: {"total_records":1,"totalRecords":1,"result_table_scan_range":null,"total_record_size":0,"select_fields_order":[],"device":"vm","cluster":"vm_default","sql":"{result_table_id='591_bkbase_test_env_vmraw'}","result_table_ids":["591_bkbase_test_env_vmraw"],"resource_use_summary":null,"source":null,"list":[{"stats":{"seriesFetched":"1","executionTimeMsec":1},"data":{"resultType":"matrix","result":[{"metric":{"__name__":"test_metric_value","bcs_cluster_id":"BCS-K8S-11111","db":"default","result_table_id":"591_bkbase_test_env_vmraw","src":"127.0.0.1"},"values":[[1757924704,"1"],[1757925304,"1"]]}]},"isPartial":false,"status":"success"}],"bksql_call_elapsed_time":0,"result_schema":[],"timetaken":0.006,"stage_elapsed_time_mills":{"check_forbidden":0,"check_permission":0,"execute_task":2,"check_syntax":0,"match_connector":0,"check_semantic":0,"match_route_rule":0,"match_storage":4},"external_api_call_time_mills":{"bkbase_meta_api":4.38194},"trino_cluster_host":"","bk_biz_ids":[]}
Done
Querying for DD...
2025-09-15T08:35:04.053994Z  INFO clients::api::client: 214: Resp url=http://bkapi.bkce7.bktencent.com/api/bk-base/prod/v4/dd/?bk_app_code=bk_bkdata&bk_app_secret=f6a03dc5-626d-4837-bebe-627b97d37060&bk_username=admin&bkdata_authentication_method=inner&storage=vm&result_table_id=591_bkbase_test_env_vmraw&no_value=true status=200 OK text={"result":true,"code":"00","data":{"metrics":[{"name":"test_metric","update_time":1757924293771,"dimensions":[{"name":"src","update_time":1757924293771,"values":[]},{"name":"bcs_cluster_id","update_time":1757924293771,"values":[]},{"name":"result_table_id","update_time":1757924293771,"values":[]}]}]},"message":null,"errors":null,"trace_id":"51bafb8224faa2fbfcdce80d3d594d21","span_id":""}
DD result: {"metrics":[{"name":"test_metric","update_time":1757924293771,"dimensions":[{"name":"src","update_time":1757924293771,"values":[]},{"name":"bcs_cluster_id","update_time":1757924293771,"values":[]},{"name":"result_table_id","update_time":1757924293771,"values":[]}]}]}
Done
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

### 部署监控

部署监控后台和 saas 以及监控数据链路组件：
```bash
helmfile -f 04-bkmonitor.yaml.gotmpl sync
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

### 修改 ES 分片数量（可选）

默认的 es 主分片数量为 `1` ，副本分片数量为 `0` （适用于单 es 实例环境），如果有更改数据，请参考以下配置：
- BKAPP_ES_REPLICAS：副本分片数量
- BKAPP_ES_SHARDS：主分片数量

```bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
yq -i '.extraEnvVars = [{"name": "BKAPP_ES_REPLICAS", "value": "0"},{"name": "BKAPP_ES_SHARDS", "value": "1"}]' environments/default/bklog-search-custom-values.yaml.gotmpl
yq e '.extraEnvVars' environments/default/bklog-search-custom-values.yaml.gotmpl # 查看配置是否生效
```

注意：该操作只对初次部署生效，后续无法修改

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

### 访问日志平台

需要配置域名 `bklog.$BK_DOMAIN`，操作步骤已经并入《部署步骤详解 —— 后台》 文档 的 “[配置用户侧的 DNS](https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.2/manual-install-bkce.md#hosts-in-user-pc)” 章节。
配置成功后，即可在桌面打开 “日志平台” 应用了。
此时位于 “检索” 界面，如果左上角 “索引集” 下拉列表为空。可以：
- 启用蓝鲸各平台预置的日志采集项1. 完成下文的 “蓝鲸各平台容器日志上报” 章节。
- 采集主机日志1. 在节点管理中，为待采集主机安装 `bkunifylogbeat` 插件。
	2. 在日志平台的 “管理” —— “日志采集” 界面添加采集项。
- 采集容器环境日志 （需要完成 “对接容器管理平台” 章节）- 蓝鲸集群（BCS-K8S-00000）1. 完成 “部署容器日志采集器” 章节。
		2. 在日志平台的 “管理” —— “日志采集” 界面添加采集项。
	- 其他集群1. TODO 其他集群容器日志采集步骤。

### 更多功能

参考文档 https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.2/install-co-suite.md

### 问题