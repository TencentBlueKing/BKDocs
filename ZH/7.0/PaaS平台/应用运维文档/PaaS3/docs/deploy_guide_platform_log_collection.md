# addons/platform-log-collection 安装指南

## 简介

`platform-log-collection` 是蓝鲸平台产品的日志采集组件。

## 准备服务依赖

开始部署前，请提供一套 ElasticSearch(7.x) 集群作为日志存储，以确保整体功能验证的流畅性。

## 准备 `values.yaml`

### 1. 准备采集组件的镜像

采集主要由 `filebeat` 构成，默认地，我们采用蓝鲸镜像。

如果你的集群无法访问外网仓库，请在 `values.yaml` 中覆盖对应的镜像地址

```yaml
bkplatform-filebeat:
  image:
    # 默认社区镜像地址
    repository: "docker.elastic.co/beats/filebeat"
    tag: "7.7.1"
    pullPolicy: "IfNotPresent"
```

### 2. 准备 ElasticSearch 集群信息

请准备好 ElasticSearch 集群信息，并将它们填写到正确的位置

```yaml
global:
  elasticSearchSchema: "http"
  elasticSearchHost: "some-elasticsearch-host"
  elasticSearchPort: "9600"
  elasticSearchUsername: "foo"
  elasticSearchPassword: "password-bar"
```

采集规则会自动在 ElasticSearch 中创建索引，并且上报监控信息。

### 3. 确定平台产品的命名空间

PaaS 相关产品需要按行采集标准输出内容，将其产品所在命名空间添加到 `includeNamespaces` 中。
apiGateway 相关的产品将标准输出中的内容以 JSON 解析，所以将产品所在命名空间添加到 `includeJSONNamespaces` 中。

```yaml
bkplatform-filebeat:
  includeNamespaces:
    - paas-system

  includeJSONNamespaces:
    - bk-apigateway
```

### 4. 确定容器标准输出路径

由于 k8s 集群初始化的方案会影响 docker 容器日志文件在母机上的存放地址。
默认地，我们假定集群采用 BCS 生成方案，即容器文件母机路径为： `/data/bcs/docker/var/lib/docker/containers/`

如果你使用的不是 BCS 方案，而是其他方案，例如 k8s 社区方案，那么大概率母机路径为：`/var/log/containers/`。此时，你需要在 `values.yaml` 中修改对应内容：

```yaml
bkplatform-filebeat:
  containersLogPath: /var/log/containers/
```

完成以上步骤，准备好 `values.yaml` 后，便可开始安装了。

## 安装 Chart

准备好 Values.yaml 后，你便可以开始安装蓝鲸应用采集组件了。执行以下命令，在集群内安装名为 `plat-log` 的 Helm release：

```shell
# 请使用独立的命名空间，不要和采集目标共用命名空间！
$ helm install plat-log bk-paas3/platform-log-collection --namespace plat-log --values value.yaml
```

上述命令将在 Kubernetes 集群中部署蓝鲸 PaaS 平台日志采集服务, 并输出访问指引。

### 卸载Chart

使用以下命令卸载 `plat-log`:

```shell
$ helm uninstall plat-log
```

上述命令将移除所有与 plat-log 相关的 Kubernetes 资源，并删除 release。

## 更多配置

可以查阅 [plat-log-collection 变量配置](../addons/platform-log-collection/README.md) 了解更多。
