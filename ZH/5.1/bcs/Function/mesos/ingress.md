# bcs Ingress 配置说明


bcs ingress 基于 bcs-service 抽象出将流量导入 bcs 集群的基本规则，满足应用多场景下的负载均衡需求。

## 1. 配置模板说明

```json
{
    "apiVersion": "v1",
    "kind": "ingress",
    "metadata": {
        "name": "ingress-demo",
        "namespace": "default",
        "labels": {
            "ingressname": "ingress-demo"
        },
        "annotation": {
            "annotation-demo": "annotation-value"
        }
    },
    "spec": {
        "lbGroup": "external",
        "clusterid": "sz-loldemo-0000123",
        "rules": [
            {
                "kind": "HTTP",
                "balance": "roundrobin",
                "httpIngress": {
                    "host": "demo.bcs.com",
                    "paths": [
                        {
                            "path": "/read/demo",
                            "backend": [
                                {
                                    "serviceName": "service-1",
                                    "servicePort": "8801",
                                    "weight": 70
                                },
                                {
                                    "serviceName": "service-2",
                                    "servicePort": "8802",
                                    "weight": 30
                                }
                            ]
                        }
                    ]
                }
            },
            {
                "kind": "TCP",
                "balance": "roundrobin",
                "tcpIngress": {
                    "listenPort": 8083,
                    "backend": [
                        {
                            "serviceName": "service-3",
                            "servicePort": "8803",
                            "weight": 70
                        },
                        {
                            "serviceName": "service-4",
                            "servicePort": "8804",
                            "weight": 30
                        }
                    ]
                }
            }
        ]
    }
}
```

- 基本信息
 - apiVersion: 版本
 - kind：ingress
 - metadata:
   - name: ingress name
   - namespace: ingress 所属的 namespace
   - labels: ingress 所需要的 label 信息。
   - annotaion: ingress 所需要的相关标注信息。

## 2. Ingress Spec 信息

### 2.1 `lbGroup`  
标识该 ingress 所属的 lb 管理节点。该名称需要和 lb 的名称相对应。否则无法正常工作。
### 2.2 `clusterid`  
标识该 ingress 所属的 cluster。
### 2.3 `rules`  
rules 明确的指出该 ingress 所需要负载均衡的`一组`相关信息，具体如下:
 - kind:  
   支持`TCP`和`HTTP`两种类型, 使用 HTTP 则需要配置`httpIngress`，使用`TCP`则需要配置`tcpIngress`。
 - balance:  
   配置负载均衡的策略，支持"roundrobin"与"source"。
 - httpIngress：
   - host:  
     需要负载均衡的域名。
   - paths:  
     该域名下具体的 uri 分配规则
     - path:  
       指定具体的 path
     - backend:  
       配置后端具体负载的实例，以 service 为逻辑单位（"serviceName"），同时可以指定多个 service 之间的流量比例（"weight"）

 - tcpIngress:
   - listenPort:  
     lb 监听的服务端口。
   - backend:  
     配置后端具体负载的实例，以 service 为逻辑单位（"serviceName"），同时可以指定多个 service 之间的流量比例（"weight"）


> **`注意`**
> 1. 目前 k8s 只支持 HTTP 的路由策略，TCP 的暂不支持。
> 2. 对于`httpIngress`中的`paths`，现预留为数组，目前仅支持一个，如果配置多个，数组中的第`0`个元素生效，其它的不会生效。
