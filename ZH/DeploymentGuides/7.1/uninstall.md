# 卸载
当部署时出错，请留意显示的 release 名字。

如果 pod 稳定在 `CrashLoopBackOff` 状态，且重新执行部署命令依旧未能成功，说明需要卸载对应的 release，并清除数据。

如果出错的 release 过多，可以选择卸载整个蓝鲸，然后从头开始部署。

请查阅对应章节了解操作细节。

## 卸载单个 release

我们封装了卸载脚本可以实现 release 卸载及关联的 k8s 资源（包括 cm、pvc 等数据）的删除。

本章下级标题均以 release 名区分，你可以在中控机使用如下命令查看所有的 release：
``` bash
helm list -aA
```
### 卸载 ingress 及公共存储服务
本章内容适用于蓝鲸预置的 `00-ingress-nginx.yaml.gotmpl` 及 `base-storage.yaml.gotmpl` 定义的 release。

如果你安装时选择自备 ingress-nginx 及存储服务，则本章内容仅供参考，不宜直接粘贴命令使用。

#### 卸载 ingress-nginx
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
NAMESPACE="ingress-nginx" ./scripts/uninstall.sh -y ingress-nginx
```
重新安装：
``` bash
helmfile -f 00-ingress-nginx.yaml.gotmpl sync
```
当 `ingress-nginx` 重装后，请参考《[部署基础套餐](install-bkce.md)》文档刷新各场景下除 `apps.$BK_DOMAIN` 外其他域名的解析记录。


#### 卸载 bk-mysql
使用此方法卸载会删除 pvc，丢失所有数据记录。请提前备份。
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-mysql
```
重新安装：
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-mysql sync
```

#### 卸载 bk-rabbitmq
使用此方法卸载会删除 pvc，丢失所有数据记录。请提前备份。
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-rabbitmq
```
重新安装：
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-rabbitmq sync
```

#### 卸载 bk-redis
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-redis
```
重新安装：
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-redis sync
```

#### 卸载 bk-redis-cluster
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-redis-cluster
```
重新安装：
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-redis-cluster sync
```

#### 卸载 bk-mongodb
使用此方法卸载会删除 pvc，丢失所有数据记录。请提前备份。
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-mongodb
```
重新安装：
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-mongodb sync
```

#### 卸载 bk-elastic
使用此方法卸载会删除 pvc，丢失所有数据记录。请提前备份。
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-elastic
```
重新安装：
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-elastic sync
```

#### 卸载 bk-zookeeper
使用此方法卸载会删除 pvc，丢失所有数据记录。请提前备份。
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-zookeeper
```
重新安装：
``` bash
helmfile -f base-storage.yaml.gotmpl -l name=bk-zookeeper sync
```


### 卸载基础套餐
在 `base-blueking.yaml.gotmpl` 中定义了蓝鲸基础套餐的 release。

SaaS 不能卸载，一般重新部署一次即可解决问题。如果遇到问题可以联系助手。

#### 卸载 bk-repo
>**注意**
>
>卸载 bk-repo 时会移除 pvc，蓝鲸其他平台托管在 bkrepo 的文件将会丢失，且无法重新找回。
>
>如果是在刚开始安装 bk-repo 时异常，可用本方法卸载。如果已经安装过了 bk-paas，保险起见应该卸载整个蓝鲸。

``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-repo
```
重新安装：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-repo sync
```

#### 卸载 bk-auth
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-auth
```
重新安装：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-auth sync
```

#### 卸载 bk-apigateway
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-apigateway
```
重新安装：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-apigateway sync
```

#### 卸载 bk-iam
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-iam
```
重新安装：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-iam sync
```

#### 卸载 bk-ssm
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-ssm
```
重新安装：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-ssm sync
```

#### 卸载 bk-console
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-console
```
重新安装：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-console sync
```

#### 卸载 bk-user
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-user
```
重新安装：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-user sync
```

#### 卸载 bk-iam-saas
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-iam-saas
```
重新安装：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-iam-saas sync
```

#### 卸载 bk-iam-search-engine
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-iam-search-engine
```
重新安装：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-iam-search-engine sync
```

#### 卸载 bk-gse
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-gse
```
重新安装：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-gse sync
```

#### 卸载 bk-cmdb
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-cmdb
```
重新安装：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-cmdb sync
```

#### 卸载 bk-paas
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-paas
```
重新安装：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-paas sync
```

#### 卸载 bk-applog
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-applog
```
重新安装：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-applog sync
```

#### 卸载 bk-ingress-nginx
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-ingress-nginx
```
重新安装：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-ingress-nginx sync
```
当 `bk-ingress-nginx` 重装后，请参考《[部署基础套餐](install-bkce.md)》文档刷新各场景下 `apps.$BK_DOMAIN` 域名的解析记录。

#### 卸载 bk-ingress-rule
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-ingress-rule
```
重新安装：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-ingress-rule sync
```

#### 卸载 bk-job
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-job
```
重新安装：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-job sync
```

#### 卸载 bk-nodeman
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-nodeman
```
重新安装：
``` bash
helmfile -f base-blueking.yaml.gotmpl -l name=bk-nodeman sync
```
节点管理在部署后需要配置，请参考《[部署基础套餐](install-bkce.md)》文档补齐相关操作。

### 卸载 容器管理套餐
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
NAMESPACE="bcs-system" ./scripts/uninstall.sh -y bcs-services-stack
```
核对下是否有残留资源：
``` bash
kubectl get deploy,sts,cronjob,job,pod,svc,ingress,secret,cm,sa,role,rolebinding,pvc -n bcs-system
```
可能残留一些公共资源，为正常情况。参考输出：
``` plain
NAME                     TYPE  其他字段略
secret/default-token-略  kubernetes.io/service-account-token  其他字段略

NAME  其他字段略
configmap/kube-root-ca.crt  其他字段略

NAME  其他字段略
serviceaccount/default  其他字段略
```

重新安装方法见《[部署容器管理平台](install-bcs.md)》 文档。


### 卸载 监控日志套餐
重新安装方法见 《[部署监控日志套餐](install-co-suite.md)》 文档对应章节。

#### 卸载 bk-monitor
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-monitor
```

#### 卸载 bk-monitor-operator
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
NAMESPACE="bkmonitor-operator" ./scripts/uninstall.sh -y bkmonitor-operator
```
#### 卸载 bk-log-search
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-log-search
```
#### 卸载 bklog-collector
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bklog-collector
```


### 卸载 持续集成套餐
重新安装方法见 《[部署持续集成套餐](install-ci-suite.md)》 文档对应章节。

#### 卸载 bk-ci
``` bash
cd ~/bkce7.1-install/blueking/  # 进入工作目录
./scripts/uninstall.sh -y bk-ci
```


## 卸载整个蓝鲸
如果只是需要删除部分 release 或套餐，可参考上文对应内容操作。

如果想完全卸载蓝鲸，请按以下步骤操作：

1.  浏览器访问节点管理，卸载全部节点的 GSE Agent。如有部署 Proxy，卸载 Agent 完毕后请一并卸载。
2.  根据安装顺序反过来依次卸载，先卸载监控日志套餐（如有安装）：
    ``` bash
    cd ~/bkce7.1-install/blueking/  # 进入工作目录
    ./scripts/uninstall.sh -y bklog-collector
    NAMESPACE="bkmonitor-operator" ./scripts/uninstall.sh -y bkmonitor-operator
    ./scripts/uninstall.sh -y bk-log-search
    ./scripts/uninstall.sh -y bk-monitor
    ```
3.  如果有执行步骤 2，等待命令执行完毕后，开始卸载监控日志的存储服务：
    ``` bash
    helmfile -f monitor-storage.yaml.gotmpl destroy
    ```
4.  删除部署 SaaS 创建的 namespace：
    ``` bash
    kubectl get ns | awk '/^bkapp-bk/ { print $1 }' | xargs --no-run-if-empty kubectl delete ns
    ```
5.  卸载 BCS 、蓝盾及蓝鲸基础套餐：
    ``` bash
    NAMESPACE="bcs-system" ./scripts/uninstall.sh -y bcs-services-stack
    NAMESPACE="bkpaas-app-operator-system" ./scripts/uninstall.sh -y bkpaas-app-operator
    ./scripts/uninstall.sh -y  # 无参数表示删除blueking namespace下的所有release，包括蓝盾
    ```
6.  删除其他资源：
    ``` bash
    # 删除给paas3创建的账号
    kubectl delete clusterrolebinding bk-paasengine;
    kubectl -n blueking delete sa bk-paasengine;
    # 删除crd：
    kubectl get crd | grep tencent.com | xargs --no-run-if-empty kubectl delete crd
    # 删除pvc：
    kubectl delete pvc --all -n blueking; kubectl delete pvc --all -n bcs-system
    # 删除已知的 hooks 生成的资源残留
    kubectl delete secret,configmap,job -n blueking -l 'app.kubernetes.io/instance in (bk-job,bk-repo,bk-paas)'
    # 删除已知的无label的残留资源：
    kubectl delete secret bkpaas3-engine-bkrepo-envs bkpaas3-workloads-bkrepo-envs -n blueking
    kubectl delete configmap bk-log-search-builtin-collect-configmap bk-log-search-grafana-ini bkpaas3-apiserver-3rd-apps -n blueking
    ```
7.  如果是用 `bcs.sh` 创建的 k8s 集群，那么检查下 localpv 的目录是否有残留文件：
    ``` bash
    node_ips=$(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}')
    echo "node_ips=$node_ips."
    for ip in $node_ips; do
      ssh $ip 'echo $HOSTNAME; find /mnt/blueking/ -type f';
    done
    ```
8.  检查残留资源：
    ``` bash
    kubectl get deploy,sts,cronjob,job,pod,svc,ingress,secret,cm,sa,role,rolebinding,pvc -n blueking
    kubectl get deploy,sts,cronjob,job,pod,svc,ingress,secret,cm,sa,role,rolebinding,pvc -n bcs-system
    kubectl get deploy,sts,cronjob,job,pod,svc,ingress,secret,cm,sa,role,rolebinding,pvc -n bkmonitor-operator
    ```
    可能残留一些公共资源，为正常情况。参考输出：
    ``` plain
    NAME                     TYPE  其他字段略
    secret/default-token-略  kubernetes.io/service-account-token  其他字段略
    
    NAME  其他字段略
    configmap/kube-root-ca.crt  其他字段略
    
    NAME  其他字段略
    serviceaccount/default  其他字段略
    ```
9.  重命名工作目录（部署时会写入一些文件到这里，一段时间后确认不需要时可删除）：
    ``` bash
    mv ~/bkce7.1-install ~/bkce7.1-install.bak-$(date +%Y%m%d-%H%M%S)
    ```

接下来跟随 《[部署基础套餐](install-bkce.md)》 文档开始全新部署吧！
