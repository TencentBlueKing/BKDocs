存储服务涉及到存储卷以及各类数据库服务。

# 供应存储卷
蓝鲸预期使用默认存储卷创建卷。

为了方便快速部署，且充分利用磁盘性能，本文选择了 `localpv` 存储类型。

但是如果 pod 有使用到 pv，则 `localpv` 会限制 pod 的迁移。为了解决 node 绑定的问题，你可以配置网络类型的存储类，例如 `nfs`。

你参考 k8s 文档配置其他存储类后，需将其设置为 **默认**，且确保 `kubectl get sc` 输出结果中，只有一个默认（`(default)`后缀）的存储类。

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
请确保各 `node` 中为 `localpv` 源目录预留至少 100GB 的可用空间。

### 制备 pv 目录
>**提示**
>
>使用 `bcs-ops` 部署 k8s 集群时，不再默认制备 pv 目录。
>
>如果已经在 “新建 k8s 集群(bcs-ops)” 章节中，操作过 “可选：适配 localpv” 步骤的话，这里的制备 pv 目录可以跳过。

`localpv` 要求每个 pv 目录都是一个挂载点。

如果没有足够的磁盘，可以使用 `mount --bind` 来实现相同的效果。源目录可以自定义，但是目的目录需要和 values 保持一致。

我们在 全局 values 文件里的 `localpv.hostDir` 定义了 pv 目录，默认值为 `/mnt/blueking/`。如需修改，请在 全局 custom-values 中进行覆盖。

需要 **登录到各 node** 上操作（如果希望让 master 能提供 pv，则也需操作）：
``` bash
# 源目录可以自定义，需要目录所在磁盘有 100GB 以上的空间。此处为了和 bcs.sh 保持一致，使用 /data/bcs/localpv/
src_dir=/data/bcs/localpv/
# pv目录需要和全局 Values 中的 .localpv.hostDir 保持一致
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
# 在目录制备完成后，需要mount才能被 localpv provisioner 认可。
mount -va
# 检查 fstab 和 mount 结果
grep -w vol[0-9][0-9] /etc/fstab /proc/self/mounts
```

### 创建 pv
执行如下命令配置 localpv 存储类并创建一批 pv：
``` bash
# 切换到工作目录
cd $INSTALL_DIR/blueking
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
* bk-mysql8
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

### 部署 bk-mysql8
在中控机工作目录下执行：
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-mysql8 sync
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
禁用蓝鲸内置服务，配置使用已有服务。

请参考 helmfile 定义及 values 文件自行研究。

### 示例：自定义 mysql
#### 修改配置文件
参考 `base-storage.yaml.gotmpl` 中的 `bk-mysql8` 定义：
``` yaml
  - name: bk-mysql8
    namespace: {{ .Values.namespace }}
    # Mysql chart files/create_database.sql contains CREATE DATABASE for all blueking databases
    chart: ./charts/mysql-{{ .Values.version.mysql8 }}.tgz
    missingFileHandler: Warn
    version: {{ .Values.version.mysql8 }}
    condition: bitnamiMysql8.enabled
    values:
    - ./environments/default/mysql8-values.yaml.gotmpl
    - ./environments/default/mysql8-custom-values.yaml.gotmpl
```

condition 决定 release 是否启用。这是在全局 values（`environments/default/values.yaml`）中定义的：
``` yaml
bitnamiMysql8:
  enabled: true
```

而调用 MySQL 的服务，则需要修改他们各自的 values 文件。我们已经提前在这些 values 文件中引用了全局 values：
``` yaml
mysql:
  # 处于同一集群可以使用k8s service 名
  host: "bk-mysql8"
  port: 3306
  rootPassword: blueking
```

现在需要覆盖上述的 values，因为此处涉及的 values 都在全局 values 文件，所以修改全局 custom values 文件（`environments/default/custom.yaml`）：
``` yaml
bitnamiMysql8:
  enabled: false
mysql:
  host: "填写服务端 IP"
  port: 3306
  rootPassword: "填写服务端root密码"
apps:
  # 配置SaaS需要连接的mysql，如果和平台复用，注意这里所填地址的连通性
  mysql:
    host: "填写服务端 IP"
    rootPassword: "填写服务端root密码"
```

#### 确保 root 账户能创建数据库并授权
PaaS 在部署 SaaS 时，会调用 root 账户为 SaaS 创建数据库，并使用 `GRANT` 语句授予权限。

请检查你的 root 账户是否具备授权能力：
``` sql
SHOW GRANTS FOR root@'%';
```

如果没有显示 `GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION`，请添加完整权限：
``` sql
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
```

#### 提前创建数据库
蓝鲸 `bk-mysql` release 在启动时会自动创建所需的数据库。

你的自建 MySQL 需要提前创建这些数据库：
``` sql
CREATE DATABASE IF NOT EXISTS open_paas DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_login DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bkauth DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bkiam DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bkiam_saas DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bkssm DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_apigateway DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_esb DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_user_api DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_user_saas DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bkpaas3_engine DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bkpaas3_apiserver DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bkpaas3_svc_mysql DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bkpaas3_svc_bkrepo DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bkpaas3_svc_rabbitmq DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bkpaas3_svc_otel DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_monitor DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_monitor_grafana DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_log_search DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bklog_grafana DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_nodeman DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_dbm DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_dbm_backup_server DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_dbm_db_celery_service DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_dbm_dbconfig DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_dbm_dbpartition DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_dbm_dbpriv DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_dbm_dbresource DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_dbm_dbsimulation DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_dbm_dns DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_dbm_grafana DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_dbm_hadb DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bk_dbm_report DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS bcs DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS `bcs-cc` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS `bcs-app` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
```

### 其他文件的修改
请自行研究 `全局 values` 文件（`environments/default/values.yaml`）。

如需覆盖，写入全局 custom values 文件（`environments/default/custom.yaml`）。

<a id="next" name="next"></a>

# 下一步
[部署步骤详解 —— 后台](manual-install-bkce.md)
