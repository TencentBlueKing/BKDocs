# 将 NFS 作为 K8S PV Provisioner

## 情景 {#Situation}
互联网应用常见的三层架构：接入层、逻辑层、存储层，在操作系统中 **文件系统** 提供存储层的存储介质，在 K8S 中是 **Persistent Volumes**（持久卷，简称 PV），而 PV 背后需要对接存储介质，比如 NFS、CephFS 以及公有云的云硬盘[1]。

接下来以 NFS 作为 K8S PV 的存储介质（Provisioner）为例，介绍在 K8S 中如何申请以及使用存储空间。


## 前提条件 {#Prerequisites}
- 了解 K8S 中[存储](kubernetes.md)的基础的概念。
- [K8S 的包管理工具](helm/ServiceAccess.md)


## 操作步骤 {#Steps}

- [1. 部署 NFS Server](#install_NFS_Server)
- [2. BCS 快速构建 Nginx 集群](#BCS_op)


### 部署 NFS Server {#install_NFS_Server}

> 以下为测试环境在 CentOS 7 下搭建 NFS 的示例，生产环境请咨询公司系统管理员。

安装 NFS Server 端，并启动以及设置开机自启动。

```bash
# yum -y install nfs-utils
systemctl enable rpcbind
systemctl enable nfs
systemctl start rpcbind
systemctl start nfs
```

设置 `/nfs` 目录为挂载目录，对 `10.0.0.0/16` 网段开放。

```bash
# mkdir /nfs

# vim /etc/exports
/nfs    10.0.0.0/16(rw,sync,no_root_squash,no_all_squash)

# systemctl restart nfs

# showmount -e localhost
Export list for localhost:
/nfs 10.0.0.0/16
```

本地挂载测试，验证 NFS 部署是否成功。

```bash
# mount -t nfs <NFS_SERVER_IP>:/nfs /mnt

# nfsstat -m
/mnt from <NFS_SERVER_IP>:/nfs
 Flags: rw,relatime,vers=4.1,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=<NFS_SERVER_IP>,local_lock=none,addr=<NFS_SERVER_IP>
```

### 部署 NFS-Client-Provisioner

K8S 使用 NFS 资源，需要能挂载 NFS 以及配套的 K8S 资源（StorageClass、ServerAccout、PersistentVolume、PersistentVolumeClaim 等）。

为了简化部署，以及为了使用 K8S 中的包管理器 [Helm](helm/ServiceAccess.md)（类比 yum ） 来部署 NFS-Client-Provisioner 的 Chart（类比 rpm）。

### 将 Chart 推到仓库

> 由于 Helm V2 需要在集群中部署 tiller，存在安全风险，无法直接使用 Helm install 部署应用，BCS 会将 Chart 通过  Helm template 解析为 K8S 的资源配置来部署。

下载 NFS-Client-Provisioner 的 Charts。

```bash
git clone https://github.com/helm/charts/
```

```bash
# pwd
charts/stable/nfs-client-provisioner
# ll
总用量 28
-rw-r--r-- 1 root root  479 8月  27 17:00 Chart.yaml
drwxr-xr-x 2 root root 4096 8月  27 17:00 ci
-rw-r--r-- 1 root root   74 8月  27 17:00 OWNERS
-rw-r--r-- 1 root root 5193 8月  27 17:00 README.md
drwxr-xr-x 2 root root 4096 8月  27 17:00 templates
-rw-r--r-- 1 root root 1677 8月  27 17:00 values.yaml

# helm push . joyfulgame
Pushing nfs-client-provisioner-1.2.6.tgz to joyfulgame...
Done.
```

### 部署 Chart

```bash
$ helm install --set nfs.server=x.x.x.x --set nfs.path=/exported/path --storageClass.defaultClass=true	 stable/nfs-client-provisioner
```

## Reference
- [1] K8S. [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
- [2] K8S. [Dynamic Volume Provisioning](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/)
- [3] Helm/Charts. [nfs-client-provisioner](https://github.com/helm/charts/tree/master/stable/nfs-client-provisioner)
- [4] kubernetes-incubator. [Kubernetes NFS-Client Provisioner](https://github.com/kubernetes-incubator/external-storage/tree/master/nfs-client)
