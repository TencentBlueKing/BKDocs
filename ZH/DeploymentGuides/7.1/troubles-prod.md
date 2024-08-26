# 产品使用问题
这里收录着产品使用过程中遇到的问题。

## 用户管理
### 新装环境组织架构默认目录不显示
#### 表现
用户管理 “组织架构” 界面时，左侧目录不显示。此时点击一次左下角的 “不可用目录” 按钮，则临时显示出 “默认目录” 及其下内容。刷新页面后，问题依旧。

#### 排查处理
版本小于 2.5.4-beta.10，仅在全新安装环境且只有默认目录时出现。

已于 2.5.4-beta.10 版本修复。请参考 《单产品更新》 文档更新 bk-user chart 版本： `>=1.4.14-beta.10`。

#### 总结
前端 bug


## 配置平台
### 字段组合模板新建侧栏空白
#### 表现
配置平台 “模型” —— “字段组合模板” 界面，点击 “新建” 按钮，右侧弹出的侧栏一片空白。

#### 排查处理
版本小于 3.11.2。

已于 3.11.2 版本修复。请参考 《单产品更新》 文档更新 bk-cmdb chart 版本： `>=3.12.2`。

#### 总结
前端 bug


## 作业平台
### 查看作业或任务中主机信息时页面报错
#### 表现
从旧版本升级到 3.7 后，界面出现报错：
1. 查看存量的作业模板、执行方案、定时任务及 IP 白名单中的主机时页面报错；
2. 生效范围为全业务的 IP 白名单不生效。

#### 排查处理
请参考对应更新文档进行数据迁移。如果未进行，会导致查询 hostid 失败而报错。

#### 总结
部署不当。


## 流程服务
### 新建服务时通知方式为空
#### 表现
全新部署的环境，在新建服务时，“通知设置” 里的 “通知方式” 没有正确展示复选框。

#### 排查处理
1. 确认问题。在中控机执行：
    ```bash
    cd ~/bkce7.1-install/blueking/  # 进入工作目录
    bkpaas_app_secret=$(yq '.appSecret.bk_paas' environments/default/app_secret.yaml)
    BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)
    curl -vs "http://bkapi.$BK_DOMAIN/api/c/compapi/cmsi/get_msg_type/?bk_app_code=bk_paas&bk_app_secret=$bkpaas_app_secret&bk_username=admin" | jq '.data[].icon="略"'
    ```
    如果显示 `is_active` 为 false，即为此问题。
2. 修改 apigateway。
    访问开发者中心--组件管理--组件管理，找到 CMSI 进入 ，如果没有自定义蓝鲸基础域名，则地址为 `http://apigw.bkce7.bktencent.com/components/access`

    找到名为 “get_msg_type” 的组件，点击编辑，重新保存一次，即可看到组件名称列中，显示 get_msg_type“有更新”。

    稍等 5 分钟左右，等缓存刷新，重新执行步骤 1 的检查，可以看到 `is_active` 显示为 `true`。即可继续操作。
3. 重新部署流程服务。步骤可参考 [部署文档](manual-install-saas.md#部署流程服务bk_itsm)（此时无需重新上传包）。

#### 总结
apigateway 初始化数据有误。


## 节点管理
### 安装 proxy 时报错 data access endpoint IP:28625 is not reachable
#### 表现
新部署的 7.1.3 版本，在节点管理中 安装 Proxy 时，在 “安装” 步骤失败：“[时间 ERROR] [script] [healthz_check] gse healthz check failed”。

此行报错上方日志为：
`"data": "data access endpoint(IP:28625) is not reachable"`。

#### 排查处理
需要升级节点管理到 2.4.4 版本。

1.  更新节点管理，请参考 [更新 bk-nodeman-2.4.4](updates/202403.md#bk-nodeman-2.4.4) 章节操作。
2.  在 **中控机** 重新上传 Agent 和 Proxy：
    ``` bash
    # 下载7.1.3的agent及proxy包
    bkdl-7.1-stable.sh -ur 7.1.3 gse_agent gse_proxy
    # 重新上传一次，触发新的解析策略。
    ./scripts/setup_bkce7.sh -u agent
    ./scripts/setup_bkce7.sh -u proxy
    ```
3.  在节点管理中勾选 Proxy 主机，批量重新安装即可。（或在历史任务详情里点击“失败重试”按钮。）

#### 总结
gse proxy 在 2.1.5-beta.7 版本的配置发生变动，依赖节点管理 `>=2.4.1` 版本。7.1.3 发版时仅升级了 gse 版本，未升级节点管理。属于发版失误，特此表示歉意。


## 容器管理平台
### 升级监控到 3.8.9 后无节点数据
#### 表现
升级监控到 3.8.9 后，容器管理平台 “概览”及“节点”等界面均无法看到监控数据，而监控平台“主机监控”界面则可以看到数据。

用户反馈： https://bk.tencent.com/s-mart/community/question/13787

#### 排查处理
先登录 **中控机**，执行查询语句确认问题：
``` bash
# 获取一个k8s node ip，以及当前时间戳。可自行赋值。
k8s_node=$(kubectl get nodes -o jsonpath={.items[0].status.addresses[?\(@.type==\"InternalIP\"\)].address})
ts=$(date +%s)
# 构造查询请求。查询一小时前的node ip监控数据。
printf -v body '{"promql":"{bcs_cluster_id=\\"BCS-K8S-00000\\", bk_instance=~\\"%s\\", __name__=\\"node_memory_MemFree_bytes\\", bk_biz_id=\\"2\\"}","start":"%s","step":"60s"}' "$k8s_node" "$((ts-3600))"

# 查询预期无数据，显示 {"series":[]}
kubectl exec -it -n bcs-system deploy/bcs-monitor-storegw -- curl -X POST 'http://bk-monitor-unify-query-http.blueking.svc.cluster.local:10205/query/ts/promql?bk_app_code=bk_bcs_app&bk_app_secret=%3Cmasked%3E' -H "User-Agent: bcs-monitor/v1.0" -H "X-Bk-Scope-Space-Uid: bkcc__2" -H "Content-Type: application/json" -d "$body"
# 查询预期有数据
kubectl exec -it -n bcs-system deploy/bcs-monitor-storegw -- curl -X POST 'http://bk-monitor-unify-query-http.blueking.svc.cluster.local:10205/query/ts/promql?bk_app_code=bk_bcs_app&bk_app_secret=%3Cmasked%3E' -H "User-Agent: bcs-monitor/v1.0" -H "X-Bk-Scope-Space-Uid: bkcc__2" -H "Content-Type: application/json" -d "${body/bk_instance/instance}"
```

如果 2 条 curl 命令的响应符合注释描述，则命中此问题。如果“查询预期无数据”也能看到数据，则可能为其他问题，可以联系蓝鲸助手排查。

修改配置文件：
``` bash
# 进入工作目录
cd "${INSTALL_DIR:-INSTALL_DIR-not-set}/blueking/"
# 修改配置文件
touch environments/default/bkmonitor-operator-custom-values.yaml.gotmpl
yq -i '.bkmonitor-operator-charts.bkmonitor-operator.builtinLabels = ["instance"]'  environments/default/bkmonitor-operator-custom-values.yaml.gotmpl
```

重启 release：
``` bash
helmfile -f 04-bkmonitor-operator.yaml.gotmpl sync
```

重启 release 不会影响已有的资源，会在数秒内完成。如果 `helmfile sync` 命令超时，请先删除异常 pod，然后重试一次。

检查 configmap：
``` bash
kubectl get configmap -n bkmonitor-operator bkm-operator -o jsonpath='{.data.bkmonitor-operator\.yaml}' | yq '.operator.builtin_labels'
```
预期显示：
``` yaml
- "instance"
```

稍等 1~3 分钟，重新执行上文确认操作里的“查询预期无数据”命令，能查到数据即说明新的 configmap 已经生效。

此时刷新容器管理平台页面，即可看到监控数据。

#### 总结
监控平台规范了维度名，未更新兼容配置所致。
