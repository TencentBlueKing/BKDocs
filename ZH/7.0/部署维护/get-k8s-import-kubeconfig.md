## 使用已有的 k8s 集群
>**注意**
>
>限 1.18 或 1.20，其他版本未经测试。用户报告 1.22 以上版本不兼容，1.17 版本部署 bcs 会失败。

1. 取得 kubeconfig 文件：`~/.kube/config`。
   * 如果能访问到 `master` 上的文件，可将 `master` 上的 `~/.kube/config` 复制到 **中控机** 的 `~/.kube/config` 路径下。
   * 如果使用了 k8s 云服务，则厂商一般会提供 kubeconfig 导出功能，复制内容并写入 **中控机** 的 `~/.kube/config` 路径下即可。
   * 其他情况请自行解决。
2. 配置中控机 `/etc/hosts` 文件。
   同时记得更新  **中控机** 的 `/etc/hosts` 文件确保可访问 config 文件中 k8s server。
3. 在中控机安装 `kubectl` 命令。
   * 如果能访问到 `master` 上的文件，可将 `master` 上的 `/usr/bin/kubectl` 复制到 **中控机** 的 `/usr/bin/` 路径下。
   * 其他情况可参考本文下面的 “在中控机安装 kubectl” 章节操作。

# 下一步
前往《[准备中控机](prepare-bkctrl.md)》文档。
