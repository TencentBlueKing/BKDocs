# 卸载
## 部分卸载

如果安装到某个 charts 失败。需要重新安装，建议先卸载干净，然后重试。以安装 paas-stack 为例。假设中途失败了。
```  bash
helm list -n blueking -a | grep bk-paas # 会看到failed的一个release。
```

执行脚本：`./scripts/uninstall.sh -y bk-paas` 卸载 bk-paas 这个 release 及其相关资源。

## 完全卸载
如果想完全卸载蓝鲸，建议按以下步骤：

1. 浏览器访问节点管理，卸载全部节点的 gse_agent。
2. 根据安装顺序反过来依次卸载，先卸载监控日志套餐（如有安装）：
   ``` bash
   helmfile -f 04-bklog-collector.yaml.gotmpl destroy
   helmfile -f 04-bkmonitor-operator.yaml.gotmpl destroy
   helmfile -f 04-bklog-search.yaml.gotmpl destroy
   helmfile -f 04-bkmonitor.yaml.gotmpl destroy
3. 等待上面的的 Pod 都彻底删除干净后，开始卸载监控日志的存储服务：
   ``` bash
   helmfile -f monitor-storage.yaml.gotmpl destroy
   ```
4. 卸载 BCS 及蓝鲸基础套餐：
   ``` bash
   helmfile -f 03-bcs.yaml.gotmpl destroy
   helmfile -f base-blueking.yaml.gotmpl destroy
   ```
5. 删除蓝鲸基础套餐的存储服务：
   ``` bash
   helmfile -f base-storage.yaml.gotmpl destroy
   ```
6. 删除其他资源：
   ``` bash
   # 删除给paas3创建的账号
   kubectl delete clusterrolebinding bk-paasengine; kubectl -n blueking delete sa bk-paasengine;
   # 删除crd：
   kubectl get crd | grep tencent.com | xargs --no-run-if-empty kubectl delete crd
   # 删除pvc：
   kubectl delete pvc --all -n blueking; kubectl delete pvc --all -n bcs-system
   ```
7. 删除部署 SaaS 创建的 namespace：
   ``` bash
   kubectl get ns | awk '/^bkapp-bk/ { print $1 }' | xargs --no-run-if-empty kubectl delete ns
   ```
8. 删除残留资源：
   ``` bash
   # 删除已知的 hooks 生成的资源残留
   kubectl delete secret,configmap,job -n blueking -l 'app.kubernetes.io/instance in (bk-job,bk-repo,bk-paas)'
   # 删除已知的无label的残留资源：
   kubectl delete secret bkpaas3-engine-bkrepo-envs bkpaas3-workloads-bkrepo-envs -n blueking ; kubectl delete configmap bk-log-search-builtin-collect-configmap bk-log-search-grafana-ini bkpaas3-apiserver-3rd-apps -n blueking
   ```
9. 如果是用 `bcs.sh` 创建的 k8s 集群，那么检查下 localpv 的目录是否有残留文件：
   ``` bash
   for ip in node_ips; do
     ssh $ip 'echo $HOSTNAME; find /mnt/blueking/ -type f';
   done
   ```
10. 检查确保无残留：
   ``` bash
   kubectl get deploy,sts,cronjob,job,pod,svc,ingress,secret,cm,sa,role,rolebinding,pvc -n blueking
   ```
