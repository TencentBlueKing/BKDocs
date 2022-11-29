# 蓝鲸平台日志采集 Platform Log Collection

平台日志采集旨在将平台各个模块的日志统一采集到 ElasticSearch 中，原则上所有平台项目的日志都需要以容器标准日志输出的方式提供。

## 变量配置

以下参数均以 `bkplatform-filebeat.` 开头，描述中已省略

| 参数                                      | 描述                                                                  | 默认值                                        | 示例                   |
| ----------------------------------------- | --------------------------------------------------------------------- | --------------------------------------------- | ---------------------- |
| `global.elasticSearchSchema`              | ElasticSearch 访问协议, `http` 或 `https`                             | "http"                                        |                        |
| `global.elasticSearchHost`                | ElasticSearch 访问地址                                                | ""                                            |                        |
| `global.elasticSearchPort`                | ElasticSearch 访问端口                                                | ""                                            |                        |
| `global.elasticSearchUsername`            | ElasticSearch 访问用户名                                              | ""                                            |                        |
| `global.elasticSearchPassword`            | ElasticSearch 访问密码                                                | ""                                            |                        |
| `global.imagePullSecrets.extraSecrets`    | 镜像拉取 secret 名字列表                                              | []                                            | ["secretA"]            |
| `platform-filebeat.includeNamespaces`     | 行日志容器所在命名空间列表                                            | ["paas-system"]                               | []                     |
| `platform-filebeat.includeJSONNamespaces` | JSON 日志容器所在命名空间列表                                         | ["bk-apigateway"]                             | []                     |
| `platform-filebeat.image.repository`      | filebeat 镜像地址                                                     | "docker.elastic.co/beats/filebeat"            |                        |
| `platform-filebeat.image.tag`             | filebeat 镜像 Tag                                                     | "7.7.1"                                       |                        |
| `platform-filebeat.image.pullPolicy`      | filebeat 镜像拉取策略                                                 | "Always"                                      |                        |
| `platform-filebeat.containersLogPath`     | 母机上容器日志路径，默认为 BCS 集群生成路径，用于挂载容器标准输出日志 | "/data/bcs/docker/var/lib/docker/containers/" | "/var/log/containers/" |

## 高级配置

### 如何将平台自定义的日志文件纳入采集

首先，你需要额外定义一个 `sideCar` 用来将自定义的日志文件转发到容器标准输出日志文件。

一个简单的例子：

``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: apiserver
spec:
  containers:
  # 正常的平台容器
  - name: apiserver
    image: busybox
    volumeMounts:
    - name: app-json-log
      # 需要自定义采集的日志路径
      mountPath: ${CUSTOM_LOG_PATH}
  # 额外定义的转存 sidecar
  - name: log-channel
    image: busybox
    # 将日志文件内容，转送到标准输出
    args: [/bin/sh, -c, 'tail -n+1 -f ${CUSTOM_LOG_PATH}/EXAMPLE.log']
    volumeMounts:
    - name: app-json-log
      mountPath: ${CUSTOM_LOG_PATH}
  volumes:
  - name: varlog
    emptyDir: {}
```

同时，如果你需要使用额外的 ElasticSearch Index，请在 `pod.labels` 中添加：

``` yaml
platform-log-custom-index: ${CUSTOM_INDEX}
```

否则默认地，将和其他产品混用 Index。

### 解析标准输出中的 JSON 日志

与直接解析不同，我们需要额外在 `includeJSONNamespaces` 中配置目标所在命名空间
形如：

```yaml
includeJSONNamespaces:
  - bk-apigateway
```

如果想让命名空间内的标准输出日志更易观测，请务必加上 `platform-log-custom-index` 指定目标 Index。倘若在指定空间内，仍存在非 JSON 格式的日志，则将视为解析失败，被送往 `{{ platform-log-custom-index }}-nonjson` 中。
