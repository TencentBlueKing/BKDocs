# 常见问题
# 一、客户端拉取配置报错：context deadline exceeded

```bash
kubectl get pod test-listener-cf964596d-sq6tj
NAME                            READY   STATUS                  RESTARTS   AGE
test-listener-cf964596d-sq6tj   0/2     Init:CrashLoopBackOff   1          22s

kubectl logs test-listener-cf964596d-sq6tj -c bscp-init
===================================================================================
oooooooooo   oooo    oooo         oooooooooo     oooooooo     oooooo    oooooooooo
 888     Y8b  888   8P             888     Y8b d8P      Y8  d8P    Y8b   888    Y88
 888     888  888  d8              888     888 Y88bo       888           888    d88
 888oooo888   88888[      8888888  888oooo888     Y8888o   888           888ooo88P
 888     88b  888 88b              888     88b        Y88b 888           888
 888     88P  888   88b            888     88P oo      d8P  88b    ooo   888
o888bood8P   o888o  o888o         o888bood8P   88888888P     Y8bood8P   o888o
===================================================================================

Version  : v1.1.1
BuildTime: 2024-02-19T11:05:52+0800
GitHash  : bb1e4ecd29525971a894db35e22086999f0de625
GoVersion: go1.20.4
use command line args or environment variables
args: --biz=10 --app=service_demo --feed-addrs=10.0.5.10:31510 --token=*** --temp-dir=/data/bscp --port=9616 --file-cache-enabled=true --file-cache-dir=/data/bscp/cache --cache-threshold-gb=2.000000
time=2024-03-09T08:24:46.354Z level=INFO source=client/client.go:69 msg="instance fingerprint" fingerprint=172-17-5-200:195627
time=2024-03-09T08:24:48.355Z level=ERROR source=pull.go:77 msg="init client" err="init upstream client failed, err: dial upstream grpc server failed, err: context deadline exceeded"
```

遇到这种情况一般是客户端连接服务配置中心的后台服务feed server的地址端口失败导致，解决思路如下

## 1. 检查feed server服务状态是否正常

```bash
# feed server默认位于容器平台的“蓝鲸”项目下，执行以下命令以判断其状态是否正常
kubectl get pod -n bk-bscp |grep 'bk-bscp-feed-feedserver'
bk-bscp-feed-feedserver-7778c7b575-5qv6t     1/1     Running     0          22h
bk-bscp-feed-feedserver-7778c7b575-vjl87     1/1     Running     0          22h
```

若Pod的READY和STATUS属性均无问题，则表示正常。如有问题，请参考服务配置中心部署文档进行修复

## 2. 检查客户端到feed server网络是否畅通

```bash
# feed server 出口一般以 NodePort 或 LoadBalancer 来暴露，执行一下命令获取feed server出口地址
kubectl get svc -n bk-bscp|grep bk-bscp-feed-feedserver
bk-bscp-feed-feedserver            ClusterIP   192.168.31.64    <none>        9510/TCP,9610/TCP               319d
bk-bscp-feed-feedserver-nodeport   NodePort    192.168.29.26    <none>        9510:31510/TCP,9610:31610/TCP   316d
```

确定客户端配置的 feed_addrs 参数是否与上面的 bk-bscp-feed-feedserver-nodeport 一致

- 如果是集群内访问直接使用 192.168.31.64:9510即可
- 如果是集群外使用NodePort访问使用：集群任一节点IP地址:31510
- 如果是集群外使用LoadBalancer访问使用：VIP:VPORT

如果 feed_addrs 参数配置与暴露的feed server 出口地址端口一致，那就得检查客户端网络环境与 feed server 网络是否畅通

```bash
# 在客户端网络环境telnet feed server出口地址端口
telnet 10.0.5.10 31510
```

如果 telnet 不通请检查网络环境与防火墙、安全组配置是否正确

# 二、客户端拉取配置报错：no permission to access config item

```bash
kubectl get pod test-listener-658f478944-pnxhl
NAME                             READY   STATUS                  RESTARTS   AGE
test-listener-658f478944-pnxhl   0/2     Init:CrashLoopBackOff   4          2m19s

kubectl logs test-listener-658f478944-pnxhl -c bscp-init
===================================================================================
oooooooooo   oooo    oooo         oooooooooo     oooooooo     oooooo    oooooooooo
 888     Y8b  888   8P             888     Y8b d8P      Y8  d8P    Y8b   888    Y88
 888     888  888  d8              888     888 Y88bo       888           888    d88
 888oooo888   88888[      8888888  888oooo888     Y8888o   888           888ooo88P
 888     88b  888 88b              888     88b        Y88b 888           888
 888     88P  888   88b            888     88P oo      d8P  88b    ooo   888
o888bood8P   o888o  o888o         o888bood8P   88888888P     Y8bood8P   o888o
===================================================================================

Version  : v1.1.1
BuildTime: 2024-02-19T11:05:52+0800
GitHash  : bb1e4ecd29525971a894db35e22086999f0de625
GoVersion: go1.20.4
use command line args or environment variables
args: --biz=10 --app=service_demo --feed-addrs=10.0.5.10:31510 --token=*** --temp-dir=/data/bscp --port=9616 --file-cache-enabled=true --file-cache-dir=/data/bscp/cache --cache-threshold-gb=2.000000
time=2024-03-09T09:00:29.377Z level=INFO source=client/client.go:69 msg="instance fingerprint" fingerprint=172-17-5-202:975846
time=2024-03-09T09:00:29.379Z level=INFO source=upstream/upstream.go:143 msg="dial upstream server success" upstream=10.0.5.10:31510
time=2024-03-09T09:00:29.382Z level=INFO source=cache/cache.go:189 msg="start auto cleanup file cache " cacheDir=/data/bscp/cache cleanupIntervalSeconds=300s thresholdGB=2GB retentionRate=90%
time=2024-03-09T09:00:29.382Z level=INFO source=cache/cache.go:202 msg="calculate current cache directory size" currentSize="4.0 KiB"
time=2024-03-09T09:00:29.383Z level=ERROR source=pull.go:89 msg="pull files failed" err="pull file meta failed, err: rpc error: code = PermissionDenied desc = no permission to access config item 1864, rid: 7a4e8509-ddf3-11ee-a50a-3686c3b50ac2"
```

此情况通常是由于使用的服务密钥没有拉取配置文件的权限导致的。客户端服务密钥配置参数为：token。通常，只需在服务密钥管理功能中关联需要拉取配置的服务即可解决此问题，关于如何关联服务密钥和服务配置，请参考：[服务密钥管理](../Function/client_token.md)