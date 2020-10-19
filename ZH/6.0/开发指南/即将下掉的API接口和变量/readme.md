#  API 下线及变更

以下部分 API 预计于下一个版本下线及变更（2020 年 10 月之后）。

## CMDB

### 下线接口

| 要下线的 API                                   | 要下线 API 对应的地址                               | 替换使用地址                                                 |
| ---------------------------------------------- | --------------------------------------------------- | ------------------------------------------------------------ |
| /api/App/getapplist                            | /api/c/compapi/cc/get_app_list/                     | /api/c/compapi/v2/cc/search_business/                        |
| /api/App/getAppByID                            | /api/c/compapi/cc/get_app_by_id/                    | /api/c/compapi/v2/cc/search_business/                        |
| /api/App/getappbyuin                           | /api/c/compapi/cc/get_app_by_user/                  | /api/c/compapi/v2/cc/search_business/                        |
| /api/User/getUserRoleApp                       | /api/c/compapi/cc/get_app_by_user_role/             | /api/c/compapi/v2/cc/search_business/                        |
| /api/TopSetModule/getappsetmoduletreebyappid   | /api/c/compapi/cc/get_topo_tree_by_app_id/          | 查询业务下的主机          /v2/cc/list_biz_hosts/          在所有业务中主机查询          /v2/cc/list_hosts_without_biz/          获取主机与拓扑的关系          /v2/cc/find_host_topo_relation |
| /api/app/addApp                                | /api/c/compapi/cc/add_app/                          | /api/c/compapi/v2/cc/create_business/                        |
| /api/app/deleteApp                             | /api/c/compapi/cc/del_app/                          | /api/c/compapi/v2/cc/delete_business/                        |
| /api/App/getHostAppByCompanyId                 | /api/c/compapi/cc/get_host_by_company_id/           | 查询业务下的主机          /v2/cc/list_biz_hosts/          在所有业务中主机查询          /v2/cc/list_hosts_without_biz/          获取主机与拓扑的关系          /v2/cc/find_host_topo_relation |
| /api/app/editApp                               | /api/c/compapi/cc/edit_app/                         | /api/c/compapi/v2/cc/update_business/                        |
| /api/Module/getmodules                         | /api/c/compapi/cc/get_modules/                      | /api/c/compapi/v2/cc/search_module/                          |
| /api/module/editmodule                         | /api/c/compapi/cc/update_module_property/           | /api/c/compapi/v2/cc/update_module/                          |
| /api/module/delModule                          | /api/c/compapi/cc/del_module/                       | /api/c/compapi/v2/cc/delete_module/                          |
| /api/Set/getsetsbyproperty                     | /api/c/compapi/cc/get_sets_by_property/             | /api/c/compapi/v2/cc/search_set/                             |
| /api/Set/getsetproperty                        | /api/c/compapi/cc/get_set_property/                 | /api/c/compapi/v2/cc/search_object_attribute/                |
| /api/Set/getmodulesbyproperty                  | /api/c/compapi/cc/get_modules_by_property/          | /api/c/compapi/v2/cc/search_module/                          |
| /api/set/addset                                | /api/c/compapi/cc/add_set                           | /api/c/compapi/v2/cc/create_set/                             |
| /api/set/updateset                             | /api/c/compapi/cc/update_set/                       | /api/c/compapi/v2/cc/update_set/                             |
| /api/set/updateSetServiceStatus                | /api/c/compapi/cc/update_set_service_status/        | /api/c/compapi/v2/cc/update_set/                             |
| /api/set/delset                                | /api/c/compapi/cc/del_set/                          | 批量删除:  /api/c/compapi/v2/cc/batch_delete_set/     删除单个: /api/c/compapi/v2/cc/delete_set/ |
| /api/set/delSetHost                            | /api/c/compapi/cc/del_set_host/                     |                                                              |
| /api/host/addhost                              | 无                                                  |                                                              |
| /api/host/enterIp                              | 无                                                  |                                                              |
| /api/Host/gethostlistbyip                      | /api/c/compapi/cc/get_host_list_by_ip/              | 查询业务下的主机          /v2/cc/list_biz_hosts/          在所有业务中主机查询          /v2/cc/list_hosts_without_biz/          获取主机与拓扑的关系          /v2/cc/find_host_topo_relation |
| /api/Host/getsethostlist                       | /api/c/compapi/cc/get_set_host_list/                | 查询业务下的主机          /v2/cc/list_biz_hosts/          在所有业务中主机查询          /v2/cc/list_hosts_without_biz/          获取主机与拓扑的关系          /v2/cc/find_host_topo_relation |
| /api/host/getmodulehostlist                    | /api/c/compapi/cc/get_module_host_list/             | 查询业务下的主机          /v2/cc/list_biz_hosts/          在所有业务中主机查询          /v2/cc/list_hosts_without_biz/          获取主机与拓扑的关系          /v2/cc/find_host_topo_relation |
| /api/host/getapphostlist                       | /api/c/compapi/cc/get_app_host_list/                | 查询业务下的主机          /v2/cc/list_biz_hosts/          在所有业务中主机查询          /v2/cc/list_hosts_without_biz/          获取主机与拓扑的关系          /v2/cc/find_host_topo_relation |
| /api/set/gethostsbyproperty                    | /api/c/compapi/cc/get_hosts_by_property/            | 查询业务下的主机          /v2/cc/list_biz_hosts/          在所有业务中主机查询          /v2/cc/list_hosts_without_biz/          获取主机与拓扑的关系          /v2/cc/find_host_topo_relation |
| /api/Host/updateHostStatus                     | /api/c/compapi/cc/update_gse_proxy_status/          | 查询业务下的主机          /v2/cc/list_biz_hosts/          在所有业务中主机查询          /v2/cc/list_hosts_without_biz/          获取主机与拓扑的关系          /v2/cc/find_host_topo_relation |
| /api/Host/updateHostByAppId                    | /api/c/compapi/cc/update_host_by_app_id/            | 查询业务下的主机     /v2/cc/list_biz_hosts/     在所有业务中主机查询     /v2/cc/list_hosts_without_biz/     获取主机与拓扑的关系     /v2/cc/find_host_topo_relation |
| /api/Host/getCompanyIdByIps                    | /api/c/compapi/cc/get_host_company_id/              | 查询业务下的主机          /v2/cc/list_biz_hosts/          在所有业务中主机查询          /v2/cc/list_hosts_without_biz/          获取主机与拓扑的关系          /v2/cc/find_host_topo_relation |
| /api/Host/getHostListByAppidAndField           | /api/c/compapi/cc/get_host_list_by_field/           | 查询业务下的主机          /v2/cc/list_biz_hosts/          在所有业务中主机查询          /v2/cc/list_hosts_without_biz/          获取主机与拓扑的关系          /v2/cc/find_host_topo_relation |
| /api/Host/getIPAndProxyByCompany               | /api/c/compapi/cc/get_ip_and_proxy_by_company/      | 查询业务下的主机          /v2/cc/list_biz_hosts/          在所有业务中主机查询          /v2/cc/list_hosts_without_biz/          获取主机与拓扑的关系          /v2/cc/find_host_topo_relation |
| /api/Host/updatehostmodule                     | /api/c/compapi/cc/update_host_module/               | 分情况替换：     在业务用户创建的模块做转移：      /api/c/compapi/v2/cc/transfer_host_module/       转移到故障机：     /api/c/compapi/v2/cc/transfer_host_to_faultmodule/     转移到空闲机：     /api/c/compapi/v2/cc/transfer_host_to_idlemodule/ |
| /api/host/updateCustomProperty                 | /api/c/compapi/cc/update_custom_property/           | /api/c/compapi/v2/cc/update_host/                            |
| /api/host/cloneHostProperty                    | /api/c/compapi/cc/clone_host_property/              | /api/c/compapi/v2/cc/clone_host_property/                    |
| /api/host/delHostInApp                         | /api/c/compapi/cc/del_host_in_app/                  |                                                              |
| /api/host/getgitServerIp                       | /api/c/compapi/cc/get_git_server_ip/                |                                                              |
| /api/host/hardinfo                             | 无                                                  | 查询业务下的主机          /v2/cc/list_biz_hosts/          在所有业务中主机查询          /v2/cc/list_hosts_without_biz/          获取主机与拓扑的关系          /v2/cc/find_host_topo_relation |
| /api/CustomerGroup/getContentByCustomerGroupID | /api/c/compapi/cc/get_content_by_customer_group_id/ | /api/c/compapi/v2/cc/get_custom_query_data/                  |
| /api/CustomerGroup/getCustomerGroupList        | /api/c/compapi/cc/get_customer_group_list           | /api/c/compapi/v2/cc/get_custom_query_detail/                |
| /api/Plat/updateHost                           | /api/c/compapi/cc/update_host_plat                  | /api/c/compapi/v2/cc/update_host/                            |
| /api/Plat/get                                  | /api/c/compapi/cc/get_plat_id/                      | /v2/cc/search_cloud_area                                     |
| /api/Plat/delete                               | /api/c/compapi/cc/del_plat/                         | /v2/cc/delete_cloud_area                                     |
| /api/Plat/add                                  | /api/c/compapi/cc/add_plat_id/                      | /v2/cc/create_cloud_area                                     |
| /api/process/getProcessPortByApplicationID     | /api/c/compapi/cc/get_process_port_by_app_id/       |                                                              |
| /api/process/getProcessPortByIP                | /api/c/compapi/cc/get_process_port_by_ip/           |                                                              |
| /api/Property/getList                          | /api/c/compapi/cc/get_property_list/                | /api/c/compapi/v2/cc/search_object_attribute/                |
| /api/Host/getAppOwnerHostList                  | /api/c/compapi/cc/get_property_list/                | 查询业务下的主机          /v2/cc/list_biz_hosts/          在所有业务中主机查询          /v2/cc/list_hosts_without_biz/          获取主机与拓扑的关系          /v2/cc/find_host_topo_relation |
| /api/App/getAppByUinExt                        | 无                                                  | /api/c/compapi/v2/cc/search_business/                        |


| 接口名                      | 功能描述                 |
| --------------------------- | ------------------------ |
| bind_process_module         | 绑定进程到模块           |
| bind_role_privilege         | 绑定角色权限             |
| create_user_group           | 新建用户分组             |
| delete_process_module_bind  | 解绑进程模块             |
| delete_user_group           | 删除用户分组             |
| find_host_by_module         | 根据模块查询主机         |
| search_custom_query         | 查询自定义查询           |
| search_group_privilege      | 查询分组权限             |
| search_host                 | 根据条件查询主机         |
| get_custom_query_data       | 根据自定义查询获取数据   |
| get_custom_query_detail     | 获取自定义查询详情       |
| get_operation_log           | 获取操作日志             |
| get_process_bind_module     | 查询进程绑定模块         |
| get_role_privilege          | 获取角色绑定权限         |
| get_user_privilege          | 查询用户权限             |
| search_object_topo_graphics | 查询拓扑图               |
| search_user_group           | 查询用户分组             |
| testing_connection          | 测试推送（只测试连通性） |
| update_user_group           | 更新用户分组             |

### 变更接口协议 (输入或输出有调整)

| 接口名                       | 功能描述                                      | 变更信息类型 | 变更信息                               |
| ---------------------------- | --------------------------------------------- | ------------ | -------------------------------------- |
| add_host_lock                | 新加主机锁                                    | 减少请求参数 | bk_cloud_id                            |
| batch_create_proc_template   | 批量创建进程模板                              | 参数结构变更 | 进程的ip、端口等属性的层次结构发生变化 |
| create_business              | 新建业务                                      | 新增请求参数 | language                               |
| create_process_instance      | 创建进程实例                                  | 参数结构变更 | 进程的ip、端口等属性的层次结构发生变化 |
| create_set                   | 创建集群                                      | 新增请求参数 | set_template_id                        |
| delete_host_lock             | 删除主机锁                                    | 减少请求参数 | bk_cloud_id                            |
| delete_object_attribute      | 删除对象模型属性                              | 新增功能     | 删除自定义字段                         |
| find_object_association      | 查询模型之间的关联关系                        | 减少请求参数 | metadata                               |
| get_service_template         | 获取服务模板                                  | 请求参数变更 | metadata变更为service_template_id      |
| list_process_instance        | 查询进程实例列表                              | 参数结构变更 | 进程的ip、端口等属性的层次结构发生变化 |
| list_proc_template           | 查询进程模板列表                              | 参数结构变更 | 进程的ip、端口等属性的层次结构发生变化 |
| list_service_instance_detail | 获取服务实例详细信息                          | 新增请求参数 | page                                   |
| search_cloud_area            | 查询云区域                                    | 减少返回参数 | data.page                              |
| search_host_lock             | 查询主机锁                                    | 减少请求参数 | bk_cloud_id                            |
| search_object_attribute      | 查询对象模型属性                              | 新增功能     | 可以业务id查询                         |
| search_subscription          | 查询订阅                                      | 减少请求参数 | bk_biz_id                              |
| update_custom_query          | 更新自定义API                                 | 减少请求参数 | bk_biz_id                              |
| update_process_instance      | 更新进程实例                                  | 参数结构变更 | 进程的ip、端口等属性的层次结构发生变化 |
| update_proc_template         | 更新进程模板                                  | 参数结构变更 | 进程的ip、端口等属性的层次结构发生变化 |
| update_process_instance      | 更新进程实例                                  | 参数结构变更 | 进程的ip、端口等属性的层次结构发生变化 |
| update_proc_template         | 更新进程模板                                  | 参数结构变更 | 进程的ip、端口等属性的层次结构发生变化 |
| get_proc_template            | 获取单个进程模板信息，url参数中指定进程模板ID | 参数结构变更 | 进程的ip、端口等属性的层次结构发生变化 |


### 新增接口

| 接口名                                     | 功能描述                                                                     |
| ------------------------------------------ | ---------------------------------------------------------------------------- |
| create_biz_custom_field                    | 创建业务自定义模型属性                                                       |
| create_set_template                        | 新建集群模板                                                                 |
| delete_related_inst_asso                   | 删除某实例所有的关联关系（包含其作为关联关系原模型和关联关系目标模型的情况） |
| delete_set_template                        | 删除集群模板                                                                 |
| find_host_biz_relations                    | 查询主机业务关系信息                                                         |
| find_host_by_service_template              | 查询服务模板下的主机                                                         |
| find_host_by_set_template                  | 查询集群模板下的主机                                                         |
| find_host_by_topo                          | 查询拓扑节点下的主机                                                         |
| find_host_snapshot_batch                   | 批量查询主机快照                                                             |
| find_module_batch                          | 批量查询某业务的模块详情                                                     |
| find_module_host_relation                  | 根据模块ID查询主机和模块的关系                                               |
| find_set_batch                             | 批量查询某业务的集群详情                                                     |
| find_topo_node_paths                       | 查询业务拓扑节点的拓扑路径                                                   |
| list_resource_pool_hosts                   | 查询资源池中的主机                                                           |
| list_set_template                          | 查询集群模板                                                                 |
| list_set_template_related_service_template | 获取某集群模版下的服务模版列表                                               |
| resource_watch                             | 监听资源变化事件                                                             |
| search_hostidentifier                      | 根据条件查询主机身份                                                         |
| search_related_inst_asso                   | 查询某实例所有的关联关系（包含其作为关联关系原模型和关联关系目标模型的情况） |
| search_topo_tree                           | 搜索业务拓扑树                                                               |
| sync_set_template_to_set                   | 集群模板同步                                                                 |
| update_biz_custom_field                    | 更新业务自定义模型属性                                                       |
| update_set_template                        | 编辑集群模板                                                                 |


## GSE

<table>
    <tr>
        <th> GSE 接口</th>
        <th>任务结果协议格式规范化</th>
        <th>描述</th>
    </tr>
    <tr>
        <td>getTaskRst</td>
        <td rowspan="7">"规范化前  --> 规范化后 <br>
			errcode  -> error_code<br>
			errmsg -> error_msg<br>
			starttime -> start_time<br>
			endtime  -> end_time<br>
			screenkey -> screen_key <br>
			screenctx -> screen_all"
		</td>
        <td rowspan="7">
            " GSE 任务结果的协议字段中，<br>
            将规范化前的 key，转化为规范后的 key
        </td>
    </tr>
    <tr>
        <td>getTaskDetailRst</td>
    </tr>
    <tr>
        <td>getTaskInfo</td>
    </tr>
    <tr>
        <td>getPushFileRst</td>
    </tr>
    <tr>
        <td>getCopyFileRst</td>
    </tr>
    <tr>
        <td>getProcStatus</td>
    </tr>
</table>


## JOB

### 下线接口

| 要下线 job api 对应的 esb api 地址           | 替换使用 esb api 地址            |
| ----------------------------------------- | ------------------------------- |
| /api/c/compapi/job/execute_task/          | /api/v2/execute_job             |
| /api/c/compapi/job/change_cron_status/    | /api/v2/update_cron_status      |
| /api/c/compapi/job/execute_platform_task/ | /api/v2/execute_platform_job    |
| /api/c/compapi/job/execute_task_ext/      | /api/v2/execute_job             |
| /api/c/compapi/job/fast_execute_script/   | /api/v2/fast_execute_script     |
| /api/c/compapi/job/fast_push_file/        | /api/v2/fast_push_file          |
| /api/c/compapi/job/get_agent_status/      | 无                              |
| /api/c/compapi/job/get_cron/              | /api/v2/get_cron_list           |
| /api/c/compapi/job/get_proc_result/       | /api/v2/get_proc_result         |
| /api/c/compapi/job/get_task/              | /api/v2/get_job_list            |
| /api/c/compapi/job/get_task_detail/       | /api/v2/get_job_detail          |
| /api/c/compapi/job/get_task_ip_log/       | /api/v2/get_job_instance_log    |
| /api/c/compapi/job/get_task_result/       | /api/v2/get_job_instance_status |
| /api/c/compapi/job/gse_proc_operate/      | /api/v2/operate_process         |
| /api/c/compapi/job/gse_push_file/         | /api/v2/push_config_file        |
| /api/c/compapi/job/gse_set_base_report/   | /api/v2/set_base_report         |
| /api/c/compapi/job/save_cron/             | /api/v2/save_cron               |

| 接口名            | 功能描述           |
| ----------------- | ------------------ |
| callback_protocol | 作业类回调报文描述 |

### 变更接口协议 (输入或输出有调整)

| 接口名                   | 功能描述         | 变更信息                                                                                                                                                                      |
| ------------------------ | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| execute_job              | 功能不兼容       | 出于产品设计和系统安全考虑，执行时不允许传入步骤(steps)参数，覆盖作业模板的参数<br>统一目标服务器参数(target_server)，用于替换之前的custom_query_id/ip_list参数传递目标服务器 |
| fast_execute_script      | 新增传递参数     | 统一目标服务器参数(target_server)，用于替换之前的custom_query_id/ip_list参数传递目标服务器                                                                                    |
| fast_push_file           | 新增传递参数     | 统一目标服务器参数(target_server)，用于替换之前的custom_query_id/ip_list参数传递目标服务器                                                                                    |
| get_job_detail           | 新增返回参数     | 统一目标服务器参数(target_server)，用于替换之前的custom_query_id/ip_list参数返回目标服务器                                                                                    |
| get_job_instance_status  | 减少返回参数     | 减少返回参数block_order、block_name、operation_list                                                                                                                           |
| get_job_list             | 减少传递返回参数 | 不用传递 tag_id 参数，减少返回参数step_num、tag_id                                                                                                                            |
| get_step_instance_status | 参数类型变更     | bk_biz_id 参数 int 变更为 long                                                                                                                                                |
| save_cron                | 参数类型变更     | bk_biz_id、bk_job_id、cron_id 参数 int 变更为 long                                                                                                                            |
| update_cron_status       | 参数类型变更     | bk_biz_id、cron_id 参数 int 变更为 long                                                                                                                                       |

### 新增接口

| 接口名                 | 功能描述         |
| ---------------------- | ---------------- |
| fast_execute_sql       | 快速执行SQL      |
| get_public_script_list | 查询公共脚本列表 |
| operate_job_instance   | 作业实例操作     |
| operate_step_instance  | 步骤实例操作     |
| push_config_file       | 分发配置文件     |

## 监控平台

### 下线接口

| 接口名                  | 功能描述                 | 替换API      | 替换API功能描述 |
| ----------------------- | ------------------------ | ------------ | --------------- |
| alarm_instance          | 返回指定告警             | search_event | 查询事件        |
| get_alarms              | 通过筛选条件获取指定告警 | search_event | 查询事件        |
| list_alarm_instance     | 批量筛选告警             | search_event | 查询事件        |
| query_data              | 图表数据查询             | get_ts_data  | 获取ES数据      |
| component_instance      | 返回指定组件             | 废弃         |                 |
| deploy_script_collector | 下发脚本采集配置         | 废弃         |                 |
| export_alarm_strategy   | 导出监控策略             | 废弃         |                 |
| export_log_collector    | 导出日志采集配置         | 废弃         |                 |
| export_script_collector | 导出脚本采集配置         | 废弃         |                 |
| import_alarm_strategy   | 导入监控策略             | 废弃         |                 |
| import_log_collector    | 导入日志采集配置         | 废弃         |                 |
| import_script_collector | 导入脚本采集配置         | 废弃         |                 |
| list_component_instance | 批量筛选组件             | 废弃         |                 |

### 新增接口

| 接口名                                    | 功能描述                                   |
| ----------------------------------------- | ------------------------------------------ |
| add_shield                                | 新增告警屏蔽                               |
| delete_alarm_strategy                     | 删除告警策略                               |
| delete_notice_group                       | 删除通知组                                 |
| disable_shield                            | 解除告警屏蔽                               |
| edit_shield                               | 编辑告警屏蔽                               |
| get_collect_config_list                   | 采集配置列表                               |
| get_collect_status                        | 查询采集配置节点状态                       |
| get_es_data                               | 获取监控链路时序数据                       |
| get_event_log                             | 查询事件流转记录                           |
| get_shield                                | 获取告警屏蔽                               |
| get_ts_data                               | 获取ES数据                                 |
| get_uptime_check_node_list                | 拨测节点列表                               |
| get_uptime_check_task_list                | 拨测任务列表                               |
| list_shield                               | 获取告警屏蔽列表                           |
| metadata_create_cluster_info              | 创建存储集群信息                           |
| metadata_create_data_id                   | 创建监控数据源                             |
| metadata_create_event_group               | 创建事件分组                               |
| metadata_create_result_table              | 创建监控结果表                             |
| metadata_create_result_table_metric_split | 创建结果表的维度拆分配置                   |
| metadata_create_time_series_group         | 创建自定义时序分组                         |
| metadata_delete_event_group               | 删除事件分组                               |
| metadata_delete_time_series_group         | 删除自定义时序分组                         |
| metadata_get_cluster_info                 | 查询指定存储集群信息                       |
| metadata_get_data_id                      | 获取监控数据源具体信息                     |
| metadata_get_event_group                  | 查询事件分组具体内容                       |
| metadata_get_result_table                 | 获取监控结果表具体信息                     |
| metadata_get_result_table_storage         | 查询指定结果表的指定存储信息               |
| metadata_get_time_series_group            | 获取自定义时序分组具体内容                 |
| metadata_get_time_series_metrics          | 获取自定义时序结果表的metrics信息          |
| metadata_list_label                       | 查询当前已有的标签信息                     |
| metadata_list_result_table                | 查询监控结果表                             |
| metadata_modify_cluster_info              | 修改存储集群信息                           |
| metadata_modify_data_id                   | 修改指定数据源的配置信息                   |
| metadata_modify_event_group               | 修改事件分组                               |
| metadata_modify_result_table              | 修改监控结果表                             |
| metadata_modify_time_series_group         | 修改自定义时序分组                         |
| metadata_query_event_group                | 创建事件分组                               |
| metadata_query_tag_values                 | 获取自定义时序分组具体内容                 |
| metadata_query_time_series_group          | 查询事件分组                               |
| metadata_upgrade_result_table             | 将指定的监控单业务结果表升级为全业务结果表 |
| query_collect_config                      | 查询采集配置                               |
| save_alarm_strategy                       | 保存告警策略                               |
| save_collect_config                       | 创建/保存采集配置                          |
| save_notice_group                         | 保存通知组                                 |
| search_alarm_strategy                     | 查询告警策略                               |
| search_event                              | 查询事件                                   |
| search_notice_group                       | 查询通知组                                 |
| switch_alarm_strategy                     | 启停告警策略                               |



## 标准运维

### 新增接口

| 接口名                  | 功能描述                 |
| ----------------------- | ------------------------ |
| fast_create_task        | 快速新建一次性任务       |
| get_plugin_list         | 查询某个业务下的插件列表 |
| get_tasks_status        | 批量查询任务状态         |
| get_task_node_data      | 获取节点执行数据         |
| get_template_schemes    | 获取模板执行方案列表     |
| get_user_project_detail | 获取项目详情             |
| get_user_project_list   | 获取用户有权限的项目列表 |
| import_project_template | 导入业务流程模板         |
| operate_node            | 操作任务中的节点         |
| preview_task_tree       | 获取节点选择后新的任务树 |