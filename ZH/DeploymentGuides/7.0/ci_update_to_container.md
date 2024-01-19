# 蓝盾二进制升级容器化指引

## 概述

本文档为二进制版蓝盾升级为容器化蓝盾指引，升级后数据库沿用二进制版本所使用的数据库。

本文档基础环境如下：

- 蓝鲸基础套餐 v6.1
- 蓝盾 v1.7.45

---
## 版本同步至 1.7.45
本文档基于 v1.7.45 蓝盾进行升级。若版本为 v1.7.36 或其他版本，请先升级到 v1.7.45 版本。
若已为 v1.7.45 版本，请忽略此步骤。
### 快速部署

1. **导入标准运维流程模板**

进入“标准运维”，选择《`蓝鲸`》业务，导入 [部署流程模板](https://bkopen-1252002024.file.myqcloud.com/bkci/bk-ci-deploy-20220315.dat) 。
1. **执行部署**

选择 " [蓝鲸持续集成] [CI]部署或升级流水线” 模板新建任务
>填写蓝鲸中控机 IP 及版本号。版本号填写 **v1.7.45**
流程中会自动下载重命名安装包，也可手动下载安装包，并传输到中控机上，确保文件路径为 /data/src/bkci-版本号.tar.gz，可自动跳过下载步骤。
如果出现异常，请查看具体步骤的报错，故障排除后可直接重试对应的步骤。

---
## 一、蓝盾二进制 v1.7.45版本升级至 1.9.2

蓝盾二进制版本需先升级为 1.9.2 版本。可参考之前安装蓝盾的方式，使用标准运维模板，直接修改版本号部署即可。

### 快速部署

1. **导入标准运维流程模板**

进入“标准运维”，选择《`蓝鲸`》业务，导入 [部署流程模板](https://bkopen-1252002024.file.myqcloud.com/bkci/bk-ci-deploy-20220315.dat) 。

2. **执行部署**

选择 " [蓝鲸持续集成] [CI]部署或升级流水线” 模板新建任务

> 填写蓝鲸中控机 IP 及版本号。版本号填写 **v1.9.2**
>
> 流程中会自动下载重命名安装包，也可手动下载安装包，并传输到中控机上，确保文件路径为 /data/src/bkci-版本号.tar.gz，可自动跳过下载步骤。
>
> 如果出现异常，请查看具体步骤的报错，故障排除后可直接重试对应的步骤。



### 已知问题修复
标准运维执行过程中， [滚动部署或更新流水线] 目前会有异常，gateway 、agentless 服务会无法拉起，为预期内现象。

后续将修改新版流程模板修复此问题，目前请手动进行修复：

**中控机** 上操作

```
# 登录 CI 机器修复服务异常
source /data/install/utils.fc
ssh $BK_CI_IP
sed -i 's/server_name\ \;/server_name\ devops.example.com\;/g' /data/bkce/ci/gateway/conf/./vhosts/all.static.server.conf
systemctl restart bk-ci-gateway.service
# 查看服务是否都已正常
/data/install/bin/bks.sh
```

确认服务都正常后，在标准运维中选择跳过此节点。
至此，蓝盾二进制版本升级完成。

---

## 二、蓝鲸6.1升级至7.0

### 停止蓝盾所有服务

**中控机** 上操作

```
# 停止蓝盾服务
source /data/install/utils.fc
ssh $BK_CI_IP
systemctl stop bk-ci-*
exit
# 停止 dockerhost 服务
ssh $BK_CI_DOCKERHOST_IP
systemctl stop bk-ci-*
```



### 基础环境升级

1. 参考官方文档，完成蓝鲸基础套餐 6.1 → 7.0 升级

[6.1-7.0升级指引](https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.0/how-to-upgrade-from-v6.1.md)



2. 升级完成后，删除 bkci 关于 iam 的回调信息。部署蓝盾容器化时，会重新写入新数据。

- 二进制中控机执行

```
mysql --login-path=mysql-default -e "delete from devops_ci_auth.T_AUTH_IAM_CALLBACK;"
```



---

## 三、蓝盾容器化安装

确保已完成基础套餐的升级后，即可开始蓝盾容器化的安装部署。

### 二进制数据库授权 k8s 节点 bk_ci 用户访问权限

二进制**中控机**上操作

```
# 登录至 MySQL 机器
source /data/install/utils.fc
ssh $BK_MYSQL_IP

source /data/install/utils.fc

# 请注意替换授权主机列表 $KUBERNETES_CLUSTER_IPLIST
# KUBERNETES_CLUSTER_IPLIST 可使用该命令在容器化环境获取：kubectl get nodes -o wide | awk 'NR>1{print $6}'| tr '\n' ' '
hosts=($KUBERNETES_CLUSTER_IPLIST)

# 授权 bk_ci 用户访问
source /data/install/utils.fc
for i in ${hosts[@]};do /data/install/bin/grant_mysql_priv.sh -n default-root -u $BK_CI_MYSQL_USER -p $BK_CI_MYSQL_PASSWORD -H $i;done
```

### 配置 coredns

在 **中控机** 执行：

```bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" devops.$BK_DOMAIN codecc.$BK_DOMAIN bktbs.$BK_DOMAIN
./scripts/control_coredns.sh list  # 检查添加的记录。
```

### 配置 version

容器化蓝盾版本需与二进制版本对应，修改 `environments/default/version.yaml` 文件，配置 bk-ci charts version 为 `2.0.68`：

```
cd ~/bkhelmfile/blueking/  # 进入工作目录
sed -i 's/bk-ci:.*/bk-ci: "2.0.68"/' environments/default/version.yaml
grep bk-ci environments/default/version.yaml  # 检查修改结果2.0.68
```

### 配置 custom values

- 目前 编译加速平台（turbo）暂未适配完成，需要临时禁用初始化。
- 需要更新 bkrepo 的配置项，不然上传构件会失败。
- 需要调高部分 pod 的 limit，初次启动很容易超时。（如果你的资源充足，可以调整更多 Pod）。
- 沿用旧版数据库，需要修改数据库信息



1. 二进制中控机操作

- 在/data目录下，生成配置文件 bkci-custom-values.yaml.gotmpl

```
source /data/install/utils.fc
# 生成配置文件
cat >> /data/bkci-custom-values.yaml.gotmpl  <<EOF
init:
  turbo: false
config:
  bkRepoFqdn: bkrepo.{{ .Values.domain.bkDomain }}
auth:
  resources:
    limits:
      cpu: 1500m
      memory: 1500Mi
store:
  resources:
    limits:
      cpu: 1500m
      memory: 1500Mi
openapi:
  resources:
    limits:
      cpu: 1500m
      memory: 1500Mi

# 内部数据源配置
mysql:
  enabled: false
redis:
  enabled: false
elasticsearch:
  enabled: false
mongodb:
  enabled: false
influxdb:
  enabled: false
#外部数据库
externalMysql:
  host: $BK_MYSQL_IP
  port: 3306
  username: $BK_MYSQL_ADMIN_USER
  password: "$BK_MYSQL_ADMIN_PASSWORD"
externalRedis:
  host: $BK_REDIS_IP
  port: 6379
  password: "$BK_REDIS_ADMIN_PASSWORD"
externalElasticsearch:
  host: $BK_ES7_IP
  port: 9200
  username: elastic
  password: "$BK_ES7_ADMIN_PASSWORD"
externalMongodb:
  turbo:
    turboUrl: mongodb://$BK_MONGODB_ADMIN_USER:$BK_MONGODB_ADMIN_PASSWORD@$BK_MONGODB_IP:27017,$BK_MONGODB_IP:27017/db_turbo?authSource=admin
    quartzUrl: mongodb://$BK_MONGODB_ADMIN_USER:$BK_MONGODB_ADMIN_PASSWORD@$BK_MONGODB_IP:27017,$BK_MONGODB_IP:27017/db_quart?authSource=admin
externalInfluxdb:
  host: $BK_CI_INFLUXDB_HOST
  port: 8080
  username: $BK_INFLUXDB_ADMIN_USER
  password: "$BK_INFLUXDB_ADMIN_PASSWORD"
EOF
```

- 推送文件

```
# 推送文件到 kubernetes master 机器上，请注意替换 kubernetes_master_host 为实际的机器IP
kubernetes_master_host=<10.0.0.1>
rsync -avgz /data/bkci-custom-values.yaml.gotmpl root@$kubernetes_master_host:/data/
```



2. 容器化中控机操作

拷贝之前，请确认在容器化环境 `~/bkhelmfile/blueking/environments/default/` 文件中是否有其他自定义内容，如果有，请将文件内容进行合并，避免直接拷贝导致原自定义文件内容被覆盖。

```bash
cp -a /data/bkci-custom-values.yaml.gotmpl ~/bkhelmfile/blueking/environments/default/bkci/
```



### 部署容器化 bk-ci

```bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
helmfile -f 03-bkci.yaml.gotmpl sync  # 部署
```

部署需 5 ~ 10 分钟。上述命令结束后，可在中控机检查所有 Pod 是否正常：

```bash
kubectl get pod -A | grep bk-ci
```

**提示**

**如果部署期间出错，请先查阅 《[问题案例](https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.0/troubles.md)》文档。**

问题解决后，可重新执行 `helmfile` 命令。

### 迁移 CI 应用
- 进入 PaaS 后台 `http://$BK_DOMAIN/admin/app/app/` ，选择蓝盾
- 勾选是否已经提测、是否已经上线、是否为第三方应用，开发者选项至少需要选中一个用户。
- 填写第三方应用 URL： `http://devops.$BK_DOMAIN`
- 前往开发者中心，选择【一键迁移】将蓝盾【迁移到新版开发者中心】，勾选全部选项，开启迁移，最后确认迁移

### 浏览器访问

需要配置域名 `devops.$BK_DOMAIN`，操作步骤已经并入《基础套餐部署》文档的 “[配置用户侧的 DNS](https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.0/install-bkce.md#hosts-in-user-pc)” 章节。

---
## 四、补充操作
### 对接制品库
升级完成后，创建的蓝盾新项目会自动在制品库中创建项目。而在**二进制**版本蓝盾中创建的项目，升级之后，默认**不会**在制品里创建项目，会导致老项目 Upload artifacts 无法使用。
需要手动在制品库里，创建蓝盾对应的项目。

1. 在制品库里，【项目管理】-【创建】创建和蓝盾项目名同名的项目。
2. 选择制品库创建的项目，手动创建以下三个仓库
  - report
  - custom
  - pipeline


### 重新导入节点
在蓝盾升级后，请求的域名有变化。私有构建机需要重新导入后才可以使用。
- cd agent目录 && sh uninstall.sh
- 私有构建机需配置解析蓝盾新域名 `devops.$BK_DOMAIN`
- 【节点管理】- 【导入节点】重装蓝盾 agent



### 公共构建机
- 升级后，之前使用了公共构建机的流水线，构建资源会被置空。
- 重新选择一下构建资源为【Kubernetes构建资源】即可。