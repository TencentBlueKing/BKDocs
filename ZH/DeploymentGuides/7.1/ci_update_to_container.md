# 容器化CI1.9-2.0

## 概述

本文档为二进制版蓝盾升级为容器化蓝盾指引，升级后数据库沿用二进制版本所使用的数据库。
本文档基础环境如下：
- 蓝鲸基础套餐 v7.0
- 蓝盾 chartVersion：v2.0.68


----
## 一、升级蓝鲸版本到 7.1

### 蓝鲸升级

蓝盾2.0版本对蓝鲸基础组件有依赖，因此蓝鲸版本需升级到 7.1。
请按照升级文档进行升级操作：https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.1/v70-upgrade-to-v71.md 

### 流程服务

新的 RBAC 权限方案由 **权限中心** 提供能力支撑，会调用 **流程服务** 处理权限单据，请提前安装。


----
## 二、升级蓝盾

### 1、检查蓝盾版本号

cd ~/bkce7.1-install/blueking/  # 进入工作目录
修改 `environments/default/version.yaml` 文件，配置 bk-ci charts version 为 `3.0.10-beta.2`：
```
sed -i 's/bk-ci:.*/bk-ci: "3.0.10-beta.2"/' environments/default/version.yaml
grep bk-ci environments/default/version.yaml  # 检查修改结果
```
预期输出：
>bk-ci: "3.0.10-beta.2"


### 2、修改 custom values

基于 7.1.0 版本部署时，需要调整一些默认配置：
- 优化镜像下载地址。
- 修改 rabbitmq 插件下载地址，保障下载速度。
- 禁用 ci 插件下载，如果用户访问 GitHub 不稳定，可能因此导致部署超时。
- 编译加速暂未开放，禁用相关对接功能。
- 需要调高部分 pod 的 limit，初次启动很容易超时。

请创建或修改 environments/default/bkci/bkci-custom-values.yaml.gotmpl，配置内容如下：
```
global:
  imageRegistry: {{ .Values.imageRegistry }}

kubernetes-manager:
  kubernetesManager:
    image: {{ .Values.imageRegistry }}/blueking/bkci-kubernetes-manager:0.0.31
    buildAndPushImage:
      image: {{ .Values.imageRegistry }}/kaniko-project/executor:v1.9.0

rabbitmq:
  communityPlugins: https://bkopen-1252002024.file.myqcloud.com/ce7/files/rabbitmq_delayed_message_exchange-3.8.17.8f537ac.ez

turbo:
  enabled: false
init:
  turbo: false
  plugin:
    enabled: false

config:
  bkCiAuthProvider: rbac
  bkCiIamUrlPrefix: {{ .Values.bkDomainScheme }}://bkiam.{{ .Values.domain.bkDomain }}
  bkCiItsmUrlPrefix: {{ .Values.bkDomainScheme }}://apps.{{ .Values.domain.bkDomain }}/bk--itsm
  bkCiItsmApigwUrl: {{ .Values.bkDomainScheme }}://bkapi.{{ .Values.domain.bkDomain }}/api/bk-itsm/prod
  bkCiIamApigwUrl: {{ .Values.bkDomainScheme }}://bkapi.{{ .Values.domain.bkDomain }}/api/bk-iam/prod
  bkCiIamSystemId: bk_ci_rbac
  bkCiIamMigrateToken: 9sBQj!M0
  bkCiIamWebUrl: {{ .Values.bkDomainScheme }}://bkiam.{{ .Values.domain.bkDomain }}
  bkIamPrivateUrl: {{ .Values.bkDomainScheme }}://bkiam.{{ .Values.domain.bkDomain }}

auth:
  resources:
    limits:
      cpu: 2
      memory: 1500Mi
store:
  resources:
    limits:
      cpu: 2
      memory: 1500Mi
process:
  resources:
    limits:
      cpu: 1500m
      memory: 1500Mi
```
### 3、配置 coredns

在 **中控机** 执行：
```
cd ~/bkce7.1-install/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" devops.$BK_DOMAIN
./scripts/control_coredns.sh list  # 检查添加的记录。
```
### 4、部署蓝盾

请在 **中控机** 执行：
```
cd ~/bkce7.1-install/blueking/  # 进入工作目录
helmfile -f 03-bkci.yaml.gotmpl sync  # 部署
在admin桌面添加应用，也可以登录后自行添加。
scripts/add_user_desktop_app.sh -u "admin" -a "bk_ci"
设为默认应用。
scripts/set_desktop_default_app.sh -a "bk_ci"
```部署需 5 ~ 10 分钟。上述命令结束后，可在中控机检查所有 Pod 是否正常：
```
kubectl get pod -A | grep bk-ci
>**提示**
>**如果部署期间出错，请先查阅 《问题案例》文档。**
>问题解决后，可重新执行 helmfile 命令。


### 5、数据迁移

>2.0相对于1.0的版本,权限从对接权限中心v3升级到对接权限中心rbac。
对鉴权数据做了较大的变更 所以升级后, 需要调用命令做变更后数据迁移

蓝盾 MySQL 执行
```
# 进入蓝盾 MySQL
kubectl exec -it -n blueking $(kubectl get pods -n blueking |grep bk-ci-mysql|awk '{print $1}') -- mysql -uroot -pblueking

# 删除冲突
DELETE FROM devops_ci_auth.T_AUTH_IAM_CALLBACK WHERE RESOURCE IN ("experience_task", "experience_group");
```
蓝盾 auth Pod 执行
```
# 进入 auth pod
kubectl exec -it -n blueking $(kubectl get pods -n blueking |grep bk-ci-auth|awk '{print $1}') -- bash

# 数据迁移
curl -XPOST http://127.0.0.1/api/op/auth/migrate/allToRbac
```
迁移结果检查
```
# 进入蓝盾 MySQL
kubectl exec -it -n blueking $(kubectl get pods -n blueking |grep bk-ci-mysql|awk '{print $1}') -- mysql -uroot -pblueking

# 检查结果
select * from devops_ci_auth.T_AUTH_MIGRATION\G
```
说明：
- status有三个值，0-迁移中,1-迁移成功,2-迁移失败
- 迁移中的项目不要访问，请求可能会报资源不存在


### 6、已知问题

蓝盾升级后，之前使用了公共构建机的流水线可能会报错。
在页面上重新选择一下公共构建机即可。


----
## 三、对接制品库

蓝盾依靠蓝鲸制品库来提供流水线仓库和自定义仓库，需要调整制品库的认证模式。
当 bk-ci release 成功启动后，我们开始配置蓝鲸制品库，并注册到蓝盾中。
### 修改 bk-repo custom values

请在 **中控机** 执行：
```
cd ~/bkce7.1-install/blueking/  # 进入工作目录
case $(yq e '.auth.config.realm' environments/default/bkrepo-custom-values.yaml.gotmpl 2>/dev/null) in
  null|"")
    tee -a environments/default/bkrepo-custom-values.yaml.gotmpl <<< $'auth:\n  config:\n    realm: devops'
  ;;
  devops)
    echo "environments/default/bkrepo-custom-values.yaml.gotmpl 中配置了 .auth.config.realm=devops, 无需修改."
  ;;
  *)
    echo "environments/default/bkrepo-custom-values.yaml.gotmpl 中配置了 .auth.config.realm 为其他值, 请手动修改值为 devops."
  ;;
esac
```
修改成功后，继续在工作目录执行如下命令使修改生效：
```
helmfile -f base-blueking.yaml.gotmpl -l name=bk-repo apply
```
### 检查配置是否生效

检查 release 生效的 values 和 configmap 是否重新渲染。
请在 **中控机** 执行：
```
helm get values -n blueking bk-repo | yq e '.auth.config.realm' - ;\
kubectl get cm -n blueking bk-repo-bkrepo-auth -o json | jq -r '.data."application.yml"' | yq e '.auth.realm' -
```
预期 2 条命令均显示 devops。如果任意配置没有生效，请检查上述 helmfile 命令的输出是否正常。
### 重启 bk-repo auth 微服务

因为 deployment 没有变动，所以不会自动重启，此处需要单独重启：
```
kubectl rollout restart deployment -n blueking bk-repo-bkrepo-auth
```
### 在蓝盾中注册制品库

请在 **中控机** 执行：
```
cd ~/bkce7.1-install/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
# 向project微服务注册制品库
kubectl exec -i -n blueking deploy/bk-ci-bk-ci-project -- curl -sS -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'X-DEVOPS-UID: admin' -d "{\"showProjectList\":true,\"showNav\":true,\"status\":\"ok\",\"deleted\":false,\"iframeUrl\":\"//bkrepo.$BK_DOMAIN/ui/\"}" "http://bk-ci-bk-ci-project.blueking.svc.cluster.local/api/op/services/update/Repo"
```