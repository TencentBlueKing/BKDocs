# K8S 使用技巧

## 如何与集群中的资源进行比较

- 场景
    + 已有 K8S 集群，并部署有业务容器，并希望尽量降低变更风险
    + 怀疑手动改了集群的一些资源配置

在 K8S 1.14 中新增了 [kubectl diff](https://kubernetes.io/docs/concepts/overview/working-with-objects/object-management/#declarative-object-configuration) 命令，支持将线下 YAML 文件与线上环境做比对。

情景：将本地 deployment.yaml 中的 Nginx 的镜像从 1.17.0 修改为 1.17.1，与线上环境比对，结果如下：

```bash
# kubectl  diff -f deployment.yaml
diff -u -N /tmp/LIVE-740052839/extensions.v1beta1.Deployment.default.bk-bcs-test /tmp/MERGED-190542234/extensions.v1beta1.Deployment.default.bk-bcs-test
--- /tmp/LIVE-740052839/extensions.v1beta1.Deployment.default.bk-bcs-test       2019-09-09 16:11:26.933501898 +0800
+++ /tmp/MERGED-190542234/extensions.v1beta1.Deployment.default.bk-bcs-test     2019-09-09 16:11:26.940501902 +0800
@@ -6,7 +6,7 @@
     kubectl.kubernetes.io/last-applied-configuration: |
       {"apiVersion":"extensions/v1beta1","kind":"Deployment","metadata":{"annotations":{},"name":"bk-bcs-test","namespace":"default"},"spec":{"template":{"metadata":{"labels":{"app":"bk-bcs-test"}},"spec":{"containers":[{"image":"nginx:1.17.0","name":"nginx"}]}}}}
   creationTimestamp: "2019-09-09T07:40:57Z"
-  generation: 1
+  generation: 2
   labels:
     app: bk-bcs-test
   name: bk-bcs-test
@@ -33,7 +33,7 @@
         app: bk-bcs-test
     spec:
       containers:
-      - image: nginx:1.17.0
+      - image: nginx:1.17.1
         imagePullPolicy: IfNotPresent
         name: nginx
         resources: {}
exit status 1
```
