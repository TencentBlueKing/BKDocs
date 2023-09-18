存储服务涉及到存储卷以及各类数据库服务。

# 供应存储卷
蓝鲸预期使用默认存储卷创建卷。为了方便演示，且充分利用磁盘性能，所以选择了 `localpv` 存储类型。

但是如果 pod 有使用到 pv，则 `localpv` 会限制 pod 的迁移。你可能需要配置一些网络存储，例如 `nfs`。

TODO 其他 sc 的配置

## localpv
蓝鲸默认使用 local pv provisioner 提供存储。

你可以参考下述内容配置 `localpv`，或者自行对接其他存储类并设置为默认存储类。

### 检查 sc
先检查当前的存储提供者。在 中控机 执行：
``` bash
kubectl get sc
```
* 如果上述命令提示 `No resources found`，说明还没有配置存储类，继续按照本文档操作。
* 如果 `NAME` 列存在 `xxx (default)` 的条目，说明已经配置了默认存储类，可以跳过本章节。

### 检查磁盘空间
请确保各 `node` 中为 `localpv` 目录预留至少 100GB 的可用空间。

### 制备 pv 目录
>**提示**
>
>当你使用 `bcs.sh` 部署 k8s 集群时，会默认为 node 节点制备 pv 目录，可以跳过本章节。如果希望让 master 提供 pv，可以参考本章节手动操作。

本章节内容需要在 node 上操作。

当使用 `localpv` 时，要求每个 pv 目录都是一个挂载点。

如果没有足够的磁盘，可以使用 `mount --bind` 来实现相同的效果。源目录可以自定义，但是目的目录需要和 values 保持一致。

我们在 全局 values 文件里的 `localpv.hostDir` 定义了 pv 目录，默认值为 `/mnt/blueking/`。如需修改，请在 全局 custom-values 中进行覆盖。

因为 bcs.sh 没有为 master 提供 pv 目录，所以接下来以此为例，描述如何制备 pv 目录：
``` bash
# 源目录可以自定义，此处为了和 bcs.sh 保持一致，使用 /data/bcs/localpv/
src_dir=/data/bcs/localpv/
# pv目录需要和 Values.localpv.hostDir 保持一致
pv_host_dir=/mnt/blueking/
# 创建 20 个pv所需的目录。
for i in {01..20}; do
  vol="vol$i"
  vol_dir="${pv_host_dir%/}/$vol"
  vol_src="${src_dir%/}/$vol"
  mkdir -p "$vol_dir" "$vol_src";
  if grep -w "$vol_dir" /etc/fstab; then
    echo >&2 "TIP: vol $vol exist in /etc/fstab."
  else
    echo "$vol_src $vol_dir none defaults,bind 0 0" | tee -a /etc/fstab
  fi
done
# 在目录制备完成后，需要mount才行。
mount -va
```

检查各 node 的 fstab 和 mount 结果：
``` bash
grep -w vol[0-9][0-9] /etc/fstab /proc/self/mounts
```

### 创建 pv
执行如下命令配置 localpv 存储类并创建一批 pv：
``` bash
# 切换到工作目录
cd ~/bkce7.1-install/blueking
helmfile -f 00-localpv.yaml.gotmpl sync
```

### 检查结果
如果上面没有报错，则可以查看创建的 pv：
``` bash
kubectl get pv
```
预期可以看到很多行。参考输出如下：
``` text
NAME                CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS    REASON   AGE
local-pv-18c3e0ef   98Gi       RWO            Delete           Available           local-storage            6d8h
```

# 存储服务
蓝鲸预置了如下的 release 供快速体验：
* bk-mysql
* bk-rabbitmq
* bk-redis
* bk-redis-cluster
* bk-mongodb
* bk-elastic
* bk-zookeeper
* bk-etcd

你也可以使用自建的服务。

## 部署蓝鲸预置的存储服务
>**提示**
>
>在中控机执行 `helmfile -f base-storage.yaml.gotmpl sync` 即可并行部署这些 release。

### 部署 bk-mysql
在中控机工作目录下执行：
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-mysql sync
```

### 部署 bk-rabbitmq
在中控机工作目录下执行：
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-rabbitmq sync
```

### 部署 redis
在中控机工作目录下执行：
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-redis sync
helmfile -f base-storage.yaml.gotmpl -l name=bk-redis-cluster sync
```

### 部署 bk-mongodb
在中控机工作目录下执行：
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-mongodb sync
```

### 部署 bk-elastic
在中控机工作目录下执行：
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-elastic sync
```

### 部署 bk-zookeeper
在中控机工作目录下执行：
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-zookeeper sync
```

### 部署 bk-etcd
在中控机工作目录下执行：
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-etcd sync
```

## 对接已有的存储服务
TODO 禁用蓝鲸内置服务，配置使用已有服务

<a id="next" name="next"></a>

# 下一步
[部署步骤详解 —— 后台](manual-install-bkce.md)
