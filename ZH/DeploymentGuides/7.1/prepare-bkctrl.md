整个安装过程都在中控机上进行，我们需要准备好部署脚本所需的环境。

# 检查 k8s 集群
在前面的章节中，你已经选择了适合的 k8s 集群，现在需要在中控机管理。

## 在中控机安装 kubectl
当 **中控机** 为 k8s `master` 时，已经存在 `kubectl` 命令，可以跳过本章节。

如果已经存在 `kubectl` 命令，请先检查版本，如果和服务端版本不一致，建议重新安装。

如果 **中控机** 为 CentOS 7 系统，可直接使用如下的命令安装：
``` bash
k8s_version=1.20.11  # 推荐安装和服务端相同版本的客户端，如为其他版本，请重新赋值
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

## 配置 kubectl 命令行补全
在部署和日常维护时，启用补全会方便我们在命令行操作。因为 `kubectl` 命令参数十分复杂，且 pod 名称可能随机。

在 **中控机** 上执行如下命令：
``` bash
yum install -y bash-completion
mkdir -p /etc/bash_completion.d/
kubectl completion bash > /etc/bash_completion.d/kubectl  # 添加命令行补全
source /etc/bash_completion.d/kubectl  # 补全会在下次登录时加载，如需在当前会话补全，主动加载之。
```

## 检查 k8s 集群节点
在 **中控机** 上执行如下命令：
```bash
kubectl get nodes -o wide
```
其输出如下图所示：

![](../7.0/assets/2022-03-09-10-34-42.png)

当  `STATUS`  列的值为  `Ready` ，即表示此 `node` 已经成功加入集群且工作正常。

如需了解对应  `node`  的详情，可使用命令：
```bash
kubectl describe nodes NAME  # NAME参数为 kubectl get nodes输出的 NAME 列
```

### kubectl 的常见报错
1. `Unable to connect to the server: dial tcp: lookup k8s-api.bcs.local: no such host`，请确保 **中控机** 能正常解析  `~/.kube/config` 文件中的 `cluster.server` 配置项中的域名。
2. `The connection to the server k8s-api.bcs.local:6443 was refused - did you specify the right host or port?`，请确保 **中控机** 到 `k8s-api.bcs.local` （提示的域名）的 6443 端口。一般需要检查目的服务器的防火墙，云服务器需额外检查安全组。
3. `Unable to connect to the server: dial tcp 10.0.0.154:6443: i/o timeout`，请确保 **中控机** 到 `k8s-api.bcs.local` （提示的域名）的网络可互通，以及目的服务器的防火墙，云服务器需额外检查安全组。


# 在中控机安装工具

<a id="install-bkdl" name="install-bkdl"></a>

## 安装蓝鲸下载脚本
鉴于目前容器化的软件包数量较多，我们提供了下载脚本帮助你下载文件并制备安装目录。

此脚本无需提供给所有用户，所以我们把它安装到 `~/bin` 目录下：
``` bash
mkdir -p ~/bin/
curl -sSf https://bkopen-1252002024.file.myqcloud.com/ce7/7.1-stable/bkdl-7.1-stable.sh -o ~/bin/bkdl-7.1-stable.sh
chmod +x ~/bin/bkdl-7.1-stable.sh
```

接下来直接执行：
``` bash
bkdl-7.1-stable.sh
```
即可看到命令的用法提示信息。

在 `7.1` 版本，下载脚本的默认输出目录变为了 `$HOME/bkce7.1-install/`。

>**提示**
>
>如果提示 `command not found`，请修正你的 `PATH` 环境变量，确保包含 `$HOME/bin` 目录。

## 补齐系统命令
如下命令在部署或者下载脚本中会用到。

请在 **中控机** 执行如下命令安装：
``` bash
yum install -y unzip uuid
```

## 安装部署所需的工具
中控机需要安装如下命令。
* `jq`：部署脚本会调用 `jq` 命令，用于在中控机解析服务端 API 返回的 JSON 响应。
* `yq`：用于解析 helmfile 模板以及 values 文件（YAML 格式）。
* `helm`：蓝鲸使用 helm 进行编排。
* `helm-diff`：用于比较 helm release 差异。方便增量更新。
* `helmfile`：鉴于 helm release 数量较多，我们使用 helmfile 来控制流程和管理配置。

使用下载脚本下载 `tools`：
``` bash
bkdl-7.1-stable.sh -r latest tools
```

将下载好的命令复制到系统 PATH 路径下：
``` bash
# 下载好的文件默认放置在 `$HOME/bkce7.1-install/` 下，如有修改，请调整此变量。
INSTALL_DIR=$HOME/bkce7.1-install/
# 安装生成配置所需的命令
for _cmd in helmfile helm yq jq; do
  cp -v "${INSTALL_DIR:-INSTALL_DIR-not-set}/bin/$_cmd" /usr/local/bin/
done
# 安装helm-diff插件
tar xf ../bin/helm-plugin-diff.tgz -C ~/
```

检查 helm diff 插件：
``` bash
helm plugin list
```
预期输出 diff 及其版本：
``` plain
NAME	VERSION	DESCRIPTION
diff	3.1.3  	Preview helm upgrade changes as a diff
```

## 配置默认命名空间
设置 k8s 默认 ns, 方便后续操作.
``` bash
kubectl config set-context --current --namespace=blueking
```

# 可选：配置 ssh 免密登录
>**提示**
>
>部署脚本没有要求配置 ssh 免密。如果你所在的公司有安全规范禁止直接添加公钥授权，可以跳过此步骤。

本文档中会提供命令片段方便你快速使用。其中部分脚本可能会从直接中控机上调用 `ssh` 在 k8s node 上执行远程命令，所以需提前配置免密登录。

在 **中控机** 执行如下命令：
``` bash
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
继续 [部署基础套餐](install-bkce.md)
