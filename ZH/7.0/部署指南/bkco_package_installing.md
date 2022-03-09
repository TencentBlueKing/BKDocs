# 部署监控日志套餐
> **提示**
> 
> 监控平台的 **容器监控** 功能依赖容器管理平台（BCS），请先部署容器管理平台。

## 部署监控平台
1. 通过该命令获取 bcs gateway token
 ```plain
	kubectl get secret --namespace bcs-system bcs-password -o jsonpath="{.data.gateway_token}" | base64 -d
```plain
2. 将上述获取到的 bcs gateway token 填入至 08-bkmonitor.yaml.gotmpl 文件内的  `monitor.config.bcsApiGatewayToken`配置项 
3. 开始部署
```
在中控机 ~/bkhelmfile/blueking 执行
helmfile -f 04-bkmonitor.yaml.gotmpl sync
helmfile -f 04-bkmonitor-operator.yaml.gotmpl sync
```plain
4. 配置本地 hosts 进行访问
```
# 请注意替换为实际的 BK_DOMAIN
BK_DOMAIN=paas.bktencent.com
IP1=$(kubectl get pods -n blueking -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].status.hostIP}')
IP1=$(ssh $IP1 'curl ip.sb')
echo $IP1 bkmonitor.$BK_DOMAIN
```plain

## 部署日志平台
1. 开始部署
```
在中控机 ~/bkhelmfile/blueking 执行
helmfile -f 04-bklog-collector.yaml.gotmpl sync
helmfile -f 04-bklog-search.yaml.gotmpl sync
```plain
2. 配置本地 hosts 进行访问
```
# 请注意替换为实际的 BK_DOMAIN
BK_DOMAIN=paas.bktencent.com
IP1=$(kubectl get pods -n blueking -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].status.hostIP}')
IP1=$(ssh $IP1 'curl ip.sb')
echo $IP1 bklog.$BK_DOMAIN
