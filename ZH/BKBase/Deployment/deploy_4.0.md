# 计算平台 4.0 部署指引

## 适用范围

该文档仅适用于计算平台 4.0 版本。

计算平台 4.0 的后台服务全部以 Helm Chart 形式交付，通过 [helmfile](https://github.com/helmfile/helmfile) 编排部署。本文档描述的是 `helmfile.yaml` 编排的 18 个子 helmfile，表中的序号即实际部署顺序：

| 序号 | 子 helmfile | Release | 说明 |
| --- | --- | --- | --- |
| 1 | `01-migration-apigw.yaml.gotmpl` | `bkbase-v4-migration-apigw` | API 网关注册与同步 |
| 2 | `02-migration-config-db.yaml.gotmpl` | `bkbase-v4-migration-config-db` | 配置库表结构迁移 |
| 3 | `03-server.yaml.gotmpl` | `bkbase-v4-server` | 核心 API 与 Controller |
| 4 | `04-webserver.yaml.gotmpl` | `bkbase-v4-webserver` | Web 后端服务 |
| 5 | `05-databus.yaml.gotmpl` | `bkbase-v4-databus-*` | 数据总线，按逻辑集群部署多个 release |
| 6 | `07-language-server.yaml.gotmpl` | `bkbase-bksql-language-server` | SQL 语法提示与补全 |
| 7 | `08-lakemgr.yaml.gotmpl` | `bkbase-v4-lakemgr` | 数据湖管理 |
| 8 | `09-jobnavi-scheduler.yaml.gotmpl` | `bkbase-v4-jobnavi-scheduler` | 离线任务调度器 |
| 9 | `10-jobnavi-runner.yaml.gotmpl` | `bkbase-v4-jobnavi-runner` | 离线任务执行器 |
| 10 | `11-promql.yaml.gotmpl` | `bkbase-bkpromqlapi` | PromQL 查询 API |
| 11 | `12-bksqlextend.yaml.gotmpl` | `bkbase-bksqlextend` | BKSQL 解析扩展 |
| 12 | `13-flinksql.yaml.gotmpl` | `bkbase-flinksql` | 实时计算 SQL 解析 |
| 13 | `14-flinksql-batch.yaml.gotmpl` | `bkbase-flinksql-batch` | 离线计算 SQL 解析 |
| 14 | `15-init.yaml.gotmpl` | `bkbase-v4-init` | 平台初始化与常驻初始化任务 |
| 15 | `19-databus-lake.yaml.gotmpl` | `bkbase-hdfsiceberg-inner-bcs1`、`bkbase-hdfspaimon-inner-bcs1` | 数据湖入库总线 |
| 16 | `06-queryengine.yaml.gotmpl` | `bkbase-v4-queryengine-*` | 查询引擎 |
| 17 | `21-hive.yaml.gotmpl` | `bkbase-hive-*` | Hive Metastore |
| 18 | `20-trino.yaml.gotmpl` | `bkbase-trino-*` | Trino 查询集群 |

> `helmfile` 目录下另有 `00-vm.yaml`、`16-metaapi.yaml`、`17-datalabapi.yaml`、`18-risingwave.yaml` 四个子 helmfile，未纳入 `helmfile.yaml` 的编排列表，不在本文档的部署范围内。

---

## 一、前置要求

### 1.1 蓝鲸平台服务

计算平台 4.0 不是独立系统，需要对接蓝鲸平台的多个服务。部署前请确认下述服务均已就绪，并取得对应的访问地址与凭据。

| 蓝鲸服务 | 计算平台的使用场景 | 需要取得的信息 |
| --- | --- | --- |
| 蓝鲸 PaaS / API 网关（APIGW） | 所有对外部蓝鲸服务的调用均经由网关，同时用于校验请求 JWT | 网关域名、APIGW 的 JWT 公钥 |
| 蓝鲸开发者中心 | 注册计算平台应用，取得应用凭据 | `bk_app_code`、`bk_app_secret` |
| 蓝鲸权限中心（bkiam） | 数据资源的权限申请与鉴权 | 网关路径、操作账号 |
| 配置平台（bk-cmdb） | 同步业务、模块、主机等元数据 | 网关路径、操作账号 |
| 管控平台（bk-gse） | 日志文件、自定义上报等数据源的采集下发 | 网关路径 |
| 节点管理（bk-nodeman） | 采集器部署与页面跳转 | 网关路径 |
| 监控平台（bkmonitorv3） | 指标数据链路对接、自监控数据上报 | 网关路径、上报 token |
| 日志平台（bk-log-search） | 日志检索链路对接 | 网关路径、日志平台使用的 ES 集群连接信息 |
| 用户管理（bk-user） | 用户信息与登录态校验 | 网关路径 |
| 流程服务（bk-itsm） | 权限与资源申请单据 | 网关路径 |
| 容器管理平台（BCS） | 实时计算 Flink、离线计算 Runner 的运行集群编排 | BCS 网关地址、集群 token、项目 ID/Code |

> 上述服务的部署请参考对应版本的蓝鲸部署文档。本文档不锁定蓝鲸平台的具体版本，只要求上述服务可用且网关路径可访问。

### 1.2 Kubernetes 与工具链

| 名称 | 版本要求 | 备注 |
| --- | --- | --- |
| Kubernetes | 待确认 | 计算平台后台服务的运行集群 |
| helm | ≥ 3.5 | `helmDefaults.waitForJobs` 依赖 Helm 3.5+ 特性 |
| helmfile | 待确认 | 需支持 `bases`、`helmfiles`、`--selector` |
| kubectl | 与集群版本匹配 | |

> **TODO**：补充 Kubernetes 与 helmfile 的最低版本要求。

`helmfile.yaml` 与 `env.yaml` 中均将 helm 可执行文件路径写死为 `/usr/local/bin/helm`。若实际路径不同，请调整 `helmBinary` 配置，或将 helm 软链到该路径。

### 1.3 依赖的开源组件

计算平台 4.0 **不负责部署下述开源组件**，需要由使用方自行准备（自建或复用已有集群），并在部署前取得连接信息。各组件与配置项的对应关系见 [第三章](#三配置参数)。

| 组件 | 版本要求 | 计算平台的使用场景 |
| --- | --- | --- |
| MySQL | 8.0 | 平台配置库（`bkdata_basic`、`bkdata_meta`、`bkbase_flow`、`bkdata_lab`、`bkdata_log` 等库）；另作为 Hive Metastore 的元数据库 |
| HDFS | 2.9.2 | 数据湖存储（Iceberg / Paimon）、离线计算落地、Flink checkpoint / savepoint、UDF 存储 |
| ZooKeeper | 待确认 | HDFS HA 选主；Beacon 数据源接入的配置下发 |
| Kafka | 待确认 | 数据总线的默认消息通道、数据入库前的缓冲 |
| VictoriaMetrics | 待确认 | 指标数据的默认存储；平台自监控指标的写入与查询 |
| Elasticsearch | 待确认 | 日志类数据的默认存储（与日志平台共用集群，索引生命周期由日志平台管理） |
| Redis | 待确认 | 维度发现缓存、CMDB 同步缓存、JDBC Puller 与 HTTP Puller 的状态、Flink checkpoint 元信息 |

> **TODO**：补充 ZooKeeper、Kafka、VictoriaMetrics、Elasticsearch、Redis 的版本要求。

关于 Redis 需要说明的是：计算平台按用途区分了 5 组 Redis 配置（`redis`、`ddRedis`、`cmdbRedis`、`jdbcPullerRedis`、`httpPullerRedis`）。这 5 组可以指向同一个 Redis 实例，也可以按用途拆分到不同实例以隔离负载，取决于实际的数据量规模。

---

## 二、部署准备

### 2.1 获取并解压部署包

> **TODO**：补充部署包的获取方式。

```bash
# 假设部署包已放置在 /data 目录
tar xf /data/bkbase-helmfile-4.0.tar.gz -C /data
cd /data/bkbase-helmfile
```

解压后的目录结构如下：

```
bkbase-helmfile/
├── helmfile.yaml                  # 编排入口，定义 18 个子 helmfile 的部署顺序
├── env.yaml                       # helm 路径与 helm 默认参数
├── defaults.yaml                  # 定义 environments 的 values 加载顺序
├── 01-migration-apigw.yaml.gotmpl # 各组件的子 helmfile
├── ...
├── environments/
│   ├── default/                   # 仓库内维护的公共基线，不要直接修改
│   └── custom/                    # 环境差异化配置，部署时由使用方填写
├── docs/                          # 部署注意事项、租户初始化等补充文档
└── scripts/
```

### 2.2 添加 Chart 仓库

所有 chart 从 `chartNameSpace` 指定的仓库拉取，缺省为 `blueking`。请先将 chart 仓库添加到 helm 并更新索引。

```bash
helm repo add blueking <chart 仓库地址>
helm repo update blueking
```

### 2.3 创建命名空间

`helmDefaults.createNamespace` 为 `false`，helmfile 不会自动创建命名空间，需要手动创建。命名空间由 `namespace` 配置项决定，缺省为 `bkbase`。

```bash
kubectl create namespace bkbase
```

### 2.4 域名解析

`globalIngress.disabled` 缺省为 `true`，即由 server 自身的 ingress 暴露 API。需要保证下述域名可解析到集群的 ingress 入口：

- `bkbase.${BK_DOMAIN}`：计算平台 4.0 的 API 与 Web 后端入口，由 `bkDomain` 配置项拼接得到。

集群内部服务之间通过 Kubernetes Service 直连，不依赖上述域名；但 Web 页面、SaaS 以及集群外的调用方需要能解析。配置方式（CoreDNS 解析、本地 hosts、DNS 记录）请参考对应版本的蓝鲸部署文档。

---

## 三、配置参数

### 3.1 配置文件加载顺序

`defaults.yaml` 定义了 values 的加载顺序，后加载的覆盖先加载的：

```
environments/default/values.yaml    →  environments/custom/values.yaml
environments/default/keys.yaml      →  environments/custom/keys.yaml
environments/default/version.yaml   →  environments/custom/version.yaml
```

因此**部署时只需在 `environments/custom/` 下填写与基线不同的配置项**，不要直接修改 `environments/default/` 下的文件——那是随部署包一起升级的公共基线，修改后会在升级时产生冲突。

`environments/custom/` 目录在部署包中可能不存在，需要先创建：

```bash
mkdir -p environments/custom
```

`missingFileHandler` 为 `Warn`，`custom` 下缺失的文件只会告警不会中断，但**下表中标记为「必填」的配置项在基线中是占位值（`xxxx`、`example.com` 或空字符串），不覆盖会导致服务无法正常工作**。

### 3.2 基础配置

填写在 `environments/custom/values.yaml`。

| 配置项 | 必填 | 说明 | 基线值 |
| --- | --- | --- | --- |
| `namespace` | 否 | 部署到哪个命名空间 | `bkbase` |
| `bkDomain` | 是 | 蓝鲸域名后缀，用于拼接 ingress 域名与页面跳转地址 | `example.com` |
| `registry` | 是 | 镜像仓库地址 | `mirrors.example.com` |
| `repoNameSpace` | 否 | 镜像仓库下的项目名 | `blueking` |
| `chartNameSpace` | 否 | helm chart 仓库名 | `blueking` |
| `timezone` | 否 | 时区 | `Asia/Shanghai` |
| `defaultGeogAreaCode` | 否 | 默认地域，可选 `inland` / `SEA` / `NA` | `inland` |
| `ipFamily` | 否 | IP 协议栈配置，双栈环境需配置 `ipFamilyPolicy` 与 `ipFamilies` | `{}` |
| `globalIngress.disabled` | 否 | 是否禁用全局 ingress | `true` |

### 3.3 平台自身的服务地址

| 配置项 | 必填 | 说明 | 基线值 |
| --- | --- | --- | --- |
| `bkbaseApiDomain` | 是 | 计算平台 4.0 API 的 ingress 域名 | `bkbase.example.com` |
| `bkbaseApiService` | 否 | API 的集群内 Service 地址，供集群内组件直连 | `bkbase-v4-api-service.bkbase:3000` |
| `bkbaseQueryApiDomain` | 否 | 查询引擎的集群内 Service 地址 | `bkbase-v4-queryengine-default-service.bkbase.svc.cluster.local:3000` |
| `queryengine_web_fqdn` | 是 | 查询引擎的 Web 访问域名 | `bkapi.example.com` |
| `v3BkbaseApiDomain` | 视情况 | 计算平台 3.x 的 API 域名。未部署 3.x 时该项无实际作用，同时需将 server 的 `syncV3MetaEnabled` 保持为 `false` | `bkbase-api.example.com` |

### 3.4 蓝鲸平台对接配置

| 配置项 | 必填 | 说明 | 基线值 |
| --- | --- | --- | --- |
| `paasUrl` | 是 | 蓝鲸 API 网关域名，`bk-gse` / `bkmonitorv3` / `bk-nodeman` / `bk-user` / `bk-log-search` 等调用地址均由此拼接 | `bkapi.example.com` |
| `bkapi.isLoginPath` | 是 | 登录态校验的 API 路径 | `api/c/compapi/v2/example/is_login/` |
| `iamBaseUrl` | 是 | 权限中心网关地址 | `https://bkapi/api/bkiam/prod/` |
| `cmdbBaseUrl` | 是 | 配置平台网关地址 | `https://bkapi/api/bk-cmdb/prod/` |
| `itsmBaseUrl` | 是 | 流程服务网关地址 | `https://bkapi/api/bk-itsm/prod/` |
| `dbmBaseUrl` | 是 | 数据库管理网关地址 | `https://bkapi/api/bkdbm/prod/` |
| `cmdbUsername` | 是 | CMDB 同步使用的账号，单租户填 `admin`，多租户填 `bk_admin` | `admin` |
| `iamUsername` | 是 | 权限中心操作账号 | `admin` |
| `metric.bkmonitorDomain` | 是 | 监控平台自监控数据的上报地址 | `127.0.0.1:4318` |
| `metric.bkmonitorToken` | 是 | 上报 token | `token` |
| `bkLogConfig.dataId` | 是 | 平台自身日志采集使用的 dataid，需在日志平台预先申请。注意各组件的 `dataIdForApi` / `dataIdForSys` 写死在各自的 `environments/default/*-values.yaml.gotmpl` 中，不读取全局值，需要时请按组件在 `custom` 下覆盖 | `1` |
| `nodemanAppStatePrefix` | 否 | 节点管理应用态前缀，仅多租户模式生效 | `""` |

### 3.5 应用凭据与加解密

填写在 `environments/custom/keys.yaml`。**这些是敏感配置，请纳入密钥管理，不要提交到代码仓库。**

| 配置项 | 必填 | 说明 |
| --- | --- | --- |
| `appCode` | 是 | 计算平台在蓝鲸开发者中心注册的应用 ID |
| `appToken` | 是 | 对应的应用 Secret |
| `jwtPubKeyB64` | 是 | APIGW 的 JWT 公钥，base64 编码后去掉换行：`cat pub_key.txt \| base64 \| tr -d '\n'` |
| `cryptRootKey` | 是 | 敏感配置（如存储集群密码、连接信息）加解密的根密钥 |
| `cryptRootIV` | 是 | 加解密的初始化向量 |
| `cryptInstanceKey` | 是 | 加解密的实例密钥 |

> `cryptRootKey` / `cryptRootIV` / `cryptInstanceKey` 一旦有数据落库就**不可更改**，否则已加密的配置无法解密。请在首次部署前确定并妥善保管。

### 3.6 依赖组件的连接配置

#### MySQL 8.0 — 平台配置库

server、webserver、migration-config-db、dataflow 等组件都读写这套配置库。

| 配置项 | 必填 | 说明 | 基线值 |
| --- | --- | --- | --- |
| `configDb.host` | 是 | 配置库地址 | `xxxx` |
| `configDb.port` | 是 | 端口 | `3306` |
| `configDb.user` | 是 | 账号，需具备建库建表权限（`02-migration-config-db` 要执行表结构迁移） | `root` |
| `configDb.password` | 是 | 密码 | `xxxx` |

#### MySQL — Hive Metastore 元数据库

`21-hive` 与 `20-trino` 使用，可与配置库共用同一个 MySQL 实例，但建议使用独立库。

| 配置项 | 必填 | 说明 | 基线值 |
| --- | --- | --- | --- |
| `mysql.host` | 是 | Metastore 元数据库地址 | `bkbase-mysql.bkbase.svc.cluster.local` |
| `mysql.port` | 是 | 端口 | `3306` |
| `mysql.user` | 是 | 账号 | `xxxx` |
| `mysql.password` | 是 | 密码 | `xxxx` |

#### Redis

5 组配置的字段结构一致，均为 `host` / `port` / `user` / `password`（`redis` 组不含 `user`）。可全部指向同一实例。

| 配置项前缀 | 必填 | 使用方与用途 |
| --- | --- | --- |
| `redis` | 是 | 租户默认 Redis 集群；实时计算 Flink checkpoint 的元信息管理 |
| `ddRedis` | 是 | 指标链路的维度发现缓存，server、databus、init 均使用 |
| `cmdbRedis` | 是 | CMDB 数据同步缓存，server 与 databus 使用；不配置时回退到 `ddRedis` |
| `jdbcPullerRedis` | 是 | databus JDBC Puller 的拉取位点与状态 |
| `httpPullerRedis` | 是 | databus HTTP Puller 的拉取位点与状态 |

#### HDFS 2.9.2

写入配置库作为租户的默认 HDFS 集群，同时供 Hive、Trino 读取。

| 配置项 | 必填 | 说明 | 基线值 |
| --- | --- | --- | --- |
| `hdfs.nameServices` | 是 | HA nameservice 名称 | `hdfs-default` |
| `hdfs.nnHosts` | 是 | NameNode 地址，多个用英文逗号拼接 | `""` |
| `hdfs.hostName1` / `hostName2` | 是 | 两个 NameNode 的主机名 | `""` |
| `hdfs.nameNodes` | 是 | NameNode 的逻辑名，如 `nn1,nn2` | `""` |
| `hdfs.rpcPort` | 是 | RPC 端口 | `9000` |
| `hdfs.serviceRpcPort` | 是 | Service RPC 端口 | `53310` |
| `hdfs.httpPort` | 是 | HTTP 端口 | `50070` |
| `hdfs.replication` | 是 | 副本数 | `2` |
| `hdfs.version` | 否 | HDFS 版本，仅作声明，当前未被 `environments/default` 下的模板引用 | `2.9.2` |
| `hdfs.zkHost` | 是 | HDFS HA 使用的 ZooKeeper 地址 | `""` |
| `hdfs.zkPort` | 是 | ZooKeeper 端口 | `2181` |

#### ZooKeeper

除上述 `hdfs.zkHost` / `hdfs.zkPort` 外，Beacon 数据源接入另有一组独立配置。

| 配置项 | 必填 | 说明 | 基线值 |
| --- | --- | --- | --- |
| `beaconZkHost` | 视情况 | Beacon 数据源接入的配置下发 ZooKeeper 地址，格式为 `host:port`。不使用 Beacon 接入时可不配置 | `bkbase-zookeeper.bkbase.svc.cluster.local:2181` |
| `beaconNodePath` | 视情况 | Beacon 配置在 ZooKeeper 上的节点路径 | `/config/databus/beacon/` |

#### Kafka

写入配置库作为租户的默认 Kafka 集群，数据总线以此作为消息通道。

| 配置项 | 必填 | 说明 | 基线值 |
| --- | --- | --- | --- |
| `kafka.host` | 是 | Broker 地址 | `xxxx` |
| `kafka.port` | 是 | 端口 | `9092` |
| `kafka.user` | 否 | 账号，无鉴权时留空 | `""` |
| `kafka.password` | 否 | 密码，无鉴权时留空 | `""` |

#### VictoriaMetrics

既是租户的默认指标存储，也承载平台自身的监控指标。

| 配置项 | 必填 | 说明 | 基线值 |
| --- | --- | --- | --- |
| `vm.insertHost` | 是 | vminsert 地址 | `bkbase-vm-vminsert.bkbase.svc.cluster.local` |
| `vm.insertPort` | 是 | vminsert 端口 | `8480` |
| `vm.selectHost` | 是 | vmselect 地址 | `bkbase-vm-vmselect.bkbase.svc.cluster.local` |
| `vm.selectPort` | 是 | vmselect 端口 | `8481` |
| `vm.commonSelectHost` | 是 | 公共查询入口地址 | `bkbase-vm-vmselect.bkbase.svc.cluster.local` |
| `vm.user` | 是 | 账号 | `xxxx` |
| `vm.password` | 是 | 密码 | `xxxx` |
| `metric.bkbasePrometheusWriteUrl` | 是 | 平台自监控指标的写入地址，需与上面的 vminsert 地址一致 | `http://bkbase-vm-vminsert.bkbase.svc.cluster.local:8480/insert/0/prometheus/api/v1/import/prometheus` |

#### Elasticsearch

日志类数据的默认存储。该集群与蓝鲸日志平台共用，**计算平台只负责写入，索引的生命周期管理由日志平台处理**。

| 配置项 | 必填 | 说明 | 基线值 |
| --- | --- | --- | --- |
| `bklogDefaultEs.host` | 是 | ES 地址 | `bk-elastic-elasticsearch-master.blueking.svc.cluster.local` |
| `bklogDefaultEs.port` | 是 | 端口 | `9200` |
| `bklogDefaultEs.user` | 是 | 账号 | `xxxx` |
| `bklogDefaultEs.password` | 是 | 密码 | `xxx` |

### 3.7 计算与资源编排配置

这部分配置服务于实时计算、离线计算与数据湖能力。基线中多为空值，**若不使用对应能力可暂不配置，但相关功能不可用**。

| 配置项 | 说明 |
| --- | --- |
| `resManage.bcsBaseUrl` | BCS 网关基础 URL |
| `resManage.computeBcsToken` | 访问 BCS 集群的 token，实时计算与离线计算共用 |
| `resManage.bcsGeneratorToken` | 生成 BCS 用户临时 token，用于获取项目集群信息 |
| `resManage.bkbaseBcsProjectId` / `bkbaseBcsProjectCode` | 计算平台注册到 BCS 的项目标识，用于聚合平台所有 k8s 集群的 worker IP |
| `resManage.jobnaviRunnerCluster.server` / `token` / `namespace` | 离线 Runner 的部署目标集群 |
| `dataflow.stream.flinkImage` / `flinkCodeImage` / `pyflinkImage` / `hadoopClientImage` | 实时计算使用的镜像 |
| `dataflow.stream.metric.kafkaNsName` / `kafkaTopic` | 实时计算指标上报的 Kafka 通道与 topic |
| `dataflow.metricConfig.batchMetricsTable` / `streamMetricsTable` | 任务日志中展示资源指标所用的结果表 |
| `cdc.image` | Flink CDC 镜像 |
| `cdc.metricKafkaNsName` / `metricKafkaTopic` | CDC 指标上报通道 |
| `cdc.checkpointsDir` / `savepointsDir` | CDC 的 HDFS checkpoint / savepoint 路径 |
| `cdc.cluster.server` / `token` / `namespace` | CDC 任务的运行集群 |
| `trino.host` / `port` / `user` / `password` / `auth` / `ssl` / `version` | 查询引擎连接 Trino 的配置 |

### 3.8 多集群与多租户

| 配置项 | 说明 |
| --- | --- |
| `server.clusters` | server 实例列表，缺省 `["default"]`。需要内外网 API 分离等场景时追加集群名，详见部署包内 `docs/deployment_notes.md` |
| `databus.clusters` | 数据总线的逻辑集群及各自的 chart 版本 |
| `queryengine.clusters` | 查询引擎集群列表 |
| `datalab.trino.clusters` / `datalab.hive.clusters` | Trino 与 Hive 的集群列表 |
| `tenant.enabled` | 是否启用多租户，缺省 `false` |
| `tenant.default` | 默认租户名，缺省 `default` |

### 3.9 Chart 版本

各组件的 chart 版本在 `environments/default/version.yaml` 中定义，随部署包一起交付，通常不需要调整。如需为某个组件指定版本，在 `environments/custom/version.yaml` 中覆盖对应字段。

---

## 四、执行部署

### 4.1 部署前预检

先用 `helmfile template` 渲染全部 release，确认模板能正常渲染、配置项无遗漏，且不会实际变更集群。

```bash
cd /data/bkbase-helmfile
helmfile -f helmfile.yaml template > /tmp/bkbase-v4-rendered.yaml
```

渲染结果中若仍存在 `xxxx`、`example.com` 等占位值，说明对应配置项没有在 `environments/custom/` 下覆盖，请回到[第三章](#三配置参数)补齐。

再用 `helmfile diff` 确认将要发生的变更。该命令依赖 [helm-diff](https://github.com/databus23/helm-diff) 插件，未安装请先安装：

```bash
helm plugin install https://github.com/databus23/helm-diff
helmfile -f helmfile.yaml diff
```

### 4.2 一键部署

`helmfile.yaml` 已按依赖关系编排好 18 个子 helmfile 的顺序，一条命令即可完成全部部署：

```bash
cd /data/bkbase-helmfile
helmfile -f helmfile.yaml sync
```

各子 helmfile 的 `helmDefaults` 来自 `env.yaml`，其中 `wait` 与 `waitForJobs` 均为 `true`，helmfile 会等待每个 release 的资源与 Job 就绪后才继续下一个，因此整体耗时较长。单个 Kubernetes 操作的超时由 `env.yaml` 的 `helmDefaults.timeout` 控制，缺省 360 秒；若依赖组件响应慢或镜像拉取耗时长导致超时，可适当调大。部署过程中请勿中断。

### 4.3 关于部署顺序

部署顺序由 `helmfile.yaml` 的 `helmfiles` 列表决定，其中两处顺序是有依赖约束的，调整时需要注意：

- **queryengine 必须在 init 之后**：查询引擎依赖 `15-init` 完成的平台初始化，因此 `06-queryengine` 被排在 `15-init` 之后，而非按编号排在第 6 位。
- **queryengine → hive → trino**：三者必须按此顺序部署，对应列表中的 `06-queryengine` → `21-hive` → `20-trino`。

更多注意事项见部署包内的 `docs/deployment_notes.md`。

---

## 五、部署验证

### 5.1 检查 release 状态

```bash
helm list -n bkbase
```

所有 release 的状态应均为 `deployed`。release 总数会多于 18 个：databus、queryengine、hive、trino、server 会按各自的集群列表渲染出多个 release，databus-lake 固定渲染 2 个。

### 5.2 检查 Pod 状态

```bash
kubectl get pods -n bkbase
```

### 5.3 检查 API 可用性

计算平台 4.0 没有全局健康检查入口，可用 dataflow 模块的健康检查接口确认 API 服务已正常提供服务：

```bash
# 集群内访问
kubectl run -n bkbase curl-test --rm -it --image=curlimages/curl --restart=Never -- \
  curl -s http://bkbase-v4-api-service:3000/v4/dataflow/flow/flows/healthz/

# 集群外通过 ingress 访问，同时验证域名解析与 ingress 转发
curl -s http://bkbase.${BK_DOMAIN}/v4/dataflow/flow/flows/healthz/
```

集群外访问不通但集群内正常，说明问题在域名解析或 ingress，请回到 [2.4 域名解析](#24-域名解析) 检查。

---

## 六、常见运维操作

### 6.1 单个组件重新部署

调整某个组件的配置后，只需同步该组件对应的子 helmfile，无需整体重跑：

```bash
# 例：只重新部署 server
helmfile -f 03-server.yaml.gotmpl sync
```

对于按集群渲染出多个 release 的组件（databus、queryengine、hive、trino、server），可用 `-l` 选择具体 release：

```bash
# 例：只重新部署 eslog-1 这个总线集群
helmfile -f 05-databus.yaml.gotmpl -l name=bkbase-v4-databus-eslog-1 sync
```

### 6.2 版本升级

1. 解压新版本部署包到新目录；
2. 将旧目录的 `environments/custom/` 整体拷贝到新目录；
3. 对比新旧 `environments/default/values.yaml`，确认新增或语义变更的配置项，按需在 `custom` 中补充；
4. 执行 `helmfile -f helmfile.yaml diff` 确认变更范围；
5. 执行 `helmfile -f helmfile.yaml sync`。

### 6.3 初始化租户

新增租户需要初始化默认资源并为其部署独立的总线集群，步骤见部署包内的 `docs/init_tenant.md`。

### 6.4 卸载

```bash
helmfile -f helmfile.yaml destroy
```

`destroy` 只删除 helm release，不会删除 PVC、配置库中的数据以及依赖组件中已落地的数据，这些需要按需手动清理。
