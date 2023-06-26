# K8S 存储

BCS 支持 K8S 原生的多种存储能力。在存储类型上，支持本地存储 hostpath、emptyDir、local 等；在存储方式上，支持 Volume、静态 PV、动态 PV； 在存储插件方案上，支持 K8S 内置的 In-tree 存储驱动、FlexVolume 存储驱动，以及 CSI 存储驱动的方案。

## 基础概念

-  Volume、PV 和动态 PV
K8S 使用 Volume、PV 来管理 Pod 容器的持久化数据。

-  Volume
Volume 生命周期与 Pod 绑定，容器挂掉重启后，Volume 的数据依然存在。 Pod 被删除时， Volume 被清理， 数据是否丢失取决于 Volume Driver 类型。

-  PV
为了更好管理应用的持久化数据存储，K8S 推出了 PV（[Persistent Volume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)）的概念。PV 独立于 Pod 的生命周期。应用在使用 PV 时，先创建 PVC（[PersistentVolumeClaim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims)），然后在 Pod 中声明绑定 PVC。

PV 有 Static PV 和 [Dynamic PV](https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/) 两种使用方式。

- PV 、PVC 的关系：
   - PV、PVC 类似 Nodes、Pods 的关系，Pod 是最小调度单元，资源是 Node 提供。
   - 工作负载（Workload）调度 PVC 申请网络资源，PVC 按照规范匹配合适的 PV，或者动态创建，然后 PV 和 PVC 进行绑定

## 本地存储

### hostpath

hostpath 映射宿主机 host 上的目录或文件至 K8S Pod 容器中，典型场景如运行的容器需要访问 Docker 内部结构，此时挂载宿主机 host 上的 /var/lib/docker 目录至容器中， 又如将 cAdvisor 部署在 Pod 容器中，需要挂载宿主机 host 上的 /sys 目录至容器中。

使用示例：
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-pd
spec:
  containers:
  - image: nginx:latest
    name: nginx
    ports:
    - containerPort: 80
    volumeMounts:
    - mountPath: /data
      name: testvolume
  volumes:
  - name: testvolume
    hostPath:
      path: /tmp/testvolume
```

### emptyDir

emptyDir 用于 Pod 需要挂载临时目录的情况。当 Pod 被调度到 host 节点上时，在 host 上自动创建一个空目录并挂载进 Pod 容器中，当 Pod 从 host 上删除时，这个目录也被删除。因此目录中存储的数据在 Pod 删除后并不会持久化到宿主机 host 上。

使用示例：
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-pd
spec:
  containers:
  - image: nginx:latest
    name: nginx
    ports:
    - containerPort: 80
    volumeMounts:
    - mountPath: /cache
      name: cache-volume
  volumes:
  - name: cache-volume
    emptyDir: {}
```

## 本地存储使用方式

使用 hostpath 和 emptyDir 等本地存储时，建议用 volume 方式来做存储管理。
在 “模板集 》Deployment 》Pod 模板设置 》卷” 中，可以配置使用 hostpath 或 emptyDir 本地存储。

![-w2020](../../assets/localStorage.png)

## 存储插件方案

K8S 支持多种后端存储，包括公有云存储产品 AWS EBS, AzureFile, GCE PD 等；商业存储产品 ScaleIO 等；开源存储产品 Ceph, GlusterFS 等。
后端存储是以插件化的方式提供支持的，K8S 前期都是以内置 in-tree 的方式接入第三方存储，存储驱动的代码是嵌入 K8S 核心代码当中的。从 1.13 版本开始，CSI(Container Storage Interface)插件方案正式进入到稳定版本，使用 CSI 插件方案可以解耦 K8S 与存储 driver， 以容器化的方式把 CSI 存储驱动部署在 K8S 集群中。

BCS 原生支持 K8S 的存储方案，考虑到安全性、可扩展性以及可运维性，BCS 推荐以 CSI 的方式使用第三方后端存储。
下面以 Ceph RBD 为例，展示 BCS K8S 第三方分布式存储的接入。

## Ceph RBD 接入和使用

### RBD CSI 部署

RBD CSI 推荐以 Helm 的方式部署到 K8S 集群当中。BCS 会在 Helm 仓库中提供 RBD CSI 的 Helm Chart 包，用户如果需要在 K8S 集群的应用中使用 Ceph RBD 分布式块存储，可直接通过 Helm 把 RBD CSI 部署至集群当中。

### RBD CSI 使用

#### 创建 StorageClass

BCS 管理员后台创建 RBD 的 StorageClass

- secret:

```yaml
# This is a template secret that helps define a Ceph cluster configuration
# as required by the CSI driver. This is used when a StorageClass has the
# "clusterID" defined as one of the parameters, to provide the CSI instance
# Ceph cluster configuration information.
apiVersion: v1
kind: Secret
metadata:
  # The <cluster-id> is used by the CSI plugin to uniquely identify and use a
  # Ceph cluster, the value MUST match the value provided as `clusterID` in the
  # StorageClass
  name: ceph-cluster-{ceph_cluster_id}
  namespace: default
data:
  # Base64 encoded and comma separated Ceph cluster monitor list
  #   - Typically output of: `echo -n "mon1:port,mon2:port,..." | base64`
  monitors:
  # Base64 encoded and comma separated list of pool names from which volumes
  # can be provisioned
  pools:
  # Base64 encoded admin ID to use for provisioning
  #   - Typically output of: `echo -n "<admin-id>" | base64`
  # Substitute the entire string including angle braces, with the base64 value
  adminid: =
  # Base64 encoded key of the provisioner admin ID
  #   - Output of: `ceph auth get-key client.<admin-id> | base64`
  # Substitute the entire string including angle braces, with the base64 value
  adminkey:
  # Base64 encoded user ID to use for publishing
  #   - Typically output of: `echo -n "<admin-id>" | base64`
  # Substitute the entire string including angle braces, with the base64 value
  userid:
  # Base64 encoded key of the publisher user ID
  #   - Output of: `ceph auth get-key client.<admin-id> | base64`
  # Substitute the entire string including angle braces, with the base64 value
  userkey:
```

- StorageClass:

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
   name: csi-rbd
provisioner: rbd.csi.ceph.com
parameters:
  clusterID: {ceph_cluster_id}
  pool:
  # RBD image format. Defaults to "2".
  imageFormat: "2"

  # RBD image features. Available for imageFormat: "2"
  # CSI RBD currently supports only `layering` feature.
  imageFeatures: layering
reclaimPolicy: Delete
```

#### 创建 PVC

用户在模板集中创建 PVC, 或者使用 kubectl 通过 bcs-api 操作 K8S 集群创建 PVC。

- PVC:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: rbd-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 0.1Gi
  storageClassName: csi-rbd
```

#### 引用 PVC

在模板集中创建的 Deployment 应用时，在 Pod 中指定挂载 PVC。

- Deployment:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: csirbd-demo-deploy
spec:
  replicas: 1
  selector:
    matchLabels:
      app: csirbd-demo-Pod
  template:
    metadata:
      labels:
        app: csirbd-demo-Pod
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
        volumeMounts:
          - name: mypvc
            mountPath: /data1
      volumes:
      - name: mypvc
        persistentVolumeClaim:
          claimName: rbd-pvc
          readOnly: true
```
