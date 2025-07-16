## 部署 SaaS 时的报错

### 创建应用时选择安装包后报错 仅支持 .tar 或 tar.gz 格式的文件
#### 表现

使用浏览器访问 开发者中心，在 “创建应用” 界面上传 SaaS 安装包文件后，页面顶部出现报错：
>仅支持蓝鲸 S-mart 包，可以从“蓝鲸 S-mart”获取，上传成功后即可进行应用部署 仅支持 .tar 或 tar.gz 格式的文件。

#### 排查处理

文件上传界面限制了文件的 MIME 类型为 `application/x-tar,application/x-gzip`。如果不匹配，则会出现上述报错。

已知 Windows 10 系统更新后，`.gz` 文件的 MIME 类型变为了 `application/gzip`。

#### 总结

已知 Windows 10 和 11 用户使用 Chrome 浏览器可触发此问题。

可按需选择临时解决方案：
* 如果要部署 流程服务（ITSM）及 标准运维（SOPS），可参考 《[基础套餐部署](../install-bkce.md#setup_bkce7-i-saas)》 文档在 中控机 使用 “一键脚本” 部署 SaaS。
* 如果是其他 SaaS，或者不便使用一键脚本，可将 `.tar.gz` 安装包解压为 `.tar` 格式进行上传（推荐使用 7-zip 软件操作，**切勿解压为目录后重新打包**为 `.tar` 文件，重新打包过的文件可能无法安装）。


### 创建应用时选择安装包后报错 应用 ID: 某名称 的应用已存在
#### 表现

使用浏览器访问 开发者中心，在 “创建应用” 界面上传 SaaS 安装包文件后，文件名下方出现报错：`应用 ID: 某名称 的应用已存在！`

#### 排查处理

应用已经创建后，如果需要更新软件包，请参考 [《SaaS 部署文档》中的“上传安装包——更新安装包”章节](../manual-install-saas.md#upload-bkce-saas) 操作。

#### 总结

操作不当。


### 部署 SaaS 时报错 配置资源实例异常: unable to provision instance for services mysql
#### 表现

当使用“一键脚本”部署 SaaS 时，终端出现报错：
``` plain
时间略 [INFO] uploading 工作目录/scripts/../../saas/bk_itsm.tgz
时间略 [INFO] installing bk_itsm-default-image-2.6.2
DeployError: 部署失败, 配置资源实例异常: unable to provision instance for services<mysql>❌
```
或者在浏览器里访问开发者中心部署时，在 “准备阶段” —— “配置资源实例” 阶段的日志中出现报错：
> 配置资源实例异常: unable to provision instance for services`<mysql>`

#### 排查处理

kubernetes token 有误。

先刷新 PaaS 中存储的 token：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
rm -f environments/default/paas3_initial_cluster.yaml  # 删除配置文件
./scripts/create_k8s_cluster_admin_for_paas3.sh  # 重新生成
helmfile -f base-blueking.yaml.gotmpl -l name=bk-paas sync  # 重启paas
```
然后重新部署 SaaS。

#### 总结

操作不当。

用户在卸载后未曾参照文档重命名 bkhelmfile 目录，导致在 k8s 中创建了新的 token ，但是配置文件没有更新。


### 部署 SaaS 时报错 配置资源实例异常: unable to provision instance for services redis
#### 表现

当使用“一键脚本”部署 SaaS 时，终端出现报错：
``` plain
时间略 [INFO] uploading 工作目录/scripts/../../saas/bk_itsm.tgz
时间略 [INFO] installing bk_itsm-default-image-2.6.2
DeployError: 部署失败, 配置资源实例异常: unable to provision instance for services<redis>❌
```
或者在浏览器里访问开发者中心部署时，在 “准备阶段” —— “配置资源实例” 阶段的日志中出现报错：
> 配置资源实例异常: unable to provision instance for services`<redis>`

#### 排查处理

无。

#### 总结

未配置 redis 实例所致。请在中控机工作目录执行 `./scripts/setup_bkce7.sh -u redis`。

* 一键部署脚本：用户在卸载后未曾参照文档重命名 bkhelmfile 目录，导致自动跳过了此步骤。
* 手动部署：遗漏了 “[在 PaaS 界面配置 Redis 资源池](../manual-install-saas.md#paas-svc-redis)” 步骤。


### 部署 SaaS 在构建应用步骤出错
#### 表现

在“开发者中心”部署 SaaS 时失败，页面显示在 构建阶段 的 “构建应用” 步骤失败。

#### 排查处理

需要根据右侧日志查阅下面的案例，未记录的问题请提供日志截图联系客服或在社区发帖。

#### 总结

无


### 部署 SaaS 在构建应用步骤报错 code command not found
#### 表现

在“开发者中心”部署 SaaS 时失败，页面显示在 构建阶段 的 “构建应用” 步骤失败。

右侧部署日志显示：
``` plain
/tmp/stdlib.sh: line 2: code: command not found
/tmp/stdlib.sh: line 2: code: command not found
略
    !! command failed (build: file /buildpack/bk-buildpack-python/bin/compile, line 0, code 127: operation failed)
failed with exit code 1
Building failed, please check logs for more details
```

#### 排查处理

出现这个报错的原因是：PaaS 在部署 `package` 格式的 SaaS 时，会直接 `curl bkrepo-url | bash` 下载构建脚本。

当 runtimes 尚未上传到 bkrepo 时，bkrepo 响应的 json 内容为：
``` json
{
  "code" : 错误码,
...
```
这个 json 被 shell 解释为了 `"code"` 命令和 2 个参数 `:`、 `错误码,`，所以显示出报错 `line 2: code: command not found`。

#### 总结

操作不当。

未安装 PaaS runtimes 所致，请先完成 《[上传 PaaS runtimes 到 bkrepo](../paas-upload-runtimes.md)》 文档。部署文档中提示了此步骤可选，并描述了使用场景。用户可能遗漏了文档步骤。


### 部署 SaaS 在执行部署前置命令步骤出错
#### 表现

当使用“一键脚本”部署 SaaS 时，终端出现报错：
``` plain
时间略 [INFO] installing bk_itsm-default-image-2.6.2
DeployError: 部署失败, Pre-Release-Hook failed, please check logs for more details❌
command terminated with exit code 1
```
或者在“开发者中心”部署 SaaS 时失败，页面显示在 部署阶段 的 “执行部署前置命令” 步骤失败。

#### 排查处理

“执行部署前置命令” 对应着 `pre-release-hook` pod。如果报错 `pod not found`，则说明已经被自动清理，可点击 “重新部署” 按钮或者重试“一键脚本”，即出现此 pod。

我们先检查 pod 事件，以 `bk_itsm` 为例：
``` bash
kubectl describe pod -n bkapp-bk0us0itsm-prod pre-release-hook
```
>**提示**
>
>其他 SaaS 需调整 `namespace`。前缀保持不变，app_code 部分需替换 `_` 为 `0us0`，后缀用于区分环境： `prod`（生产环境）或 `stag`（预发布环境）。

该命令输出如下：
``` plain
Events:
  Type     Reason     Age                    From               Message
  ----     ------     ----                   ----               -------
  Normal   Scheduled  3m56s                  default-scheduler  Successfully assigned bkapp-bk0us0itsm-prod/pre-release-hook to node-10-0-1-3
  Normal   Pulling    2m24s (x4 over 3m56s)  kubelet            Pulling image "docker.bkce7.bktencent.com/bkpaas/docker/bk_itsm/default:2.6.2"
  Warning  Failed     2m24s (x4 over 3m55s)  kubelet            Failed to pull image "docker.bkce7.bktencent.com/bkpaas/docker/bk_itsm/default:2.6.2": rpc error: code = Unknown desc = Error response from daemon: Get https://docker.bkce7.bktencent.com/v2/: dial tcp: lookup docker.bkce7.bktencent.com on 10.0.1.1:53: no such host
  Warning  Failed     2m24s (x4 over 3m55s)  kubelet            Error: ErrImagePull
  Normal   BackOff    2m10s (x6 over 3m55s)  kubelet            Back-off pulling image "docker.bkce7.bktencent.com/bkpaas/docker/bk_itsm/default:2.6.2"
  Warning  Failed     119s (x7 over 3m55s)   kubelet            Error: ImagePullBackOff
```
此处的报错是 `node-10-0-1-3` 无法解析 `docker.bkce7.bktencent.com`，请参考 [配置 k8s node 的 DNS](../install-bkce.md#hosts-in-k8s-node) 文档操作。

其中 `Error response from daemon:` 为 containerd 返回的报错。

如：
``` plain
  Warning  Failed     85s (x4 over 2m43s)  kubelet            Failed to pull image "docker.bkce7.bktencent.com/bkpaas/docker/bk_itsm/default:2.6.2": rpc error: code = Unknown desc = Error response from daemon: Get https://docker.bkce7.bktencent.com/v2/: x509: certificate is valid for ingress.local, not docker.bkce7.bktencent.com
```
此报错则是 HTTPS 证书问题，请参考 [确保 node 能拉取 SaaS 镜像](../install-bkce.md#k8s-node-cri-insecure-registries) 文档操作。

#### 总结

目前用户报告的案例中，均为拉取镜像失败所致。又可细分为以下 2 种情况：
1. 遗漏了 “[配置 k8s node 的 DNS](../install-bkce.md#hosts-in-k8s-node)” 步骤，导致无法解析 bkrepo docker registry 的域名。
2. 遗漏了 “[确保 node 能拉取 SaaS 镜像](../install-bkce.md#k8s-node-cri-insecure-registries)” 步骤，导致 https 连接失败。

请先检查 **全部 node**，补齐这些操作，然后重试。如未解决，可参考问题分析排查。

其他报错可自行处理，或提供上述 kubectl describe pod 命令的完整输出联系蓝鲸助手。
