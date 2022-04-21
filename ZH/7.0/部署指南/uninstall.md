# 卸载
## 部分卸载

如果安装到某个 charts 失败。需要重新安装，建议先卸载干净，然后重试。以安装 paas-stack 为例。假设中途失败了。
```  bash
helm list -n blueking -a | grep bk-paas # 会看到failed的一个release。
```

执行脚本：`./scripts/uninstall.sh -y bk-paas` 卸载 bk-paas 这个 release 及其相关资源。

## 完全卸载
如果想完全卸载蓝鲸，建议按以下步骤：

1. 卸载 blueking namespace 下的所有 release：
   ``` bash
   ./scripts/uninstall.sh -y
   ```
2. 删除 mysql 的 pvc：
   ``` bash
   kubectl delete pvc data-bk-mysql-mysql-master-0
   ```
3. 删除 blueking 的残留的资源：
   ``` bash
   kubectl delete namespace blueking
   ```
4. 卸载 bcs：
   ``` bash
   helmfile -f 03-bcs.yaml.gotmpl destroy
   ```
5. 删除 rolebinding：
   ``` bash
   kubectl delete clusterrolebinding bk-paasengine paasengine
   ```
6. 删除部署 SaaS 创建的 namespace：
   ``` bash
   kubectl get ns | awk '/^bkapp-bk/ { print $1 }' | xargs kubectl delete ns
   ```
