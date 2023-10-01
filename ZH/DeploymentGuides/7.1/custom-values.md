本文描述如何创建初始的全局配置文件，以及各 release 的配置方式。

# 下载安装文件

>**注意**
>
>在部署前，请确保完成了《[准备中控机](prepare-bkctrl.md)》文档。

请在 **中控机** 使用下载脚本下载蓝鲸 helmfile 包及公共证书。
``` bash
bkdl-7.1-stable.sh -ur latest base demo
```

这些文件默认放在了 `~/bkce7.1-install/` 目录。

# 安装背景知识
## 安装目录
一个完整的安装目录包含如下的子目录：
``` plain
|-- bin   # 安装所需的工具
|-- blueking  # 蓝鲸部署文件及部署脚本，后续部署操作的工作目录。
|-- ci-plugins  # 蓝盾流水线插件
|-- gse2  # GSE V2 的 Proxy、Agent及插件。
|-- paas-runtimes  # bk-paas 构造 SaaS 运行环境所需的文件
`-- saas  # SaaS 安装包
```
在接下来的部署过程中，会陆续使用下载脚本填充这些目录。

## 工作目录
工作目录为 bkhelmfile 包解压所得，整个部署文档都基于此目录引用文件路径。

>**提示**
>
>中控机默认工作目录为 `~/bkce7.1-install/blueking/`，如果你有自定义，请注意修改。

``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
```

### 蓝鲸基础套餐 helmfile
`base.yaml.gotmpl` 是蓝鲸存储服务 + 后台的组合。在快速部署时，`scripts/setup_bkce7.sh` 脚本就是直接使用此文件启动。

其内容如下：
``` yaml
bases:
  - env.yaml
---
bases:
  - defaults.yaml
---
helmfiles:
  - path: ./base-storage.yaml.gotmpl
  - path: ./base-blueking.yaml.gotmpl
    selectors:
    - seq=first
  - path: ./base-blueking.yaml.gotmpl
    selectors:
    - seq=second
  - path: ./base-blueking.yaml.gotmpl
    selectors:
    - seq=third
  - path: ./base-blueking.yaml.gotmpl
    selectors:
    - seq=fourth
```

可以看到引用了 2 个文件：
* `base-storage.yaml.gotmpl` 中声明了 蓝鲸预置的存储服务 的 release。
* `base-blueking.yaml.gotmpl` 中声明了 蓝鲸后台服务 的 release，且使用了 `seq` 标签来控制启动次序。

### 其他 helmfile 文件
为了方便展示包含关系，我在被包含的文件名前添加了 2 个空格。
``` plain
00-ingress-nginx.yaml.gotmpl  # 部署文件：网关
00-localpv.yaml.gotmpl  # 部署文件：供应localpv

00-metrics-server.yaml.gotmpl  # 部署文件：度量k8s资源用量，方便调试

03-bcs.yaml.gotmpl  # 部署文件：蓝鲸容器管理平台

03-bkci.yaml.gotmpl  # 部署文件：蓝盾流水线平台

monitor.yaml.gotmpl  # 蓝鲸监控日志套餐，一般调用下面的独立文件。
  monitor-storage.yaml.gotmpl  # 监控专用的存储服务
  04-bkmonitor.yaml.gotmpl  # 监控后台
  04-bkmonitor-operator.yaml.gotmpl  # 监控采集器
  04-bklog-search.yaml.gotmpl  # 日志后台
  04-bklog-collector.yaml.gotmpl  # 日志采集器

05-bkapicheck.yaml.gotmpl  # 部署文件：api测试工具
```

### values 文件
为了方便修改 `helm values`，我们预定义了一系列的文件来存储不同的 values，并预定义了覆盖默认值的文件，一般称为 `custom-values 文件`。

全局 values：所有 release 模板都能读取的 values 文件，路径为 `environments/default/values.yaml`。

全局 custom-values：用于覆盖全局 values 的值，路径为 `environments/default/custom.yaml`。

版本号文件：版本号信息都存放在 `environments/default/version.yaml` 文件。key 的名字是固定的，请勿修改。

各 release 私有的 values 文件及 custom-values 文件路径规则不同，获取方法详见下文 “声明 release” 里的描述。

## 声明 release
我们看看 `base-blueking.yaml.gotmpl` 中声明的 `bk-repo` release：
``` yaml
releases:
  - name: bk-repo
    namespace: {{ .Values.namespace }}
    chart: blueking/bkrepo
    version: {{ index .Values.version "bkrepo" }}
    missingFileHandler: Warn
    labels:
      seq: first
    values:
    - ./environments/default/bkrepo-values.yaml.gotmpl
    - ./environments/default/bkrepo-custom-values.yaml.gotmpl
```

* `name` 就是每个 release 的名字，后续会使用 `helm` 命令来操作这些 release。
* `namespace` 会从全局 values 中获取，默认是 `blueking`。
* `chart` 在 《自定义配置》 文档中，我们添加了 `blueking` 仓库，此时引用名为 `bkrepo` 的 chart 来创建 release。`version` 指定了上述 chart 的版本号。
* `labels` 中，我们定义了 `seq` 标签，用于 helmfile 命令通过标签值筛选出所需的 release。
* `values` 则是一系列的 values 配置，用于覆盖 chart 内置的 values。我们预定义了 `custom-values 文件` 方便覆盖，一般命名为 `xxx-custom-values.yaml.gotpml`。


# 配置 helm 及 docker 仓库
## 添加 charts 仓库
蓝鲸 7.0 软件产品通过 https://hub.bktencent.com/ 进行分发。

请先在 helm 中添加名为 `blueking` 的 charts 仓库：
``` bash
helm repo add blueking https://hub.bktencent.com/chartrepo/blueking
helm repo update
helm repo list
```

## 可选：配置 docker registry 地址
如果你在内网提供了 registry，可以提前配置环境变量，指示部署脚本使用。

在中控机执行：
``` bash
export REGISTRY=代理IP:端口
```

注意：请提前在 **全部 k8s node** 上为 dockerd 配置 TLS 证书或者 `insecure-registries` 选项。


# 配置全局 custom-values

## 进入工作目录
>**提示**
>
>中控机默认工作目录为 `~/bkce7.1-install/blueking/`，如果你有自定义，请注意修改。

``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
```

## 配置访问域名
蓝鲸平台均需通过域名访问，为了简化域名配置，我们提供了基础域名的配置项 `domain.bkDomain`（也可使用 `BK_DOMAIN` 这个惯用变量名来称呼它）。此配置项用于拼接蓝鲸其他系统的访问域名，也是蓝鲸统一登录所需的 cookie 域名。

而 `domain.bkMainSiteDomain` 则为蓝鲸的主站入口域名，一般配置为 `domain.bkDomain` 相同的值。

如果需要自定义参数，需要新建文件 `environments/default/custom.yaml` （下文简称为 `custom.yaml` 文件），此文件用于对 values.yaml 文件的内容进行覆盖。

例如，需要自定义域名 `bkce7.bktencent.com`，可以使用如下命令生成 `custom.yaml` 文件：
``` bash
BK_DOMAIN=bkce7.bktencent.com  # 请修改为你分配给蓝鲸平台的主域名
cd ~/bkce7.1-install/blueking/  # 进入工作目录
# 可使用如下命令添加域名。如果文件已存在，请手动编辑。
custom=environments/default/custom.yaml
cat >> "$custom" <<EOF
imageRegistry: ${REGISTRY:-hub.bktencent.com}
domain:
  bkDomain: $BK_DOMAIN
  bkMainSiteDomain: $BK_DOMAIN
EOF
```

如果你在公有云上部署蓝鲸，请先完成域名备案，否则会被云服务商依法阻断访问请求。

## 配置容器日志目录
平台组件的后台日志采集用。

请在所有 **k8s node** 上执行此命令，预期输出一致：
``` bash
docker info | awk -F": " '/Docker Root Dir/{print $2"/containers"}'
```
当上述路径一致时，请编辑中控机的 `custom.yaml` 文件，添加如下配置项：
``` bash
apps:
  bkappFilebeat.containersLogPath: "查询到的路径"
```

我们预期你的 k8s node 具备相同的 docker 配置。如果此路径不一致，请先完成 docker 标准化。

# 生成 values 文件
还有一些 values 文件随着部署环境的不同而变化，所以我们提供了脚本快速生成。

## 生成蓝鲸 app code 对应的 secret
``` bash
./scripts/generate_app_secret.sh ./environments/default/app_secret.yaml
```

## 生成 apigw 所需的 keypair
``` bash
./scripts/generate_rsa_keypair.sh ./environments/default/bkapigateway_builtin_keypair.yaml
```

## 生成 paas 所需的 clusterAdmin
``` bash
./scripts/create_k8s_cluster_admin_for_paas3.sh
```

# 安装入口网关
## 安装 ingress controller
先检查你的环境是否已经部署了 ingress controller:
``` bash
kubectl get pods -A -l app.kubernetes.io/name=ingress-nginx
```

如果没有，则使用如下命令创建：
``` bash
helmfile -f 00-ingress-nginx.yaml.gotmpl sync
kubectl get pods -A -l app.kubernetes.io/name=ingress-nginx  # 查看创建的pod
```

<a id="hosts-in-coredns" name="hosts-in-coredns"></a>

## 配置 coredns
在部署过程中，会在容器内访问这些域名，所以需要提前配置 coredns，将蓝鲸域名解析到 service IP。

>**注意**
>
>当 service 被删除，重建后 clusterIP 会变动，此时需刷新 hosts 文件。

因此需要注入 hosts 配置项到 `kube-system` namespace 下的 `coredns` 系列 pod，步骤如下：

``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" $BK_DOMAIN bkrepo.$BK_DOMAIN docker.$BK_DOMAIN bkapi.$BK_DOMAIN bkpaas.$BK_DOMAIN bkiam-api.$BK_DOMAIN bkiam.$BK_DOMAIN apps.$BK_DOMAIN bknodeman.$BK_DOMAIN jobapi.$BK_DOMAIN
```

确认注入结果，执行如下命令：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/control_coredns.sh list
```
参考输出如下：
``` plain
        10.244.0.5 bkce7.bktencent.com
        10.244.0.5 apps.bkce7.bktencent.com
        10.244.0.5 bkrepo.bkce7.bktencent.com
        10.244.0.5 docker.bkce7.bktencent.com
        10.244.0.5 bkapi.bkce7.bktencent.com
        10.244.0.5 bkpaas.bkce7.bktencent.com
        10.244.0.5 bkiam-api.bkce7.bktencent.com
        10.244.0.5 bkiam.bkce7.bktencent.com
        10.244.0.5 bcs.bkce7.bktencent.com
        10.244.0.5 bknodeman.bkce7.bktencent.com
        10.244.0.5 jobapi.bkce7.bktencent.com
```

<a id="next" name="next"></a>

# 下一步
[部署或对接存储服务](storage-services.md)
