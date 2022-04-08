# 部署常见问题

## Q: 为什么 engine 项目提示无权限获取到应用集群信息？

engine 服务在初始化集群时，需要填入集群的 https 证书信息，这其中包含一个 K8S 的用户，需要保证这个用户拥有 `cluster-admin` 的角色，如果没有，则可以手动绑定。

``` bash
# 以用户名 kube-apiserver 为例
kubectl create clusterrolebinding apiserver --clusterrole=cluster-admin --user kube-apiserver
```

## Q: 应用集群和平台集群混合部署会有什么问题吗？

需要规避命名空间冲突。平台默认会在应用集群为不同应用创建不同的 namespace(命名空间)，所以在为平台服务部署时，需要规避使用 `bkapp` 开头的命名空间。

## Q: 如何往 bkrepo 添加额外的 NodeJS SDK?

一般情况下, NodeJS SDK 往往具有复杂的依赖关系, 如需往 bkrepo 添加额外的 NodeJS SDK, 则需要将该 SDK 依赖的其他 SDK 一并上传至 bkrepo。
为此, 平台提供了 NodeJS 依赖管理工具 bk-npm-mgr。该工具已集成至镜像 paas3-npm-mgr, 也可直接从 bkrepo 中下载安装(运行依赖 node >= 12)。
以下讲解如何使用 bk-npm-mgr 工具上传额外的 NodeJS SDK 至 bkrepo。

```bash
# 在能访问外网的机器中执行以下操作.
# 1. 启动容器
docker run -it --rm --entrypoint=bash ${your-docker-registry}/paas3-npm-mgr:${image-tag}
# 2. 安装需要上传额外的 NodeJS SDK, 以 vue 为例.
yarn add vue@3.0.11
# 3. 下载依赖至 dependencies 目录(执行步骤2时, 会生成 package.json 文件)
bk-npm-mgr download package.json -d dependencies
# 4. 上传 dependencies 目录中的 NodeJS SDK 至 bkrepo
bk-npm-mgr upload --username ${bkrepoConfig.bkpaas3Username} --password ${bkrepoConfig.bkpaas3Password} --registry ${bkrepoConfig.endpoint}/npm/${bkrepoConfig.bkpaas3Project}/npm -s dependencies -v

# 如需上传自研的 SDK 至 bkrepo, 则需要将源码挂载至容器中, 可参考以下流程.
# 1. 启动容器, 并将源码挂载至启动目录.
docker run -it --rm --entrypoint=bash -v ${NodeSDK源码的绝对路径}:/blueking ${your-docker-registry}/paas3-npm-mgr:${image-tag}
# 2. 下载依赖至 dependencies 目录
bk-npm-mgr download package.json -d dependencies
# 3. 打包 SDK 至 dependencies
yarn pack -f dependencies/${your-sdk-name.tgz}
# 4. 上传 dependencies 目录中的 NodeJS SDK 至 bkrepo
bk-npm-mgr upload --username ${bkrepoConfig.bkpaas3Username} --password ${bkrepoConfig.bkpaas3Password} --registry ${bkrepoConfig.endpoint}/npm/${bkrepoConfig.bkpaas3Project}/npm -s dependencies -v
```

**说明**：bkrepo 相关变量的值，可以从 `values.yaml` 文件中的 `global.bkrepoConfig` 配置项获取。

## Q: 为什么应用日志采集没有数据？

应用日志采集主要有三类：

- 应用自定义的 JSON 文件日志
- 应用容器标准输出
- 经由 Ingress Controller 的应用访问日志

日志采集会在 ElasticSearch 中自动创建 Index，前两个共用默认为 `bk_paas3_app`，Ingress 独立使用 `bk_paas3_ingress`。
理论上来说，有几种情况可能出现日志采集异常：

### 日志采集组件（Filebeat & Logstash）启动异常，未能正常工作

这种情况下，你可以从它们的日志输出中获取异常原因，大多数问题都可以通过搜索引擎在互联网社区中找到解决方案。

### 日志采集组件正常，已有蓝鲸应用成功部署

理论上，如果你的应用已经成功部署，大多情况下都会有容器标准输出，`bk_paas3_app` 就已经会自动创建了。

如果 ES 中没有相应索引，那么有可能是以下几种原因：

- ES 配置有误。请查看 Filebeat 和 Logstash 的容器输出，观测是否有 `ERROR` 日志，辅助判断 ES 信息填写是否正确。
- 没有正确配置 `containersLogPath`。请通过 `kubectl` 登录到 Filebeat 容器中，检查 `containersLogPath` 路径下是否有容器的标准输出日志。
- 应用没有产生符合规范的日志。某些特殊情况下，应用容器并未产生标准输出，可以尝试通过重启应用容器的方式，生成一些符合规范的日志，做进一步观测。

## Q: 如何添加或排查容器环境变量问题？

在 `paas-stack` 和 `bk-service` 项目中我们定义了四个可能的环境变量来源：

- env： 支持 `k-v` 结构的环境变量定义，优先级高
- extraEnv: 原生渲染 env，支持类似 hostIP 这类的动态值渲染
- envFrom: 支持从 configmap/secret 挂载环境变量
- sharedUrlEnvMap: 访问地址的快捷环境变量生成，支持填写 Helm 模版，优先级低，可被 env 同 key 指内容覆盖

### 访问地址拼接问题

蓝鲸内部产品的访问地址大多通过 `sharedUrlEnvMap` 变量定义，遵循企业版部署的通用规则，由 `.Values.global.sharedDomain` 拼接而成，可以在 `paas-stack` 的子模块(apiserver/engine/webfe)的 Chart 中查看具体规则。

如果遇到访问地址并未遵循通用的拼接规则，那么你可以在 `.Values.env` 中手动指定，将直接覆盖 `sharedUrlEnvMap` 中对应的环境变量。

当前模块中自动拼接的访问地址：

apiserver:

- BK_PAAS3_URL: "http://bkpaas.{{ .Values.global.sharedDomain }}"
- BK_PAAS2_URL: "http://paas.{{ .Values.global.sharedDomain }}"
- BK_SSM_URL: "http://bkssm.{{ .Values.global.sharedDomain }}"
- BK_IAM_V3_INNER_HOST: "http://bkiam.{{ .Values.global.sharedDomain }}"
- BK_CC_HOST: "http://cmbd.{{ .Values.global.sharedDomain }}"
- BK_JOB_HOST: "http://job.{{ .Values.global.sharedDomain }}"
- BK_API_URL_TMPL: "http://bkapi.{{ .Values.global.sharedDomain }}/api/{api_name}
- VALID_CUSTOM_DOMAIN_SUFFIXES: ".{{ .Values.global.sharedDomain }}"

webfe:

- BK_PAAS3_URL: "http://bkpaas.{{ .Values.global.sharedDomain }}"
- BK_PAAS2_URL: "http://paas.{{ .Values.global.sharedDomain }}"
- BK_LOGIN_URL: "http://paas.{{ .Values.global.sharedDomain }}/login"
- BK_COMPONENT_API_URL: "http://paas.{{ .Values.global.sharedDomain }}"
- BK_APIGW_URL: "http://apigw.{{ .Values.global.sharedDomain }}"
- BK_APIGW_DOC_URL: "http://docs-apigw.{{ .Values.global.sharedDomain }}"
- BK_LESSCODE_URL: "http://lesscode.{{ .Values.global.sharedDomain }}"

举例来说，在部署 `paas-stack`时，如果真实的 `bkssm` 服务的访问地址和自动拼接的内容有出入，你可以通过指定 `apiserver.env.BK_SSM_URL` 变量来直接覆盖。

**注意**：BK_PAAS3_URL 是 PaaS3.0 开发者中心的访问地址，默认值为 `http://bkpaas.{{ .Values.global.sharedDomain }}`。如果有修改，还需要同步修改 `apiserver.processes.ingress.host` 和 `engine.processes.ingress.host` 两个配置项的值，同时注意 Helm Notes 中的访问地址无法同步更新。

## Q: 为什么每次更新都有很多容器要运行？

当前我们在部署流程中定义了一系列用于初始化 & 变更数据的容器：

apiserver:

- on-migrate: 变更表结构，`install & upgrade` 时执行
- on-initial-fixtures: 初始化平台数据，`install` 时执行
- on-initial-script: 初始化运行时数据，`install & upgrade` 时执行

engine:

- on-migrate: 变更表结构，`install & upgrade` 时执行
- on-initial-fixtures: 初始化平台数据，`install` 时执行
- generate-initial-cluster-state: 生成集群节点状态，`install` 时执行

在安装过程中，如果权重高的步骤失败终止，再次 `upgrade` 时，会导致那些权重低的、仅在 `install` 时执行的步骤无法执行。

你可以采用以下解决方案：

- 删除 release，保证配置正确，再次 `helm install`
- 修改部分 hook 的执行位置

在 `values.yaml` 中添加对应内容

```yaml
apiserver：
  preRunHooks：
    on-initial-fixtures.position: pre-install,pre-upgrade

engine：
  preRunHooks：
    on-initial-fixtures.position: pre-install,pre-upgrade
    generate-initial-cluster-state.position: post-install,post-upgrade
```

再次运行 `helm upgrade` 就可以看到这些任务能够正常运行了。在保证数据已经初始化后，可以从删除以上配置，精简部署升级流程。


## Q:为什么部署完后桌面中开发者中心的地址还是 PaaS2.0 的地址

1. 需要确认 PaaS2.0（open_paas） 的版本为 **2.12.18** 及以上

2. 需要给 open_paas 模块新增以下 4 个环境变量


| 变量名 | 描述 | 示例|
| :--- | :---: | ---: |
| BK_PAAS3_URL | PaaS3.0开发中心地址，可以在 `paas-stack` 模块的 helm notes 中获取 | http://bkpaas.example.com |
| BK_APIGW_URL | API 网关主站地址，可以在 `bk-apigateway` 模块的 helm notes 中获取 | http://apigw.example.com |
| BK_APIGW_DOC_URL | API 帮助中心地址，可以在 `bk-apigateway` 模块的 helm notes 中获取 | http://docs-apigw.example.com |
| BK_ESB_MENU_ITEM_BUFFET_HIDDEN | 是否隐藏 ESB 自助接入菜单| true |
