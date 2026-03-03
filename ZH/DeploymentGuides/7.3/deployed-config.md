环境部署后，各个产品有些功能需要运维提前配置才能生效，主要用于给测试使用。

注意：下列配置项打开后，要同步给对应的测试。

# 后端环境

## 切换 https

如果 ssl 证书挂在 ingress 上，需要用户管理配置：
```yaml
bklogin:
  extraEnvs:
  - name: BK_LOGIN_REDIRECT_URL_REQUIRE_HTTPS
    value: "False"
bkuser:
  extraEnvs:
  - name: OPEN_WEB_API_REQUIRED_BROWSER_HEADERS
    value: HTTP_ACCEPT,HTTP_ACCEPT_LANGUAGE,HTTP_ACCEPT_ENCODING,HTTP_USER_AGENT,HTTP_SEC_FETCH_DEST,HTTP_SEC_FETCH_MODE,HTTP_SEC_FETCH_SITE
```

## 部署蓝鲸 API 测试工具

部署前与测试确认好版本号

### 获取公共变量

```bash
sops_secret=$(kubectl -n blueking exec deploy/bkauth -- /app/bkauth cli list_access_key --app_code='bk_sops' -c /app/config.yaml | awk '/bk_sops/{print $3}')
notice_secret=$(kubectl -n blueking exec deploy/bkauth -- /app/bkauth cli list_access_key --app_code='bk_notice' -c /app/config.yaml | awk '/bk_notice/{print $3}')
cwaitsm_secret=$(kubectl -n blueking exec deploy/bkauth -- /app/bkauth cli list_access_key --app_code='cw_aitsm' -c /app/config.yaml | awk '/cw_aitsm/{print $3}')
```

### 多租户

```bash
touch environments/default/bkapicheck-custom-values.yaml.gotmpl
# 用户与密码请根据环境配置
cat >> environments/default/bkapicheck-custom-values.yaml.gotmpl << EOF
config:
  envs:
    BK_PAAS_ADMIN_USERNAME: test
    BK_PAAS_ADMIN_PASSWORD: Bluking@2025
    BK_MULTI_TENANT_MODE: "true"
    BK_NOTICE_APP_SECRET: $notice_secret
    BK_SOPS_APP_SECRET: $sops_secret
    CW_AITSM_APP_SECRET: $cwaitsm_secret
EOF
```

# 基础套餐

## API 网关

API网关部署后，需要运维提前配置的：

【必须】
- 网关 sdk
- 可编程网关跳转 paas 地址
- 展示运营状态和健康检查
- 启用 MCP Prompt 功能以及 Mock 模式

【可选】
- 流水日志 （依赖日志平台部署+配置采集+配置日志清洗）
- 仪表盘 （依赖蓝鲸监控部署+配置servicemonitor 采集）
- 统计报表（同仪表盘【每日定时任务查的蓝鲸监控，入库，累计统计数据】）

可选部分可以问测试是否需要提前打开。

### 网关 sdk 配置

网关 sdk 生成时，需要提前配置好上传 sdk 包所需的路径以及账号信息，配置如下：


```yaml
bkrepoConfig:
  genericBucket: generic
  mavenRepositoryID: system.bkpaas-maven
  mavenRepositoryPassword: "" # 制品库创建个人令牌
  mavenRepositoryURL: "{{ .Values.bkDomainScheme }}://bkrepo.{{ .Values.domain.bkDomain }}/maven/system.bkpaas/maven/"
  mavenRepositoryUsername: "" # 创建个人令牌的用户
  apigatewayPassword: blueking
  apigatewayProject: system.bkpaas
  apigatewayUsername: bkpaas3
```

### 可编程网关跳转 paas 平台地址
```bash
bkPaas3Url: {{ .Values.bkDomainScheme }}://bkpaas.{{ .Values.domain.bkDomain }}
```

### 网关流水日志

需要确保已经部署了日志平台并且打开容器日志采集功能 [蓝鲸各平台容器日志上报](https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.2/install-co-suite.md#%E8%93%9D%E9%B2%B8%E5%90%84%E5%B9%B3%E5%8F%B0%E5%AE%B9%E5%99%A8%E6%97%A5%E5%BF%97%E4%B8%8A%E6%8A%A5) 。

**配置清洗规则**：

容器化版本，API 网关请求流水日志、ESB 组件请求流水日志采集到 bklog 后，需要配置清洗规则后，才能在网关管理端查询。

**如何配置清洗规则**：

前往日志平台，【管理】 -> 【 清洗列表】，点击 【新增】，并关联对应的采集项：

- 采集项：选择 apigateway、esb 对应的采集项，如 bkapigateway_apigateway_container、bkapigateway_esb_container 
- 原始日志：如当前有请求记录，原始日志应该有默认填充值；如无默认填充值，构造一个 ESB 组件请求实际请求下
- 模式选择：JSON
- 调试字段设置：参考 bkapigateway_apigateway_api_log.json, bkapigateway_esb_api_log.json 中字段属性，为字段设置类型
	- 类型已初始设置为 string 的，一般不用改
	- integer: 类型可设置为 int，或者 long，timestamp 建议设置为 long
	- text：设置为 string
	- timestamp 字段：重命名设置为 _timestamp(官方不允许使用 timestamp), 设置为 `时间` 字段
	- 部分字段配置是否分词（一般为类型是 text 的部分字段），如网关字段：backend_addr, backend_host, backend_path, body, http_path, http_host, response_body 等，仅影响日志这些字段值的模糊查询

### 仪表盘与统计报表

依赖监控平台 + 配置 servicemonitor 采集，参考 [蓝鲸服务 SLI 看板](https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.2/install-co-suite.md#%E8%93%9D%E9%B2%B8%E6%9C%8D%E5%8A%A1%20SLI%20%E7%9C%8B%E6%9D%BF)

### 展示运营状态和健康检查

```yaml
dashboard:
  extraEnvVars:
    - name: FEATURE_FLAG_ENABLE_GATEWAY_OPERATION_STATUS
      value: "true"
    - name: FEATURE_FLAG_ENABLE_HEALTH_CHECK
      value: "true"
```

### 启用 MCP Prompt 功能以及 Mock 模式

```yaml
dashboard:
  extraEnvVars:
    - name: FEATURE_FLAG_ENABLE_MCP_SERVER_PROMPT
      value: "true"
    - name: BKAIDEV_USE_MOCK
      value: "true"
```

### 汇总

```yaml

```

## 开发者中心

【必须】
- 集群出口 ip （访问管理-域名解析）
- 可观测性

### 集群入口 ip

paas 的集群配置上虽然有个 “出口IP” 的设置，但是它其实是 “入口IP” 的含义。

前端配置路径：开发者中心-平台管理-应用集群-集群列表-编辑-集群访问入口 IP 。

后端配置：
```yaml
apiserver:
  initialCluster:
    ingressConfig:
      frontend_ingress_ip: "" # 此处填访问蓝鲸域名的外网 ip
```

### 可观测性

相关配置：
```yaml
global:
  bkOtel:
    # enabled 为 true 时才会在给应用创建 otel 增强服务实例
    enabled: true
    # 蓝鲸监控平台提供的 Grpc push url
    bkOtelGrpcUrl: "http://bk-collect-ip:4317" # 监控平台自定义上报 ip
  bkMonitor:
    enabled: true
    apiGateWay:
      enabled: true
    bkMonitorV3Url: '{{ .Values.bkDomainScheme }}://bkmonitor.{{ .Values.domain.bkDomain }}'
  # 蓝鲸日志相关配置
  bkLog:
    enabled: true
    apiGateWay:
      enabled: true
    config:
      timeZone: 8
      storageClusterID: "3" # 日志平台默认 ES 集群 ID
apiserver:
  initialCluster:
    featureFlags:
      #应用部署后会往监控下发告警策略
      ENABLE_BK_MONITOR: true
      #应用的日志走日志平台采集
      ENABLE_BK_LOG_COLLECTOR: true
```

## 消息通知中心

参考 [部署消息通知中心](https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.2/install-notice.md)

## 消息通知渠道

参考 [初始化通知渠道](https://github.com/TencentBlueKing/support-docs/blob/master/ZH/DeploymentGuides/7.3/install-bkce-tenant.md#%E5%88%9D%E5%A7%8B%E5%8C%96%E9%80%9A%E7%9F%A5%E6%B8%A0%E9%81%93%E5%8F%AF%E9%80%89)

# 监控日志套餐

## 监控平台

### APM

#### 安装 bk-collect 插件

任意选择一台目前环境管控的机器，前往节点管理安装 bk-collect 插件。

#### 监控平台填写配置自定义上报服务

路径：监控平台-全局设置-自定义上报默认服务器(|域名显示)

填写安装bk-collect插件的主机IP

#### bkpaas 配置 otel 增强服务

bkOtelGrpcUrl 为 安装了 `bk-collect 所在的机器 IP` 。端口默认为 `4317`

```yaml
global:
## OpenTelemetry 增强服务
  bkOtel:
    # enabled 为 true 时才会在给应用创建 otel 增强服务实例
    enabled: true
    # 蓝鲸监控平台提供的 Grpc push url
    bkOtelGrpcUrl: "http://<bk-collect-ip>:4317"
```

配置之后需要重新 sync bkpaas

```bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-paas sync

# 检查输出
helm get values -n blueking bk-paas | yq e '.global.bkOtel' -
```

删除 redis 缓存

```bash
redis_pass=$(kubectl get secrets -n blueking bk-redis -o go-template='{{index .data "redis-password" | base64decode }}{{"\n"}}')

kubectl exec -i -n blueking bk-redis-master-0 -- redis-cli -h bk-redis-master -p 6379 -a "$redis_pass" -n 0 del "1remote:service:config:a31e476d-5ec0-29b0-564e-5f81b5a5ef32"

kubectl exec -i -n blueking deploy/bkpaas3-apiserver-web -- python manage.py shell <<< 'from paasng.platform.scheduler.jobs import update_remote_services; update_remote_services()'
```

如果在配置之前就已经分配了 OTEL 的相关实例信息，此时可能 `OTEL_GRPC_URL` 为空。如果有这种情况需要前往开发者中心平台管理删掉原来分配的实例。然后重装对应 SaaS。这里以标准运维为例，

`注意`：请在删除前，仔细确认需要删除的是预发布还是正式环境。

#### 等待数据上报

前往监控平台-观测场景，左侧导航栏搜索 `sops/itsm`，数据已经归纳至对应的空间项目下。

如果 10 分钟左右还是无数据上报，需要登陆到对应的 pod，看下渲染 OTEL 环境变量与 bkpaas 分配的是否一致。

## 日志平台

### 日志提取链路

授权管理员用户为 django_admin 即可：
```bash
./scripts/bk-tenant-admin.sh su $tenant_supermanager_userid log
```

授权后，日志平台管理页面会出现日志提取链路管理。也可通过 url 访问 `bklog.${BK_DOMAIN}/#/manage/extract-link-manage/` 。

# 持续集成套餐

## 持续集成平台

Github 信息找测试要

### 关联github代码库

```yaml
config:
  bkCiRepositoryGithubApp: zhangsan****
  bkCiRepositoryGithubAppname: zhangsan**** # 同上
  bkCiRepositoryGithubClientId: Iv23****
  bkCiRepositoryGithubClientSecret: 0ce9bd7*********
```

部署
```bash
helmfile -f 03-bkci.yaml.gotmpl apply
```

重启 repository 模块
```bash
kubectl rollout restart deployment bk-ci-bk-ci-repository
```