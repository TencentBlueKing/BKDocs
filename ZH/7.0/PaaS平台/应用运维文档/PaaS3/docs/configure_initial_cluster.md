# 如何配置初始化集群

## 什么是初始化集群？

Engine 模块提供了初始化集群配置，目的是为了初次安装集群时，能够在部署 `values.yaml` 中快速完成集群配置，加速验证流程。
所以请牢记：该配置只会在初次部署(`helm install`）时生效，安装完成后的若需持续更新集群配置，请通过 `${PAAS_DOMAIN}/backend/admin42/platform/clusters/manage/` 进行管理，同时修改数据后，请重启 Engine 模块的 `main` & `celery` 进程。

## 什么是集群配置？

平台通过 Engine 模块对 K8S 集群进行管理，包括不限于：创建或删除命名空间、创建或删除蓝鲸应用(`Deployment`/`Service`/`Ingress`等)。所以需要在 Engine 模块中配置对应集群的相关信息，包括：

- kube-apiserver 访问地址
- kube-apiserver 访问身份和 `cluster-admin` 权限
- 应用集群访问方式以及入口域名

其中访问方式和集群前置 IP 的配置请参考 [集群前置 IP 配置](./configure_ingress_front_ip.md)。
下面具体来介绍如何配置 kube-apiserver 的访问身份和如何配置 `cluster-admin` 权限。

## 获取 ApiServer 访问证书

### BCS 集群

如果你的应用集群是通过 BCS 服务生成且托管的集群，那么你可以在 Master 节点的 `/etc/kubernetes/ssl/` 中找到已签发的证书。

其中 `ca.pem`、`apiserver.pem`、`apiserver-key.pem` 就对应了初始化配置中的 `caData`、`certData`、`keyData`，将其中内容进行 `base64` 编码，填入 `values.yaml` 中。

### 自建集群

如果你的应用集群**仅是通过 BCS 服务托管而非生成的**，你需要通过 `cat $HOME/.kube/config` 查看访问证书，并仿照上一小节，将证书内容编码并正确填写。

> 如不使用“客户端证书”方式校验，可不填写 `certData` 与 `keyData` 字段，详情参考本文档的“选择集群身份校验方式”部分。

### 选择集群身份校验方式

当前，你可以使用两种不同的身份校验方式：“客户端证书”或“Bearer Token”。

#### 1. 客户端证书

如需使用“客户端证书”方式完成身份校验，请配置 `certData`、`keyData` 两个字段（均需 base64 编码），并确保该证书签发的身份在 K8S RBAC 权限体系中拥有 `cluster-admin` 的身份，否则请按照 [部署 FAQ](./deploy_faq.md#q-为什么-workloads-项目提示无权限获取到应用集群信息) 处理。

#### 2. Bearer Token

使用“Bear Token”完成身份校验，你首先需要拿到一个有效的 Token。获取集群 token 最常见的方式，是创建一个属于 `cluster-admin` 角色的 ServiceAccount 账号，然后使用该账号的 token。

举个例子，下面的 YAML 资源会在集群的 `kube-system` 命名空间中创建一个名为 `admin-user` 的具有 `cluster-admin` 权限的 ServiceAccount 对象：

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system
```

之后执行以下命令就可获取 Token：

```console
# 读取 token 所在 Secret 名称
$ TOKENNAME=`kubectl -n kube-system get serviceaccount/admin-user -o jsonpath='{.secrets[0].name}'`

# 读取并打印 Token（base64 解码过的）
$ kubectl -n kube-system get secret $TOKENNAME -o jsonpath='{.data.token}'| base64 --decode
eyJhbGciOiJSUzI1NiIsImtp...
```

最后将该 Token 填入 paas-stack 模块的 `workloads.initialCluster.tokenValue` 配置项中即可完成身份校验配置。

可以查阅 [paas-stack 配置说明](../cores/paas-stack/README.md#初始化集群配置) 了解更多。
