# 使用腾讯云云服务部署蓝鲸7.1

蓝鲸 7.1 相对于 蓝鲸 6.X 最大的区别在于部署方式的不同，蓝鲸 7.1 是基于 Kubernetes 改造的全平台容器化形态。

本教程描述了如何针对云原生服务场景进行蓝鲸 7.1 部署。

## 1. 资源准备

### 1.1. 域名和证书

#### 1.1.1 域名规则与规划

蓝鲸平台均需通过域名访问，默认使用 paas.bktencent.com 将作为蓝鲸的主站域名（下文简称为 **BK_DOMAIN**），**BK_DOMAIN** 也用于拼接蓝鲸其他系统的访问域名，也是蓝鲸统一登录所需的 cookie 域名。

**BK_DOMAIN** 将作为蓝鲸的主站域名，请提前规划您的主站域名：

- 全量域名清单：
```plain
# 主站域名
paas.bktencent.com  
# 基础套餐各个模块使用的域名
bkpaas.paas.bktencent.com
bkuser.paas.bktencent.com
bkuser-api.paas.bktencent.com
bkapi.paas.bktencent.com
apigw.paas.bktencent.com
bkiam.paas.bktencent.com
bkiam-api.paas.bktencent.com
bkssm.paas.bktencent.com
apps.paas.bktencent.com
cmdb.paas.bktencent.com
job.paas.bktencent.com
jobapi.paas.bktencent.com
bkrepo.paas.bktencent.com
docker.paas.bktencent.com
helm.paas.bktencent.com
bknodeman.paas.bktencent.com
bkmonitor.paas.bktencent.com
bklog.paas.bktencent.com
lesscode.paas.bktencent.com
# bcs 使用的域名 
bcs.paas.bktencent.com
bcs-cc.paas.bktencent.com
bcs-api.paas.bktencent.com
# bkci 使用的域名
devops.paas.bktencent.com
codecc.paas.bktencent.com
bktbs.paas.bktencent.com
```

#### 1.1.2 证书准备

- **可选步骤**。不启用 HTTPS 或如果有企业级 SSL 证书，可以忽略这一步
- SSL 证书需要准备泛域名证书，需包含 <u><b>bpaas.bktencent.com</b></u> 和 <u><b>\*.paas.bktencent.com</b></u>，可以使用 [acme.sh](https://github.com/acmesh-official/acme.sh) 签发，签发参数如下:
```bash
# 安装步骤请参考：https://github.com/acmesh-official/acme.sh#1-how-to-install
acme.sh --issue --domain 'paas.bktencent.com' --domain '*.paas.bktencent.com' ...
```

#### 1.1.3 信息记录（便于后续步骤配置中使用）

- BK_DOMAIN 取值为 **主站域名**
```bash
BK_DOMAIN=paas.bktencent.com
```
- 下载证书文件供后续使用
  - 参考：腾讯云-负载均衡-证书要求及转换证书格式-操作指南：[https://cloud.tencent.com/document/product/214/6155](https://cloud.tencent.com/document/product/214/6155)

### 1.2. TKE 标准集群

#### 1.2.1. 创建集群

> 使用腾讯云容器服务的 [TKE 标准集群](https://cloud.tencent.com/document/product/457/6759)作为容器服务使用，便于降低搭建与运维集群的成本。
> 购买前建议先阅读腾讯云的 [云上容器应用部署 Check List](https://cloud.tencent.com/document/product/457/41497)

1. 集群信息。创建 TKE 标准集群集群：https://console.cloud.tencent.com/tke2/cluster/create ，配置参考：

| 名称 | 选项 / 配置 |
| -- | -- | 
| 集群名称|按需填写|
| 新增资源所属项目|按需填写|
| Kubernetes 版本| 1.20.6 |
| 运行时组件|docker|
| 所在地域 | 按需选择 |
| 集群网络 | 按需选择 |
| 容器网络插件|Global Router|
| 容器网络| 假设此处 node 网络为10.0.0.0/0，容器网络分配为 172.16.0.0/16，不跟集群所在 VPC 网络冲突即可 |
| 节点Pod分配方式| 建议：1024 个 Service/集群、128 个 Pod/节点、504 个节点/集群（SaaS 较多的场景，可以考虑扩大单节点 Pod 数量上限、集群内 Service 数量上限 |
| 镜像提供方 | 公共镜像 |
| 操作系统|TencentOS Server2.4（TK4）/ CentOS 7.8 64bit |
| 以下选项在<u>高级设置</u>内|请展开高级设置进行设置|
|运行时版本|19.3|
| 其他 | 默认即可 | 
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image.png)


2. 选择机型：此处**仅需**新增 1~2 台 **2C4G** 作为 **ingress 专用节点**：

| 名称 | 选项 / 配置 |
| -- | -- | 
|节点来源|新增节点|
|集群类型|托管集群（托管集群的 Master 和 Etcd 由腾讯云进行管理和维护）|
|集群规格|L5（开启自动升配）|
|计费模式 | 包年包月（费用较优惠） |
|Worker 节点配置|新增数据盘（大小建议200G，格式化并挂载 /var/lib/docker），**不**分配免费公网IP（见下图）<br \>2. 此处不添加其他机型，其余机器使用节点池（便于随时扩容，节点配置有版本记录可以复用）|
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-1.png)
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-2.png)

3. 云服务器配置

| 名称 | 选项 / 配置 |
| -- | -- | 
| qGPU共享 | 不开启 |
| 容器目录 | 设置容器和镜像存储目录，存储到数据盘：/var/lib/docker |
| 安全组 | - 安全组规则需包含：入站 NODE 网络+容器网络：ALL；出站 0.0.0.0/0: ALL<br \>- 更详细的规则可参考：[容器服务安全组设置](https://cloud.tencent.com/document/product/457/9084#.E7.8B.AC.E7.AB.8B.E9.9B.86.E7.BE.A4-master-.E9.BB.98.E8.AE.A4.E5.AE.89.E5.85.A8.E7.BB.84.E8.A7.84.E5.88.99) |
| 登录方式 | 使用秘钥关联，方便后续新增机器自动免密码登陆 |
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-3.png)

4. 组件配置
  - 默认即可
5. 设置 **ingress 专用节点** 的[出网带宽](https://cloud.tencent.com/document/product/213/43793#:~:text=%E5%87%BA%E7%BD%91%E5%B8%A6%E5%AE%BD%EF%BC%9A%E4%BB%8E%E4%BA%91%E6%9C%8D%E5%8A%A1%E5%99%A8%E6%B5%81%E5%87%BA%E7%9A%84%E5%B8%A6%E5%AE%BD%E3%80%82%E4%BE%8B%E5%A6%82%EF%BC%8C%E4%BA%91%E6%9C%8D%E5%8A%A1%E5%99%A8%E5%AE%9E%E4%BE%8B%E5%AF%B9%E5%A4%96%E6%8F%90%E4%BE%9B%E8%AE%BF%E9%97%AE%E3%80%82)：
  - 访问腾讯云 - 云服务器 控制台：https://console.cloud.tencent.com/cvm
  - 找到此处新增的 ingress 专用节点，按需调整目标带宽上限
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-4.png)

#### 1.2.2 信息记录（便于后续步骤配置中使用）
- 访问获取：`https://console.cloud.tencent.com/tke2/cluster/sub/list/nodeManage/node?rid=33&clusterId=<你的TKE集群id>`

| 名称 | ip | 端口（固定，无需更改） |
| -- | -- |  -- |
| ingress 专用节点 | 10.0.x.x | 32080 |
| ingress 专用节点 | 10.0.x.x | 32080 |

####  1.2.3. 节点池配置：新建普通节点池

> 为帮助您高效管理 Kubernetes 集群内节点，腾讯云容器服务 TKE 引入[节点池](https://cloud.tencent.com/document/product/457/43719)概念。借助节点池基本功能，您可以方便快捷地创建、管理和销毁节点，以及实现节点的动态扩缩容

新增两个节点池：**基础节点池** 和 **应用节点池**，此处以两个节点池的视角来做说明。

> 应用节点池为单独分配给 SaaS 专用 node 节点池

新建普通节点池：`https://console.cloud.tencent.com/tke2/cluster/sub/list/nodeManage/nodepool?rid=33&clusterId=<你的TKE集群id>&np=default`

![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-5.png)

#####  1.2.3.1. 新建基础集群的节点池
| 名称 | 选项 / 配置 |
| -- | -- | 
| 节点池类型 | 普通节点池 |
| 节点池名称 | 基础节点池 |
| 操作系统 | TencentOS Server2.4（TK4）/ CentOS 7.8 64bit |
| 计费模式 | 按量计费，包年包月节点池不能打开自动扩缩容 |
| 机型配置 | 16C64G，新增数据盘（大小建议200G，格式化并挂载 /var/lib/docker），**不**分配免费公网IP |
| 登录方式 | 使用秘钥关联，方便后续新增机器自动免密码登陆 |
| 数量 | 4 | 
| 节点数量范围 | 4 ~ 6 |
| 以下为：高级设置||
| 容器目录 | 设置容器和镜像存储目录，存储到数据盘：/var/lib/docker |
| 自定义数据 | 填入下面的脚本 | 
| 其他 | 默认即可 | 
```bash
# BK_DOMAIN 取值请参考 1.1.3 章节
yum -y -q install jq
jq '. += {"insecure-registries": ["docker.<BK_DOMAIN>"]}' /etc/docker/daemon.json > /tmp/daemon.json 
cp /tmp/daemon.json /etc/docker/daemon.json
systemctl restart dockerd.service
```

配置示例截图：

![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-6.png)
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-7.png)

#####  1.2.3.2. 新建应用集群的节点池
| 名称 | 选项 / 配置 |
| -- | -- | 
| 节点池类型 | 普通节点池 |
| 节点池名称 | 应用节点池 |
| 操作系统 | TencentOS Server2.4（TK4）/ CentOS 7.8 64bit |
| 计费模式 | 按量计费，包年包月节点池不能打开自动扩缩容 |
| 机型配置 | 16C64G，新增数据盘（大小建议200G，格式化并挂载 /var/lib/docker），**不**分配免费公网IP |
| 登录方式 | 使用秘钥关联，方便后续新增机器自动免密码登陆 |
| 数量 | 2 | 
| 节点数量范围 | 2 ~ 4 |
| 以下为：高级设置||
| 容器目录 | 设置容器和镜像存储目录，存储到数据盘：/var/lib/docker |
| Labels | dedicated=bkSaaS |
| Taints | dedicated=bkSaaS:PreferNoSchedule |
| 自定义数据 | 填入下面的脚本，注意`docker.paas.bktencent.com`替换为docker实际域名 | 
| 其他 | 默认即可 | 
```bash
yum -y -q install jq
# BK_DOMAIN 取值请参考 1.1.3 章节
BK_DOMAIN=paas.bktencent.com
jq --arg bk_domain "docker.$BK_DOMAIN" '. += {"insecure-registries": [$bk_domain]}' /etc/docker/daemon.json > /tmp/daemon.json 
cp /tmp/daemon.json /etc/docker/daemon.json
systemctl restart dockerd.service
```

配置示例截图：

![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-8.png)
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-9.png)

#####  1.2.3.3. *可选* 启用弹性伸缩 AS，并设置全局配置打开自动缩容

- 启用弹性伸缩 AS，详细参考官方文档：[五分钟创建伸缩方案](https://cloud.tencent.com/document/product/377/3578)
- 设置全局配置打开自动缩容，详细参考官方文档：[调整节点池](https://cloud.tencent.com/document/product/457/43737#adjustGlobalNodePool)

#### 1.2.4. 信息记录（便于后续步骤配置中使用）

- 获取 Kubeconfig
  1. 访问：https://console.cloud.tencent.com/tke2/cluster/sub/list/basic/info?rid=1&clusterId=<你的TKE集群id>
  2. 找到 **集群APIServer信息** 
  3. 启用 **内网访问**
  4. 下载 Kubeconfig 待用
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-10.png)

### 1.3. 云存储

> 通过使用云存储服务来降低搭建与运维存储集群的人力成本

**注意：云存储安全组要放通node以及pod所在网段，云存储的密码不能包含特殊字符，尤其是redis，最好是大小写字母和数字的组合**

#### 1.3.1. MySQL 
> MySQL 为蓝鲸平台大多数平台提供核心数据存储服务

创建实例：https://buy.cloud.tencent.com/cdb

- 数据库设置

| 名称 | 选项 / 配置 |
| -- | -- | 
|数据库版本| mysql5.7|
|引擎| InnoDB|
|架构|**默认** 双节点|
|数据复制方式|**默认** 异步复制|
| 实例配置 | 通用型4核8G；200G数据盘 |
| 字符集|**默认** UTF8（升级需复用当前自建 mysql 的匹配的字符集） |
| 排序规则|**默认** UTF8_GENERAL_CI|
| 表名大小写敏感|**默认** 关闭|
|密码复杂度|**默认** 关闭|
| 数量 | 1（亦可按模块拆分，配置可降低） |
| 其他 | 默认即可 | 
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-11.png)
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-12.png)

#### 1.3.2. MongoDB
> MongoDB 为以下平台提供存储服务：
> 
> 配置平台（CMDB）、制品库（bkrepo）、作业平台（Job）、管控平台（GSE）、trubo、codecc

创建实例：https://buy.cloud.tencent.com/mongodb
- 数据库设置

| 名称 | 选项 / 配置 |
| -- | -- | 
| 数据库版本 | 4.4 |
| 架构类型 | 副本集 |
| Mongod规格 | 至少 4核8G（配置过低实例最大连接数不足整个环境的使用）；200G数据盘 3节点（1主2从节点）|
| 数量 | 1（亦可按模块拆分，配置可降低） |
| 其他 | 默认即可 | 
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-13.png)

#### 1.3.3. Elasticsearch
> Elasticsearch 为 bkpaas3、bkapigateway、bkmonitor、bklog、bkci 提供实时日志存储、全文检索、统计分析等功能。

创建实例：https://buy.cloud.tencent.com/es
- 数据库设置

| 名称 | 选项 / 配置 |
| -- | -- | 
| 版本 | 7.14.2 |
| 高级特性 | 白金版 |
| 节点配置 | 4核8G；200G数据盘；3节点 |
| 数量 | 1（亦可按模块拆分，配置可降低） |
| 其他 | 默认即可 | 
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-14.png)
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-15.png)

#### 1.3.4. Redis
> Redis 满足蓝鲸平台大多数平台、上层 SaaS 应用在缓存、存储等不同场景的需求。

创建实例：https://buy.cloud.tencent.com/redis
- 数据库设置
| 名称 | 选项 / 配置 |
| -- | -- | 
| 版本 | 5.0 |
| 架构版本 | 标准架构 |
| 内存容量 | 8GB |
| 副本数量 | 1主1副本 |
| 数量 | 1|
| 其他 | 默认即可 | 
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-16.png)

#### 1.3.5. Redis-cluster
> 集群架构的 Redis 提供 bkgse 缓存服务

创建实例：https://buy.cloud.tencent.com/redis
- 数据库设置

| 名称 | 选项 / 配置 |
| -- | -- | 
| 版本 | 5.0 |
| 架构版本 | 集群架构 |
| 内存容量 | 4GB |
| 副本数量 | 1主1副本 |
| 数量 | 1 |
| 其他 | 默认即可 | 
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-17.png)

#### 1.3.6. CFS
> CFS 提供 bkrepo 可扩展的共享文件存储服务

创建实例：https://console.cloud.tencent.com/cfs
- 设置

| 名称 | 选项 / 配置 |
| -- | -- | 
| 存储类型 | 通用标准型 |
| 文件协议 | NFS |
| 数量 | 1 |
| 其他 | 默认即可 | 

#### 1.3.7. Ckafka
> Ckafka 用于蓝鲸数据管道数据上报通道的队列缓存。

创建实例：https://buy.cloud.tencent.com/ckafka
- 设置

| 名称 | 选项 / 配置 |
| -- | -- | 
| 规格类型 | 专业版 |
| Kafka 版本 | 0.10.2 |
| 实例规格 | 20～1200MB/s |
| 峰值带宽 | 40MB/s（后续按需扩容） |
| 磁盘 | 300GB |
| Partition规格 | 800 |
| 消息保留 | 72小时 |
| 数量 | 1 |
| 其他 | 默认即可 | 
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-18.png)
- 创建成功后，前往实例控制台开启自动创建 topic 设置
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-19.png)

#### 1.3.8. 信息记录（便于后续步骤配置中使用）

> 不需要记录MongoDB的hidden节点，连接信息也不能添加hidden节点

| 模块 | ip:port| port | password | uri |
| -- | -- | -- | -- | -- | 
| cdb/mysql | 10.0.x.x:3306| 3306|1234567a| | 
| mongodb|10.0.x.x:27017,10.0.x.x:27017|27017|1234567a|mongodb://mongouser:1234567a\@10.0.x.x:27017,10.0.x.x:27017/test?authSource=admin| 
| es7 | 10.0.x.x:9200| 9200|1234567a| | 
| redis-default | 10.0.x.x:6379| 6379| 1234567a| | 
| redis-cluster | 10.0.x.x:6379| 6379| 1234567a| | 
| cfs | 10.0.x.x| | | | 
| ckafka | 10.0.x.x:9092| 9092| | | 

### 1.4. CVM 自建存储

> 由于 rabbitmq、zk 维护成本较低，采用购买 cvm 自建的方案，降低整体成本；influxdb 暂无云服务供应，故采用自建方式。

#### 1.4.1. CVM 机器准备；信息记录（便于后续步骤配置中使用）

- 数据盘请挂载到 **/data**

| 模块|机型|磁盘|数量| ip | 备注|
| -- | -- | -- | -- | -- | -- |
| zk | 2C4G | 通用云硬盘100G | 3 | 10.0.x.x,10.0.x.x,10.0.x.x | - 消息队列业务对于计算和内存资源需求相对平衡，推荐标准型机型搭载云硬盘作为存储。<br \> - 后续其中一台 zk 机器可作为蓝鲸服务中控机以及集群 kubectl 操作机|
|rabbitmq| 8C16G |通用云硬盘200G | 2 | 10.0.x.x,10.0.x.x | - 消息队列业务对于计算和内存资源需求相对平衡，推荐标准型机型搭载云硬盘作为存储。 | 
|influxdb|IT5.8XLARGE128|本地 3570GB NVMe SSD 硬盘 * 2| 2 | 10.0.x.x,10.0.x.x | 数据库对于 IO 性能有着非常高的要求，推荐使用 SSD 云硬盘以及本地盘。 | 

### 1.5. 网络

#### 1.5.1. CLB

> 蓝鲸设计为需要通过域名访问使用
> 流量统一使用 CLB 转发至 ingress-nginx nodePort:32080
> 域名绑定等场景仅需指向同个 IP，便于维护和管理
> 此节开始配置前，请先完成“1.1. 域名和证书”的准备

##### 1.5.1.1 新建 CLB

创建实例：https://buy.cloud.tencent.com/clb
- 设置

| 名称 | 选项 / 配置 |
| -- | -- | 
| 网络类型 | 一个公网CLB / 一个内网CLB |
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-20.png)

##### 1.5.1.2. 配置 CLB
1. 新增个性化配置，并绑定两个 CLB 实例，参考：https://console.cloud.tencent.com/clb/config
```plain
client_max_body_size 10240M;
proxy_request_buffering off;
proxy_read_timeout 600s;
proxy_send_timeout 600s;
```
2. 证书管理，上传证书，参考：https://cloud.tencent.com/document/product/214/48837
  - 从章节 1.1.3 获取 证书
3. 在公网 CLB / 内网 CLB 新增 **HTTP/HTTPS 监听器**
  - 目的：CLB ip 80/443 转发 ingress-nginx nodePort:32080
  -  ingress 专用节点的 ip： 从章节 1.2.2 获取
  - 配置规则：
    1. [可选] 开启 HTTPS，内外网 CLB 需要同时配置 80、443 规则
    2. 80、443 规则一致，转发至 ingress 专用节点的 ip，如有多个请配置多个，内外网配置一致  
    3. 泛域名规则无需配置健康检查
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-21.png)
4. 内网 CLB 新建**TCP/UDP/TCP SSL/QUIC监听器**
  - 目的： 添加 zk、rabbitmq 4层转发规则
  - ip 信息获取：从章节 1.4.1 获取
  - 具体规则如下（如有多台请一并选择）：
	| CLB 端口 | 后端服务 | 后端端口 |
	| -------- | -------- | -------- |
	| 2181     | zk ip  | 2181     |
	| 5672     | rabbitmq ip | 5672     |
	| 15672    | rabbitmq ip | 15672    |

#### 1.5.2. 私有域解析 Private DNS

私有域设置为蓝鲸主域名，比如蓝鲸所有平台的域名为 paas.bktencent.com 形式，那私有域就为 bktencent.com ；如果是三级以上域名，私有域就为可以是 paas.bktencent.com
- 新建私有域，参考：https://console.cloud.tencent.com/privatedns/domains/add
	1. 开启：子域名递归解析
	2. 其他默认设置即可
	3. 编辑并导入附件中 private-dns.xlsx，仅需修改域名的指向为 内网 CLB 的 ip 即可

#### 1.5.3 NAT网关

- 类型：传统型 NAT 网关-小型 / 其他选项按需选择
- 创建实例，参考：https://console.cloud.tencent.com/vpc/nat
  - 注意私有网络的选择

#### 1.5.4. 路由表配置

1. 参考图片增加规则即可：https://console.cloud.tencent.com/vpc/route
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-22.png)

#### 1.5.5. 信息记录（便于后续步骤配置中使用）

| 模块 | ip:port|
| -- | -- |
| lan-clb | 10.0.x.x |
| wan-clb | x.x.x.x |
| nat | x.x.x.x |

## 2. 资源初始化

### 2.1. CVM 机器初始化

1. 执行内部初始化流程
2. 挂载数据盘，参考：https://cloud.tencent.com/document/product/213/17487

### 2.2. 中控机初始化

> 建议选择其中一台 zk 机器可作为蓝鲸服务中控机以及集群 kubectl 操作机

0. 选择登陆机器
```bash
ssh <ip>
```
1. 安装必要软件工具
```bash
YUM_DEP=( jq unzip uuid bash-completion)
yum -y install ${YUM_DEP[@]}
```
2. 在中控机安装 kubectl
```bash
curl -Lo /usr/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x /usr/bin/kubectl
```
3. 中控机下载并解压helm file
```bash
curl -sSf https://bkopen-1252002024.file.myqcloud.com/ce7/7.1-stable/bkdl-7.1-stable.sh | bash -s -- -ur latest base demo
cd ~/bkce7.1-install/blueking  # 进入工作目录
# 安装生成配置所需的命令
# 注意环境变量加载：export PATH="/usr/local/bin/:$PATH"
cp -av ../bin/helmfile ../bin/helm ../bin/yq /usr/local/bin/
# 安装helm-diff插件
tar xf ../bin/helm-plugin-diff.tgz -C ~/  
# 检查helm diff
helm plugin list  # 预期输出 diff 及其版本。
```
4. 配置 kubectl、helm 命令行补全
```bash
## https://kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-bash-linux/
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -o default -F __start_kubectl k' >>~/.bashrc
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
## https://helm.sh/docs/helm/helm_completion_bash/
helm completion bash > /etc/bash_completion.d/helm
echo 'alias h=helm' >>~/.bashrc
echo 'complete -o default -F __start_helm h' >>~/.bashrc
```
5. 添加 charts 仓库
蓝鲸 7.1 软件产品通过 https://hub.bktencent.com/ 进行分发。
请先在 helm 中添加名为 `blueking` 的 charts 仓库：
```bash
helm repo add blueking https://hub.bktencent.com/chartrepo/blueking
helm repo update
helm repo list
```
6. 配置 Kubeconfig
```bash
# 从章节 1.2.4 中下载的 Kubeconfig 
## 文件名类似：cls-0p8bafne-config
cp <Kubeconfig> $HOME/.kube/

cat >> $HOME/.bashrc <<'EOF'
export KUBECONFIG=$KUBECONFIG:$HOME/.kube/<Kubeconfig>
EOF
# 使设置生效
source ~/.bashrc
```
7. 切换 Kube context 以访问 TKE 集群
```bash
kubectl config get-contexts
kubectl config use-context <context-name>

# 例子：
# $ kubectl config get-contexts
# CURRENT   NAME                                      CLUSTER        AUTHINFO     NAMESPACE
# *         cls-g0zg9quy-88888888-context-default   cls-g0zg9quy   88888888   blueking
# $ kubectl config use-context cls-g0zg9quy-88888888-context-default
# Switched to context "cls-g0zg9quy-88888888-context-default".

# 测试可用：是否可正常访问集群
kubectl get node 
```
8. [可选]在中控机安装 k9s
```bash
curl -sS https://webinstall.dev/k9s | bash
```
9. [可选]中控机安装kubectl-node-shell，查看 Kubelet、CNI、kernel 等系统组件的日志需要首先 SSH 登录到 Node 上
```bash
curl -L -o /usr/local/bin/kubectl-node_shell https://github.com/kvaps/kubectl-node-shell/raw/master/kubectl-node_shell
chmod +x /usr/local/bin/kubectl-node_shell
```

### 2.3. 部署 rabbitmq、zk、influxdb
1. 下载安装包（可以用二进制版本的安装包，下载到/data/下，并解压）
```bash
cd /data/
cat <<EOF | wget -i -
https://bkopen-1252002024.file.myqcloud.com/common/install_ce-v6.1.2.tgz
https://bkopen-1252002024.file.myqcloud.com/ce/bkce_common-1.0.9.tgz
EOF

echo install_ce-v6.1.2.tgz bkce_common-1.0.9.tgz | xargs -n1 tar xf 
cp -a /data/src/yum /opt
```
2. 配置 install.config
```bash
# 从章节 1.4.1 中获取机器ip信息

cat >> /data/install/install.config<<EOF 
10.0.1.x zk(config),consul
10.0.1.x zk(config),consul
10.0.1.x zk(config),consul
10.0.1.x rabbitmq
10.0.1.x rabbitmq
10.0.1.x influxdb(bkmonitorv3)
10.0.1.x influxdb(bkmonitorv3)
EOF
```
3. 执行免密，如果使用密钥关联的cvm，则把公私钥放到中控机~/.ssh/id_rsa和~/.ssh/id_rsa.pub，以下步骤就可以略过
```bash
cd /data/install
bash /data/install/configure_ssh_without_pass
```
4. 进行部署
```bash
cd /data/install/
cat >> bk_install_local_storge <<"EOF"
#!/bin/bash

export LC_ALL=en_US.UTF-8
SELF_DIR=$(dirname "$(readlink -f "$0")")
export CTRL_DIR=$SELF_DIR
service=$1
cd ${BASH_SOURCE%/*} 2>/dev/null
source ./functions
step_file=.bk_install.step
[ -f $step_file ] || touch $step_file

log "commond: bk_install $@" >/dev/null

_bkc () {
    if grep -xF "$*" $step_file >/dev/null; then
        log "$@ has been performed without FATAL stat...  $(green_echo skip)"
    else
        ./bkcli $@ && echo "$*" >>$step_file

        [ $? -eq 0 -o $? -eq 10 ] || exit 1
    fi
}

_bkc install controller
_bkc install bkenv
_bkc install python
_bkc sync common
_bkc update bkenv
_bkc install yum
_bkc install consul
_bkc start consul
_bkc install zk
_bkc start zk
_bkc install rabbitmq
_bkc start rabbitmq
_bkc install influxdb
_bkc start influxdb


for svs in zk rabbitmq influxdb; do
    ./bkcli status $svs
done
EOF
mkdir -p /data/src/cert
cat >> /data/src/blueking.env <<EOF
export GSE_KEYTOOL_PASS='2y#8VI2B4Sm9Dk^J'
export JOB_KEYTOOL_PASS='mLnuob1**4D74c@F'
EOF
chmod +x bk_install_local_storge
./bk_install_local_storge
```

### 2.4. 配置存储
1. 设置 mysql loginpath
```bash
# 从章节 1.3.8 获取 mysql-ip、mysql-password
MYSQL_IP=10.0.x.x
MYSQL_PASSWD=

# 注册 mysql loginpath
yum -y install mysql-community-client
/data/install/bin/setup_mysql_loginpath.sh -n "mysql-default" -h "$MYSQL_IP" -u root -p "${MYSQL_PASSWD}"
## test
/usr/bin/mysql --login-path=mysql-default -e 'select version()'
```
2. mysql 新建 db
```bash
cd ~/bkce7.1-install/blueking/
tar --to-stdout -xf ./charts/mysql-4.5.5.tgz mysql/files/docker-entrypoint-initdb.d/create_blueking_databases.sql | /usr/bin/mysql --login-path=mysql-default
# bcs 的数据库需要额外创建
/usr/bin/mysql --login-path=mysql-default <<'EOF'
CREATE DATABASE `bcs-app` DEFAULT CHARACTER SET utf8mb4;
CREATE DATABASE `bcs-cc` DEFAULT CHARACTER SET utf8mb4;
CREATE DATABASE `bcs` DEFAULT CHARACTER SET utf8mb4;
EOF
```
3. 获取 mongodb 副本集名称
```bash
# 从章节 1.3.8 获取 mongo 连接串
MONGO_URI='mongodb://mongouser:<password>@10.0.x.x:27017,10.0.x.x:27017/test?authSource=admin'

yum -y install mongodb-org-shell
/usr/bin/mongo $MONGO_URI --shell <<EOF
rs.status().set
EOF
```
4. mongodb 需要获取副本集名称以及创建账号并授权，执行以下命令
```bash
# 从章节 1.3.8 获取 mongo 连接串
MONGO_URI='mongodb://mongouser:<password>@10.0.x.x:27017,10.0.x.x:27017/test?authSource=admin' 

# 连上mongodb来运行上述命令输出的所有js指令，如果修改了js指令里的默认密码，需要在custom.yaml里的对应字段配置新密码
/usr/bin/mongo $MONGO_URI --shell <<EOF
db = db.getSiblingDB('bkrepo');
if (db.getUser('bkrepo') == null) { db.createUser( {user: "bkrepo",pwd: "bkrepo",roles: [ { role: "readWrite", db: "bkrepo" } ]}) };

db = db.getSiblingDB('cmdb');
if (db.getUser('cmdb') == null) { db.createUser( {user: "cmdb",pwd: "cmdb",roles: [ { role: "readWrite", db: "cmdb" } ]}) };

db = db.getSiblingDB('cmdb_events');
if (db.getUser('cmdb_events') == null) { db.createUser( {user: "cmdb_events",pwd: "cmdb_events",roles: [ { role: "readWrite", db: "cmdb_events" } ]}) };

db = db.getSiblingDB('gse');
if (db.getUser('gse') == null) { db.createUser( {user: "gse",pwd: "gse",roles: [ { role: "readWrite", db: "gse" } ]}) };

db = db.getSiblingDB('joblog');
if (db.getUser('joblog') == null) { db.createUser( {user: "joblog",pwd: "joblog",roles: [ { role: "readWrite", db: "joblog" } ]}) };
EOF

```
5. rabbitmq 创建账号以及 vhost
```bash
cd /data/install
source ~/.bkrc
source utils.fc
ssh $BK_RABBITMQ_IP
for m in ${modules[@]}; do
    # rabbitmqctl add_user user password，如果在这里修改了非默认密码，需要在custom.yaml里的对应字段配置新密码
    rabbitmqctl add_user $m $m
    if [ "$m" != 'bcs' ]; then
        # rabbitmqctl set_user_tags user tag,设置用户角色
        rabbitmqctl set_user_tags $m management
        # add vhosts: rabbitmqctl add_vhost vhost_name
        rabbitmqctl add_vhost $m
        # rabbitmqctl set_permissions -p vhost user <conf> <write> <read>  设置权限
        rabbitmqctl set_permissions -p $m $m ".*" ".*" ".*"
    else
        rabbitmqctl set_user_tags bcs administrator
        rabbitmqctl set_permissions -p / bcs ".*" ".*" ".*"
    fi
    # 启用 ha policy
    rabbitmqctl set_policy ha-all '^' '{"ha-mode": "all","ha-sync-mode":"automatic"}' -p $m 
done
```
6. es 监控禁止产生以 write 开头的 index
```bash
# 从章节 1.3.8 获取 es-ip、es-password
ES7_IP=10.0.x.x
ES7_PASSWORD=

# es 监控禁止产生以 write 开头的index
curl -X PUT \
  -H 'Content-Type: application/json' \
  http://elastic:${ES7_PASSWORD}@${ES7_IP}:9200/_cluster/settings \
  -d @- <<EOF
{
   "persistent": {
        "action.auto_create_index": "-write_*,*"
    }
}
EOF
# 返回为
{"acknowledged":true,"persistent":{"action":{"auto_create_index":"-write_*,*"}},"transient":{}}
```

### 2.5. 信息记录（便于后续步骤配置中使用）

| key | values |
| -- | -- | 
|  mongodb 副本集 |  cls-xxxxxxxx | 

| 模块 | ip | port | 密码 |
| -- | -- | -- | -- |
| zk | 10.0.x.x:2181,10.0.x.x:2181,10.0.x.x:2181 | 2181 | |
| rabbitmq | 10.0.x.x:5672,10.0.x.x:5672 | 5672,15672,25672 | 管理员账号密码获取方式：`echo $BK_RABBITMQ_ADMIN_USER $BK_RABBITMQ_ADMIN_PASSWORD` |
| zk | 10.0.x.x:2181,10.0.x.x:2181,10.0.x.x:2181 | 2181 | zk 认证获取方式：`source /data/install/utils.fc; echo $BK_GSE_ZK_AUTH` |

## 3. 部署基础套餐

### 3.1. 配置访问域名

> **注意**：如果您在公有云上部署蓝鲸，请先完成域名备案，否则会被云服务商依法阻断访问请求。

```bash
BK_DOMAIN=<BK_DOMAIN>  # 从章节 1.1.3 获取
cat >> ~/bkce7.1-install/blueking/environments/default/custom.yaml <<EOF

domain:
  bkDomain: $BK_DOMAIN
  bkMainSiteDomain: $BK_DOMAIN
  
bkDomainScheme: https
EOF
```

- [可选] 如**不**启用 HTTPS：请修改 custom.yaml 中 bkDomainScheme 字段设置为 http
```bash
bkDomainScheme: http
```

### 3.2. 配置容器日志目录

平台组件的后台日志采集用。

请在所有 **k8s node** 上执行此命令，预期输出一致：

```bash
docker info  | awk -F": " '/Docker Root Dir/{print $2"/containers"}'
# 可免密登陆的前提下请直接执行
for ip in $(kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}'); do
    ssh -o StrictHostKeyChecking=no -o CheckHostIP=no root@$ip docker info  | awk -F": " '/Docker Root Dir/{print $2"/containers"}'
done
```

我们预期您的 k8s node 具备相同的 docker 配置。如果此路径不一致，请先完成 docker 标准化。

### 3.3. 增加 zk/rabbitmq 部署条件

> 这里使用的是自建的 rabbitmq 和 zk，后续部署会把 bitnamiRabbitmq.enabled 和 bitnamiZookeeper.enabled 设置为 false，不使用 k8s 内部署 rabbitmq 和 zk

- 手动编辑 `~/bkce7.1-install/blueking/base-storage.yaml.gotmpl`
```yaml
releases:
...
  - name: bk-rabbitmq
    namespace: {{ .Values.namespace }}
    chart: ./charts/rabbitmq-{{ .Values.version.rabbitmq }}.tgz
    missingFileHandler: Warn
    version: {{ .Values.version.rabbitmq }}
	## START:看这里，需要插入以下这段
    condition: bitnamiRabbitmq.enabled
	## END
    values:
    - ./environments/default/rabbitmq-values.yaml.gotmpl
    - ./environments/default/rabbitmq-custom-values.yaml.gotmpl
...
  - name: bk-zookeeper
    namespace: {{ .Values.namespace }}
    chart: ./charts/zookeeper-{{ .Values.version.zookeeper }}.tgz
    version: {{ .Values.version.zookeeper }}
    missingFileHandler: Warn
	## START:看这里，需要插入以下这段
    condition: bitnamiZookeeper.enabled
	## END
    values:
    - ./environments/default/zookeeper-values.yaml.gotmpl
    - ./environments/default/zookeeper-custom-values.yaml.gotmpl
```

### 3.4. 配置云存储

- 手动编辑 `~/bkce7.1-install/blueking/environments/default/custom.yaml` 添加以下内容，配置云存储的连接信息
```yaml
# false表示使用外部存储
bitnamiMysql:
    enabled: false
bitnamiRedis:
    enabled: false
bitnamiRedisCluster:
    enabled: false
bitnamiMongodb:
    enabled: false
bitnamiElasticsearch:
    enabled: false
bitnamiRabbitmq:
    enabled: false
bitnamiZookeeper:
    enabled: false

# 从章节 1.3.8 获取 mysql 连接信息
mysql:
  host: <ip>
  port: 3306
  rootPassword: <password>

# 从章节 1.5.5 获取 内网CLB ip
# 从章节 2.5 获取 rabbitmq password
rabbitmq:
  host: <内网CLB ip>
  # AMQP协议端口
  port: 5672
  # admin 账密
  username: admin
  password: <password>

# 从章节 1.3.8 获取 redis 连接信息
redis:
  # redis-default
  host: <ip>
  port: 6379
  password: <password>

# 集群架构的redis
# 从章节 1.3.8 获取 redis 连接信息
redisCluster:
  host: <ip>
  port: 6379
  password: <password>

# 从章节 1.3.8 获取 mongodb 连接信息
# 从章节 2.5 获取 rsName 副本集名称
mongodb:
  host: <ip>
  port: 27017
  host_port: ip1:27017,ip2:27017,ip3:27017
  rootUsername: mongouser
  rootPassword: <password>
  rsName: <cls-xxxxxx 副本集名称>

# 从章节 1.3.8 获取 es 连接信息
elasticsearch:
  host: <ip>
  # http协议的REST端口
  port: 9200
  username: elastic
  password: <password>
  
# 从章节 1.5.5 获取 内网CLB ip
# 从章节 2.5 获取 zk 认证信息
gse:
  # gse所在主机的网卡接口名
  netdev: eth0
  mongodb:
    # 默认值
    username: gse
    password: gse
    database: gse
  zookeeper:
    hosts: <内网CLB ip>:2181
    token: "zkuser:xxxxxx"
    
# cmdb主要配置zookeeper,mongodb的访问
# 从章节 1.3.8 获取 mongodb 连接信息
# 从章节 2.5 获取 zk 连接信息
cmdb:
  zookeeper:
    hosts: <内网CLB ip>:2181
  mainMongodb:
    username: cmdb
    password: <password>
    database: cmdb
  watchMongodb:
    username: cmdb_events
    password: <password>
    database: cmdb_events

# 从章节 1.3.8 获取 mongodb 连接信息
# 从章节 1.3.8 获取 cfs 连接信息
bkrepo:
  externalMongodb:
    username: bkrepo
    password: bkrepo
    database: bkrepo
  nfs:
    enabled: true
    server: <ip>

bkiam:
  rabbitmq:
    host: <内网CLB ip>
    port: 5672
    username: "bkiam"
    password: "bkiam"
    vhost: bkiam 
    
# 从章节 3.1 获取容器日志目录
# 从章节 1.3.8 获取 mysql 连接信息
# 从章节 1.3.8 获取 es 连接信息
# 从章节 2.5 获取 rabbitmq 连接信息
apps:
  bkappFilebeat.containersLogPath: <容器日志目录>
  mysql:
    host: <ip>
    port: 3306
    rootPassword: <password>
  # rabbitmq clb ip
  rabbitmq:
    host: <ip>
    managerPort: 15672
    amqpPort: 5672
    username: admin
    password: <password>
    managerPort: 15672
    amqpPort: 5672
  elasticsearch:
    host: <ip>
    port: 9200
    username: elastic
    password: <password>
```
- 创建 `~/bkce7.1-install/blueking/environments/default/bkrepo-custom-values.yaml.gotmpl`
```bash
cat >> ~/bkce7.1-install/blueking/environments/default/bkrepo-custom-values.yaml.gotmpl <<EOF
common:
  config:
    storage:
      nfs:
        enabled: {{ .Values.bkrepo.nfs.enabled }}
        server: {{ .Values.bkrepo.nfs.server }}
EOF
```
- 创建 `~/bkce7.1-install/blueking/environments/default/bkiam-saas-custom-values.yaml.gotmpl`
```bash
cat >> ~/bkce7.1-install/blueking/environments/default/bkiam-saas-custom-values.yaml.gotmpl <<EOF
externalRabbitmq:
  default:
    enabled: true
    host: {{ .Values.bkiam.rabbitmq.host }}
    port: {{ .Values.bkiam.rabbitmq.port }}
    username: {{ .Values.bkiam.rabbitmq.user }}
    password: {{ .Values.bkiam.rabbitmq.password }}
    vhost: {{ .Values.bkiam.rabbitmq.vhost }}
EOF
```
- 创建 `~/bkce7.1-install/blueking/environments/default/bkjob-custom-values.yaml.gotmpl`
```bash
cat >> ~/bkce7.1-install/blueking/environments/default/bkjob-custom-values.yaml.gotmpl <<EOF
rabbitmq:
  enabled: false
externalRabbitMQ:
  host: {{ .Values.rabbitmq.host }}
  port: {{ .Values.rabbitmq.port }}
  username: {{ .Values.job.rabbitmq.user }}
  password: {{ .Values.job.rabbitmq.password }}
  vhost: {{ .Values.job.rabbitmq.vhost }}
EOF
```

### 3.5 生成蓝鲸 app code 对应的 secret

```bash
./scripts/generate_app_secret.sh ./environments/default/app_secret.yaml
```

### 3.6. 生成 apigw 所需的 keypair
- 生成接入 apigateway 的网关组件的 rsa key 密钥对
```bash
./scripts/generate_rsa_keypair.sh ./environments/default/bkapigateway_builtin_keypair.yaml
```

### 3.7. 生成 paas 所需的 clusterAdmin
- 生成一个 clusterAdmin 管理账号 bk-paasengine 供蓝鲸 PaaS 平台使用
```bash
./scripts/create_k8s_cluster_admin_for_paas3.sh
```

### 3.8. 安装 ingress controller

- 先检查您的环境是否已经部署了 ingress controller，如有请先卸载
```bash
kubectl get pods -A -l app.kubernetes.io/name=ingress-nginx
```
- `~/bkce7.1-install/blueking/00-ingress-nginx.yaml.gotmpl` controller字段下添加以下内容，注意缩进
```yaml
- controller:
  replicaCount: 2
  nodeSelector:
    dedicated: ingress-nginx
  tolerations:
  - key: "app.kubernetes.io/name"
    operator: Equal
    effect: "NoSchedule"
    value: ingress-nginx
```
- 对“ingress 专用节点”打标签
```bash
# 从章节 1.2.1. 获取 ingress 专用节点 IP
kubectl label nodes <ingress 专用节点 IP> dedicated=ingress-nginx
```
- 对”ingress“专用节点打污点
```bash
kubectl taint nodes <ingress 专用节点 IP> dedicated=ingress-nginx:PreferNoSchedule
```
- 安装 ingress-nginx：
```bash
helmfile -f 00-ingress-nginx.yaml.gotmpl sync
kubectl get pods -A -l app.kubernetes.io/name=ingress-nginx  # 查看创建的pod
```

### 3.9. 配置 coredns

> 我们需要确保 k8s 集群的容器内能解析到蓝鲸域名。
> 所有 ip 的指向都是内网CLB ip（# 从章节 1.5.5 获取 内网CLB ip）

- 因此需要注入 hosts 配置项到 `kube-system` namespace 下的 `coredns` 系列 pod，步骤如下：
```bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml) 
IP1=<ip>  # IP1就是内网CLB ip
./scripts/control_coredns.sh update "$IP1" $BK_DOMAIN bcs.$BK_DOMAIN bcs-cc.$BK_DOMAIN bcs-api.$BK_DOMAIN apps.$BK_DOMAIN lesscode.$BK_DOMAIN bkrepo.$BK_DOMAIN docker.$BK_DOMAIN bkpaas.$BK_DOMAIN bkuser.$BK_DOMAIN bkuser-api.$BK_DOMAIN bkapi.$BK_DOMAIN apigw.$BK_DOMAIN bkiam.$BK_DOMAIN bkiam-api.$BK_DOMAIN cmdb.$BK_DOMAIN job.$BK_DOMAIN jobapi.$BK_DOMAIN bkmonitor.$BK_DOMAIN helm.$BK_DOMAIN bknodeman.$BK_DOMAIN bklog.$BK_DOMAIN devops.$BK_DOMAIN codecc.$BK_DOMAIN bktbs.$BK_DOMAIN
```
- 确认注入结果，执行如下命令：
```bash
kubectl describe configmap coredns -n kube-system
```
参考输出如下，`10.0.0.x` 是前面步骤创建的内网 CLB IP（# 从章节 1.5.5 获取 lan-clb-ip 连接信息）：
```
10.0.0.x paas.bktencent.com
10.0.0.x bkpaas.paas.bktencent.com
...
```

### 3.10. 直接开始安装基础套餐的全部 release：
```bash
helmfile -f base.yaml.gotmpl sync
```

### 3.11 部署节点管理
```bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-nodeman sync
```

### 3.12. 下载“节点管理”所需的完整待托管文件并上次至 bkrepo 仓库（gse agent / plugins）

1. 下载安装脚本
```bash
mkdir ~/bin/
curl -sSf https://bkopen-1252002024.file.myqcloud.com/ce7/7.1-stable/bkdl-7.1-stable.sh -o ~/bin/bkdl-7.1-stable.sh
chmod +x ~/bin/bkdl-7.1-stable.sh
```
2. 参考“配置节点管理”：https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.1/config-nodeman.md

### 3.13. 上传 heroku bulidpack 资源包至 bkrepo 仓库

- 参考“上传 PaaS runtimes 到制品库”：https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.1/paas-upload-runtimes.md

### 3.14. 配置 PaaS V3 资源池
- 需要添加 SaaS 使用的 redis 资源池，共享资源池和独占资源池，各添加 10 个(复用，所以 json 是一样的)
- 蓝鲸 PaaS Admin: `http://bkpaas.<BK_DOMAIN>/backend/admin42/platform/pre-created-instances/manage`
```bash
# 可直接使用下述命令获取正确的 json 内容
# 从章节 1.3.8 获取  redis-default  连接信息
REDIS_IP=<ip>
REDIS_PASSWORD=<password>
# 打屏输出需要填入的参数
cat <<EOF
{
  "host":"$REDIS_IP",
  "port":6379,
  "password":"$REDIS_PASSWORD"
}
EOF
```

### 3.15. 修改增强服务地址 （MySQL）
-  获取用户名和密码：`helm status -n blueking bk-user`
- 前往 admin42： `http://bkpaas.<BK_DOMAIN>/backend/admin42/platform/plans/manage`
- 修改 default-mysql
- host：（# 从章节 1.3.8 获取 mysql 连接信息）
- password：（# 从章节 1.3.8 获取 mysql 连接信息）

### 3.16. 配置 SaaS 专用 node（在 PaaS 页面配置污点容忍）

1. 先登录。访问 `http://bkpaas.<BK_DOMAIN>`
2. 访问蓝鲸 PaaS Admin（如果未登录则无法访问）： `http://bkpaas.<BK_DOMAIN>/backend/admin42/platform/clusters/manage/` 。
3. 点击集群 最右侧的编辑按钮。
4. 在 **集群出口 IP** 栏填写 `bk-ingress-nginx` pod 所在 **k8s node** 的 IP。
5. 在 **默认 nodeSelector** 栏填写：
    ``` json
    {"dedicated": "bkSaaS"}
    ```
6. 在 **默认 tolerations** 栏填写：
    ``` json
    [{"key":"dedicated","operator":"Equal","value":"bkSaaS","effect":"NoSchedule"}]
    ```
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-23.png)

### 3.17.  部署标准运维

| 名字及 app_code | 版本号 | 下载链接|
| -- | -- | -- |
| 标准运维（bk_sops）| 3.28.13 | https://bkopen-1252002024.file.myqcloud.com/saas-paas3/bk_sops/bk_sops-V3.28.13.tar.gz |

1. 前往开发者中心，打开标准运维 【应用引擎】-【包版本管理】，上传容器化版本包
2. 开始部署

### 3.18. 部署流程服务

| 名字及 app_code | 版本号 | 下载链接|
| -- | -- | -- |
|流程服务（bk_itsm）| 2.6.6 | https://bkopen-1252002024.file.myqcloud.com/saas-paas3/bk_itsm/bk_itsm-V2.6.6.tar.gz|

1. 前往开发者中心，打开流程服务 【应用引擎】-【包版本管理】，上传容器化版本包
2. 开始部署

###  3.19. 添加桌面应用
使用脚本在 admin 用户的桌面添加应用，也可以登录后自行在桌面添加。
```bash
cd ~/bkce7.1-install/blueking
scripts/add_user_desktop_app.sh -u "admin" -a "bk_cmdb,bk_job,bk_usermgr,bk_repo"
scripts/set_desktop_default_app.sh -a "bk_usermgr"  # 将用户管理设置为默认应用，新用户登录桌面就可以看到。
```

### 3.20. 此时可以通过浏览器访问 paas 桌面，域名解析
```bash
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml) 
WAN_CLB_IP=<# 从章节 1.5.5 获取外网 CLB ip>
# 输出 hosts 信息
cat <<EOF
${WAN_CLB_IP} $BK_DOMAIN bkpaas.${BK_DOMAIN} bkuser.${BK_DOMAIN} bkuser-api.${BK_DOMAIN} bkapi.${BK_DOMAIN} apigw.${BK_DOMAIN} bkiam.${BK_DOMAIN} bkiam-api.${BK_DOMAIN} bkssm.${BK_DOMAIN} apps.${BK_DOMAIN} cmdb.${BK_DOMAIN} job.${BK_DOMAIN} jobapi.${BK_DOMAIN} bkrepo.${BK_DOMAIN} docker.${BK_DOMAIN} helm.${BK_DOMAIN} bknodeman.${BK_DOMAIN} bkmonitor.${BK_DOMAIN} bklog.${BK_DOMAIN} lesscode.${BK_DOMAIN} bcs.${BK_DOMAIN} bcs-cc.${BK_DOMAIN} bcs-api.${BK_DOMAIN} devops.${BK_DOMAIN} codecc.${BK_DOMAIN} bktbs.${BK_DOMAIN}
EOF
```


## 4. 部署容器管理套餐

### 4.1. 确认 storageClass

在 **中控机** 检查当前 k8s 集群所使用的存储：

```bash
kubectl get sc
```

预期输出为：

```bash
NAME            PROVISIONER                 RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
cbs (default)   com.tencent.cloud.csi.cbs   Delete          Immediate           false                  111d
```

如果输出的名称不是 `local-storage`，则需通过创建 `custom.yaml` 实现修改：

```bash
cd ~/bkce7.1-install/blueking/
cat <<EOF >> environments/default/custom.yaml
bcs:
  storageClass: 填写上面的查询到的名称
EOF
```

### 4.2. 创建命名空间

创建bcs命名空间bcs-system

```bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/create_bcs_namespace.sh bcs-system

kubectl get ns
```

### 4.3. 新增 bcs-custom-values.yaml.gotmpl

```bash
cat > ~/bkce7.1-install/blueking/environments/default/bcs-custom-values.yaml.gotmpl<<BCS_CUSTOM
global:
  bkIAM:
    bkiamHost: "{{ .Values.bkDomainScheme }}://{{ .Values.domain.bkMainSiteDomain }}"
  storage:
    mongodb:
      endpoint: {{ .Values.mongodb.host_port }}
      username: {{ .Values.mongodb.rootUsername }}
      password: {{ .Values.mongodb.rootPassword }}
    messageQueue:
      enabled: true
      kind: "rabbitmq"
      # 填写rabbitmq的具体ip和端口
      endpoint: {{ .Values.rabbitmq.host }}:{{ .Values.rabbitmq.port }}
      username: "bcs"
      password: "bcs"
    redis:
      # 填写具体的redis ip和端口
      endpoint: {{ .Values.redis.host }}:{{ .Values.redis.port }}
      # 改成了db 14
      database: 14
      password: {{ .Values.redis.password }}
bcs-user-manager:
  mysql:
    enabled: false
  env:
    # 填写实际的mysql信息
    BK_BCS_coreDatabaseDsn: "root:{{ .Values.mysql.rootPassword }}@tcp({{ .Values.mysql.host }}:{{ .Values.mysql.port }})/bcs?charset=utf8mb4&loc=Local&parseTime=True"
    BK_BCS_redisDsn: "redis://:{{ .Values.redis.password }}@{{ .Values.redis.host }}:{{ .Values.redis.port }}/14"
  redis:
    enabled: false

mongodb:
  enabled: false
rabbitmq:
  enabled: false

bcs-ui:
  mariadb:
    enabled: false
  externalDatabase:
    ## bcs-app 数据库
    app:
      name: "bcs-app"
      host: {{ .Values.mysql.host }}
      port: {{ .Values.mysql.port }}
      user: "root"
      password: {{ .Values.mysql.rootPassword }}
    ## bcs-cc 数据库
    cc:
      name: "bcs-cc"
      host: {{ .Values.mysql.host }}
      port: {{ .Values.mysql.port }}
      user: "root"
      password: {{ .Values.mysql.rootPassword }}
  redis:
    enabled: false
  externalRedis:
    default:
      host: {{ .Values.redis.host }}
      port: {{ .Values.redis.port }}
      password: {{ .Values.redis.password }}
      # db0 -> db14
      db: 14
  app:
    envs:
      BKAPP_BK_MONITOR_QUERY_URL: http://bk-monitor-unify-query-http.{{ .Values.namespace }}:10206

bcs-webconsole:
  config:
    base_conf:
      bk_paas_host: {{ .Values.bkDomainScheme }}://{{ .Values.domain.bkDomain }}
    redis:
      host: {{ .Values.redis.host }}
      port: {{ .Values.redis.port }}
      password: {{ .Values.redis.password }}
      # db1 -> db15
      db: 15
    web:
      host: {{ .Values.bkDomainScheme }}://bcs-api.{{ .Values.domain.bkDomain }}

 
bcs-monitor:
  config:
    base_conf:
      bk_paas_host: {{ .Values.bkDomainScheme }}://{{ .Values.domain.bkDomain }}
    redis:
      host: {{ .Values.redis.host }}
      password: {{ .Values.redis.password }}
      port: 6379
      # db1 -> db15
      db: 15
    web:
      host: {{ .Values.bkDomainScheme }}://bcs-api.{{ .Values.domain.bkDomain }}
    storegw:
      - type: BK_MONITOR
        config:
          metadata_url: http://bk-monitor-unify-query-http.{{ .Values.namespace }}.svc.cluster.local:10206
          url: http://bk-monitor-unify-query-http.{{ .Values.namespace }}.svc.cluster.local:10206

bcs-cluster-manager:
  storage:
    mongodb:
      endpoint: {{ .Values.mongodb.host_port }}
      username: {{ .Values.mongodb.rootUsername }}
      password: {{ .Values.mongodb.rootPassword }}

bcs-cluster-resources:
  storage:
    mongodb:
      endpoint: {{ .Values.mongodb.host_port }}
      username: {{ .Values.mongodb.rootUsername }}
      password: {{ .Values.mongodb.rootPassword }}
  svcConf:
    redis:
      address: {{ .Values.redis.host }}:{{ .Values.redis.port }}
      db: 14
      password: {{ .Values.redis.password }}

bcs-project-manager:
  svcConf:
    mongo:
      address: {{ .Values.mongodb.host_port }}
      username: {{ .Values.mongodb.rootUsername }}
      password: {{ .Values.mongodb.rootPassword }}
      database: bcsproject_project

bcs-storage:
  storage:
    mongodb:
      endpoint: {{ .Values.mongodb.host_port }}
      username: {{ .Values.mongodb.rootUsername }}
      password: {{ .Values.mongodb.rootPassword }}
  env:
    BK_BCS_rabbitmqAddress: amqp://bcs:bcs@{{ .Values.rabbitmq.host }}:{{ .Values.rabbitmq.port }}
BCS_CUSTOM
```

### 4.4. 部署 bcs

- 注意：v7.1 bcs-webconsole 未有兼容 redis 使用云服务的场景，避免 bcs-webconsole 出现 CreateContainerConfigError，请提前手动创建 bcs-redis-password secret
![](Deploy-BlueKing-7-1-using-Tencent-Cloud-s-services/image-24.png)
- 处理方案：
  1. redis_password_forbcs 和 redis-password 字段设置为 redis 密码的 base64 编码后的结果（# 从章节1.3.8 获取 redis 密码）
  2. 创建 bcs-redis-password secret
    ```bash
    # 请按脚本内容执行
    redis_pass_base64=$( printf <redis密码> | base64 -w0)

    cat <<EOF | kubectl apply -n bcs-system -f -

    apiVersion: v1
    kind: Secret
    metadata:
      name: bcs-redis-password
      namespace: bcs-system
      labels:
        helm.sh/chart: bcs-user-manager-1.28.2-beta.2
        app.kubernetes.io/platform: bk-bcs
        app.kubernetes.io/name: bcs-user-manager
        app.kubernetes.io/instance: bcs-services-stack
        app.kubernetes.io/version: "v1.28.2-beta.2"
        app.kubernetes.io/managed-by: Helm
    type: Opaque
    data:
      redis_password_forbcs: "${redis_pass_base64}"
      redis-password: "${redis_pass_base64}"
    EOF
    ```
- 开始部署
```bash
cd ~/bkce7.1-install/blueking
helmfile -f 03-bcs.yaml.gotmpl sync
# 在admin桌面添加应用，也可以登录后自行添加。
scripts/add_user_desktop_app.sh -u "admin" -a "bk_bcs"
```
- 耗时 3 ~ 7 分钟，此时可以另起一个终端观察相关 pod 的状态
```bash
kubectl get pod -n bcs-system -w
```

### 4.5. 浏览器访问

访问 `bcs.<BK_DOMAIN>`

## 5. 部署监控平台

### 5.1. 配置外部存储

- 创建 `~/bkce7.1-install/blueking/environments/default/bkmonitor-custom-values.yaml.gotmpl`，配置 influxdb、kafka、rabbitmq 信息
```yaml
# 从章节 1.3.8 获取 ckafka 连接信息
externalKafka:
  host: <ip>
  port: 9092

# 从章节 2.5 获取 influxdb 连接信息
externalInfluxdb:
  # 两台influxdb 的ip信息
  hosts:
  - <ip>
  - <ip>
  # influxdb 密码信息通过在中控机执行source /data/install/utils.fc;echo $BK_INFLUXDB_ADMIN_USER $BK_INFLUXDB_ADMIN_PASSWORD;获取
  password: <password>
  port: 8086
  username: "admin"
  
externalRabbitmq:
  enabled: true
  host: {{ .Values.rabbitmq.host }}
  port: {{ .Values.rabbitmq.port }}
  username: {{ .Values.bkmonitor.rabbitmq.user }}
  password: {{ .Values.bkmonitor.rabbitmq.password }}
  vhost: {{ .Values.bkmonitor.rabbitmq.vhost }}

# 从章节 1.5.5 获取内网CLB IP 连接信息
monitor:
  config:
    # gse zk
    gseZookeeperHost: <内网CLB IP>
    gseZookeeperPort: 2181
```

### 5.2. 添加 bcsApiGatewayToken

```bash
GATEWAY_TOKEN=$(kubectl get secret --namespace bcs-system bcs-password -o jsonpath="{.data.gateway_token}" | base64 -d)

vim environments/default/bkmonitor-custom-values.yaml.gotmpl 
monitor:
  config:
    # 从章节 1.5.5 获取内网CLB IP 连接信息
    gseZookeeperHost: <内网CLB IP >
    gseZookeeperPort: "2181"
	# 填写获取到的GATEWAY_TOKEN的真实值
    bcsApiGatewayToken: "$GATEWAY_TOKEN"
```

### 5.3. 部署监控

```bash
# bk-consul
helmfile -f monitor-storage.yaml.gotmpl -l name=bk-consul sync

# monitor 后台 + web服务
helmfile -f 04-bkmonitor.yaml.gotmpl sync

# bkmonitor-operator
helmfile -f 04-bkmonitor-operator.yaml.gotmpl sync
```

### 5.4. 配置可选功能

- 见文档：https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.1/install-co-suite.md?catalog_id=1019

**蓝鲸服务 SLI 看板** 章节里的：
1. 检查 servicemonitor 资源
2. 配置指标上报
3. 重启待上报指标的平台
4. 导入仪表盘

## 6. 部署日志平台

### 6.1. 配置外部存储

- 创建 `~/bkce7.1-install/blueking/environments/default/bklog-search-custom-values.yaml.gotmpl`，配置 rabbitmq 信息
```yaml
# rabbitmq配置
rabbitmq:
  host: {{ .Values.rabbitmq.host }}
  port: {{ .Values.rabbitmq.port }}
  vhost: {{ .Values.bklog.rabbitmq.vhost }}
  user: {{ .Values.bklog.rabbitmq.user }}
  password: {{ .Values.bklog.rabbitmq.password }}
# $GATEWAY_TOKEN 从5.2小节获取
configs:
  bcsApiGatewayToken: "$GATEWAY_TOKEN"
```

### 6.2. 部署日志平台
需要先将tke node安装蓝鲸agent，否则collector部署会失败
```bash
helmfile -f 04-bklog-collector.yaml.gotmpl sync
helmfile -f 04-bklog-search.yaml.gotmpl sync
```

### 6.3 配置可选功能

参考 **蓝鲸各平台容器日志上报** 一节进行配置：https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.1/install-co-suite.md?catalog_id=1019



## FAQ

### 1. 容器服务 Pod 一直处于 Pending 状态-故障处理-文档中心-腾讯云
- 基础排查指引：https://cloud.tencent.com/document/product/457/42948
- 偶现 pod Node-Selectors 配置了 cloud.tencent.com/provider=tencentcloud 导致了 Pod Pending，去掉后 Node-Selectors 后恢复

### 2. 访问 cmdb 提示“查询有权限的业务列表失败”
- apiserver 日志中有请求 bkiam.service.consul 无法解析的异常
```
E0315 09:57:36.498984       1 service/filter.go:211] authFilter failed, authorized request failed, url: /api/v3/event/watch/resource/biz_set_relation, err: list user policy failed, err: list user's policy failed, err: Post "http://bkiam.service.consul:5001/api/v1/policy/query_by_actions": dial tcp: lookup bkiam.service.consul on 10.0.0.x:53: no such host, rid: abb03b53e3444dd49836adc8f9d85190
```
- 处理方案
  1. 检查 iam db 中注册的域名是否正常（一般是 http://bk-cmdb-auth.svc.cluster.local）
  ```sql
  select id, name, provider_config from bkiam.saas_system_info where id = "bk_cmdb"; 
  ```
  2. 确认 zk 中注册信息 authServer.address 的值为 http://bkiam-web
  ```bash
  zkCli# addauth digest cc:3.0#bkcc
  zkCli# get /cc/services/config/common
  ```
  3. 确保以上都正常后，重新部署 cmdb 

### 3. bkiam-saas-web 和 bkiam-saas-api 状态异常，desc pod enents healthz check fail

- 尝试从其他 pod 请求 `<bkiam-saas-web pod ip>:5000/healthz`，若返回为：celery ping test fail, error: [Errno 104] Connection reset by peers，则检查 rabbitmq 相关的配置（ip、port、user、passwd）
