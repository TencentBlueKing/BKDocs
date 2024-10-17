整个安装过程都在中控机上进行，我们需要准备好部署脚本所需的环境。


# 在中控机安装工具

## 补齐系统命令
如下命令在部署或者下载脚本中会用到。

请在 **中控机** 执行如下命令安装：
``` bash
yum install -y unzip uuid
```

<a id="install-bkdl" name="install-bkdl"></a>

## 安装蓝鲸下载脚本
鉴于目前容器化的软件包数量较多，我们提供了下载脚本帮助你下载文件并制备安装目录。

此脚本无需提供给所有用户，所以我们把它安装到 `~/bin` 目录下：
``` bash
mkdir -p ~/bin/
curl -sSf https://bkopen-1252002024.file.myqcloud.com/ce7/7.2-stable/bkdl-7.2-stable.sh -o ~/bin/bkdl-7.2-stable.sh
chmod +x ~/bin/bkdl-7.2-stable.sh
```

接下来直接执行：
``` bash
bkdl-7.2-stable.sh
```
即可看到命令的用法提示信息。

>**提示**
>
>如果提示 `command not found`，请修正你的 `PATH` 环境变量，确保包含 `$HOME/bin` 目录。


在 `7.2` 版本，下载脚本的默认安装目录变为了 `$HOME/bkce7.2-install/`。

建议配置 `.bashrc` 文件固定 `INSTALL_DIR` 变量：
``` bash
# 下载好的文件默认放置在 `$HOME/bkce7.2-install/` 下，如有修改，请调整此变量。
INSTALL_DIR=$HOME/bkce7.2-install/
# 把上述环境变量写入 bashrc
if grep -q "^export INSTALL_DIR=" ~/.bashrc; then
  source ~/.bashrc
  echo >&2 "load from bashrc: INSTALL_DIR=$INSTALL_DIR."
else
  tee -a ~/.bashrc <<EOF
# 蓝鲸部署目录
export INSTALL_DIR="$INSTALL_DIR"
EOF
fi
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
bkdl-7.2-stable.sh -r latest tools
```

将下载好的命令复制到系统 PATH 路径下：
``` bash
# 安装部署脚本所需的命令到 /usr/local/bin/，请确保此路径在 $PATH 中
for _cmd in helmfile helm yq jq; do
  cp -v "${INSTALL_DIR:-INSTALL_DIR-not-set}/bin/$_cmd" /usr/local/bin/
done
# 安装helm-diff插件到 $HOME 目录。
tar xf "${INSTALL_DIR:-INSTALL_DIR-not-set}/bin/helm-plugin-diff.tgz" -C ~/
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

# 准备 k8s 集群
请准备好一个 k8s 集群，并确保可以在中控机调用 kubectl 管理该集群。

我们适配了如下的场景，请点击前往章节获得对应场景的操作指引：
* [新建 k8s 集群，使用蓝鲸 bcs-ops 脚本](get-k8s-create-bcsops.md) （v1.24 及以上版本，支持 containerd）
* [导入现有的 k8s 集群](get-k8s-import-kubeconfig.md)
* [购买腾讯云 TKE 服务](get-k8s-purchase-tke.md) （其他厂商提供 K8S 集群同理）
