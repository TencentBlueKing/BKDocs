
在资源充足的情况下，可以单独给 SaaS 分配单独的 `node`。

普通 SaaS 在部署时，会临时编译，会产生高 IO 和高 CPU 消耗。原生 k8s 集群的 io 隔离暂无方案，这样会影响到所在 `node` 的其他 `pod`。

蓝鲸官方发行的 SaaS 安装包针对 V7 进行了优化，使用了预编译的镜像文件，无上述负担。

# 配置 SaaS 专用 node
我们通过 k8s 的污点（`taint`）来实现专机专用。

## 配置 node 污点
假设该节点名为 `node-1`，给该 node 配置 label 和污点，确保 `pod` 默认不会分配到这些 `node`。
``` bash
kubectl label nodes node-1 dedicated=bkSaas
kubectl taint nodes node-1 dedicated=bkSaas:NoSchedule
```
## 在 PaaS 页面配置污点容忍
1. 先登录。访问 `http://bkpaas.$BK_DOMAIN` （需替换 `$BK_DOMAIN` 为你配置的蓝鲸基础域名。）
2. 访问蓝鲸 PaaS Admin（如果未登录则无法访问）： `http://bkpaas.$BK_DOMAIN/backend/admin42/platform/clusters/manage/` 。
3. 点击集群 最右侧的编辑按钮。
4. 在 **集群出口 IP** 栏填写 `bk-ingress-nginx` pod 所在 **k8s node** 的 IP。
5. 在 **默认 nodeSelector** 栏填写：
    ``` json
    {"dedicated": "bkSaas"}
    ```
6. 在 **默认 tolerations** 栏填写：
    ``` json
    [{"key":"dedicated","operator":"Equal","value":"bkSaas","effect":"NoSchedule"}]
    ```

最终配置效果如下图所示，确认无误后点击保存按钮。

![](../7.0/assets/2022-03-09-10-44-14.png)

## SaaS 专用 node 问题排查
如果发现 SaaS 的 Pod 调度到了其他 `node`，请检查 PaaS 页面的配置是否正确。

如果因为资源不足导致 SaaS 运行异常，请先参考 **添加 k8s-node** 完成 k8s 扩容，然后参考 **配置 node 污点** 完成专机配置。

如果保存时报错 `engine 服务错误: ingress_config: frontend_ingress_ip`，请填写 **集群出口 IP** 。


# 下一步
直接开始部署 SaaS：
* [部署步骤详解 —— SaaS](manual-install-saas.md)

如果是从快速部署文档跳转过来，可以 [回到快速部署文档继续阅读](install-bkce.md#saas-node)。
