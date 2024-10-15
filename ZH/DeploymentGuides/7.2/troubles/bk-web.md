本文档按产品名组织章节。部分产品问题复杂，会进一步细化指引，请注意阅读。

## 蓝鲸登录

### 登录界面样式丢失
#### 表现

当提示登录时，登录界面只能看到文字，且排版错乱。

#### 排查处理

打开浏览器开发者工具，切换到 network 栏刷新，发现请求静态资源（图片、js 及 css）时响应为 404 Not Found。

首先检查 `ingress-nginx` 的日志，得到请求的上游地址。

检查 endpoint：
``` bash
kubectl get endpoints -A
```

发现确实是 `bk-login-web` pod。

检查 pod 日志：
``` bash
kubectl logs -n blueking deploy/bk-login-web
```

发现对应资源确实是 bk-login-web 响应的 404，且上一行伴有异常：
``` plain
[Errno 2] No such file or directory: '/app/staticfiles//js/login.js'
::ffff:10.244.0.1 - - [时间略] "GET /static/js/login.js HTTP/1.1" 404 13 "http://bkce7.bktencent.com/login/?c_url=/" "UA略" in 0.000382 seconds
```

比对正常环境日志，发现启动时少了一行输出：
``` plain
55 static files copied to '/app/staticfiles'.
```

怀疑是 pod 启动阶段遇到异常，导致 Django collectstatic 因为异常退出，无法复制所需的静态文件。待开发修复。

#### 总结

环境问题。

bk-login-pod 启动异常，在中控机执行如下命令重启：
``` bash
kubectl rollout restart deployment -n blueking bk-login-web
```
观察新 pod Ready 后，然后刷新浏览器页面即可。


## 蓝鲸桌面
### 蓝鲸桌面点击图标后提示 应用已经下架，正在为您卸载该应用
#### 表现

在蓝鲸桌面点击应用图标，结果提示 ”应用已经下架，正在为您卸载该应用……”。

#### 排查处理

点击桌面的 “添加” 按钮，发现应用商店中只有 “配置平台”、“作业平台” 和 新安装的 SaaS，并没有 “权限中心”、“用户管理” 等应用。

怀疑为 PaaS 初始化数据库异常，用户暂未提供日志，无法找到初始化失败的原因。

#### 总结

PaaS 初始化异常。

我们正在排查此问题出现的原因，请在 **中控机** 执行如下命令取得数据库转储文件：
``` bash
kubectl exec -it -n blueking bk-mysql-mysql-master-0 -- mysqldump -uroot -pblueking --databases open_paas bkpaas3_apiserver | gzip -c > bk-paas3-dump.sql.gz
```
然后将生成的 `bk-paas3-dump.sql.gz` 文件发送给蓝鲸助手。


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

### 配置平台循环登录
#### 表现

当访问 配置平台（CMDB）时，登录成功后依旧不断提示登录。但是登录成功后访问其他系统均访问，且隐私窗口中只需登录一次即可访问配置平台。

#### 排查处理

蓝鲸 V6 的默认部署域名为 `bktencent.com`，而蓝鲸 V7 的默认域名为 `bkce7.bktencent.com`。当用户已经成功登录 V6 环境后，则会在浏览器存储 `bk_token`，此时访问 V7 环境，因为域名后缀相同，则 `bktencent.com` 域名里的 `bk_token` cookie 也会发给 V7 环境，导致登录校验失败。

此问题涉及同名 cookie 读取逻辑调整，待配置平台评估正式解决方案。

#### 总结

环境问题。

用户同时存在多套蓝鲸环境且域名后缀相同，最终清空浏览器 cookie 解决。

使用其他浏览器（或同浏览器登录其他账户）也可临时解决问题。

建议用户尝试使用其他域名。


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
3. 重新部署流程服务。步骤可参考 [部署文档](../manual-install-saas.md#部署流程服务bk_itsm)（此时无需重新上传包）。

#### 总结
apigateway 初始化数据有误。


## 节点管理


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


## 监控平台

### 监控平台 观测场景 kubernetes 访问报错 resource is unauthorized
#### 表现

访问 “监控平台” —— “观测场景” —— “kubernetes” 界面。页面提示 报错 “resource is unauthorized”。

#### 排查处理

“部署监控平台”章节末尾有提示配置容器监控，但是用户可能遗漏，需要先询问确认。

如果已经配置过，需要核对 bcs token 是否正确。在工作目录执行 `bash -x scripts/config_monitor_bcs_token.sh`，检查输出的 `GATEWAY_TOKEN` 和 `./environments/default/bkmonitor-custom-values.yaml.gotmpl` 内容是否一致。
   * 如果不一致，请替换文件内容，并部署一次监控平台：`helmfile -f 04-bkmonitor.yaml.gotmpl sync`。
   * 如果一致，也请 **先尝试部署一次监控平台**。如果问题依旧，请联系助手排查。

#### 总结

分为 2 种情况：
1. 操作不当：遗漏步骤 [配置容器监控](../install-co-suite.md#bkmonitor-install-operator)。
2. 配置不当：bcs 实际 token 变动，更新 token 配置后重启监控平台解决。


## 权限中心

### 权限中心中申请节点管理及作业平台系统的权限时报错
#### 表现

在权限中心申请自定义权限，切换到节点管理系统后，点击选择资源实例时，浏览器顶部会出现报错：
``` plain
接入系统资源接口请求失败: bk_nodeman's API unreachable! call bk_nodeman's API fail! you should check: 1.the network is ok 2.bk_nodeman is available 3.get details from bk_nodeman's log. [POST /api/iam/v1/cloud body.data.method=list_instance](system_id=bk_nodeman, resource_type_id=cloud) request_id=d840e70027cbcd7075bba0f0de3d03cb. Exception HTTPConnectionPool(host='bknodeman.bkce7.bktencent.com', port=80): Max retries exceeded with url: /api/iam/v1/cloud (Caused by NewConnectionError('<urllib3.connection.HTTPConnection object at 0x7f57e8ff8668>: Failed to establish a new connection: [Errno -2] Name or service not known',)) (RESOURCE_PROVIDER_ERROR)
```

申请作业平台权限时也会出现相同的报错。

#### 排查处理

目前节点管理及作业平台对接权限中心使用了 `$BK_DOMAIN` 后缀的域名，所以需要配置解析。

后续会评估能否切换为 k8s 服务发现域名。请临时配置 coredns 解决此问题。

#### 总结

蓝鲸部署文档 bug。

需要补充注册下 coredns，在中控机执行如下脚本：
``` bash
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" bknodeman.$BK_DOMAIN jobapi.$BK_DOMAIN $BK_DOMAIN
```
