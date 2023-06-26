# FAQ
## 流水线（CI）部署问题
### 异常信息：IP 校验失败，请确认输入的 IP xxx 是否合法
参考 “安装 gse agent” 章节安装 agent，并确保 IP 所在业务和流程模板一致。
### 异常信息：任务执行失败，详情页提示 can not find agent by ip
参考 “安装 gse agent” 章节安装 agent，“节点管理”对应 IP 的“agent 状态”应为“正常”。
### "下载及解压安装包"失败：curl 报错
此步骤会联网下载 CI 安装包，如无法正常下载，请参考上文“离线环境部署”章节放置安装包。
### 制作 linux 版 jrezip 步骤报错 /data/src/java8.tgz 不存在
一般为用户自行删除了中控机上的 `/data/src/java8.tgz` ， 请重新下载蓝鲸社区版安装包并解压，或者从 job 及 ci 等主机上获取。

## 流水线（CI）访问及使用问题
### web 界面一直提示服务部署中

首先请耐心等待一段时间，在 systemd 服务状态转为 `active` 时，表示 `java` 进程启动成功，此时蓝盾的微服务逻辑可能还没启动完成，未曾注册服务发现的域名。

如果已经等待了 10 分钟，可能出现了故障，请参考此步骤检查：
1. 检查蓝盾集群中的 Consul 是否正在运行： `pcmd -m ci 'FORCE_TTY=1 ${CTRL_DIR:-/data/install}/bin/bks.sh consul'`。并使用 `consul members`确认成功加入了 consul 集群。
2. 检查网关及微服务是否正常运行：`pcmd -m ci 'FORCE_TTY=1 ${CTRL_DIR:-/data/install}/bin/bks.sh bk-ci'`，参考《[日常维护](../../增强包维护/蓝盾/Maintenance.md)》的“检查日志——网关日志”章节检查是否出现报错（ERROR 或者 Exception）。
3. 根据 《[日常维护](../../增强包维护/蓝盾/Maintenance.md)》的“检查状态——检查微服务域名” 章节确认微服务域名是否注册，当对应的微服务没有注册时，请参考《[日常维护](../../增强包维护/蓝盾/Maintenance.md)》的“检查日志——微服务日志”章节检查是否出现异常。

### 找不到公共构建机

执行流水线后，job 无法初始化，提示 `Start build Docker VM failed, no available Docker VM. Please wait a moment and try again.`。

这是因为找不到可用的公共构建机所致。请参考如下步骤排查：
1. 新增的公共构建机需要手动注册，请参考 “注册构建机” 章节。
2. 在 `ci(dispatch-docker)` 主机使用 `/data/src/ci/scripts/bkci-op.sh list` 命令检查当前构建机是否均为 `enabled=yes` 的状态。否则请检查对应 dockerhost 节点的服务是否存活，并核查服务日志。

>**提示**
>
> 如果确定不需要公共构建机，或者急需使用，可以考虑添加私有构建机到本项目使用。细节请参考《[私有构建机方案](../../增强包维护/蓝盾/Private-build-setup.md)》。

### artifactory 下载构件时偶现 404
表现为下载的二进制构件文件不变的情况，经常出现 404，但是重试时能正常下载。
请检查是否部署了多个 artifactory 实例，gateway 会将请求均衡到不同的实例上。
故 artifactory 多实例时，应该提前配置 NFS 等共享文件系统到 `$BK_CI_DATA_DIR`。
如果已经存在多实例，造成了数据分裂，需人工合并 artifactory 服务的数据目录（ `$BK_CI_DATA_DIR/artifactory/`）。

## 流水线（CI）维护问题
### ci-gateway 使用非 80 端口问题
目前暂未测试使用非 80 端口的效果，可以自行变更 env 文件中的端口变量体验，但不对效果做保证。

如果发现端口不一致的 bug，欢迎在 GitHub 反馈：[chore: ci-gateway 监听非 80 端口 #4611](https://github.com/Tencent/bk-ci/issues/4611)

### HTTPS 适配
>**提示**
>
> 我们在 v1.5.8 临时提供了 `${BK_PKG_SRC_PATH:-/data/src}/ci/scripts/bk-ci-utils-https.sh` 快速设置 https。
>
> 在中控机执行此脚本即可。如果升级了 CI 版本，需要重新执行此脚本。
>
> 欢迎体验上述切换脚本并在 GitHub 反馈: [chore: ci-gateway 部署时支持 https #4612](https://github.com/Tencent/bk-ci/issues/4612)

蓝盾的 HTTPS 适配目前没有全部通过测试，故暂无默认部署支持，需要使用上述补丁脚本。

参考手动修改步骤：
1. 修改 gateway `server.devops.conf`里注释掉的 SSL 相关配置项。
2. 复制蓝鲸的`bk.ssl`到上述配置里 `devops.ssl` 对应的路径。
3. 修改 PUBLIC_URL 为 HTTPS:// 前缀。
4. 重新使用 HTTPS URL 注册蓝鲸 PaaS APP 。

>**提示**
>
>HTTPS 适配还面临着更多证书信任相关的适配工作，且未曾经过完备的 HTTPS 兼容性测试及评审，故暂不做官方推荐，不提供自动部署 HTTPS 。

### GitLab HTTPS 适配问题

当 GitLab 启用 HTTPS 且 HTTP 默认 30x 跳转到 HTTPS 时，无法自动注册 WebHook 的问题。此问题排期中： [https://github.com/Tencent/bk-ci/issues/2894](https://github.com/Tencent/bk-ci/issues/2894)

目前有 2 种临时解决方案，按需选择。

**选择 1 ：修复自动注册问题**
注意：此操作会导致后续添加的其他 GitLab 服务端均使用对应的 HTTPS 入口访问。
参考步骤：
1. 配置 `BK_CI_REPOSITORY_GITLAB_URL` 为 HTTPS 开头的地址。
2. 重新安装 `ci(repository)` ，并重启服务。
```bash
pcmd -m ci_repository 'cd ${CTRL_DIR:-/data/install}; export LAN_IP; ./bin/install_ci.sh -e ./bin/04-final/ci.env -p "$BK_HOME" -m repository 2>&1;'
pcmd -m ci_repository 'systemctl restart bk-ci-repository'
```
3. 编辑流水线，确保使用 WebHook 触发，重新保存，因为仅在流水线保存时才触发 WebHook 注册。
4. 检查 GitLab 对应项目下是否出现了自动注册 WebHook 地址。

**选择 2 ：手动添加 WebHook**
如果不想修改蓝盾的配置，可以前往 GitLab 对应的仓库下配置手动触发。（需要管理员权限，路径参考为 settings--integrations ）。
填写的 WebHook URL 请查阅配置文件 `${BK_HOME:-/data/bkce}/etc/ci/application-repository.yml` 的 `scm.externel.gitlab.gitlabHookUrl` 配置项：
```yaml
scm:
  external:
    gitlab:
      gitlabHookUrl: 默认为$BK_CI_PUBLIC_URL/ms/process/api/external/scm/gitlab/commit
```
“trigger” 一般选择 push 即可。也可选择 tag ，请测试后决定。
“ssl verify” 按需禁用。

### 流水线镜像问题
流水线调用 Docker 进行镜像的拉取，请确保 dockerhost 节点可以访问私有的 Docker registry 服务，或 Docker 官方 registry 。

