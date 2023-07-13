这里汇总整理了各种访问入口及账户密码获取方法。

# 蓝鲸默认账户密码
>**提示**
>
>如无特殊说明，本文所提及的命令片段均应在 **中控机** 运行。

## PaaS 登录密码
bk-user 初始用户和密码
``` bash
kubectl get cm -n blueking bk-user-api-general-envs -o go-template='user={{.data.INITIAL_ADMIN_USERNAME}}{{"\n"}}password={{ .data.INITIAL_ADMIN_PASSWORD }}{{"\n"}}'
```

## bkrepo
bkrepo 使用了独立的账户密码。此处仅显示登录账户密码，去掉 `grep` 命令可以查看全部账户密码。
``` bash
kubectl get secret -n blueking bkpaas3-apiserver-bkrepo-envs -o go-template='{{range $k,$v := .data}}{{$k}}={{$v|base64decode}}{{"\n"}}{{end}}' | grep ADMIN
```

# 蓝鲸访问入口
蓝鲸工作台：

在 中控机 执行如下命令获取访问入口：
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
BK_DOMAIN=$(grep -h "" environments/default/{values,custom}.yaml 2>/dev/null | yq e '.domain.bkDomain' -)  # 读取默认或自定义域名
echo "http://$BK_DOMAIN"
```

# 存储组件的账户密码
## MySQL
获取 root 密码：
``` bash
kubectl get secrets -n blueking bk-mysql-mysql -o go-template='{{index .data "mysql-root-password" | base64decode}}{{"\n"}}'
```

## MongoDB
获取 root 密码 和 副本集密钥
``` bash
kubectl get secrets -n blueking bk-mongodb -o go-template='{{range $k,$v := .data}}{{$k}}={{$v|base64decode}}{{"\n"}}{{end}}'
```

## Redis
``` bash
kubectl get secrets -n blueking bk-redis -o go-template='{{index .data "redis-password" | base64decode }}{{"\n"}}'
```

## Elasticsearch
``` bash
kubectl get secrets -n blueking bk-elastic-elasticsearch -o go-template='{{index .data "elasticsearch-password" | base64decode }}{{"\n"}}'
```

## RabbitMQ
获取 erlang cookie。
``` bash
kubectl get secrets -n blueking bk-rabbitmq -o go-template='{{index .data "rabbitmq-erlang-cookie" | base64decode }}{{"\n"}}'
```

## Zookeeper
获取 auth 字符串，格式为 `用户名:密码`。

``` bash
kubectl get -n blueking cm bk-gse-task-config -o go-template --template '{{index .data "gse_task.conf" }}' | jq -r ".zookeeper.token"
```
如果提示 configmap not found，可尝试下旧版本的路径：
``` bash
kubectl get -n blueking cm bk-gse-ce-task-config -o go-template --template '{{index .data "task.conf" }}' | jq -r ".zkauth"
```

# 访问存储服务
访问公共 mysql：
``` bash
kubectl exec -it -n blueking bk-mysql-mysql-master-0 -- mysql -uroot -p密码
```

访问公共 mongodb:
``` bash
kubectl exec -it -n blueking bk-mongodb-0 -- mongo
```

访问公共 zk:
``` bash
kubectl exec -it -n blueking bk-zookeeper-0 -- zkCli.sh
```

# bcs 自带的存储服务

bcs 使用了自带的 mysql 和 mongodb pod。

查询 mysql 的 root 密码：
``` bash
kubectl get secrets -n bcs-system bcs-user-manager-mysql-password -o go-template='{{index .data "mysql-root-password" | base64decode}}{{"\n"}}'
```

查询 mongodb root 密码：
``` bash
kubectl get secrets -n bcs-system bcs-password -o go-template='{{index .data "mongodb-root-password" | base64decode}}{{"\n"}}'
```

连接 mysql：
``` bash
kubectl exec -it -n bcs-system bcs-mysql-0 -- mysql -uroot -p密码
```

连接 mongodb：
``` bash
kubectl exec -it -n bcs-system deploy/bcs-mongodb -- mongo mongodb://root:密码@/bcs-mongodb服务地址?authSource=admin

```

# 一些配置项
## gse 默认接入点的区域和城市
用于 节点管理 —— 全局配置 中的 `GSE默认接入点`：
``` bash
kubectl get -n blueking cm bk-gse-cluster-config -o go-template --template '{{index .data "gse_cluster.conf" }}' | jq '. | {default_region: .zone_id, default_city: .city_id}'
```
如果提示 configmap not found，可尝试下旧版本的路径：
``` bash
kubectl get -n blueking cm bk-gse-ce-task-config -o  go-template --template '{{ index (.data) "task.conf" }}' |  jq '. | {default_region: ."dftregid", default_city: ."dftcityid"}'
```
