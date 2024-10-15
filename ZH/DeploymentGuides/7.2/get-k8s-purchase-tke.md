>**注意**
>
>本文档待重写，当前内容仅供参考。

# 采购腾讯云 TKE 集群
如需采购其他厂商提供的 K8S 集群服务，请阅读厂商官方的文档。

本文档基于腾讯云官方文档改写。

## 集群需求
- 版本：1.20
- 运行时组件：docker
- 容器网络插件：Global Router
- 容器网络：CIDR 自定义，不跟集群所在 VPC 网络冲突即可；建议：1024 个 Service/集群、128 个 Pod/节点、504 个节点/集群
- node 节点
 	- 基础套餐 8 核 16G 100G 硬盘 x 3 台
 	- 基础+监控日志套餐 8 核 16G 100G 硬盘 x 4 台
- master 节点：可以托管也可以自购 CVM 来独立部署，这里以托管 master 为例
>因为 master 独立部署模式至少需要 3 台 cvm，选择托管集群，另外只需要一台低配的中控机能通过 kubectl 连到集群即可。

## 购买基础套餐部署所需 TKE 集群
https://console.cloud.tencent.com/tke2/cluster?rid=1

![](../7.0/assets/2022-03-09-10-39-04.png)
![](../7.0/assets/2022-03-09-10-39-12.png)
![](../7.0/assets/2022-03-09-10-39-22.png)

## 配置安全组

请注意配置安全组，放行中控机的出口 IP。

# 在中控机管理集群

## 在中控机安装 kubectl
当 **中控机** 为 k8s `master` 时，则可以跳过本章节。

如果已经存在 `kubectl` 命令，请先检查版本，如果和服务端版本不一致，建议重新安装。

如果 **中控机** 为 CentOS 7 系统，可直接使用如下的命令安装：
``` bash
k8s_version=1.20.11  # 推荐安装和服务端相同版本的客户端，如为其他版本，请调整赋值
if ! command -v kubectl; then
  cat > /etc/yum.repos.d/kubernetes.repo <<EOF
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.tencent.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
EOF
  yum makecache fast
  yum install -y kubectl-$k8s_version
fi
```

如为其他系统，你可以参考 k8s 官方文档： https://kubernetes.io/zh/docs/tasks/tools/install-kubectl-linux/

### 配置 kubectl 命令行补全
鉴于 `kubectl` 命令参数复杂，且部分资源实例名称随机。日常进行命令行操作时，启用命令补全功能会大幅提升效率。

在 **中控机** 上执行如下命令：
``` bash
yum install -y bash-completion
mkdir -p /etc/bash_completion.d/
# 写入默认的命令行补全配置文件。
kubectl completion bash > /etc/bash_completion.d/kubectl
# 补全会在下次登录时加载。如需在当前会话补全，主动加载之。
source /etc/bash_completion.d/kubectl
```

## 中控机配置 kubectl 连接集群

在腾讯云导出 kubeconfig ，将其内容写入  **中控机** 的  `~/.kube/config` 路径下即可：
```bash
mkdir -p ~/.kube/
cat > ~/.kube/config <<EOF
此处粘贴从TKE管理界面复制的Kubeconfig内容。
EOF
```

在 TKE 页面的基本信息里可以有具体的指引，参考配置即可：
![](../7.0/assets/2022-03-09-10-39-43.png)

## 检查 k8s 集群节点
在 **中控机** 上执行如下命令：
```bash
kubectl get nodes -o wide
```
其输出如下图所示：<br/>
![](../7.0/assets/2022-03-09-10-39-54.png)

能正常显示则说明已经连上了集群。后续扩容须在腾讯云控制台完成。

# 部署蓝鲸所需的调整项

## 配置默认命名空间
设置 k8s 默认 ns, 方便后续操作。在中控机执行：
``` bash
kubectl config set-context --current --namespace=blueking
```

## 调整 ingress

先部署 ingress-nginx。在中控机执行：
```bash
cd $INSTALL_DIR/blueking
helmfile -f 00-ingress-nginx.yaml.gotmpl sync
```
TKE 集群默认启用了 ingressClass 为 qcloud 的 ingress-controller，需要将它禁用掉：
```bash
kubectl scale --replicas=0 -n kube-system deployment l7-lb-controller
```

否则，默认没有指定 ingressClass 的 LoadBalancerIP 会自动创建一个 CLB 资源，会很浪费（参考 TKE 文档：
https://cloud.tencent.com/document/product/457/45685 ）

如果接入层使用 clb，需要在腾讯云页面上配置下 clb 的以下参数：

```plain
client_max_body_size 10240M;
proxy_request_buffering off;
proxy_read_timeout 600s;
proxy_send_timeout 600s;
```

# 下一步

[部署基础套餐](install-bkce.md)
