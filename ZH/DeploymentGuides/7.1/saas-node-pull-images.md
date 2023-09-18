从蓝鲸 7.0 开始，PaaS 默认使用 `image` 格式的 `S-Mart` 包，部署过程中需要访问蓝鲸制品库。

# 配置 node DNS
## 生成配置项
需要确保 node 能正常访问蓝鲸制品库的 docker registry 服务（入口域名为前面章节中配置的 `docker.$BK_DOMAIN`）。

一般配置 DNS 系统，或者修改 node 的 `/etc/hosts` 文件实现域名解析。

因为 node 内能访问 服务 IP，所以一个配置添加 `bkrepo docker` 域名： `docker.$BK_DOMAIN`。

在中控机执行命令显示 hosts 项：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
echo "$IP1 docker.$BK_DOMAIN"
```

## 修改配置
请参考上述显示的 hosts 记录更新所有 node 的 `/etc/hosts` 文件，或者 node 所在的 DNS 服务器。

## 检查配置
在全部 node 上尝试请求制品库提供的 docker 服务。

请在 node 上执行，自行替换域名后缀：
``` bash
curl -v docker.bkce7.bktencent.com/v2/
```

预期看到能成功解析 IP，并建立连接。然后提示认证，其响应如下：
``` plain
{
  "errors" : [ {
    "message" : "authentication required",
    "code" : "UNAUTHORIZED",
    "detail" : "The access controller was unable to authenticate the client. Often this will be accompanied by a Www-Authenticate HTTP response header indicating how to authenticate."
  } ]
}
```

如果没有看到制品库 docker 服务返回的认证提示，说明解析的地址可能不正确，请排查操作步骤及 ingress-nginx 的访问记录。

# 配置 docker 运行时访问蓝鲸制品库
k8s 运行时默认使用 https 协议拉取镜像，所以需要额外操作确保正常拉取镜像。

目前仅提供了 `dockerd` 运行时 的配置方法，如果你使用 `containerd`，请自行尝试配置方法。

## 配置 dockerd
如果你的运行时为 `dockerd`，请根据你预期的场景选择对应章节：
* 场景一：调整 dockerd 使用 http 协议访问 registry（推荐做法，步骤见下）
* 场景二：配合 dockerd 默认行为（不提供操作步骤，请阅读对应章节获取提示）
>**注意**
>
>如果你的运行时为 `containerd`，不能直接照搬下面的命令，需自行研究。注意二者配置文件格式不同。

### 场景一：调整 dockerd 使用 http 协议访问 registry

docker 服务端支持使用 http 协议拉取镜像，但需要调整配置项。

本章节命令在 **中控机** 执行，请先进入工作目录：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
```

然后按步骤操作：
>**注意**
>
>下面的步骤均使用 docker 默认的配置文件路径： `/etc/docker/daemon.json` 。如果你的 k8s dockerd 配置文件路径不同，请注意修改。

1.  获取当前配置文件作为模板。接下来会使用此文件模板覆盖全部 node 上的对应路径，如果各 node 配置文件内容不同，请自行分批获取模板。
    * 如果中控机不是 k8s master，建议从 master 上获取：
      ``` bash
      # 取第一台master的ip
      first_master=$(kubectl get nodes -l node-role.kubernetes.io/master -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
      scp "$first_master":/etc/docker/daemon.json daemon.json.orig
      ```
    * 如果中控机是 master：
      ``` bash
      cp /etc/docker/daemon.json daemon.json.orig
      ```
2.  生成新的配置文件：
    ``` bash
    BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
    jq --arg k "insecure-registries" --arg v "docker.$BK_DOMAIN" 'if .[$k]|index($v) then . else .[$k]+=[$v] end' daemon.json.orig | tee daemon.json
    ```
3.  将新生成的 `daemon.json` 分发到全部 k8s node 上的 `/etc/docker/daemon.json`（如果各 node 配置文件路径不同，请自行分批操作。）：
    ``` bash
    # 取全部 node 的ip，包括master
    all_nodes="$(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}')"
    now=$(date +%Y%m%d-%H%M%S)
    for ip in $all_nodes; do
      ssh "$ip" "cp /etc/docker/daemon.json /etc/docker/daemon.json.bak-$now"
      scp daemon.json "$ip":/etc/docker/daemon.json
      ssh "$ip" "diff /etc/docker/daemon.json /etc/docker/daemon.json.bak-$now"
    done
    ```
4.  然后通知 docker 服务重载配置文件。在中控机执行如下命令可以通知全部 node 上的 docker 服务：
    ``` bash
    # 取全部 node 的ip，包括master
    all_nodes="$(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}')"
    for ip in $all_nodes; do
      ssh "$ip" "systemctl reload dockerd.service || systemctl reload docker.service"
    done
    ```
    视 docker 部署方式差异，docker 服务名有 `docker.service` 和 `dockerd.service` 两种情况。
    当下一步检查发现未生效时，可能是配置文件异常，可以登录到 node 上检查服务的 journal：`journalctl -xeu docker服务的名字`。
5.  检查确认已经生效：
    ``` bash
    # 取全部 node 的ip，包括master
    all_nodes="$(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}')"
    for ip in $all_nodes; do
      echo "=== config in $ip: ==="
      ssh "$ip" "docker info | sed -n '/Insecure Registries:/,/^ [^ ]/p'"
    done
    ```
    预期输出如下所示，可看到新添加的 `docker.$BK_DOMAIN` ：
    ``` yaml
     Insecure Registries:
      docker.bkce7.bktencent.com
      127.0.0.0/8
     Registry Mirrors:
    ```

全部 node 配置成功后，即可继续部署。如果检查发现部分 node 没有生效，请登录到对应 node 逐步操作排查原因。

### 场景二：配合 docker 服务默认行为
如果希望使用 https 协议访问 registry。则需要变更 ingress-nginx，并更新各 node 证书库。确保 node 和 registry 间能成功建立 SSL 连接。

>**提示**
>
>此场景未经完整测试，仅简述技术要点，具体步骤请自行研究。欢迎你在社区分享经验。

第一步需要调整 ingress-nginx，为 `docker.$BK_DOMAIN` 域名启用 SSL 并配置证书。

然后根据你的证书情况检查全部 node（包括 master）：
* 如果你为 `docker.$BK_DOMAIN` 域名购买了商业证书，则系统预置了 root CA，无需额外操作。如果依旧提示证书不可信，可以先尝试更新 node 所在系统的根证书包（CentOS 7 使用 `yum install ca-certificates` 命令更新）。
* 如使用了自签的证书，则：
  1. 为 node 添加自签证书（PEM 格式）的 root CA 到此路径：`/etc/docker/cert./docker.$BK_DOMAIN/ca.crt`。（建议一并更新操作系统 root CA 数据库。）
  2. 重启 node 上的 docker 服务。

>**提示**
>
>docker ssl 的更多配置可以参考 [docker 官方文档](https://docs.docker.com/engine/security/certificates/)。


<a id="next" name="next"></a>

# 下一步
继续完善 SaaS 运行环境：
* [推荐：上传 PaaS runtimes 到制品库](paas-upload-runtimes.md)
* [可选：配置 SaaS 专用 node](saas-dedicated-node.md)

也可以直接开始部署 SaaS：
* [部署步骤详解 —— SaaS](manual-install-saas.md)

如果是从快速部署文档跳转过来，可以 [回到快速部署文档继续阅读](install-bkce.md#k8s-node-docker-insecure-registries)。
