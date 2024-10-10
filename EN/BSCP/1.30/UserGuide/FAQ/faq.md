# Frequently Asked Questions
# 1. Client pulls configuration error: context deadline exceeded

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

This situation is usually caused by the client failing to connect to the address port of the background service feed server of the service configuration center. The solution is as follows

## 1. Check whether the feed server service status is normal

```bash
# feed server by default, it is located in the "BlueKing" project of the container platform. Execute the following command to determine whether its status is normal.
kubectl get pod -n bk-bscp |grep 'bk-bscp-feed-feedserver'
bk-bscp-feed-feedserver-7778c7b575-5qv6t     1/1     Running     0          22h
bk-bscp-feed-feedserver-7778c7b575-vjl87     1/1     Running     0          22h
```

If the READY and STATUS properties of the Pod are both correct, it means it is normal. If there is a problem, please refer to the deployment document of the service configuration center to fix it.

## 2. Check whether the network from the client to the feed server is unobstructed

```bash
# The feed server export is generally exposed as NodePort or LoadBalancer. Execute the following command to obtain the feed server export address
kubectl get svc -n bk-bscp|grep bk-bscp-feed-feedserver
bk-bscp-feed-feedserver            ClusterIP   192.168.31.64    <none>        9510/TCP,9610/TCP               319d
bk-bscp-feed-feedserver-nodeport   NodePort    192.168.29.26    <none>        9510:31510/TCP,9610:31610/TCP   316d
```

Determine whether the feed_addrs parameter configured on the client is consistent with the above bk-bscp-feed-feedserver-nodeport

- If you are accessing within the cluster, just use 192.168.31.64:9510
- If you are accessing outside the cluster using NodePort, use: any node IP address in the cluster: 31510
- If you are accessing outside the cluster using LoadBalancer, use: VIP:VPORT

If the feed_addrs parameter configuration is consistent with the exposed feed server export address port, then you need to check whether the client network environment and the feed server network are unobstructed

```bash
# Telnet feed server export address port in client network environment
telnet 10.0.5.10 31510
```

If telnet fails, please check whether the network environment, firewall, and security group configuration are correct

# 2. Client pull configuration error: no permission to access config item

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

This situation is usually caused by the service key used not having permission to pull configuration files. The client service key configuration parameter is: token. Usually, this problem can be solved by simply associating the service that needs to pull configuration in the service key management function. For how to associate service keys and service configurations, please refer to: [Service Key Management](../Function/client_token.md)