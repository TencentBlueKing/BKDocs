从蓝鲸 7.0 开始，PaaS 默认使用 `image` 格式的 `S-Mart` 包，部署过程中需要访问蓝鲸制品库。

# 配置 node DNS
## 生成配置项
需要确保 node 能正常访问蓝鲸制品库的 Docker Registry 服务（入口域名为前面章节中配置的 `docker.$BK_DOMAIN`）。

一般配置 DNS 系统，或者修改 node 的 `/etc/hosts` 文件实现域名解析。

因为 node 内都使用 服务 IP 访问，所以域名指向 ingress 的 Cluster IP。

在中控机执行命令显示 hosts 项：
``` bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
echo "$IP1 docker.$BK_DOMAIN"
```

## 修改配置
请参考上述显示的 hosts 记录更新所有 node 的 `/etc/hosts` 文件，或者 node 所在的 DNS 服务器。

## 检查配置
在全部 node 上尝试请求蓝鲸制品库的 Docker Registry 服务。

请在 node 上执行，自行替换域名后缀：
``` bash
curl -v docker.bkce7.bktencent.com/v2/
```

预期看到能成功解析 IP，并建立连接。因为刚才的请求没有携带认证信息，所以响应内容提示需要认证，如下所示：
``` plain
{
  "errors" : [ {
    "message" : "authentication required",
    "code" : "UNAUTHORIZED",
    "detail" : "The access controller was unable to authenticate the client. Often this will be accompanied by a Www-Authenticate HTTP response header indicating how to authenticate."
  } ]
}
```
如果没有看到上述提示，说明解析的地址可能不正确，请排查操作步骤及 ingress-nginx 的访问记录。

# 配置容器运行时访问蓝鲸制品库
容器运行时默认使用 https 协议拉取镜像，所以需要额外操作确保正常拉取镜像。

目前仅提供了 “`containerd` 运行时” 的配置方法。如果你从 7.1 升级而来，使用的是 `dockerd`，请查看 7.1 版本的部署文档。

## 配置 containerd
如果你的运行时为 `containerd`，请根据你预期的场景选择对应章节：
* 场景一：忽略 containerd 的 https 证书检查（推荐做法，步骤见下）
* 场景二：补齐环境中的证书信任链（请阅读对应章节获取提示，不提供具体命令）

>**注意**
>
>如果你的运行时为 `containerd`，不能直接照搬下面的命令，需自行研究。注意二者配置文件格式不同。

### 场景一：忽略 containerd 的 https 证书检查

在 **中控机** 执行：
``` bash
cd $INSTALL_DIR/blueking/  # 进入工作目录
# 取全部 node 的ip，包括master
all_nodes="$(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}')"
# 从自定义配置中提取, 也可自行赋值
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml) 
# bkrepo-docker 服务入口
bkrepo_docker_fqdn="docker.$BK_DOMAIN"
for ip in $all_nodes; do
  ssh -n "$ip" "cd /root/bcs-ops && ./k8s/insecure_registry.sh -c containerd -a $bkrepo_docker_fqdn"
done
```
>**注意**
>
>上述步骤均使用 containerd 默认的配置文件路径： `/etc/containerd/certs.d/${registry}` 。如果你的配置文件路径不同，请手动修改。


全部 node 配置成功后，即可继续部署。如果检查发现部分 node 没有生效，请登录到对应 node 逐步操作排查原因。

### 场景二：补齐环境中的证书信任链
在严格要求安全的场合，访问 registry 时应该检查 https 证书。则需要：
1. 变更 ingress-nginx，使用指定的 SSL 证书。此步骤可查阅 k8s 官方的《[Ingress TLS](/etc/containerd/certs.d/${registry})》 文档。
2. 更新各 node 上的 containerd 证书库（`/etc/containerd/certs.d/${registry}`），编写配置文件并放置证书。此步骤请查阅 containerd 官方的《[Registry Configuration](https://github.com/containerd/containerd/blob/main/docs/hosts.md)》文档。

>**提示**
>
>此场景未经完整测试，仅简述技术要点，具体步骤请自行研究。欢迎你在社区分享经验。


<a id="next" name="next"></a>

# 下一步
如果是从快速部署文档跳转过来，可以 [回到快速部署文档继续阅读](install-bkce.md#k8s-node-cri-insecure-registries)。

如果是手动部署，可按需完善 SaaS 运行环境：
* [推荐：上传 PaaS runtimes 到制品库](paas-upload-runtimes.md)
* [可选：配置 SaaS 专用 node](saas-dedicated-node.md)

也可以直接开始部署 SaaS：
* [部署步骤详解 —— SaaS](manual-install-saas.md)

