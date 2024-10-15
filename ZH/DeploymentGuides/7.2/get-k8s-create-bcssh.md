
# 使用 bcs.sh 快速部署 k8s 集群
bcs.sh 是蓝鲸容器管理平台 **早期** 的 k8s 新建集群方案。仅支持 k8s v1.20 版本，使用 docker 作为运行时。

## 部署初始 master
欢迎使用蓝鲸提供的 `bcs.sh` 脚本快速部署 k8s 集群。

请在 **第一台 `master` 机器**（下文称为 **初始 master**，新手用户建议复用 **中控机**）上执行此命令：
``` bash
curl -fsSL https://bkopen-1252002024.file.myqcloud.com/ce7/bcs.sh | bash -s -- -i k8s
```

安装成功后输出如下图所示（红框内的命令会在扩容章节里说明获取方法，此时无需保存）:
![](../7.0/assets/bcssh-k8sctrl-add-node-cmds.png)

这表示你成功部署了一个 k8s 集群，此时你可以使用 `kubectl` 命令了。接下来开始添加节点吧。

## 扩容节点
### 获取扩容命令
在 **初始 master** 机器上执行如下命令可显示扩容命令：
``` bash
curl -fsSL https://bkopen-1252002024.file.myqcloud.com/ce7/bcs.sh | bash -s -- -i k8sctrl
```
上述命令的输出如下图所示，不同类型的节点扩容命令不同，请按需选择：
* 如果要扩容 `master`，请复制 **扩容控制平面** 下方的全部命令（已用红框标出）。注意 master **总数量** 应该为 **奇数**，一般为 1、3、5，如需更多 master，请根据集群规模谨慎评估。扩容后请自行参考 k8s 官网文档配置高可用。
* 如果要扩容 `node`，请复制 **扩容节点** 下方的全部命令（已用红框标出）。

![](../7.0/assets/bcssh-k8sctrl-add-node-cmds.png)

### 执行扩容
>**提示**
>
>同一类型的机器扩容命令相同。

在待扩容的机器上粘贴刚才复制的命令。扩容成功后, 会在结尾输出:
``` text
This node has joined the cluster:
* Certificate signing request was sent to apiserver and a response was received.
* The Kubelet was informed of the new secure connection details.

Run 'kubectl get nodes' on the control-plane to see this node join the cluster.

[INFO]: 添加Kubernetes节点成功

[INFO]: LAN_IP: 10.0.0.5
  Welcome to BCS on qcloud
```

### 可选：扩容后调整 dockerd
当你计划使用内网 docker registry 加速部署时，请根据你的 registry 情况配置 dockerd：
* 如果使用 HTTP 协议，请配置 `insecure-registries` 选项。
* 如果使用 HTTPS 协议，请在 `/etc/docker/certs.d/服务器地址:服务器端口/ca.crt` 路径放置证书。

# 在中控机管理集群

## 在中控机安装 kubectl

如果你的 **中控机** 同时兼任 `master`，则可 **跳过本章节**。

本文预期 **中控机** 和 `master` 的操作系统相同，故直接复制二进制到中控机使用。如为其他系统，你可以参考 k8s 官方文档安装： https://kubernetes.io/zh/docs/tasks/tools/install-kubectl-linux/

在 **中控机** 上执行如下命令（请赋值 `master_ip`为 master 的 IP）：
```bash
master_ip=10.0.0.2  # 请自行修改为bcs.sh所部署的master ip，建议配置好中控机免密登录。
scp "$master_ip":/usr/bin/kubectl /usr/bin/
```

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

## 配置 kubectl 连接集群

如果你的 **中控机** 同时兼任 `master`，则可 **跳过本章节**。

需要将 `master` 上的 `~/.kube/config` 复制到 **中控机** 的 `~/.kube/config` 路径下。

在 **中控机** 上执行如下命令（请替换 `k8s-master`为具体的主机名或 IP）：
```bash
master_ip=10.0.0.2  # 请自行修改为bcs.sh所部署的master ip，建议配置好中控机免密登录。
mkdir -p ~/.kube
# 复制kubeconfig，如未配置免密登录请输入master的密码
scp "$master_ip":.kube/config ~/.kube/config
# 导出master上的bcs hosts配置到中控机，如未配置免密登录请输入master的密码
grep bcs.local /etc/hosts || ssh "$master_ip" grep bcs.local /etc/hosts | tee -a /etc/hosts
```

## 检查 k8s 集群节点
在 **中控机** 上执行如下命令：
```bash
kubectl get nodes -o wide
```
其输出如下图所示：<br/>
![](../7.0/assets/2022-03-09-10-34-42.png)

当  `STATUS`  列的值为  `Ready` ，即表示此 `node` 已经成功加入集群且工作正常。

如需了解对应  `node`  的详情，可使用命令：
```bash
kubectl describe nodes NAME  # NAME参数为 kubectl get nodes输出的 NAME 列
```

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
