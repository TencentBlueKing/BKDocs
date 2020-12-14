## FAQ

1. **容器管理平台服务异常了如何排查问题？**

   容器管理平台服务基本都是使用 systemd 托管的，各个服务的功能与服务名称可以在本文档 **第四部分** 查询，首先使用命令：
   ```bash
   systemctl status [service_name] 
   ```
   查看服务的状态是否异常，如果服务器异常使用命令：
   ```bash
   systemctl restart [service_name]
   systemctl status [service_name]
   ```
    重启服务看看是否可以恢复，否则就需要根据 **第四部分** 中提供的日志路径来查看具体错误日志来解决，如果还是解决不了请在社区寻求帮忙。

2. **导入标准运维模版时流程 ID 冲突了如何处理？**
   
   如果导入标准运维模版有冲突代表你目前公共流程中已经存在流程模版中的流程 ID 了，这时我们可以选择点击 流程 ID 自增提交。等部署完成容器管理平台后，找到部署了 bcs-ops 的服务器（部署容器管理平台时填写的“bcs 后台服务 IP 地址”参数 IP，如果有多台，多台都需要修改），bcs-ops 服务的配置文件/data/bkce/etc/bcs/ops-operator.conf，原本映射关系如下：
   ```ini
   template_k8s_install_id = 1 （[BlueKing][BCS][K8S] Create Master）
   template_k8s_uninstall_id = 2 （[BlueKing][BCS][K8S] Remove Master）
   template_k8s_add_id = 3 （[BlueKing][BCS][K8S] Add Node）
   template_k8s_remove_id = 4 （[BlueKing][BCS][K8S] Delete Node）
   ```
   假如流程 ID 自增提交后的流程 ID 与模版名称如下：
   ```plain
   10001  [BlueKing][BCS][K8S] Create Master
   10002  [BlueKing][BCS][K8S] Remove Master
   10003  [BlueKing][BCS][K8S] Add Node
   10004  [BlueKing][BCS][K8S] Delete Node
   ```
   那配置文件就修改为：
   ```ini
   template_k8s_install_id = 10001
   template_k8s_uninstall_id = 10002
   template_k8s_add_id = 10003
   template_k8s_remove_id = 10004
   ```
   最后需要重启 bcs-ops，使配置生效：
   ```bash
   systemctl restart bcs-ops
   systemctl status bcs-ops 
   ```