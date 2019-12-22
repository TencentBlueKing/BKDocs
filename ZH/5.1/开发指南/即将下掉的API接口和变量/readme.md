# 即将下线的 API 和变量

以下部分 API 预计于下一个版本下线（2020 年 6 月之后）。 


## CMDB

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