# 介绍

蓝鲸服务配置中心为业务提供全面的服务配置管理功能，支持文件型和键值（KV）型配置。通过集中化的配置管理，减少手动配置的工作量，提升配置管理的效率。

>**提示**
>
>* 在部署前，请根据实际业务需求评估其适用性。如果业务不需要复杂的配置管理功能，可以选择不部署此系统。
>* 部署该服务需提前确保蓝鲸集群内每个节点都已安装 Agent。
>* 确保已成功完成 [监控平台](./install-co-suite.md#监控平台) 的部署并提供 [容器监控数据上报](install-co-suite.md#推荐：容器监控数据上报)

# 前置检查

如果为全新部署，可以忽略本章节。从 7.1 升级到 7.2 时，需要做这些检查。

## 版本要求
| release |	chart version | app version |
|--|--|--|
| bk-paas | bkpaas3-1.4.0 | 1.4.0 |
| bkpaas-app-operator | bkpaas-app-operator-1.4.0 | 1.4.0 |
| bk-apigateway | bk-apigateway-1.12.11	| 1.12.11 |
| bk-auth | bkauth-0.0.13 | 0.0.13

## 创建应用 bk_bscp
检查是否已生成蓝鲸 app code 对应的 secret。

``` bash
kubectl -n blueking get cm bkauth-config -ojsonpath='{.data.config\.yaml}' | yq .accessKeys.bk_bscp
```
如果输出为 `null`，则继续操作。显示其他内容则跳过本章节。

在中控机创建 app secret，并重启 bk-auth release 使之生效。
``` bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
./scripts/generate_app_secret.sh environments/default/app_secret.yaml bk_bscp

# 重新部署bkauth
helmfile -f base-blueking.yaml.gotmpl -l name=bk-auth sync
```

# 部署

## 检查 crd

检查命令如下：
```bash
kubectl get crd podmonitors.monitoring.coreos.com -o name
```
>参考输出为：`customresourcedefinition.apiextensions.k8s.io/podmonitors.monitoring.coreos.com`

如果显示 `"podmonitors.monitoring.coreos.com" not found` ，请先完成 [容器监控数据上报](install-co-suite.md#推荐：容器监控数据上报) 文档。

## 配置 coredns
需要在 coredns 注册新的域名，方便其他服务调用。

在中控机执行：
``` bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" bscp.$BK_DOMAIN bscp-api.$BK_DOMAIN
./scripts/control_coredns.sh list  # 检查添加的记录。
```

## 部署 bscp
在中控机执行：
``` bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
helmfile -f 06-bkbscp.yaml.gotmpl sync
# 在admin桌面添加应用，也可以登录后手动添加。如果未曾打开过桌面，则会提示 user(admin) not exists，可忽略。
scripts/add_user_desktop_app.sh -u "admin" -a "bk_bscp"
# 设为默认应用。
scripts/set_desktop_default_app.sh -a "bk_bscp"
```

# 访问

需要配置域名 `bscp.$BK_DOMAIN` 和 `bscp-api.$BK_DOMAIN`，操作步骤已经并入 《部署步骤详解 —— 后台》 文档 的 “[配置用户侧的 DNS](manual-install-bkce.md#hosts-in-user-pc)” 章节。

配置成功后，即可在桌面打开 “服务配置中心” 应用了。


# 下一步
* 回到《[部署基础套餐](install-bkce.md#next)》文档看看其他操作
* 开始 [了解服务配置中心](../../BSCP/1.30/UserGuide/Introduction/product_introduction.md)
