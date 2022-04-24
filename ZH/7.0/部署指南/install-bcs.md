# 部署容器管理套餐

>**注意**
>
>目前灰度版本中，BCS 有部分功能可能无法使用，建议先体验其他产品。

## 部署容器管理平台
### TKE 集群配置
如果是 TKE 集群请修改 BCS 的 storageClass，其他场景可以忽略本步骤。
``` bash
cd ~/bkhelmfile/blueking/
cat <<EOF >> environments/default/custom.yaml
bcs:
  storageClass: cbs
EOF
```

### 开始部署
在 中控机 执行：
``` bash
cd ~/bkhelmfile/blueking
helmfile -f 03-bcs.yaml.gotmpl sync
```
耗时 3 ~ 7 分钟，此时可以另起一个终端观察相关 pod 的状态
``` bash
kubectl get pod -n bcs-system -w
```

### 浏览器访问
配置本地 hosts 进行访问
``` bash
# 请注意替换为实际的 BK_DOMAIN
BK_DOMAIN=bkce7.bktencent.com
IP1=$(kubectl get pods -n blueking -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].status.hostIP}')
IP1=$(ssh $IP1 'curl ip.sb')
echo $IP1 bcs.$BK_DOMAIN
```
