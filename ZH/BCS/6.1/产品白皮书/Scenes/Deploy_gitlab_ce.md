# 在 K8S 中部署 GitLab

## 情景

GitLab，不仅仅一个独立部署的流行 Git 代码托管仓库，通过其 Pipeline 具备部分 CI 环节的能力，接下来看 BCS 如何快速部署 GitLab。

## 前提条件

- [了解 Helm 的使用方法](../Function/helm/ServiceAccess.md)
- [集成 K8S 存储](../Function/StorageSolution/kubernetes.md)，例如 [将 NFS 作为 K8S PV Provisioner](../Function/StorageSolution/K8s_NFS_Client_Provisioner.md)
- Git Clone [Helm Charts](https://github.com/helm/charts/)
- 新增 [LoadBalancer](../Function/NetworkSolution/k8s/LoadBalancer.md)

## 操作步骤

1. 上传 GitLab Chart 到仓库

2. 部署 GitLab

3. 访问测试

## 上传 GitLab Chart 到仓库

进入 [Charts](https://github.com/helm/charts/) 本地仓库的 gitlab-ce 目录。

```bash
# cd charts/stable/gitlab-ce/

# ll
总用量 28
-rwxr-xr-x 1 root root  365 8月  27 17:00 Chart.yaml
-rw-r--r-- 1 root root 2502 8月  27 17:00 README.md
-rw-r--r-- 1 root root  336 8月  27 17:00 requirements.lock
-rw-r--r-- 1 root root  209 8月  27 17:00 requirements.yaml
drwxr-xr-x 2 root root 4096 9月  13 15:14 templates
-rw-r--r-- 1 root root 3445 8月  27 17:00 values.yaml
```

可以看到存在 requirements.yaml 文件，了解 GitLab 依赖 redis、postgresql 的 Chart。

```bash
# cat requirements.yaml
dependencies:
- name: redis
  version: 0.9.0
  repository: https://kubernetes-charts.storage.googleapis.com/
- name: postgresql
  version: 0.8.1
  repository: https://kubernetes-charts.storage.googleapis.com/
```

在当前目录使用 Helm 命令下载依赖包。

```bash
# helm dep build
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "joyfulgame" chart repository
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
Saving 2 charts
Downloading redis from repo https://kubernetes-charts.storage.googleapis.com/
Downloading postgresql from repo https://kubernetes-charts.storage.googleapis.com/
Deleting outdated charts
```

推送 Chart 到仓库

```bash
# helm push . joyfulgame
Pushing gitlab-ce-0.2.2.tgz to joyfulgame...
Done.
```

在 BCS 【Chart 仓库】菜单中，点击【同步仓库】，将刚刚上传的 Chart 从仓库同步到 BCS 的界面中。

## 部署 GitLab

在 BCS 【Chart 仓库】菜单中，找到刚刚上传的 GitLab Chart ，点击【部署】。

![-w1678](../assets/15683755718942.jpg)

选择 Chart 版本以及命名空间后，下方显示 Helm 参数。

![-w1673](../assets/15683757228949.jpg)

需调整 externalUrl、Service 和 Ingress：

- externalUrl

必填，安装过程需要 GitLab 访问地址。

- Service

使用 ClusterIP 即可，因为用户访问使用 Ingress。

```yaml
serviceType: ClusterIP
```

  - Ingress

  此处启用 Ingress，并填写 URL。

```yaml
ingress:
  annotations:
      # kubernetes.io/ingress.class: nginx
      # kubernetes.io/tls-acme: "true"
  enabled: true
  tls:
      # - secretName: gitlab.cluster.local
      #   hosts:
      #     - gitlab.cluster.local
  url: gitlab.bk.tencent.com
```

点击【预览】，可以看到 BCS 将 Charts 通过 `helm template` 命令渲染为 K8S 的对象描述文件。

![-w1679](../assets/15683761927767.jpg)

点击 【部署】即可。

在【Release 列表】菜单中可以查看部署状态。

![-w1676](../assets/15683762160110.jpg)

部署成功，接下来测试访问。

## 访问测试

修改域名解析或 PC 上 hosts 文件（Mac 下路径为 /etc/hosts），将 Ingress 中配置的主机名指向到 LoadBalancer 中节点的外网 IP，然后打开浏览器访问，可以看到 GitLab 首次登录密码设置界面。

管理员用户名为 root，登录后界面如下：

![-w1678](../assets/15683762619925.jpg)

创建一个仓库，体验一下。

![-w1676](../assets/15683763495121.jpg)

BCS 部署应用，如此简单。
