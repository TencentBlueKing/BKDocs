# kubernetes Secret 说明

kubernetes(简称 k8s)中的 Secret 资源可以用来存储密码、Token、秘钥等敏感数据。 将这些敏感信息保存在 Secret 中，相对于暴露到 Pod、镜像中更加的安全和灵活。k8s 内置了三种类型的 Secret：
- Service Account Secret
- Opaque Secret
- kubernetes.io/dockerconfigjson

## 1. 模板示例
### 1.1 Service Account Secret

为了能从集群内部访问 k8s API，k8s 提供了 Service Account 资源。 Service Account 会自动创建和挂载访问 k8s API 的 Secret，会挂载到 Pod 的`/var/run/secrets/kubernetes.io/serviceaccount`目录中。 这种类型的 Secret 通常不需要用户显示定义，所以这里不展开。

### 1.2 Opaque Secret

Opaue 类型的 Secret 是一个 map 结构(key-value)，其中 vlaue 要求以 base64 格式编码。
```yml
apiVersion: v1
kind: Secret
metadata:
  name: external-secret-config
type: Opaque
data:
  RDS_USERNAME: YWRtaW4=
  RDS_PASSWORD: MWYyZDFlMmU2N2Rm
```
引用方式
```yml
       envFrom:
        - secretRef:
            name: external-secret-config
```
### 1.3 kubernetes.io/dockerconfigjson
用于 docker registry 认证的 secret
```yml
apiVersion: v1
data:
  .dockercfg: eyJjY3IuY2NzLnRlbmNlbnR5dW4uY29tL3RlbmNlbnR5dW4iOnsidXNlcm5hbWUiOiIzMzIxMzM3OTk0IiwicGFzc3dvcmQiOiIxMjM0NTYuY29tIiwiZW1haWwiOiIzMzIxMzM3OTk0QHFxLmNvbSIsImF1dGgiOiJNek15TVRNek56azVORG94TWpNME5UWXVZMjl0In19
kind: Secret
metadata:
  name: paas.image.registry.default
type: kubernetes.io/dockerconfigjson
```
引用方法
```yml
  spec:
      imagePullSecrets:
        - name: paas.image.registry.default
```

## 2. 配置项介绍

`type`字段用于指定 Secret 的类型，`data`字段存储数据信息(value 需要 base64 编码)。

## 3. BCS 模板集操作

关于 Secret 的使用，请参照 [在 K8S 中部署 WordPress](../../../Scenes/Deploy_wordpress.md)：

如果没有在 Chart 参数中没有设置密码，可以通过命令获取 WordPress 的 Secret。

```yaml
# kubectl  get secret -n dev
NAME                                                TYPE                                  DATA   AGE
wordpress-1909130255                                Opaque                                1      4h37m

# kubectl  get secret/wordpress-1909130255 -n dev -o yaml
apiVersion: v1
data:
  wordpress-password: bFgzTmZvSHJIVg==
kind: Secret
  creationTimestamp: 2019-09-13T07:01:33Z
  name: wordpress-1909130255
  namespace: dev
type: Opaque

# echo "bFgzTmZvSHJIVg==" | base64 --decode
lX3NfoHrHV
```
