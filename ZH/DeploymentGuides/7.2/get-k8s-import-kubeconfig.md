# 使用已有的 k8s 集群

## 在中控机安装 kubectl
当 **中控机** 为 k8s `master` 时，则可以跳过本章节。

如果已经存在 `kubectl` 命令，请先检查版本，如果和服务端版本不一致，建议重新安装。

如果中控机和 `master` 系统版本一致，可将 `master` 上的 `/usr/bin/kubectl` 复制到 **中控机** 的 `/usr/bin/` 路径下。

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

## 从 master 取得 kubeconfig

登录到 master，确认存在 `~/.kube/config`。
   * 如果能访问到 `master` 上的文件，可将 `master` 上的 `~/.kube/config`（或 `/etc/kubenetes/admin.conf`）复制到 **中控机** 的 `~/.kube/config` 路径下。
   * 如果使用了 k8s 云服务，则厂商一般会提供 kubeconfig 导出功能，复制内容并写入 **中控机** 的 `~/.kube/config` 路径下即可。
   * 其他情况请自行解决。

## 中控机配置 kubectl 连接集群

需要更新 **中控机** 的 `/etc/hosts` 文件确保可访问 kubeconfig 文件中 k8s server。

将 kubeconfig 写入 **中控机** 默认配置路径：`~/.kube/config`。

## 检查 k8s 集群节点
在 **中控机** 上执行如下命令：
```bash
kubectl get nodes
```
其输出如下所示：
``` plain
# kubectl get nodes
NAME             STATUS   ROLES           AGE   VERSION
master-10-0-0-1  Ready    control-plane   14h   v1.24.15
node-10-0-0-2    Ready    <none>          13h   v1.24.15
node-10-0-0-3    Ready    <none>          13h   v1.24.15
node-10-0-0-4    Ready    <none>          13h   v1.24.15
node-10-0-0-5    Ready    <none>          13h   v1.24.15
node-10-0-0-6    Ready    <none>          13h   v1.24.15
```

如需了解对应  `node`  的详情，可使用命令：
```bash
kubectl describe nodes NAME  # NAME参数为 kubectl get nodes输出的 NAME 列
```

### kubectl 的常见报错
1. `Unable to connect to the server: dial tcp: lookup k8s-api.bcs.local: no such host`，请确保 **中控机** 能正常解析  `~/.kube/config` 文件中的 `cluster.server` 配置项中的域名。
2. `The connection to the server k8s-api.bcs.local:6443 was refused - did you specify the right host or port?`，请确保 **中控机** 到 `k8s-api.bcs.local` （提示的域名）的 6443 端口。一般需要检查目的服务器的防火墙，云服务器需额外检查安全组。
3. `Unable to connect to the server: dial tcp 10.0.0.254:6443: i/o timeout`，请确保 **中控机** 到 `k8s-api.bcs.local` （提示的域名）的网络可互通，以及目的服务器的防火墙，云服务器需额外检查安全组。


# 部署蓝鲸所需的调整项

## 配置默认命名空间
设置 k8s 默认 ns, 方便后续操作。在中控机执行：
``` bash
kubectl config set-context --current --namespace=blueking
```

## 可选：配置 ssh 免密登录
部署脚本中不会登录到其他节点，本文档中为了方便你快速上手，一些命令片段会从直接中控机上调用 `ssh` 登录 k8s node（包括 master） 执行命令。

如果你提前配置免密登录，则可直接复制这些命令使用。

>**提示**
>
>如果你所在的公司有安全规范禁止直接添加公钥授权，可跳过此章节，到时手动 ssh 到对应机器操作即可。

在 **中控机** 执行如下命令：
``` bash
# 集群所有机器的IP
node_ips=$(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}')
test -f /root/.ssh/id_rsa || ssh-keygen -N '' -t rsa -f /root/.ssh/id_rsa  # 如果不存在rsa key则创建一个。
# 开始给发现的ip添加ssh key，期间需要你输入各节点的密码。
for ip in $node_ips; do
  ssh-copy-id "$ip" || { echo "failed on $ip."; break; }  # 如果执行失败，则退出
done
```

常见报错：
1. `Host key verification failed.`，且开头提示 `REMOTE HOST IDENTIFICATION HAS CHANGED`: 检查目的主机是否重装过。如果确认没连错机器，可以使用 `ssh-keygen -R IP地址` 命令删除 `known_hosts` 文件里的记录。

# 下一步

[部署基础套餐](install-bkce.md)
