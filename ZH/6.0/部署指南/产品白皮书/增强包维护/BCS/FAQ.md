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
   ```bash
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

3. **需要替换原有 BCS 域名，如何处理？**
   
   替换容器管理平台域名方法如下：
   
   1.登录部署容器管理平台时填入的参数 “BCS 导航页组件 IP 地址”，如果填入了多台，多台都需替换

   ```bash
   # {OLD_DOMAIN}为老的PaaS域名，{NEW_DOMAIN}为新的PaaS域名
   env_js_file='/data/bkce/devops/navigator/frontend/console/static/env.js'
   sed -i 's#{OLD_DOMAIN}#{NEW_DOMAIN}#g' ${env_js_file}
   cat ${env_js_file}

   # 更新lua脚本，替换域名后缀，{OLD_DOMAIN_SUFFIX}为老域名后缀，{NEW_DOMAIN_SUFFIX}为新域名后缀
   init_lua_file='/data/bkce/devops/navigator/gateway/conf/lua/init.lua'
   sed -i 's#{OLD_DOMAIN_SUFFIX}#{NEW_DOMAIN_SUFFIX}#g' ${init_lua_file}
   cat ${init_lua_file}

   # 替换BCS与BCS-API域名，{OLD_BCS_DOMAIN}为老BCS域名，{NEW_BCS_DOMAIN}为新BCS域名，{OLD_BCS_API_DOMAIN}为老BCS_API域名，{NEW_BCS_API_DOMAIN}为新BCS_API域名
   bcs_domain_file='/data/bkce/devops/navigator/gateway/conf/frontend.conf'
   sed -i 's#{OLD_BCS_DOMAIN}#{NEW_BCS_DOMAIN}#g' ${bcs_domain_file}
   cat ${bcs_domain_file}
   
   bcs_api_domain_file='/data/bkce/devops/navigator/gateway/conf/backend.conf'
   sed -i 's#{OLD_BCS_API_DOMAIN}#{NEW_BCS_API_DOMAIN}#g' ${bcs_api_domain_file}
   cat ${bcs_api_domain_file}
   
   # 重启devops服务
   systemctl restart devops
   systemctl status devops
   ```
   
   2.登录部署容器管理平台时填入的参数 “BCS Web Console IP 地址”，选其中任何一台服务器

   修改/data/install/bin/04-final/bcs.env 文件中的环境变量 DEVOPS_NAVIGATOR_FQDN 值为新的 BCS 域名，并执行以下命令：
   ```bash
   cd /data/bkce/bcs/web_console && sh on_migrate /data
   ```

   3.登录部署容器管理平台时填入的参数 “BCS 监控 IP 地址”，如果填入了多台，多台都需替换
   ```bash
   # 替换BCS域名，{OLD_BCS_DOMAIN}为老BCS域名，{NEW_BCS_DOMAIN}为新BCS域名
   bcs_monitor_file='/data/bcs/monitoring/bcs-monitor/bcs-monitor-prod.yml'
   sed -i 's#{OLD_BCS_DOMAIN}#{NEW_BCS_DOMAIN}#g' ${bcs_monitor_file}
   cat ${bcs_monitor_file}

   # 重启bcs monitor服务
   systemctl restart bcs-monitor-api bcs-monitor-ruler bcs-monitor-alertmanager
   systemctl status bcs-monitor-api bcs-monitor-ruler bcs-monitor-alertmanager
   ```
   
   4.在蓝鲸开发者中心调整环境变量与重新部署 SaaS 应用
   
   在 S-mart 应用菜单中找到 bk_bcs_app 应用，并点击进入
   ![avatar](../../assets/bcs_smart_app.png)
   
   修改环境变量 BKAPP_DEVOPS_HOST 为新的 BCS 域名
   ![avatar](../../assets/bkapp_devops.png)
   
   重新部署 bk_bcs_app 应用
   ![avatar](../../assets/deploy_bcs_app.png)
   
   在 S-mart 应用菜单中找到 bk_bcs_monitor 应用，并点击进入
   ![avatar](../../assets/monitor_smart_app.png)
   
   修改环境变量 BKAPP_DEVOPS_HOST 为新的 BCS 域名
   ![avatar](../../assets/monitor_bkapp_devops.png)
   
   重新部署 bk_bcs_monitor 应用
   ![avatar](../../assets/deploy_bcs_monitor.png)
   
   5.在蓝鲸开发者中心调整环境变量与重新部署 SaaS 应用
   
   修改域名解析或在 hosts 文件中修改映射为新的域名
   