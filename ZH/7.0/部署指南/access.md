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
cd ~/bkhelmfile/blueking/  # 进入工作目录
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

# 一些配置项
## gse 默认地区名和城市名
``` bash
kubectl get -n blueking cm bk-gse-ce-task-config -o  go-template --template '{{ index (.data) "task.conf" }}' |  jq '. | {default_region: ."dftregid", default_city: ."dftcityid"}'
```
