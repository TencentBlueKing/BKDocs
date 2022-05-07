# kubernetes Ingress 说明

Ingress 是管理外部访问集群内服务(典型的如 HTTP)的 API 对象。Ingress 可配置提供外部可访问的 URL、负载均衡、SSL、基于名称的虚拟主机等。用户通过 POST Ingress 资源到 API server 的方式来请求 Ingress。 Ingress controller 负责实现 Ingress，通常使用负载均衡器(如常用的 nginx-controller)。

## 1. 模板示例
```yml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: servergame
spec:
  tls:
  - hosts:
      - demo.bcs.com
    secretName: servergame-secret
  rules:
  - host: demo.bcs.com
    http:
      paths:
      - backend:
          serviceName: servergame
          servicePort: 8080
        path: /
```

## 2. 配置项介绍
### 2.1 基于名称的虚拟主机

通过`.spect.rules[]`来设置基于名称的虚拟主机，如示例中的`host: fwx.ffm.qq.com`，所有`https://demo.bcs.com:443/`的请求都会被转发给名称是`servergame`的 Service 后端所关联的 Pods。

### 2.2 TLS

通过指定包含 TLS 私钥和证书的 Secret 可以加密 Ingress。目前，Ingress 仅支持单个 TLS 端口 443，并假定 TLS termination。如示例中，利用`.spec.tls`给域名`demo.bcs.com`绑定了名为`servergame-secret`的 Secret 的 TLS 证书。`servergame-secret`的示意配置如下：

```yml
apiVersion: v1
data:
  tls.crt: base64 encoded cert
  tls.key: base64 encoded key
kind: Secret
metadata:
  name: servergame-secret
type: Opaque
```

## 3. BCS 模板集操作

关于 Ingress 的实战演练，请参照 [应用的蓝绿发布](../../../Scenes/Bcs_blue_green_deployment.md)。

![-w2020](../../../assets/15684302423813.jpg)
