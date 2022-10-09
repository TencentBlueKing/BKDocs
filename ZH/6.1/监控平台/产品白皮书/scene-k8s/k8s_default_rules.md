# k8s默认策略说明



## 集群资源


策略名称	 | 告警表达式 | 	阈值	| 次数
---|---|---|---
[kube集群资源] 集群的CPU资源分配过载-KubeCPUOvercommit | 	`sum by(bcs_cluster_id) (kube_pod_container_resource_requests_cpu_cores{bcs_cluster_id!="",node!=""}) / on(bcs_cluster_id) group_right() sum by(bcs_cluster_id) (kube_node_status_allocatable_cpu_cores{bcs_cluster_id!="",node!=""}) - on(bcs_cluster_id) group_right() (count by(bcs_cluster_id) (kube_node_status_allocatable_cpu_cores{bcs_cluster_id!="",node!=""}) - 1) / on(bcs_cluster_id) group_right() count by(bcs_cluster_id) (kube_node_status_allocatable_cpu_cores{bcs_cluster_id!="",node!=""}) ` |	>=0	| 10个周期5次
[kube 集群资源] 集群的内存资源分配过载-KubeMemoryOvercommit |`sum by(bcs_cluster_id) (kube_pod_container_resource_requests_memory_bytes{bcs_cluster_id!="",node!=""}) / on(bcs_cluster_id) group_right() sum by(bcs_cluster_id) (kube_node_status_allocatable_memory_bytes{bcs_cluster_id!="",node!=""}) - on(bcs_cluster_id) group_right() (count by(bcs_cluster_id) (kube_node_status_allocatable_memory_bytes{bcs_cluster_id!="",node!=""}) - 1) / on(bcs_cluster_id) group_right() count by(bcs_cluster_id) (kube_node_status_allocatable_memory_bytes{bcs_cluster_id!="",node!=""})` | >=0	| 10个周期5次

## kube-master策略

策略名称	 | 告警表达式 | 	阈值	| 次数
---|---|---|---
[kube Master] 客户端访问 APIServer 出错 rest_client_requests_total_5xx | `sum by(bcs_cluster_id, bk_instance, bk_job) (rate(rest_client_requests_total{code="^5[0-9][0-9]"}[5m])) / on(bcs_cluster_id, bk_instance, bk_job) group_right() sum by(bcs_cluster_id, bk_instance, bk_job) (rest_client_requests_total) * 100` | >1 | 5个周期1次
[kube master] apiserver证书过期监控 KubeClientCertificateExpiration | 	`histogram_quantile(0.01, sum by(bk_job, bcs_cluster_id, le) (rate(apiserver_client_certificate_expiration_seconds_bucket{bk_job="apiserver"}[5m])))` | 	<604800	| 5个周期4次

## kube-node策略

策略名称	 |  告警表达式 | 	阈值	| 次数
---|---|---|---
[kube node] 机器时钟未同步 |min by(bcs_cluster_id, instance) (node_timex_sync_status)|	=0 |	5个周期4次
[kube node] 磁盘inode使用率告警	| `(sum by(fstype, bcs_cluster_id, device, bk_instance) (sum_over_time(node_filesystem_files{fstype=~"ext[234]|btrfs|xfs|zfs"}[1m])) - on(fstype, bcs_cluster_id, device, bk_instance) group_right() sum by(fstype, bcs_cluster_id, device, bk_instance) (sum_over_time(node_filesystem_files_free{fstype=~"ext[234]|btrfs|xfs|zfs"}[1m]))) / on(fstype, bcs_cluster_id, device, bk_instance) group_right() sum by(fstype, bcs_cluster_id, device, bk_instance) (sum_over_time(node_filesystem_files{fstype=~"ext[234]|btrfs|xfs|zfs"}[1m])) * 100`	| >=90| 	10个周期8次
[kube node] 服务器负载告警| (load average 15min)	sum by(bcs_cluster_id, bk_instance) (sum_over_time(node_load15[1m])) / on(bcs_cluster_id, bk_instance) group_right() sum by(bcs_cluster_id, bk_instance) (count_over_time(node_cpu_seconds_total{bk_job="node-exporter",mode="idle"}[1m]))	| >1	|5个周期4次
[kube node] node 状态异常 |KubeNodeNotReady	max by(bcs_cluster_id, node) (max_over_time(kube_node_status_condition{bk_job="kube-state-metrics",condition="Ready",status="true"}[1m]))	| =0	|1个周期1次
[kube node] CPU使用率告警 |	(1 - avg by(bcs_cluster_id, bk_instance) (irate(node_cpu_seconds_total{mode="idle"}[5m]))) * 100	| >=90	| 5个周期4次
[kube node] 网卡状态不稳定 |	sum by(bcs_cluster_id, bk_instance, bk_namespace, bk_pod) (changes(node_network_up{bk_job="node-exporter"}[2m]))	| >0	| 1个周期1次
[kube node] 网卡接收出错 |	sum by(bcs_cluster_id, bk_instance, device) (increase(node_network_receive_errs_total[2m]))	| >10	| 1个周期1次
[kube node] 网卡发送出错 |	sum by(bcs_cluster_id, bk_instance, device) (increase(node_network_transmit_errs_total[2m])) |	>10	| 1个周期1次
[kube node] 磁盘IO使用率告警 |	sum by(bcs_cluster_id, bk_instance, device) (rate(node_disk_io_time_seconds_total[2m])) * 100	| >=90	| 5个周期4次
[kube node] 磁盘只读告警 |	`sum by(fstype, bcs_cluster_id, device, bk_instance) (sum_over_time(node_filesystem_readonly{fstype=~"ext[234]|btrfs|xfs|zfs"}[1m]))` |	>0	| 1个周期1次
[kube node] FD使用率告警 |	max by(bk_instance, bcs_cluster_id) (max_over_time(node_filefd_allocated[1m])) / on(bk_instance, bcs_cluster_id) group_right() max by(bcs_cluster_id, bk_instance) (max_over_time(node_filefd_maximum[1m])) * 100	| >=90	| 5个周期4次
[kube node] 内存使用率告警 |	(max by(bcs_cluster_id, bk_instance) (max_over_time(node_memory_MemTotal_bytes[1m])) - on(bcs_cluster_id, bk_instance) group_right() max by(bcs_cluster_id, bk_instance) (max_over_time(node_memory_MemFree_bytes[1m])) - on(bcs_cluster_id, bk_instance) group_right() max by(bcs_cluster_id, bk_instance) (max_over_time(node_memory_Cached_bytes[1m])) - on(bcs_cluster_id, bk_instance) group_right() max by(bcs_cluster_id, bk_instance) (max_over_time(node_memory_Buffers_bytes[1m])) + on(bcs_cluster_id, bk_instance) group_right() max by(bcs_cluster_id, bk_instance) (max_over_time(node_memory_Shmem_bytes[1m]))) / on(bcs_cluster_id, bk_instance) group_right() max by(bcs_cluster_id, bk_instance) (max_over_time(node_memory_MemTotal_bytes[1m])) * 100 |	>=90	| 5个周期4次
[kube node]-磁盘使用率告警  |	`(max by(mountpoint, bcs_cluster_id, bk_instance, fstype, device) (max_over_time(node_filesystem_size_bytes{fstype=~"ext[234]|btrfs|xfs|zfs"}[1m])) - on(mountpoint, bcs_cluster_id, bk_instance, fstype, device) group_right() max by(mountpoint, bcs_cluster_id, bk_instance, fstype, device) (max_over_time(node_filesystem_free_bytes{fstype=~"ext[234]|btrfs|xfs|zfs"}[1m]))) / on(mountpoint, bcs_cluster_id, bk_instance, fstype, device) group_right() max by(mountpoint, bcs_cluster_id, bk_instance, fstype, device) (max_over_time(node_filesystem_size_bytes{fstype=~"ext[234]|btrfs|xfs|zfs"}[1m])) * 100`	| >=85	| 5个周期4次
[kube node]-机器时钟漂移 |	max by(bcs_cluster_id, bk_instance) (max_over_time(node_timex_offset_seconds[1m])) and avg by(bcs_cluster_id, bk_instance) (deriv(node_timex_offset_seconds[5m]))	| >0.05 or <= -0.05	| 1个周期1次
[kube node] 使用大量Conntrack条目 |	max by(bcs_cluster_id, bk_instance) (node_nf_conntrack_entries) / on(bcs_cluster_id, bk_instance) group_right() max by(bcs_cluster_id, bk_instance) (node_nf_conntrack_entries_limit) * 100 | 	>75 |	1个周期1次
[kube节点] node不可用 KubeNodeUnreachable | 	max by(bcs_cluster_id, node) (max_over_time(kube_node_spec_taint{effect="NoSchedule",key="node.kubernetes.io/unreachable"}[1m]))	| =1	| 5个周期1次
[kube节点] node状态抖动 KubeNodeReadinessFlapping |	sum by(bcs_cluster_id, node) (changes(kube_node_status_condition{bk_job="kube-state-metrics",condition="Ready",status="true"}[20m]))	|>2	| 1个周期1次
[kube kubelet] pod 启动耗时高 kubelet_pod_worker_duration |	histogram_quantile(0.99, sum by(bcs_cluster_id, bk_instance, bk_node, le) (rate(kubelet_pod_worker_duration_seconds_bucket{bk_job="kubelet"}[5m]))) * on(bk_instance, bcs_cluster_id, bk_node) group_left() avg by(bk_instance, bcs_cluster_id, bk_node) (avg_over_time(kubelet_node_name{bk_job="kubelet"}[1m]))| 	>= 60	| 5个周期4次

## kube-pod策略

策略名称	 | 告警表达式 | 	阈值	| 次数
---|---|---|---
[kube pod] pod 的 CPU 使用率高 |	sum by(bcs_cluster_id, namespace, pod, container) (rate(container_cpu_usage_seconds_total[2m])) / on(bcs_cluster_id, namespace, pod, container) group_right() sum by(bcs_cluster_id, namespace, pod, container) (kube_pod_container_resource_limits_cpu_cores) * 100	| >=95	| 10个周期5次
[kube pod] pod的CPU 执行周期受限占比高CPUThrottlingHigh |	sum by(bcs_cluster_id, namespace, pod, container) (increase(container_cpu_cfs_throttled_periods_total[5m])) / on(bcs_cluster_id, namespace, pod, container) group_right() sum by(bcs_cluster_id, namespace, pod, container) (increase(container_cpu_cfs_periods_total[5m])) * 100	| >=25	| 10个周期5次
[kube资源] pod的内存使用率高|	max by(bcs_cluster_id, bk_instance, pod_name, namespace, container_name) (max_over_time(container_memory_rss{container_name!="",pod_name!=""}[1m])) / on(bcs_cluster_id, bk_instance, pod_name, namespace, container_name) group_right() max by(bcs_cluster_id, bk_instance, pod_name, namespace, container_name) (max_over_time(container_spec_memory_limit_bytes{container_name!="",pod_name!=""}[1m])) * 100 |	>=95 |	5个周期4次
[kube pod] pod近30分钟重启次数过多 | KubePodCrashLooping	sum by(bcs_cluster_id, namespace, container_name, pod_name) (increase(kube_pod_container_status_restarts_total{bk_job="kube-state-metrics",container_name!="",pod_name!=""}[30m]))	| >=5	| 5个周期4次
[kube kubelet] 运行的pod过多 KubeletTooManyPods	| max by(bcs_cluster_id, bk_instance) (kubelet_running_pods{bk_job="kubelet",bk_metrics_path="/metrics"}) * on(bcs_cluster_id, bk_instance) group_right() max by(bcs_cluster_id, bk_instance, node) (kubelet_node_name{bk_job="kubelet",bk_metrics_path="/metrics"}) / on(bcs_cluster_id, bk_instance, node) group_right() max by(bcs_cluster_id, bk_instance, node) (kube_node_status_capacity_pods{bk_job="kube-state-metrics"}) * 100	| >=95 |	10个周期8次
[kube pod] pod 状态异常	| `max by(bcs_cluster_id, namespace, pod) (max_over_time(kube_pod_status_phase{bk_job="kube-state-metrics",namespace!="",phase=~"^(Pending|Unknown)$",pod_name!=""}[1m])) * on(bcs_cluster_id, namespace, pod) group_right() max by(bcs_cluster_id, namespace, pod) (max_over_time(kube_pod_owner{namespace!="",owner_kind!="Job"}[1m]))`	| >0 | 5个周期4次
[kube pod] 容器状态异常	| max by(bcs_cluster_id, namespace, pod, container) (max_over_time(kube_pod_container_status_waiting_reason{bk_job="kube-state-metrics",namespace!="",pod_name!=""}[1m]))| 	>0 |	5个周期2次
[kube pod] pod 因OOM重启 |	max by(bcs_cluster_id, namespace, pod_name) (increase(kube_pod_container_status_terminated_reason{namespace!="",pod_name!="",reason="OOMKilled"}[2m]))	| >0 |	5个周期1次

## kube-daemonset策略


策略名称	 | 告警表达式 | 	阈值	| 次数
---|---|---|---
[kube daemonset] daemonset 部分 node 被错误调度 KubeDaemonSetMisScheduled |	avg by(bcs_cluster_id, namespace, daemonset) (increase(kube_daemonset_status_number_misscheduled{bk_job="kube-state-metrics"}[2m])) |	>0 |	5个周期4次
[kube daemonset] daemonSet处于就绪状态的百分比 KubeDaemonSetRolloutStuck |	sum by(bcs_cluster_id, namespace, daemonset) (sum_over_time(kube_daemonset_status_number_ready{bk_job="kube-state-metrics"}[1m])) / on(bcs_cluster_id, namespace, daemonset) group_right() sum by(bcs_cluster_id, namespace, daemonset) (sum_over_time(kube_daemonset_status_desired_number_scheduled{bk_job="kube-state-metrics"}[1m])) * 100	| <100 |	10个周期8次
[kube daemonset] daemonset 部分 node 未调度 KubeDaemonSetNotScheduled |	sum by(bcs_cluster_id, namespace, daemonset) (sum_over_time(kube_daemonset_status_desired_number_scheduled{bk_job="kube-state-metrics"}[1m])) - on(bcs_cluster_id, namespace, daemonset) group_right() sum by(bcs_cluster_id, namespace, daemonset) (sum_over_time(kube_daemonset_status_current_number_scheduled{bk_job="kube-state-metrics"}[1m]))	| >0 |	5个周期4次

## kube-job策略

策略名称	 | 告警表达式 | 	阈值	| 次数
---|---|---|---
 [kube kubelet] job运行太久	 | max by(bcs_cluster_id, namespace, job_name) (max_over_time(kube_job_spec_completions{bk_job="kube-state-metrics"}[1h])) - on(bcs_cluster_id, namespace, job_name) group_right() max by(bcs_cluster_id, namespace, job_name) (max_over_time(kube_job_status_succeeded[1h])) |	>0	| 5个周期3次
[kube kubelet] job执行失败的数量KubeJobFailed |	sum by(bcs_cluster_id, namespace, job_name) (sum_over_time(kube_job_status_failed{bk_job="kube-state-metrics"}[1m]))	| <100 |	10个周期8次

## kube-statefulset策略

策略名称	 | 告警表达式 | 	阈值	| 次数
---|---|---|---
[kube statefulset] statefulset 副本数不匹配 |	(max by(bcs_cluster_id, namespace, statefulset) (kube_statefulset_status_replicas_ready{bk_job="kube-state-metrics"}) - on(bcs_cluster_id, namespace, statefulset) group_right() max by(bcs_cluster_id, namespace, statefulset) (kube_statefulset_status_replicas{bk_job="kube-state-metrics"})) and (max by(bcs_cluster_id, namespace, statefulset) (changes(kube_statefulset_status_replicas_updated{bk_job="kube-state-metrics"}[10m])) == 0)	|>0 |	5个周期1次
[kube statefulset] statefulset 部署版本不匹配|	max by(bcs_cluster_id, namespace, statefulset) (kube_statefulset_status_observed_generation{bk_job="kube-state-metrics"}) - on(bcs_cluster_id, namespace, statefulset) group_right() max by(bcs_cluster_id, namespace, statefulset) (kube_statefulset_metadata_generation{bk_job="kube-state-metrics"})	| >0|	5个周期1次

## kube-deployment策略

策略名称	 | 告警表达式 | 	阈值	| 次数
---|---|---|---
[kube deployment] deployment 副本数不匹配 |	(avg by(bcs_cluster_id, namespace, deployment) (avg_over_time(kube_deployment_spec_replicas{deployment!=""}[1m])) - on(bcs_cluster_id, namespace, deployment) group_right() avg by(bcs_cluster_id, namespace, deployment) (avg_over_time(kube_deployment_status_replicas_available{deployment!=""}[1m]))) and (avg by(bcs_cluster_id, deployment, namespace) (changes(kube_deployment_status_replicas_updated{deployment!=""}[10m])) == 0)	| >0 |	5个周期1次
[kube deployment] deployment 部署版本不匹配 |	avg by(bcs_cluster_id, namespace, deployment) (avg_over_time(kube_deployment_status_observed_generation{bk_job="kube-state-metrics",deployment!=""}[1m])) - on(bcs_cluster_id, namespace, deployment) group_right() avg by(bcs_cluster_id, namespace, deployment) (avg_over_time(kube_deployment_metadata_generation{bk_job="kube-state-metrics",deployment!=""}[1m]))	|>0	 | 5个周期1次

## kube-hpa策略

策略名称	 | 告警表达式 | 	阈值	| 次数
---|---|---|---
[kube hpa] 副本数和HPA不匹配	| (avg by(bcs_cluster_id, namespace, hpa) (avg_over_time(kube_hpa_status_desired_replicas{hpa!=""}[1m])) - on(bcs_cluster_id, namespace, hpa) group_right() avg by(bcs_cluster_id, namespace, hpa) (avg_over_time(kube_hpa_status_current_replicas{hpa!=""}[1m]))) and (avg by(bcs_cluster_id, namespace, hpa) (changes(kube_hpa_status_current_replicas{hpa!=""}[10m])) == 0)	| >0 |	5个周期1次
[kube hpa] 副本数达到HPA最大值	| avg by(bcs_cluster_id, namespace, hpa) (avg_over_time(kube_hpa_status_current_replicas{hpa!=""}[1m])) - on(bcs_cluster_id, namespace, hpa) group_right() avg by(bcs_cluster_id, namespace, hpa) (avg_over_time(kube_hpa_spec_max_replicas{hpa!=""}[1m]))	| =0 |	5个周期1次

## kube-volume策略

策略名称	 | 告警表达式 | 	阈值	| 次数
---|---|---|---
[kube hpa] 副本数和HPA不匹配	 | `avg(avg_over_time(kube_persistentvolume_status_phase{bk_job="kube-state-metrics",phase=~"^(Failed|Pending)$"}[1m]))` |	>0 |	5个周期1次

## kube-kubelet策略

策略名称	 | 告警表达式 | 	阈值	| 次数
---|---|---|---
[kube kubelet] PLEG 耗时高 kubelet_pleg_relist |	histogram_quantile(0.99, sum by(bcs_cluster_id, bk_instance, le, bk_node) (rate(kubelet_pleg_relist_duration_seconds_bucket[5m]))) * on(bk_instance, bcs_cluster_id, bk_node) group_left() avg by(bk_instance, bcs_cluster_id, bk_node) (avg_over_time(kubelet_node_name{bk_job="kubelet"}[1m]))	| >=10 |	5个周期4次

