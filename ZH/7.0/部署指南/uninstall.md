# 卸载
## 部分卸载

如果安装到某个charts失败。需要重新安装，建议先卸载干净，然后重试。以安装paas-stack为例。假设中途失败了。
```
helm list -n blueking -a | grep bk-paas # 会看到failed的一个release。
```

执行脚本：`./scripts/uninstall -y bk-paas` 卸载bk-paas这个release及其相关资源。

## 完全卸载
如果想完全卸载蓝鲸，建议按以下步骤：

1. 卸载blueking namespace下的所有release：
   ``` bash
   ./scripts/uninstall.sh -y
   ```
2. 删除mysql的pvc：
   ``` bash
   kubectl delete pvc data-bk-mysql-mysql-master-0
   ```
3. 删除blueking的残留的资源：
   ``` bash
   kubectl delete namespace blueking
   ```
4. 卸载bcs：
   ``` bash
   helmfile -f 03-bcs.yaml.gotmpl destroy
   ```
5. 删除rolebinding：
   ``` bash
   kubectl delete clusterrolebinding bk-paasengine paasengine
   ```
6. 删除部署SaaS创建的namespace：
   ``` bash
   kubectl get ns | awk '/^bkapp-bk/ { print $1 }' | xargs kubectl delete ns
   ```
