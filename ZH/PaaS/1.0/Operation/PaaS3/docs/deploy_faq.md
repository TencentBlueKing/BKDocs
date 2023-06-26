# 部署常见问题

## Q: 为什么提示无权限获取到应用集群信息？

在初始化集群时，需要填入集群的 https 证书信息，这其中包含一个 K8S 的用户，需要保证这个用户拥有 `cluster-admin` 的角色，如果没有，则可以手动绑定。

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
- 应用没有产生符合规范的日志。某些特殊情况下，应用容器并未产生标准输出，可以尝试通过重启应用容器的方式，生成一些符合规范的日志，做进一步观测
