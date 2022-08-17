# 部署容器管理套餐

>**注意**
>
>目前灰度版本中，BCS 有部分功能可能无法使用，建议先体验其他产品。

## 部署容器管理平台
### 确认 storageClass
在 **中控机** 检查当前 k8s 集群所使用的存储：
``` bash
kubectl get sc
```
预期输出为：
``` plain
NAME                      PROVISIONER                    RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
local-storage (default)   kubernetes.io/no-provisioner   Delete          WaitForFirstConsumer   false                  3d21h
```
如果输出的名称不是 `local-storage`，则需通过创建 `custom.yaml` 实现修改：
``` bash
cd ~/bkhelmfile/blueking/
cat <<EOF >> environments/default/custom.yaml
bcs:
  storageClass: 填写上面的查询到的名称
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
cd ~/bkhelmfile/blueking/  # 进入工作目录
BK_DOMAIN=$(yq e '.domain.bkDomain' environments/default/custom.yaml)  # 从自定义配置中提取, 也可自行赋值
IP1=$(kubectl get pods -A -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].status.hostIP}')
IP1=$(ssh $IP1 'curl ip.sb')
echo $IP1 bcs.$BK_DOMAIN
```
