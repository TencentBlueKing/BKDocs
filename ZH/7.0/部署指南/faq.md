# 部署问题排查
## 常用排查命令（必知必会）
1. 切换当前 context 的 namespace 到 blueking。切换后，后面排查需要指定 `-n blueking` 的命令就可以省略了。
 `kubectl config set-context --current --namespace=blueking` 
2. 部署过程中，查看 pod 的变化情况： `kubectl get pods -w` 
3. 查看 pod 日志： `kubectl logs  -f --tail=xxx`  ，如果 pod 日志较多，加上--tail 防止刷屏
4. 查看 pod 状态不等于 Running 的： `kubectl get pods --field-selector 'status.phase!=Running'。注意job任务生成的pod，没有自动删除的且执行完毕的pod，处于Completed状态。` 
5. pod 状态不是 Running，需要了解原因： `kubectl describe pod <pod_name>` 
6. 有些 pod 的日志没有打印到 STDOUT，需要进入容器查看： `kubectl exec -it  -- bash xxxx` 
7. 访问公共 mysql： `kubectl exec bk-mysql-mysql-master-0 -- mysql -uroot -pblueking`

## 卸载
## 卸载单个模块
如果安装到某个 charts 失败，需要重新安装，建议先卸载干净，然后重试。
以安装 paas-stack 为例，假设中途失败了：
 `helm list -n blueking -a | grep bk-paas`  会看到 failed 的一个 release。
1. 卸载 release:  `helm uninstall -n blueking bk-paas` 
2. 删除和它相关的资源： `kubectl delete deploy,sts,cronjob,job,pod,svc,ingress,secret,cm,sa,role,rolebinding,pvc -n blueking -l app.kubernetes.io/instance=bk-paas` 

## 完全卸载蓝鲸并清除数据
如果想完全卸载整个容器化蓝鲸平台，建议按以下步骤：
1. 删除 coredns
```plain
	BK_DOMAIN=xxxxxx --->自定义配置的domain.bkDomain保持一致
IP=$(kubectl get pods -n blueking -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].status.hostIP}')

cd ~/bkhelmfile/blueking/ && ./scripts/control_coredns.sh del $IP bkrepo.$BK_DOMAIN $BK_DOMAIN bkapi.$BK_DOMAIN bkpaas.$BK_DOMAIN bkiam-api.$BK_DOMAIN 
```
1. 通过 helm destroy 先删除 release： `helmfile -f ./base.yaml.gotmpl destroy` 
2. 删除残留的资源： `kubectl delete namespace blueking` 
3. 删除 serviceaccount： `kubectl delete sa bk-paasengine -n default` 
4. 删除 rolebinding： `kubectl delete clusterrolebinding bk-paasengine paasengin` 
5. 删除部署 SaaS 创建的 namespace： `kubectl get ns | awk '/^bkapp-bk/ { print $1 }' | xargs kubectl delete ns` 
7. 确定 pv 是否清干净：kubectl  get pv (Available 状态可以忽略)，如果有其他状态的，比如 Released，可以执行如下命令删除。
```plain
kubectl get pv  | awk '/blueking/ && /Released/ { print $1}' | xargs kubectl delete pv 
```
6. 删除中控机相关目录 :~/bkhelmfile/blueking
