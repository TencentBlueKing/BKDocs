# 在 K8S 中部署 WordPress

## 情景

WordPress 是流行的开源博客程序，Helm 官方维护了 WorePress 的 Chart，接下来看在 BCS 中如何部署 WordPress，开始你的博客之旅。

## 前提条件

- [了解 Helm 的使用方法](../../../../BCS/1.28/UserGuide/Function/helm/ServiceAccess.md)
- [集成 K8S 存储](../../../../BCS/1.28/UserGuide/Function/StorageSolution/kubernetes.md)，例如 [将 NFS 作为 K8S PV Provisioner](../../../../BCS/1.28/UserGuide/Function/StorageSolution/K8s_NFS_Client_Provisioner.md)
- Git Clone [Helm Charts](https://github.com/helm/charts/)
- 新增 [LoadBalancer](../../../../BCS/1.28/UserGuide/Function/NetworkSolution/k8s/LoadBalancer.md)

## 操作步骤

1. 上传 WordPress Chart 到仓库
2. 部署 WordPress
3. 访问测试

## 上传 WordPress Chart 到仓库

进入 [Charts](https://github.com/helm/charts/) 本地仓库的 wordpress 目录。

```bash
# cd charts/stable/wordpress/

# ll
总用量 84
-rw-r--r-- 1 root root   454 9月  12 11:01 Chart.yaml
-rw-r--r-- 1 root root   186 9月  12 11:01 OWNERS
-rw-r--r-- 1 root root 29059 9月  12 11:01 README.md
-rw-r--r-- 1 root root   233 9月  12 11:01 requirements.lock
-rw-r--r-- 1 root root   173 8月  27 17:00 requirements.yaml
drwxr-xr-x 3 root root  4096 9月  12 11:01 templates
-rw-r--r-- 1 root root 13278 9月  12 11:01 values-production.yaml
-rw-r--r-- 1 root root 12925 9月  12 11:01 values.yaml
```

可以看到存在 requirements.yaml 文件，了解 WordPress 依赖 mariadb 的 Chart。

```bash
# cat requirements.yaml
dependencies:
- name: mariadb
  version: 6.x.x
  repository: https://kubernetes-charts.storage.googleapis.com/
  condition: mariadb.enabled
  tags:
    - wordpress-database
```

在当前目录使用 Helm 命令下载依赖包。

```bash
# helm dep build
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "joyfulgame" chart repository
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
Saving 1 charts
Downloading mariadb from repo https://kubernetes-charts.storage.googleapis.com/
Deleting outdated charts
```

推送 Chart 到仓库

```bash
# helm push . joyfulgame
Pushing wordpress-7.3.4.tgz to joyfulgame...
Done.
```

在 BCS 【Chart 仓库】菜单中，点击【同步仓库】，将刚刚上传的 Chart 从仓库同步到 BCS 的界面中。

## 部署 WordPress

在 BCS 【Chart 仓库】菜单中，找到刚刚上传的 WordPress Chart ，点击【部署】。

![w1645](../assets/15682579071348.jpg)

可以修改 Helm 参数，例如 WordPress 管理员账号、密码等，这里重点提一下用户访问用到的 Service 和 Ingress：

- Service

使用 ClusterIP 即可，因为用户访问使用 Ingress。

```yaml
service:
  type: ClusterIP
  # HTTP Port
  port: 80
```

 - Ingress

  此处启用 Ingress，并填写绑定的 **主机名** 和 **路径**。类似 Nginx 配置文件中 Server Section 部分的 server_name。

  ![w1678](../assets/15682642857653.jpg)

点击【预览】，可以看到 BCS 将 Charts 通过 `helm template` 命令渲染为 K8S 的对象描述文件。

![w1657](../assets/15682582162576.jpg)

点击 【部署】即可。

在【Release 列表】菜单中可以查看部署状态。

![w1652](../assets/15683730410624.jpg)

部署成功，接下来测试访问。

## 访问测试

修改域名解析或 PC 上 hosts 文件（Mac 下路径为 /etc/hosts），将 Ingress 中配置的主机名指向到 LoadBalancer 中节点的外网 IP，然后打开浏览器访问，可以看到 WordPress 首页。

![w1648](../assets/15683743074917.jpg)

输入用户名（默认为 user）和密码登录 Wordpress 后台。

![w1676](../assets/15683744779001.jpg)


如果没有在 Chart 参数中没有设置密码，可以通过命令获取 WordPress 的 Secret。

```yaml
# kubectl  get secret -n dev
NAME                                                TYPE                                  DATA   AGE
wordpress-1909130255                                Opaque                                1      4h37m

# kubectl  get secret/wordpress-1909130255 -n dev -o yaml
apiVersion: v1
data:
  wordpress-password: bFgzTmZvSHJIVg==
kind: Secret
  creationTimestamp: 2019-09-13T07:01:33Z
  name: wordpress-1909130255
  namespace: dev
type: Opaque

# echo "bFgzTmZvSHJIVg==" | base64 --decode
lX3NfoHrHV
```

BCS 部署应用，如此简单。
