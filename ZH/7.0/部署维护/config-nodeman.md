节点管理（bk_nodeman）部署后，需要先上传 Agent 及 插件包，并配置接入点。然后给 k8s 集群安装 Agent，实现纳管。

<a id="post-install-bk-nodeman-gse-client" name="post-install-bk-nodeman-gse-client"></a>

# 上传 GSE agent

>**提示**
>
>* 当您需要更新客户端或者加装云区域代理时，可以在下载后使用此命令重新上传。

在 **中控机** 执行如下命令下载文件：
``` bash
curl -sSf https://bkopen-1252002024.file.myqcloud.com/ce7/7.1-beta/bkdl-7.1-beta.sh | bash -s -- -ur latest gsec
```
安装：
``` bash
nodeman_backend_api_pod=$(kubectl get pod -A -l app.kubernetes.io/component=bk-nodeman-backend-api -o jsonpath='{.items[0].metadata.name}')
namespace=$(kubectl get pod -A -l app.kubernetes.io/component=bk-nodeman-backend-api -o jsonpath='{.items[0].metadata.namespace}')
cd ~/bkce7.1-install/blueking/  # 进入工作目录
# 删除缓存的旧安装包
kubectl exec -n "$namespace" "$nodeman_backend_api_pod" -- sh -c 'rm -f /app/official_plugin/gse_agent/* && rm -f /app/official_plugin/gse_proxy/*'
# 复制文件到容器内
kubectl cp ../gse2/agents/gse_clients.tgz -n "$namespace" "$nodeman_backend_api_pod:/app/official_plugin/gse_agent/"
# 安装agent
kubectl exec -n "$namespace" "$nodeman_backend_api_pod" -- python manage.py init_agents -o stable
```

<a id="post-install-bk-nodeman-gse-plugin" name="post-install-bk-nodeman-gse-plugin"></a>

# 上传 gse 插件包
>**提示**
>
>* 灰度期间，插件包随监控套餐推出。

<!--

在前面的操作中，我们已经在中控机下载了所需的文件，如需更新文件，请查阅本文“提前下载资源”章节。

在 **中控机** 执行如下命令同时上传 agent 资源及 gse 插件：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/setup_bkce7.sh -u plugin  # 更新节点管理托管的gse插件。
```
结尾提示 `[INFO] upload agent package success` （客户端及 proxy） 和 `[INFO] upload open tools success` （proxy 所需的 nginx 及 py36 等）即为上传成功。

脚本执行完成后，访问节点管理的 「插件管理」——「插件包」界面，可以看到上传成功的插件包：

![](./assets/bk_nodeman-plugin-list.png)

插件集合包中各子包的用途：
| 插件包名 | 用途 | 描述 |
| -- | -- | -- |
| bkmonitorbeat | 蓝鲸监控指标采集器 | 蓝鲸监控拨测采集器 支持多协议多任务的采集，监控和可用率计算，提供多种运行模式和热加载机制 |
| bkmonitorproxy | 自定义上报服务 | 自定义数据上报服务，用来收集用户自定义上报的时序数据，或事件数据。 |
| bkunifylogbeat | 高性能日志采集 | 数据平台，蓝鲸监控，日志检索等和日志相关的数据. 首次使用插件管理进行操作前，先到日志检索/数据平台等进行设置插件的功能项 |
| bk-collector | 多协议数据采集 | 蓝鲸监控，日志检索，应用性能监控使用的高性能 Trace、指标、日志接收端，支持 OT、Jaeger、Zipkin 等多种数据协议格式。 |
-->

<a id="post-install-bk-nodeman-gse-env" name="post-install-bk-nodeman-gse-env"></a>

# 配置 GSE 环境管理
请先登录到蓝鲸桌面，打开“节点管理”应用。然后点击顶部导航栏 “全局配置”，会默认进入“gse 环境管理” 界面。

点击 “默认接入点” 右侧的 “编辑” 图标，进入 “编辑接入点” 界面。根据你的使用场景不同，请阅读对应的章节：
* 内网环境使用 IP 访问节点管理及制品库（兼容性最佳）
* 内网环境使用域名访问节点管理及制品库（要求建设内网 DNS 系统，且机器默认可解析相关域名）
* 公网环境配置（多云管理等复杂场景）

## 内网环境使用 IP 访问节点管理及制品库
填写要求如下：
1. 不建议编辑默认接入点的名字及说明。
2. **切勿修改区域及城市**。此配置和 GSE 集群配置相关，如果和 GSE 配置不一致则会禁止安装。
3. **zookeeper**系列配置：
   * 用户名和密码可执行如下命令获取 auth 字符串，其格式为 `用户名:密码`。
      ``` bash
      kubectl get -n blueking cm bk-gse-task-config -o go-template --template '{{index .data "gse_task.conf" }}' | jq -r ".zookeeper.token"
      # 蓝鲸bkce7.1-install包7.0.0-beta.2及更早版本使用如下命令
      # kubectl get -n blueking cm bk-gse-ce-task-config -o go-template --template '{{index .data "task.conf" }}' | jq -r ".zkauth"
      ```
   * 集群地址填写 **任意 k8s node IP**，端口填写 `bk-zookeeper` 服务的 NodePort： `32181` （注意不是默认的 `2181`）。
4. GSE 服务端系列配置：部署后会填写当前的 IP，可暂不修改。<br />今后如需更新某个字段（`BtfileServer`、`DataServer` 或 `TaskServer` ），请将该字段的**内网 IP**改为 `127.0.0.1`，以指示节点管理自动修改。自动修改仅进行一次，会使用 zookeeper 中的服务发现地址填充**内网 IP**及**外网 IP**。
5. 节点管理回调地址：用于安装日志上报等。需配置为节点管理 `bk-nodeman-backend-api` 服务的 NodePort 地址：`IP:30300`。
   * **外网回调地址**：和内网回调地址保持一致。
   * **内网回调地址**：填写 `http://任意Node的IP:30300/backend` （注意结尾没有斜杠）。
6. 部署文件下载地址。用于下载安装脚本、安装文件及用户自定义的监控插件等。
   * **Agent 包服务器目录**：请保持为空。
   * **agent 包 URL**：需配置为制品库 `bk-repo-bkrepo-gateway` 服务的 NodePort 地址： `IP:30025`。
     * **内网下载 URL**：第一个输入框。填写 `http://任意Node的IP:30025/generic/blueking/bknodeman/data/bkee/public/bknodeman/download`。
     * **外网下载 URL**：第二个输入框。内容同**内网地址**。
7. 点击 “测试 Server 及 URL 可用性”。
8. 测试通过后，可以点击“下一步”。
9. 在新的 “Agent 信息” 及 “Proxy 信息” 确认界面点击 “确认” 按钮即完成。

操作步骤如下图所示：

![](./assets/bk_nodeman-conf-gse-env.png)


如果在步骤 4 中将 **内网 IP** 改为 `127.0.0.1`，则回到查看界面后，请 **等待 1 ~ 2 分钟**，然后刷新页面。如果 `BtfileServer`、`DataServer` 或 `TaskServer` 字段的地址有从 `127.0.0.1` 变更为 node 的内网 IP ，则说明读取 zookeeper 成功，否则需检查 zookeeper 的 IP、 端口以及用户名密码是否正确。

## 内网环境使用域名访问节点管理及制品库
>**提示**
>
>仅当你的内网具备 DNS 服务，且新系统默认能解析 DNS 时，才能顺畅地使用域名作为入口。如果每次安装 agent 前还需要通过其他方式批量修改 `/etc/resolv.conf` 文件，则使用域名并不划算。

请先参考 “内网环境使用 IP 访问节点管理及制品库” 完成配置。然后调整部分字段：
1. 修改节点管理的 **外网回调地址** 和 **内网回调地址** 为域名，链接使用下方代码生成。
2. 修改**agent 包 URL** 的 内网下载 URL 和外网下载 URL 为域名，链接使用下方代码生成。

在 **中控机** 运行如下命令生成 URL 及 域名解析信息：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
cat <<EOF
节点管理外网及内网回调地址（注意结尾没有斜杠）： http://bknodeman.$BK_DOMAIN/backend
agent包URL内网及外网下载URL： http://bkrepo.$BK_DOMAIN/generic/blueking/bknodeman/data/bkee/public/bknodeman/download

配置 DNS 系统或者待纳管主机的 hosts 文件：
$IP1 bkrepo.$BK_DOMAIN
$IP1 bknodeman.$BK_DOMAIN
EOF
```

然后参考上述输出，配置 DNS 系统。

## 接入点公网配置
>**提示**
>
>TODO

请先参考 “内网环境使用 IP 访问节点管理及制品库” 完成配置。然后调整部分字段。

TODO


<a id="k8s-node-install-gse-agent" name="k8s-node-install-gse-agent"></a>

# 给 node 安装 gse agent

需要给集群的 “全部 node”（包括 `master`） 安装 gse agent，并放入《蓝鲸》业务。

agent 用途：
1. job 依赖 `node` 上的 gse agent 进行文件分发。节点管理安装插件时也是通过 job 分发。
2. 容器监控需要通过 `node` 上的 gse agent 完成监控。

因为蓝鲸智云 v6 和 v7 仅为部署形态差异，各产品软件版本会保持一致。故请参考 《[安装蓝鲸 Agent（直连区域）](../节点管理/产品白皮书/QuickStart/DefaultAreaInstallAgent.md)》 文档安装 agent。

在节点管理的 “普通安装” 界面，选择 **业务为《蓝鲸》**，云区域为 “直连区域”，安装通道及接入点均使用默认值。
>**提示**
>
>如果误选了《资源池》业务，可等待 agent 安装完毕。然后回到蓝鲸桌面，访问 “配置平台”，进入 “资源” —— “主机” 界面。<br />
>全选刚才新安装的主机，点击 “分配到” 按钮，选择 “业务空闲机池”。在弹窗中选择 《蓝鲸》 业务，点击 “确定” 按钮。完成后可点击顶部导航进入 “业务” 界面，左上角切换业务为 《蓝鲸》，即可看到这批主机。

当安装 agent 完成后，您可以参考 《[插件管理](../节点管理/产品白皮书/Feature/Plugin.md)》 文档为所有 agent 批量安装 `bkmonitorbeat` 和 `bkunifylogbeat` 插件，以便使用监控及日志功能。

常见报错：
1. `[script] agent(PID:NNN) is not connect to gse server`，请检查 “配置 GSE 环境管理” 章节的配置是否正确。
2. `命令返回非零值：exit_status -> 6, stdout -> , stderr -> curl: (6) Could not resolve host: bkrepo.$BK_DOMAIN; Unknown error`，请检查目标主机的 DNS 配置是否正确，也可临时添加 hosts 记录解决解析问题。或参考 “配置 GSE 环境管理” 章节配置 agent url 为 k8s node IP。
3. `ERROR setup_agent FAILED process check: agentWorker not found (node type:agent)`，agent 启动失败。如果是先添加的 k8s node，然后安装 agent 会遇到此问题。可先行取消调度此 node，然后驱逐所有 pod，并删除主机的 `/var/run/ipc.state.report` 目录。然后先安装 agent，再将 node 加回集群。

# 下一步
回到《[部署基础套餐](install-bkce.md#next)》文档看看其他操作。
