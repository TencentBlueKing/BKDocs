# 部署问题排查
## 常用排查命令（必知必会）
请先阅读官方文档：[应用故障排查 | Kubernetes](https://kubernetes.io/zh/docs/tasks/debug-application-cluster/debug-application/)
1. 切换当前 context 的 namespace 到 `blueking` 。切换后，后面排查需要指定 `-n blueking` 的命令就可以省略了。
    ``` bash
    kubectl config set-context --current --namespace=blueking
    ```
2. 部署过程中，查看 pod 的变化情况：
   ``` bash
   kubectl get pods -w
   ```
3. 查看 pod 日志：(如果 pod 日志较多，加上 `--tail` 防止刷屏)
   ``` bash
   kubectl logs <pod_name> -f --tail=xxx
   ```
4. 查看 pod 状态不等于 `Running` 的：
   ``` bash
   kubectl get pods --field-selector 'status.phase!=Running'
   ```
   注意 job 任务生成的 pod，没有自动删除的且执行完毕的 pod，处于 `Completed` 状态。
5. pod 状态不是 `Running`，需要了解原因：
   ``` bash
   kubectl describe pod <pod_name>
   ```
6. 有些 pod 的日志没有打印到 stdout，需要进入容器查看：
   ``` bash
   kubectl exec -it <pod_name> -- bash
   ```
7. 访问公共 mysql：
   ``` bash
   kubectl exec -it -n blueking bk-mysql-mysql-master-0 -- mysql -uroot -p密码
   ```
8. 访问公共 mongodb:
   ``` bash
   kubectl exec -it -n blueking  bk-mongodb-0 -- mongo
   ```

### 部署 SaaS 在“配置资源实例”阶段报错
首先查看 `engine-main` 这个应用对应 pod 的日志。根据错误日志提示，判断定位方向：
1. 检测 mysql，rabbitmq，redis 等「增强服务」的资源配置是否正确。`http://bkpaas.$BK_DOMAIN/backend/admin42/platform/plans/manage` 以及 `http://bkpaas.$BK_DOMAIN/backend/admin42/platform/pre-created-instances/manage` 。
2. 检查应用集群的 k8s 相关配置 token 是否正确。初次部署时会自动调用 `scripts/create_k8s_cluster_admin_for_paas3.sh` 脚本自动生成 token 等参数到 `./paas3_initial_cluster.yaml` 文件中。如果不正确，可以删除后这些账号和绑定后重建。

### 无法查看 SaaS 日志

确认所使用的 k8s 集群，node 节点上，docker 的容器日志路径，和 values 中配置的是否相匹配。请参考前面文档。

### ImagePullBackOff 问题

pod 无法启动，状态是 ImagePullBackOff，一般是 image 地址问题。可以先查看各个 manifest 的 image 地址是否正确。

``` bash
helm get manifest release名 | grep image:
```

### 安装 metrics-server

```bash
helm upgrade --namespace default metrics-server bitnami/metrics-server  --set apiService.create=true --set extraArgs.kubelet-preferred-address-types=InternalIP
```

### 使用 ksniff 抓包

1. 安装 krew 插件包 https://krew.sigs.k8s.io/docs/user-guide/setup/install/
2. 使用 krew 安装 sniff 插件包 `kubectl krew install sniff`
3. 抓包。由于 apigateway 的 pod 默认没用开启特权模式，需要加上`-p`参数。
    ``` bash
    kubectl sniff -n blueking bk-apigateway-bk-esb-5655747b67-llnqj -p -f "port 80" -o esb.pcap
    ```

### 模板渲染问题

使用 `helmfile` / `helm` 工具都是对原生 k8s 的描述文件的渲染封装。如果部署的结果不符合预期，需要定位，查看中间结果，有几种手段：

1. 先看 helmfile 合并各层 values 后生成的 values 文件：
   ``` bash
   helmfile -f 03-bkjob.yaml.gotmpl write-values --output-file-template bkjob-values.yaml
   ```
2. helmfile 安装时增加 `--debug` 参数
3. 查看已经部署的 release 的渲染结果：
   ``` bash
   helm get manifest release名
   helm get hooks release名
   ```

### 删除 Completed 状态的 pod

``` bash
kubectl delete pod --field-selector=status.phase==Succeeded
```

### Delete 删除资源卡住无响应时

查看 apiserver 的日志：
``` bash
kubectl logs -n kube-system kube-controller-manager-xxxxx | grep 资源名
```

如果是因为某个 pod 处于 `Terminating` 状态，可以强制删除：
``` bash
kubectl delete pod PODNAME --grace-period=0 --force --namespace NAMESPACE
```

### Pod 没有 Ready 如何查看
先查看 `readiness` 的探测命令（搜索 `readinessProbe` 段落，`podIP`，`containerPort` 字段）：
```bash
kubectl get pod PODNAME -o yaml
```
使用带 `curl` 命令的 pod 来模拟探测，观察输出。由于 pod 没有 `Ready`，所以不能通 k8s service name 来。需要用第一步的 podIP 来探测。
```bash
curl http://$POD_IP:$containerPort/health_check_path
```

### 更改 BK_DOMAIN 后需要手动修改的地方

paas3 中的资源分配的域名：http://bkpaas.$BK_DOMAIN/backend/admin42/platform/plans/manage 修改 bkrepo 对应的域名地址。

### bkpaas3 里增加用户为管理员身份
若接入了自定义登录后没有 admin 账号，可以进入 `bkpaas3-apiserver-web` pod 执行如下命令添加其他管理员账号：
``` python
from bkpaas_auth.constants import ProviderType
from bkpaas_auth.models import user_id_encoder
from paasng.accounts.models import UserProfile

username="admin"
user_id = user_id_encoder.encode(ProviderType.BK.value, username)
UserProfile.objects.update_or_create(user=user_id, defaults={'role':4, 'enable_regions':'default'})
```

### bkpaas3 修改日志级别
apiserver 和 engine 模块都支持通过环境变量设置日志级别。

apiserver-main、apiserver-celery、engine-main、engine-celery ：编辑这些 Deployment，如：
``` bash
kubectl edit deployment apiserver-main
```
将 `DJANGO_LOG_LEVEL` 的值改为 `DEBUG`。
