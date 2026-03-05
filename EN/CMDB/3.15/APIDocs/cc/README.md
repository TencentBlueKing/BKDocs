## Configuration Platform API Introduction

**The BlueKing configuration platform is an application-oriented CMDB. In the ITIL system, the CMDB is the cornerstone for building other processes. In the BlueKing system, the configuration platform plays the role of the cornerstone, providing various Configuration data service for various operation and maintenance scenarios.**


| Resource Name                                                                                             |resource description|
| ----------------------------------------------------------------------------------------------------- |----------------------------------------------------------------------------|
| [add_host_lock](./zh-hans/add_host_lock.md)                                                           |New host lock|
| [add_host_to_resource_pool](./zh-hans/add_host_to_resource_pool.md)                                   |Add the host to the resource pool with the specified id according to the host list information  |
| [add_host_to_resource](./zh-hans/add_host_to_resource.md)                                             |Add a host to the resource pool|
| [add_instance_association](./zh-hans/add_instance_association.md)                                     |Create associations between model instances|
| [add_label_for_service_instance](./zh-hans/add_label_for_service_instance.md)                         |Add tags to service instances|
| [batch_create_instance_association](./zh-hans/batch_create_instance_association.md)                   |Create generic model instance associations in batches|
| [batch_create_inst](./zh-hans/batch_create_inst.md)                                                   |Create common model instances in batches|
| [batch_create_proc_template](./zh-hans/batch_create_proc_template.md)                                 |Batch create process templates|
| [batch_delete_inst](./zh-hans/batch_delete_inst.md)                                                   |Delete instances in batches|
| [batch_delete_set](./zh-hans/batch_delete_set.md)                                                     |Delete clusters in batches|
| [batch_update_host](./zh-hans/batch_update_host.md)                                                   |Batch update host properties|
| [batch_update_inst](./zh-hans/batch_update_inst.md)                                                   |Batch update object instances|
| [clone_host_property](./zh-hans/clone_host_property.md)                                               |Clone host properties|
| [count_instance_associations](./zh-hans/count_instance_associations.md)                               |Model instance relationship quantity query|
| [count_object_instances](./zh-hans/count_object_instances.md)                                         |General model instance number query|
| [create_biz_custom_field](./zh-hans/create_biz_custom_field.md)                                       |Create business custom model attributes|
| [create_business](./zh-hans/create_business.md)                                                       |new business|
| [create_classification](./zh-hans/create_classification.md)                                           |Add model classification|
| [create_cloud_area](./zh-hans/create_cloud_area.md)                                                   |Create a cloud zone|
| [create_dynamic_group](./zh-hans/create_dynamic_group.md)                                             |Create dynamic groups|
| [create_inst](./zh-hans/create_inst.md)                                                               |create instance|
| [create_module](./zh-hans/create_module.md)                                                           |create module|
| [create_object](./zh-hans/create_object.md)                                                           |create model|
| [create_object_attribute](./zh-hans/create_object_attribute.md)                                       |Create model properties|
| [create_process_instance](./zh-hans/create_process_instance.md)                                       |Create a process instance|
| [create_service_category](./zh-hans/create_service_category.md)                                       |Create a new service category|
| [create_service_instance](./zh-hans/create_service_instance.md)                                       |Create a service instance|
| [create_service_template](./zh-hans/create_service_template.md)                                       |Create a new service template|
| [create_set](./zh-hans/create_set.md)                                                                 |create cluster|
| [create_set_template](./zh-hans/create_set_template.md)                                               |Create a new cluster template|
| [delete_classification](./zh-hans/delete_classification.md)                                           |Delete Model Category|
| [delete_cloud_area](./zh-hans/delete_cloud_area.md)                                                   |delete cloud zone|
| [delete_dynamic_group](./zh-hans/delete_dynamic_group.md)                                             |delete dynamic group|
| [delete_host](./zh-hans/delete_host.md)                                                               |delete host|
| [delete_host_lock](./zh-hans/delete_host_lock.md)                                                     |delete host lock|
| [delete_inst](./zh-hans/delete_inst.md)                                                               |delete instance|
| [delete_instance_association](./zh-hans/delete_instance_association.md)                               |Delete the association relationship between model instances|
| [delete_module](./zh-hans/delete_module.md)                                                           |delete module|
| [delete_object](./zh-hans/delete_object.md)                                                           |delete model|
| [delete_object_attribute](./zh-hans/delete_object_attribute.md)                                       |Delete object model attribute|
| [delete_process_instance](./zh-hans/delete_process_instance.md)                                       |delete process instance|
| [delete_proc_template](./zh-hans/delete_proc_template.md)                                             |delete process template|
| [delete_related_inst_asso](./zh-hans/delete_related_inst_asso.md)                                     |Delete all associations of an instance (including cases where it is the original model of the association and the target model of the association)|
| [delete_service_category](./zh-hans/delete_service_category.md)                                       |Delete Service Classification|
| [delete_service_instance](./zh-hans/delete_service_instance.md)                                       |delete service instance|
| [delete_service_template](./zh-hans/delete_service_template.md)                                       |delete service template|
| [delete_set](./zh-hans/delete_set.md)                                                                 |delete cluster|
| [delete_set_template](./zh-hans/delete_set_template.md)                                               |Delete a cluster template|
| [execute_dynamic_group](./zh-hans/execute_dynamic_group.md)                                           |Perform dynamic grouping|
| [find_brief_biz_topo_node_relation](./zh-hans/find_brief_biz_topo_node_relation.md)                   |Query the concise relationship information of the upper and lower levels (models) directly associated with the instance|
| [find_host_biz_relations](./zh-hans/find_host_biz_relations.md)                                       |Query host business relationship information|
| [find_host_by_service_template](./zh-hans/find_host_by_service_template.md)                           |Query the hosts under the service template|
| [find_host_by_set_template](./zh-hans/find_host_by_set_template.md)                                   |Query the hosts under the cluster template|
| [find_host_by_topo](./zh-hans/find_host_by_topo.md)                                                   |Query the hosts under the topology node|
| [find_host_relations_with_topo](./zh-hans/find_host_relations_with_topo.md)                           |According to the business topology instance node, query the host relationship information under the instance node|
| [find_host_topo_relation](./zh-hans/find_host_topo_relation.md)                                       |Get the relationship between the host and the topology|
| [find_instance_association](./zh-hans/find_instance_association.md)                                   |Query the relationship between model instances|
| [find_instassociation_with_inst](./zh-hans/find_instassociation_with_inst.md)                         |Query the relationship between model instances, and optionally return the details of the source model instance and the target model instance|
| [find_module_batch](./zh-hans/find_module_batch.md)                                                   |Query the module details of a business in batches|
| [find_module_host_relation](./zh-hans/find_module_host_relation.md)                                   |Query the relationship between the host and the module according to the module ID|
| [find_module_with_relation](./zh-hans/find_module_with_relation.md)                                   |Query the modules under the business according to the conditions|
| [find_object_association](./zh-hans/find_object_association.md)                                       |Query the relationship between models|
| [find_set_batch](./zh-hans/find_set_batch.md)                                                         |Query the cluster details of a business in batches|
| [find_topo_node_paths](./zh-hans/find_topo_node_paths.md)                                             |Query the topology path of the service topology node|
| [get_biz_internal_module](./zh-hans/get_biz_internal_module.md)                                       |Query the idle machine/failure machine/module to be recycled of the business|
| [get_dynamic_group](./zh-hans/get_dynamic_group.md)                                                   |Query to specify dynamic grouping|
| [get_host_base_info](./zh-hans/get_host_base_info.md)                                                 |Get host details|
| [get_mainline_object_topo](./zh-hans/get_mainline_object_topo.md)                                     |Query the business topology of the mainline model|
| [get_proc_template](./zh-hans/get_proc_template.md)                                                   |Get Process Template|
| [get_service_template](./zh-hans/get_service_template.md)                                             |Get service template|
| [list_biz_hosts](./zh-hans/list_biz_hosts.md)                                                         |Query the host under business|
| [list_biz_hosts_topo](./zh-hans/list_biz_hosts_topo.md)                                               ||
| [list_hosts_without_biz](./zh-hans/list_hosts_without_biz.md)                                         ||
| [list_proc_template](./zh-hans/list_proc_template.md)                                                 ||
| [list_process_detail_by_ids](./zh-hans/list_process_detail_by_ids.md)                                 ||
| [list_process_instance](./zh-hans/list_process_instance.md)                                           ||
| [list_resource_pool_hosts](./zh-hans/list_resource_pool_hosts.md)                                     ||
| [list_service_category](./zh-hans/list_service_category.md)                                           ||
| [list_service_instance](./zh-hans/list_service_instance.md)                                           ||
| [list_service_instance_by_host](./zh-hans/list_service_instance_by_host.md)                           ||
| [list_service_instance_detail](./zh-hans/list_service_instance_detail.md)                             ||
| [list_service_instance_by_set_template](./zh-hans/list_service_instance_by_set_template.md)           ||
| [list_service_template](./zh-hans/list_service_template.md)                                           ||
| [list_set_template](./zh-hans/list_set_template.md)                                                   ||
| [list_set_template_related_service_template](./zh-hans/list_set_template_related_service_template.md) ||
| [remove_label_from_service_instance](./zh-hans/remove_label_from_service_instance.md)                 ||
| [resource_watch](./zh-hans/resource_watch.md)                                                         ||
| [search_biz_inst_topo](./zh-hans/search_biz_inst_topo.md)                                             ||
| [search_business](./zh-hans/search_business.md)                                                       ||
| [search_classifications](./zh-hans/search_classifications.md)                                         ||
| [search_cloud_area](./zh-hans/search_cloud_area.md)                                                   ||
| [search_dynamic_group](./zh-hans/search_dynamic_group.md)                                             ||
| [search_host_lock](./zh-hans/search_host_lock.md)                                                     ||
| [search_inst](./zh-hans/search_inst.md)                                                               ||
| [search_inst_association_topo](./zh-hans/search_inst_association_topo.md)                             ||
| [search_inst_asst_object_inst_base_info](./zh-hans/search_inst_asst_object_inst_base_info.md)         ||
| [search_inst_by_object](./zh-hans/search_inst_by_object.md)                                           ||
| [search_instance_associations](./zh-hans/search_instance_associations.md)                             ||
| [search_module](./zh-hans/search_module.md)                                                           ||
| [search_objects](./zh-hans/search_objects.md)                                                         ||
| [search_object_attribute](./zh-hans/search_object_attribute.md)                                       ||
| [search_object_instances](./zh-hans/search_object_instances.md)                                       ||
| [search_object_topo](./zh-hans/search_object_topo.md)                                                 ||
| [search_related_inst_asso](./zh-hans/search_related_inst_asso.md)                                     ||
| [search_set](./zh-hans/search_set.md)                                                                 ||
| [search_subscription](./zh-hans/search_subscription.md)                                               ||
| [subscribe_event](./zh-hans/subscribe_event.md)                                                       ||
| [sync_set_template_to_set](./zh-hans/sync_set_template_to_set.md)                                     ||
| [transfer_host_module](./zh-hans/transfer_host_module.md)                                             ||
| [transfer_host_to_faultmodule](./zh-hans/transfer_host_to_faultmodule.md)                             ||
| [transfer_host_to_recyclemodule](./zh-hans/transfer_host_to_recyclemodule.md)                         ||
| [transfer_host_to_idlemodule](./zh-hans/transfer_host_to_idlemodule.md)                               ||
| [transfer_host_to_resourcemodule](./zh-hans/transfer_host_to_resourcemodule.md)                       ||
| [transfer_resourcehost_to_idlemodule](./zh-hans/transfer_resourcehost_to_idlemodule.md)               ||
| [transfer_sethost_to_idle_module](./zh-hans/transfer_sethost_to_idle_module.md)                       ||
| [unsubcribe_event](./zh-hans/unsubcribe_event.md)                                                     ||
| [update_biz_custom_field](./zh-hans/update_biz_custom_field.md)                                       ||
| [update_business](./zh-hans/update_business.md)                                                       ||
| [update_business_enable_status](./zh-hans/update_business_enable_status.md)                           ||
| [update_classification](./zh-hans/update_classification.md)                                           ||
| [update_cloud_area](./zh-hans/update_cloud_area.md)                                                   ||
| [update_dynamic_group](./zh-hans/update_dynamic_group.md)                                             ||
| [update_event_subscribe](./zh-hans/update_event_subscribe.md)                                         ||
| [update_host](./zh-hans/update_host.md)                                                               ||
| [update_host_cloud_area_field](./zh-hans/update_host_cloud_area_field.md)                             ||
| [update_inst](./zh-hans/update_inst.md)                                                               ||
| [update_module](./zh-hans/update_module.md)                                                           ||
| [update_object](./zh-hans/update_object.md)                                                           ||
| [update_object_attribute](./zh-hans/update_object_attribute.md)                                       ||
| [update_process_instance](./zh-hans/update_process_instance.md)                                       ||
| [update_proc_template](./zh-hans/update_proc_template.md)                                             ||
| [update_service_category](./zh-hans/update_service_category.md)                                       ||
| [update_service_template](./zh-hans/update_service_template.md)                                       ||
| [update_set](./zh-hans/update_set.md)                                                                 ||
| [update_set_template](./zh-hans/update_set_template.md)                                               ||
