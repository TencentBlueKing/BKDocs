# 蓝盾-容器化-整体部署方案
## 部署持续集成套餐
- 持续集成套餐包含“流水线CI”、“代码检查CodeCC”及、“编译加速Tbs”；
- 制品库 已经做为蓝鲸基座进行部署设置，下面不再赘述；
- 编译加速Tbs 可以暂时不用部署；

## 持续集成套餐存储依赖

>**提示**
>
> - 如下说明的可以使用腾讯云服务，或其他云存储服务；
> - 存储资源的用户名/密码认证信息后续需要配置到charts的yaml文件中，用于部署；
> - 需开通对应的网络及认证；

### 流水线CI依赖存储资源

<table style="table-layout:fixed ; word-wrap:break-all">
    <colgroup>
        <col width="50">
        <col width="50">
        <col width="300">
    </colgroup>
    <tr>
        <th style="text-align:left ; color:#FFFFFF ; background-color:#0049B0">序号</th>
        <th style="text-align:left ; color:#FFFFFF ; background-color:#0049B0">存储类型</th>
        <th style="text-align:left ; color:#FFFFFF ; background-color:#0049B0">配置参考</th>
    </tr>
    <tr>
        <td>1</td>
        <td>mysql</td>
        <td>初始容量：500G <br> 版本：5.7 <br> 字符集：utf8mb4</td>
    </tr>
    <tr>
        <td>2</td>
        <td>redis</td>
        <td>10G <br> 5.0单实例</td>
    </tr>
    <tr>
        <td>3</td>
        <td>mongo</td>
        <td>数据盘：1000G <br> 版本：4.2 <br> 规格：4C8G</td>
    </tr>
    <tr>
        <td>4</td>
        <td>elasticsearch</td>
        <td>规格：3*500GB <br> 版本：7.10.1</td>
    </tr>
    <tr>
        <td>5</td>
        <td>influxdb</td>
        <td>300G <br> 1.8.4</td>
    </tr>
    <tr>
        <td>6</td>
        <td>rabbitmq</td>
        <td>容器化方式部署/或云及第三方rabbitmq服务</td>
    </tr>
</table>

### 代码检查CodeCC依赖存储资源

<table style="table-layout:fixed ; word-wrap:break-all">
    <colgroup>
        <col width="50">
        <col width="50">
        <col width="300">
    </colgroup>
    <tr>
        <th style="text-align:left ; color:#FFFFFF ; background-color:#0049B0">序号</th>
        <th style="text-align:left ; color:#FFFFFF ; background-color:#0049B0">存储类型</th>
        <th style="text-align:left ; color:#FFFFFF ; background-color:#0049B0">配置参考</th>
    </tr>
    <tr>
        <td>1</td>
        <td>redis</td>
        <td>8G <br> 5.0单实例</td>
    </tr>
    <tr>
        <td>3</td>
        <td>mongo</td>
        <td>数据盘：1000G <br> 版本：4.2 <br> 规格：4C8G</td>
    </tr>
    <tr>
        <td>3</td>
        <td>rabbitmq</td>
        <td>容器化方式部署/或云及第三方rabbitmq服务</td>
    </tr>
</table>

## 配置 coredns

在 **中控机** 执行（此部分在部署蓝鲸时会有设置）：
``` bash {.line-numbers highlight=[]}
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get svc -A -l app.kubernetes.io/instance=ingress-nginx -o jsonpath='{.items[0].spec.clusterIP}')
./scripts/control_coredns.sh update "$IP1" devops.$BK_DOMAIN codecc.$BK_DOMAIN bktbs.$BK_DOMAIN
./scripts/control_coredns.sh list  # 检查添加的记录。
```

## 仓库信息
``` bash {.line-numbers highlight=[]}
NAME            URL
blueking        https://hub.bktencent.com/chartrepo/blueking
```

## 部署 ci
如下全部操作，在 **中控机** 执行。

编辑部署ci依赖的helmfile custom yaml文件，参考如下：
- 下面方案全部使用云/第三方的存储资源，在这个前提下，下面信息需要输入到后续的yaml配置中（若使用容器化方式的存储，则不用设置外部数据源）
  - mysql注意设置IP/端口/用户名/密码；
  - redis注意设置IP/端口/密码；
  - es注意设置IP/端口/用户名/密码；
  - mongo注意设置连接串/认证串；
  - influxdb注意设置IP/端口/用户名/密码；
  - rabbitmq注意设置IP/用户名/密码/vhost，以及提前进行set_user_tags，set_permissions设置；
- 如果没用到github作为代码仓库，就不用配置关联Github代码库配置部分；
- 如下的pod replicas，mem，cpu数值为参考，可根据实际情况，自行定义设置；

``` bash {.line-numbers highlight=[]}
[root@kubectl ~/bkhelmfile/blueking/environments/default/bkci]# cat bkci-custom-values.yaml.gotmpl
# 内部数据源配置
mysql:
  enabled: false
redis:
  enabled: false
elasticsearch:
  enabled: false
mongodb:
  enabled: false
influxdb:
  enabled: false
rabbitmq:
  enabled: false

# 特别注意：使用了云/第三方的存储才需要设置如下部分
# 特别注意：使用了云/第三方的存储的，上面的需要设置为false
# 外部数据源配置
externalMysql:
  host: 云/第三方mysql IP
  port: 云/第三方mysql 端口
  username: 云/第三方mysql 用户
  password: 云/第三方mysql 密码
externalRedis:
  host: 云/第三方redis IP
  port: 云/第三方redis 端口
  password: 云/第三方redis 密码
externalElasticsearch:
  host: 云/第三方Elasticsearch IP
  port: 云/第三方Elasticsearch 端口
  username: 云/第三方Elasticsearch 用户名
  password: 云/第三方Elasticsearch 密码
externalMongodb:
  turbo:
    turboUrl: 云/第三方mongdb认证连接串
    quartzUrl: 云/第三方mongdb认证连接串
externalInfluxdb:
  host: 云/第三方InfluxDB IP
  port: 云/第三方InfluxDB 端口
  username: 云/第三方InfluxDB 用户名
  password: 云/第三方InfluxDB 密码
externalRabbitmq:
  host: 云/第三方Rabbitmq IP
  username: 云/第三方Rabbitmq 用户名
  password: 云/第三方Rabbitmq 密码
  vhost: bkci

#日志监控配置
bkLogConfig:
  enabled: {{ .Values.bkLogConfig.enabled }}
  service:
    dataId: 1
  gatewayAccess:
    dataId: 1
  gatewayError:
    dataId: 1
serviceMonitor:
  enabled: {{ .Values.serviceMonitor.enabled }}

config:
  #关联Github代码库配置，若需要此部分功能
  bkCiRepositoryGithubApp: ""
  bkCiRepositoryGithubClientId: ""
  bkCiRepositoryGithubClientSecret: ""
  bkCiRepositoryGithubSignSecret: ""
  bkCiRepositoryGithubServer: ""
  bkRepoFqdn: ""
  bkRepoGatewayIp: ""

# 构建机资源配置变量
buildResource:
  publicDocker:
    enabled: true
  k8sBuild:
    enabled: false
  defaultValue: DOCKER

# Log Deployment
log:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 1500Mi
    limits:
      cpu: 500m
      memory: 2000Mi

# Auth Deployment
auth:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 300m
      memory: 1000Mi
    limits:
      cpu: 1000m
      memory: 1500Mi

# artifactory Deployment
artifactory:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 1000Mi
    limits:
      cpu: 500m
      memory: 1500Mi

# dispatch Deployment
dispatch:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 1000Mi
    limits:
      cpu: 500m
      memory: 1500Mi

# dispatchDocker Deployment
dispatchDocker:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 1500Mi
    limits:
      cpu: 500m
      memory: 2000Mi

# dispatchKubernetes Deployment
dispatchKubernetes:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 1000Mi
    limits:
      cpu: 500m
      memory: 1500Mi

# environment Deployment
environment:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 1000Mi
    limits:
      cpu: 500m
      memory: 1500Mi

# image Deployment
image:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 1000Mi
    limits:
      cpu: 500m
      memory: 1500Mi

# misc Deployment
misc:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 1000Mi
    limits:
      cpu: 500m
      memory: 1500Mi

# metrics Deployment
metrics:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 2000Mi
    limits:
      cpu: 500m
      memory: 3000Mi

# monitoring Deployment
monitoring:
  enabled: false
  replicas: 1
  resources:
    requests:
      cpu: 100m
      memory: 1000Mi
    limits:
      cpu: 500m
      memory: 1500Mi

# notify Deployment
notify:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 1000Mi
    limits:
      cpu: 500m
      memory: 1500Mi

# openapi Deployment
openapi:
  enabled: false
  replicas: 1
  resources:
    requests:
      cpu: 100m
      memory: 1000Mi
    limits:
      cpu: 500m
      memory: 1500Mi

# plugin Deployment
plugin:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 1000Mi
    limits:
      cpu: 500m
      memory: 1500Mi

# process Deployment
process:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 2000Mi
    limits:
      cpu: 1000m
      memory: 3000Mi

# project Deployment
project:
  enabled: true
  replicas: 2
  podLabels: {}
  resources:
    requests:
      cpu: 100m
      memory: 2000Mi
    limits:
      cpu: 1000m
      memory: 3000Mi

# quality Deployment
quality:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 1000Mi
    limits:
      cpu: 500m
      memory: 1500Mi

# repository Deployment
repository:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 1000Mi
    limits:
      cpu: 500m
      memory: 1500Mi

# sign Deployment
sign:
  enabled: false
  replicas: 1
  resources:
    requests:
      cpu: 100m
      memory: 1000Mi
    limits:
      cpu: 500m
      memory: 1500Mi

# store Deployment
store:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 300m
      memory: 1500Mi
    limits:
      cpu: 1000m
      memory: 2000Mi

# ticket Deployment
ticket:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 1000Mi
    limits:
      cpu: 500m
      memory: 1500Mi

# websocket Deployment
websocket:
  enabled: true
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 1000Mi
    limits:
      cpu: 500m
      memory: 1500Mi

# turbo Deployment
turbo:
  enabled: true
  replicaCount: 2

# gateway Deployment
gateway:
  enabled: true
  type: NodePort
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 500Mi
    limits:
      cpu: 500m
      memory: 800Mi
```
设置完毕，进行部署

``` bash {.line-numbers highlight=[]}
cd ~/bkhelmfile/blueking/  # 进入工作目录
helmfile -f 03-bkci.yaml.gotmpl sync  # 部署流水线。
# 在admin桌面添加应用，也可以登录后自行添加。
scripts/add_user_desktop_app.sh -u "admin" -a "bk_ci"
# 设为默认应用。
scripts/set_desktop_default_app.sh -u "admin" -a "bk_ci"
```
部署需 5 ~ 10 分钟。上述命令结束后，可在中控机检查所有 Pod 是否正常：
``` bash
kubectl get pod -A | grep bk-ci
```

## 部署 codecc
如下全部操作，在 **中控机** 执行。

编辑codecc依赖的helmfile custom yaml文件，参考如下：
- 全部使用云/第三方的存储资源。
- pod replicas，mem，cpu可自行定义设置，根据实际情况。

``` bash {.line-numbers highlight=[]}
[root@kubectl ~/bkhelmfile/blueking/environments/default/bkci]# cat bkcodecc-custom-values.yaml.gotmpl
# 启用云/第三方mongodb服务实例
mongodb:
  enabled: false
externalMongodb:
  host: 云/第三方mongdb认证连接串
  username: 云/第三方mongdb用户名
  password: 云/第三方mongdb密码
  port: 云/第三方mongdb端口
  extraUrlParams: authSource=admin
  authDB: admin

# 启用云/第三方redis服务实例
redis:
  enabled: false
externalRedis:
  host: 云/第三方redis IP
  port: 云/第三方redis端口
  password: 云/第三方redis密码

# https模式
config:
  bkHttpSchema: https
  bkCiPublicSchema: https
  bkCodeccPublicSchema: https
```

设置完毕，进行部署

``` bash {.line-numbers highlight=[]}
cd ~/bkhelmfile/blueking/  # 进入工作目录
helmfile -f 03-bkcodecc.yaml.gotmpl sync  # 部署CodeCC
```
部署需 5 ~ 10 分钟。上述命令结束后，可在中控机检查所有 Pod 是否正常：
``` bash {.line-numbers highlight=[]}
kubectl get pod -A -o wide | grep bk-codecc
```

## 浏览器访问

- 需要配置域名 `devops.$BK_DOMAIN`，操作步骤已经并入《基础套餐部署》文档的 “[配置用户侧的 DNS](https://bk.tencent.com/docs/document/7.0/172/29311?r=1#hosts-in-user-pc))” 章节。可做参考；
- 配置成功后，即可在桌面打开 “持续集成平台-蓝盾” 应用了；
- codecc需要自行上传设置代码检查插件；