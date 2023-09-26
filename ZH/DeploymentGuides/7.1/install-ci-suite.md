蓝鲸持续集成套餐包含“蓝盾”（流水线）平台和“代码检查”系统。使用“蓝盾”作为主入口。
>**提示**
>
>“代码检查”正在适配中，敬请期待。


<a id="install-ci" name="install-ci"></a>

# 部署蓝盾平台

## 检查依赖
### 蓝鲸版本
支持在蓝鲸 7.1.0 及后续版本 加装此套餐，其中 7.1.0 需要额外执行一些步骤，请留意提示。

在中控机执行如下命令确认蓝鲸版本：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
cat VERSION
```

### 流程服务
新的 RBAC 权限方案由 **权限中心** 提供能力支撑，会调用 **流程服务** 处理权限单据，请提前安装。


## 蓝鲸 7.1.0 部署前的额外步骤
>**提示**
>
>如果直接使用蓝鲸 7.1.1 或更新版本部署，可以跳过本章节。

### 修改版本号
基于 7.1.0 版本部署时，需要修改 chart 版本号。

先进入工作目录：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
```

修改 `environments/default/version.yaml` 文件，配置 bk-ci charts version 为 `3.0.10-beta.2`：
``` bash
sed -i 's/bk-ci:.*/bk-ci: "3.0.10-beta.2"/' environments/default/version.yaml
grep bk-ci environments/default/version.yaml  # 检查修改结果
```
预期输出：
>``` yaml
>  bk-ci: "3.0.10-beta.2"
>```

### 修改 custom values

基于 7.1.0 版本部署时，需要调整一些默认配置：
* 优化镜像下载地址。
* 修改 rabbitmq 插件下载地址，保障下载速度。
* 禁用 ci 插件下载，如果用户访问 GitHub 不稳定，可能因此导致部署超时。
* 编译加速暂未开放，禁用相关对接功能。
* 需要调高部分 pod 的 limit，初次启动很容易超时。

请创建或修改 `environments/default/bkci/bkci-custom-values.yaml.gotmpl`，配置内容如下：
``` yaml
global:
  imageRegistry: {{ .Values.imageRegistry }}

kubernetes-manager:
  kubernetesManager:
    image: {{ .Values.imageRegistry }}/blueking/bkci-kubernetes-manager:0.0.31
    buildAndPushImage:
      image: {{ .Values.imageRegistry }}/kaniko-project/executor:v1.9.0

rabbitmq:
  communityPlugins: https://bkopen-1252002024.file.myqcloud.com/ce7/files/rabbitmq_delayed_message_exchange-3.8.17.8f537ac.ez

turbo:
  enabled: false
init:
  turbo: false
  plugin:
    enabled: false

config:
  bkCiAuthProvider: rbac
  bkCiIamUrlPrefix: {{ .Values.bkDomainScheme }}://bkiam.{{ .Values.domain.bkDomain }}
  bkCiItsmUrlPrefix: {{ .Values.bkDomainScheme }}://apps.{{ .Values.domain.bkDomain }}/bk--itsm
  bkCiItsmApigwUrl: {{ .Values.bkDomainScheme }}://bkapi.{{ .Values.domain.bkDomain }}/api/bk-itsm/prod
  bkCiIamApigwUrl: {{ .Values.bkDomainScheme }}://bkapi.{{ .Values.domain.bkDomain }}/api/bk-iam/prod
  bkCiIamSystemId: bk_ci_rbac
  bkCiIamMigrateToken: 9sBQj!M0
  bkIamPrivateUrl: {{ .Values.bkDomainScheme }}://bkiam.{{ .Values.domain.bkDomain }}

auth:
  resources:
    limits:
      cpu: 2
      memory: 1500Mi
store:
  resources:
    limits:
      cpu: 2
      memory: 1500Mi
process:
  resources:
    limits:
      cpu: 1500m
      memory: 1500Mi
```

## 更新 chart 仓库
登录到 **中控机**，先更新 helm 仓库缓存：
``` bash
helm repo update
```
检查仓库里的版本：
``` bash
helm search repo bk-ci --version 3.0.10-beta.2
```
预期输出如下所示：
>``` plain
>NAME          	CHART VERSION	APP VERSION   	DESCRIPTION
>blueking/bk-ci	3.0.10-beta.2	v2.0.0-beta.34	略
>```

## 配置 coredns

在 **中控机** 执行：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" devops.$BK_DOMAIN
./scripts/control_coredns.sh list  # 检查添加的记录。
```

## 部署
请在 **中控机** 执行：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
helmfile -f 03-bkci.yaml.gotmpl sync  # 部署
# 在admin桌面添加应用，也可以登录后自行添加。
scripts/add_user_desktop_app.sh -u "admin" -a "bk_ci"
# 设为默认应用。
scripts/set_desktop_default_app.sh -a "bk_ci"
```
部署需 5 ~ 10 分钟。上述命令结束后，可在中控机检查所有 Pod 是否正常：
``` bash
kubectl get pod -A | grep bk-ci
```

>**提示**
>
>**如果部署期间出错，请先查阅 《[问题案例](troubles.md)》文档。**
>
>问题解决后，可重新执行 `helmfile` 命令。


# 浏览器访问

需要配置域名 `devops.$BK_DOMAIN`，操作步骤已经并入《部署步骤详解 —— 后台》 文档 的 “[配置用户侧的 DNS](manual-install-bkce.md#hosts-in-user-pc)” 章节。

配置成功后，即可在桌面打开 “持续集成平台-蓝盾” 应用了。

蓝盾内置了 `demo` 项目，仅用于初始化用途，无法正常使用，请在登录后创建新的项目。

项目创建成功后，同步权限缓存需等待 10 秒，如果进入流水线界面后，在项目选择框看不到刚创建的项目，请等待后刷新页面并重试。

# 拓展蓝盾能力
## 对接制品库
蓝盾依靠蓝鲸制品库来提供流水线仓库和自定义仓库，需要调整制品库的认证模式。

当 `bk-ci` release 成功启动后，我们开始配置蓝鲸制品库，并注册到蓝盾中。

### 修改 bk-repo custom values
请在 **中控机** 执行：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
case $(yq e '.auth.config.realm' environments/default/bkrepo-custom-values.yaml.gotmpl 2>/dev/null) in
  null|"")
    tee -a environments/default/bkrepo-custom-values.yaml.gotmpl <<< $'auth:\n  config:\n    realm: devops'
  ;;
  devops)
    echo "environments/default/bkrepo-custom-values.yaml.gotmpl 中配置了 .auth.config.realm=devops, 无需修改."
  ;;
  *)
    echo "environments/default/bkrepo-custom-values.yaml.gotmpl 中配置了 .auth.config.realm 为其他值, 请手动修改值为 devops."
  ;;
esac
```

修改成功后，继续在工作目录执行如下命令使修改生效：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-repo apply
```

### 检查配置是否生效
检查 release 生效的 values 和 configmap 是否重新渲染。

请在 **中控机** 执行：
``` bash
helm get values -n blueking bk-repo | yq e '.auth.config.realm' - ;\
kubectl get cm -n blueking bk-repo-bkrepo-auth -o json | jq -r '.data."application.yml"' | yq e '.auth.realm' -
```
预期 2 条命令均显示 `devops`。如果任意配置没有生效，请检查上述 helmfile 命令的输出是否正常。

### 重启 bk-repo auth 微服务
因为 deployment 没有变动，所以不会自动重启，此处需要单独重启：
``` bash
kubectl rollout restart deployment -n blueking bk-repo-bkrepo-auth
```

### 在蓝盾中注册制品库
请在 **中控机** 执行：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
# 向project微服务注册制品库
kubectl exec -i -n blueking deploy/bk-ci-bk-ci-project -- curl -sS -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'X-DEVOPS-UID: admin' -d "{\"showProjectList\":true,\"showNav\":true,\"status\":\"ok\",\"deleted\":false,\"iframeUrl\":\"//bkrepo.$BK_DOMAIN/ui/\"}" "http://bk-ci-bk-ci-project.blueking.svc.cluster.local/api/op/services/update/Repo"
```

## 流水线插件
蓝鲸精选了一批流水线插件，可以提供更多的能力。更多插件请探索 https://github.com/orgs/TencentBlueKing/repositories?q=ci 。

| 代号（atomCode） | 插件名称 | 描述 |
|--|--|--|
| uploadArtifact | 归档构件 | 本插件将构建机本地的文件归档至流水线仓库或自定义仓库，对产出物进行归档 |
| uploadReport | 归档报告 | 可将构建机上的 html 报告归档，同时发送邮件出来 |
| downloadArtifact | 拉取构件 | 将制品库中的文件拉取到构建机上，支持拉取流水线仓库或自定义仓库 |
| checkout | Checkout | checkout 插件为蓝盾平台提供基本的 git 拉取操作，可以拉取所有的 git 仓库 |
| run | RunScript | Execute the script plugin. Support cross-system use. |
| sendEmail | sendEmail | Send email to any one |
| SubPipelineExec | 子流水线调用 | 以同步/异步的方式启动运行指定的项目下的流水线 |
| AcrossProjectDistribution | 跨项目推送构件 | 跨项目上传构件至其他项目自定义仓库 |
| CodeCCCheckAtom | CodeCC 代码检查 | 支持 Linux、MacOS、Windows 系统下执行所有 CodeCC 代码检查工具，包括代码缺陷（bkcheck 等）、安全漏洞（敏感信息、高危组件等）、代码规范（CppLint、CheckStyle 等）、圈复杂度、重复率等。 |

容器化环境中无法直接通过 作业平台 传输文件。相关改造计划请关注： https://github.com/TencentBlueKing/bk-ci/issues/9450

### 下载插件
请在 **中控机** 执行：
``` bash
bkdl-7.1-stable.sh -ur latest ci-plugins
```

### 上传插件
此操作只能新建插件，每个插件只能上传一次，如果重复执行会报错 `{status": 2100001, "message": "系统内部繁忙，请稍后再试", …}`。

后续如需更新插件，请访问 “蓝盾” —— “研发商店” —— “工作台” 界面，在列表中找到对应插件选择 “升级” 操作。

请在 **中控机** 执行：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
for f in ../ci-plugins/*.zip; do
  atom="${f##*/}"
  atom=${atom%.zip}
  echo >&2 "upload $atom from $f"
  kubectl exec -i -n blueking deploy/bk-ci-bk-ci-store -- \
    curl -s \
      http://bk-ci-bk-ci-store.blueking.svc.cluster.local/api/op/pipeline/atom/deploy/"?publisher=admin" \
      -H 'X-DEVOPS-UID: admin' -F atomCode=$atom -F file=@- < "$f" | jq .
  # 设置为默认插件，全部项目可见。
  kubectl exec -n blueking deploy/bk-ci-bk-ci-store -- \
    curl -s http://bk-ci-bk-ci-store.blueking.svc.cluster.local/api/op/pipeline/atom/default/atomCodes/$atom \
      -H 'X-DEVOPS-UID: admin' -X POST | jq .
done
```

# 优化项
## 调整流水线构建容器规格
目前流水线默认容器规格较低，编译时速度较慢，且可能因为内存不足导致 OOM，可按如下方法调整：
1. 增大全局构建机配额。此配置会导致资源用量暴涨，建议配置独立构建集群。
2. 导入私有构建机来完成高负载的构建任务。

TODO 调整 pod limits

## 使用独立的构建集群
默认情况下，流水线复用了蓝鲸所在集群进行构建任务。

如果你有足够的资源，且存在频繁的构建需求，可以考虑使用独立的 k8s 集群，避免干扰到蓝鲸集群。

TODO 添加 build k8s


# 下一步
回到《[部署基础套餐](install-bkce.md#next)》文档看看其他操作。
