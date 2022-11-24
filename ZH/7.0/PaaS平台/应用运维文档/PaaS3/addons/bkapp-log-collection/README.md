# 蓝鲸应用日志采集 Blueking Application Log Collection

蓝鲸应用日志采集旨在将所有应用日志统一采集到 ElasticSearch 中，包含三类日志：

* 应用容器标准输出
* 应用自定义 JSON 日志
* 应用接入层访问日志

## 变量配置

以下参数均以 `global.` 开头，描述中已省略

| 参数                            | 描述                                      | 默认值 | 示例                             |
| ------------------------------- | ----------------------------------------- | ------ | -------------------------------- |
| `elasticSearchSchema`           | ElasticSearch 访问协议, `http` 或 `https` | "http" |                                  |
| `elasticSearchHost`             | ElasticSearch 访问地址                    | ""     | "elastichsearch.example.com"     |
| `elasticSearchPort`             | ElasticSearch 访问端口                    | ""     | "9600"                           |
| `elasticSearchUsername`         | ElasticSearch 访问用户名                  | ""     | "elastic"                        |
| `elasticSearchPassword`         | ElasticSearch 访问密码                    | ""     | "some-password"                  |
| `imagePullSecrets.extraSecrets` | 全局镜像拉取 Secret 名字列表              | []     | ["some-secretA", "some-secretB"] |

以下参数以 `bkapp-filebeat.` 开头

| 参数                | 描述                                                                  | 默认值                                        | 示例                   |
| ------------------- | --------------------------------------------------------------------- | --------------------------------------------- | ---------------------- |
| `image.repository`  | filebeat 镜像地址                                                     | "docker.elastic.co/beats/filebeat"            |                        |
| `image.tag`         | filebeat 镜像 Tag                                                     | "7.7.1"                                       |                        |
| `image.pullPolicy`  | filebeat 镜像拉取策略                                                 | "IfNotPresent"                                |                        |
| `containersLogPath` | 母机上容器日志路径，默认为 BCS 集群生成路径，用于挂载容器标准输出日志 | "/data/bcs/docker/var/lib/docker/containers/" | "/var/log/containers/" |

以下参数以 `bkapp-logstash.` 开头

| 参数               | 描述                  | 默认值                                | 示例 |
| ------------------ | --------------------- | ------------------------------------- | ---- |
| `image.repository` | filebeat 镜像地址     | "docker.elastic.co/logstash/logstash" |      |
| `image.tag`        | filebeat 镜像 Tag     | "7.7.0"                               |      |
| `image.pullPolicy` | filebeat 镜像拉取策略 | "IfNotPresent"                        |      |
