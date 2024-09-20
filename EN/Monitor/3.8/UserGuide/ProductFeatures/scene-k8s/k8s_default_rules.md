# k8s default policy description



## Cluster resources


Policy name | Alarm expression | Threshold | Count
---|---|---|---
[kube cluster resources] The cluster's CPU resource allocation is overloaded - KubeCPUOvercommit | `sum by(bcs_cluster_id) (kube_pod_container_resource_requests_cpu_cores{bcs_cluster_id!="",node!=""}) / on(bcs_cluster_id) group_right() sum by(bcs_cluster_id) ( kube_node_status_allocatable_cpu_cores{bcs_cluster_id!="",node!=""}) - on(bcs_cluster_id) group_right() (count by(bcs_cluster_id) (kube_node_status_allocatable_cpu_cores{bcs_cluster_id!="",node!=""}) - 1) / on (bcs_cluster_id) group_right() count by(bcs_cluster_id) (kube_node_status_allocatable_cpu_cores{bcs_cluster_id!="",node!=""}) ` | >=0 | 5 times in 10 cycles
[kube cluster resources] The cluster's memory resource allocation is overloaded - KubeMemoryOvercommit |`sum by(bcs_cluster_id) (kube_pod_container_resource_requests_memory_bytes{bcs_cluster_id!="",node!=""}) / on(bcs_cluster_id) group_right() sum by(bcs_cluster_id) ( kube_node_status_allocatable_memory_bytes{bcs_cluster_id!="",node!=""}) - on(bcs_cluster_id) group_right() (count by(bcs_cluster_id) (kube_node_status_allocatable_memory_bytes{bcs_cluster_id!="",node!=""}) - 1) / on (bcs_cluster_id) group_right() count by(bcs_cluster_id) (kube_node_status_allocatable_memory_bytes{bcs_cluster_id!="",node!=""})` | >=0 | 5 times in 10 cycles

## kube-master policy

Policy name | Alarm expression | Threshold | Count
---|---|---|---
[kube Master] Client accessing APIServer error rest_client_requests_total_5xx | `sum by(bcs_cluster_id, bk_instance, bk_job) (rate(rest_client_requests_total{code="^5[0-9][0-9]"}[5m])) / on (bcs_cluster_id, bk_instance, bk_job) group_right() sum by (bcs_cluster_id, bk_instance, bk_job) (rest_client_requests_total) * 100` | >1 | 1 time in 5 cycles
[kube master] apiserver certificate expiration monitoring KubeClientCertificateExpiration | `histogram_quantile(0.01, sum by(bk_job, bcs_cluster_id, le) (rate(apiserver_client_certificate_expiration_seconds_bucket{bk_job="apiserver"}[5m]))` | <604800 | 5 cycles 4 Second-rate

## kube-node policy

Policy name | Alarm expression | Threshold | Count---|---|---|---
[kube node] The machine clock is not synchronized |min by(bcs_cluster_id, instance) (node_timex_sync_status)| =0 | 4 times in 5 cycles
[kube node] Disk inode usage alarm | `(sum by(fstype, bcs_cluster_id, device, bk_instance) (sum_over_time(node_filesystem_files{fstype=~"ext[234]|btrfs|xfs|zfs"}[1m])) - on(fstype, bcs_cluster_id, device, bk_instance) group_right() sum by(fstype, bcs_cluster_id, device, bk_instance) (sum_over_time(node_filesystem_files_free{fstype=~"ext[234]|btrfs|xfs|zfs"}[1m])) ) / on(fstype, bcs_cluster_id, device, bk_instance) group_right() sum by(fstype, bcs_cluster_id, device, bk_instance) (sum_over_time(node_filesystem_files{fstype=~"ext[234]|btrfs|xfs|zfs"}[1m] )) * 100` | >=90| 8 times in 10 cycles
[kube node] Server load alarm | (load average 15min) sum by(bcs_cluster_id, bk_instance) (sum_over_time(node_load15[1m])) / on(bcs_cluster_id, bk_instance) group_right() sum by(bcs_cluster_id, bk_instance) (count_over_time(node_cpu_seconds_total {bk_job="node-exporter",mode="idle"}[1m])) | >1 |4 times in 5 cycles
[kube node] Abnormal node status|KubeNodeNotReady max by(bcs_cluster_id, node) (max_over_time(kube_node_status_condition{bk_job="kube-state-metrics",condition="Ready",status="true"}[1m])) | = 0 |1 time per cycle
[kube node] CPU usage alarm | (1 - avg by(bcs_cluster_id, bk_instance) (irate(node_cpu_seconds_total{mode="idle"}[5m]))) * 100 | >=90 | 4 times in 5 cycles
[kube node] The network card status is unstable | sum by(bcs_cluster_id, bk_instance, bk_namespace, bk_pod) (changes(node_network_up{bk_job="node-exporter"}[2m])) | >0 | 1 time per cycle
[kube node] Network card reception error | sum by(bcs_cluster_id, bk_instance, device) (increase(node_network_receive_errs_total[2m])) | >10 | 1 time per cycle
[kube node] Network card transmission error | sum by(bcs_cluster_id, bk_instance, device) (increase(node_network_transmit_errs_total[2m])) | >10 | 1 time per cycle
[kube node] Disk IO usage alarm | sum by(bcs_cluster_id, bk_instance, device) (rate(node_disk_io_time_seconds_total[2m])) * 100 | >=90 | 4 times in 5 cycles
[kube node] Disk read-only alarm | `sum by(fstype, bcs_cluster_id, device, bk_instance) (sum_over_time(node_filesystem_readonly{fstype=~"ext[234]|btrfs|xfs|zfs"}[1m]))` | > 0 | 1 time per cycle
[kube node] FD usage alarm | max by(bk_instance, bcs_cluster_id) (max_over_time(node_filefd_allocated[1m])) / on(bk_instance, bcs_cluster_id) group_right() max by(bcs_cluster_id, bk_instance) (max_over_time(node_filefd_maximum[1m]) ) * 100 | >=90 | 4 times in 5 cycles
[kube node] Memory usage alarm| (max by(bcs_cluster_id, bk_instance) (max_over_time(node_memory_MemTotal_bytes[1m])) - on(bcs_cluster_id, bk_instance) group_right() max by(bcs_cluster_id, bk_instance) (max_over_time(node_memory_MemFree_bytes[1m] ] )) - on(bcs_cluster_id, bk_instance) group_right() max by(bcs_cluster_id, bk_instance) (max_over_time(node_memory_Cached_bytes[1m])) - on(bcs_cluster_id, bk_instance) group_right() max by(bcs_cluster_id, bk_instance) (max_over_time(node_memory _Buffers_bytes[ 1m])) + on(bcs_cluster_id, bk_instance) group_right() max by(bcs_cluster_id, bk_instance) (max_over_time(node_memory_Shmem_bytes[1m]))) / on(bcs_cluster_id, bk_instance) group_right() max by(bcs_cluster_id, bk_instance) (max_over_time (node_memory_MemTotal_bytes[1m])) * 100 | >=90 | 4 times in 5 cycles
[kube node]-Disk usage alarm | `(max by(mountpoint, bcs_cluster_id, bk_instance, fstype, device) (max_over_time(node_filesystem_size_bytes{fstype=~"ext[234]|btrfs|xfs|zfs"}[1m]) ) - on(mountpoint, bcs_cluster_id, bk_instance, fstype, device) group_right() max by(mountpoint, bcs_cluster_id, bk_instance, fstype, device) (max_over_time(node_filesystem_free_bytes{fstype=~"ext[234]|btrfs|xfs|zfs" }[1m]))) / on(mountpoint, bcs_cluster_id, bk_instance, fstype, device) group_right() max by(mountpoint, bcs_cluster_id, bk_instance, fstype, device) (max_over_time(node_filesystem_size_bytes{fstype=~"ext[234]| btrfs|xfs|zfs"}[1m])) * 100` | >=85 | 4 times in 5 cycles
[kube node]-Machine clock drift | max by(bcs_cluster_id, bk_instance) (max_over_time(node_timex_offset_seconds[1m])) and avg by(bcs_cluster_id, bk_instance) (deriv(node_timex_offset_seconds[5m])) | >0.05 or <= -0.05 | 1 time per cycle
[kube node] Use a large number of Conntrack entries | max by(bcs_cluster_id, bk_instance) (node_nf_conntrack_entries) / on(bcs_cluster_id, bk_instance) group_right() max by(bcs_cluster_id, bk_instance) (node_nf_conntrack_entries_limit) * 100 | >75 | 1 time in 1 cycle
[kube node] node is not available KubeNodeUnreachable | max by(bcs_cluster_id, node) (max_over_time(kube_node_spec_taint{effect="NoSchedule",key="node.kubernetes.io/unreachable"}[1m])) | =1 | 5 Cycle 1
[kube node] node status flapping KubeNodeReadinessFlapping | sum by(bcs_cluster_id, node) (changes(kube_node_status_condition{bk_job="kube-state-metrics",condition="Ready",status="true"}[20m])) |> 2 | 1 time per cycle
[kube kubelet] pod startup takes a long time kubelet_pod_worker_duration | histogram_quantile(0.99, sum by(bcs_cluster_id, bk_instance, bk_node, le) (rate(kubelet_pod_worker_duration_seconds_bucket{bk_job="kubelet"}[5m]))) * on(bk_instance, bcs_cluster_id, bk_node) group_left() avg by(bk_instance, bcs_cluster_id, bk_node) (avg_over_time(kubelet_node_name{bk_job="kubelet"}[1m]))| >= 60 | 4 times in 5 cycles
## kube-pod policy

Policy name | Alarm expression | Threshold | Count
---|---|---|---
[kube pod] pod has high CPU usage | sum by(bcs_cluster_id, namespace, pod, container) (rate(container_cpu_usage_seconds_total[2m])) / on(bcs_cluster_id, namespace, pod, container) group_right() sum by(bcs_cluster_id, namespace, pod, container) (kube_pod_container_resource_limits_cpu_cores) * 100 | >=95 | 5 times in 10 cycles
[kube pod] The CPU execution cycle of the pod is limited and the proportion is high. CPUThrottlingHigh | sum by(bcs_cluster_id, namespace, pod, container) (increase(container_cpu_cfs_throttled_periods_total[5m])) / on(bcs_cluster_id, namespace, pod, container) group_right() sum by(bcs_cluster_id, namespace, pod, container) (increase(container_cpu_cfs_periods_total[5m])) * 100 | >=25 | 5 times in 10 cycles
[kube resource] pod has high memory usage | max by(bcs_cluster_id, bk_instance, pod_name, namespace, container_name) (max_over_time(container_memory_rss{container_name!="",pod_name!=""}[1m])) / on(bcs_cluster_id , bk_instance, pod_name, namespace, container_name) group_right() max by(bcs_cluster_id, bk_instance, pod_name, namespace, container_name) (max_over_time(container_spec_memory_limit_bytes{container_name!="",pod_name!=""}[1m])) * 100 | >=95 | 4 times in 5 cycles
[kube pod] The pod has restarted too many times in the past 30 minutes | KubePodCrashLooping sum by(bcs_cluster_id, namespace, container_name, pod_name) (increase(kube_pod_container_status_restarts_total{bk_job="kube-state-metrics",container_name!="",pod_name!=" "}[30m])) | >=5 | 4 times in 5 cycles
[kube kubelet] Too many running pods KubeletTooManyPods | max by(bcs_cluster_id, bk_instance) (kubelet_running_pods{bk_job="kubelet",bk_metrics_path="/metrics"}) * on(bcs_cluster_id, bk_instance) group_right() max by(bcs_cluster_id, bk_instance, node) (kubelet_node_name{bk_job="kubelet",bk_metrics_path="/metrics"}) / on(bcs_cluster_id, bk_instance, node) group_right() max by(bcs_cluster_id, bk_instance, node) (kube_node_status_capacity_pods{bk_job="kube- state-metrics"}) * 100 | >=95 | 8 times in 10 cycles
[kube pod] Abnormal pod status | `max by(bcs_cluster_id, namespace, pod) (max_over_time(kube_pod_status_phase{bk_job="kube-state-metrics",namespace!="",phase=~"^(Pending|Unknown)$ ",pod_name!=""}[1m])) * on(bcs_cluster_id, namespace, pod) group_right() max by(bcs_cluster_id, namespace, pod) (max_over_time(kube_pod_owner{namespace!="",owner_kind!="Job "}[1m]))` | >0 | 4 times in 5 cycles
[kube pod] Container status abnormal | max by(bcs_cluster_id, namespace, pod, container) (max_over_time(kube_pod_container_status_waiting_reason{bk_job="kube-state-metrics",namespace!="",pod_name!=""}[1m]) )| >0 | 2 times in 5 cycles
[kube pod] pod restarted due to OOM | max by(bcs_cluster_id, namespace, pod_name) (increase(kube_pod_container_status_terminated_reason{namespace!="",pod_name!="",reason="OOMKilled"}[2m])) | >0 | 1 time for 5 cycles

## kube-daemonset policy


Policy name | Alarm expression | Threshold | Count
---|---|---|---
[kube daemonset] Some nodes in the daemonset are incorrectly scheduled. KubeDaemonSetMisScheduled | avg by(bcs_cluster_id, namespace, daemonset) (increase(kube_daemonset_status_number_misscheduled{bk_job="kube-state-metrics"}[2m])) | >0 | 4 times in 5 cycles
[kube daemonset] Percentage of daemonSet in ready state KubeDaemonSetRolloutStuck | sum by(bcs_cluster_id, namespace, daemonset) (sum_over_time(kube_daemonset_status_number_ready{bk_job="kube-state-metrics"}[1m])) / on(bcs_cluster_id, namespace, daemonset) group_right() sum by(bcs_cluster_id, namespace, daemonset) (sum_over_time(kube_daemonset_status_desired_number_scheduled{bk_job="kube-state-metrics"}[1m])) * 100 | <100 | 8 times in 10 cycles
[kube daemonset] Some nodes in daemonset are not scheduled KubeDaemonSetNotScheduled | sum by(bcs_cluster_id, namespace, daemonset) (sum_over_time(kube_daemonset_status_desired_number_scheduled{bk_job="kube-state-metrics"}[1m])) - on(bcs_cluster_id, namespace, daemonset) group_right () sum by(bcs_cluster_id, namespace, daemonset) (sum_over_time(kube_daemonset_status_current_number_scheduled{bk_job="kube-state-metrics"}[1m])) | >0 | 4 times in 5 cycles

## kube-job policy

Policy name | Alarm expression | Threshold | Count
---|---|---|---
  [kube kubelet] job runs too long | max by(bcs_cluster_id, namespace, job_name) (max_over_time(kube_job_spec_completions{bk_job="kube-state-metrics"}[1h])) - on(bcs_cluster_id, namespace, job_name) group_right() max by(bcs_cluster_id, namespace, job_name) (max_over_time(kube_job_status_succeeded[1h])) | >0 | 3 times in 5 cycles
[kube kubelet] Number of job execution failures KubeJobFailed | sum by(bcs_cluster_id, namespace, job_name) (sum_over_time(kube_job_status_failed{bk_job="kube-state-metrics"}[1m])) | <100 | 8 times in 10 cycles

## kube-statefulset strategyPolicy name | Alarm expression | Threshold | Count
---|---|---|---
[kube statefulset] statefulset replica number mismatch | (max by(bcs_cluster_id, namespace, statefulset) (kube_statefulset_status_replicas_ready{bk_job="kube-state-metrics"}) - on(bcs_cluster_id, namespace, statefulset) group_right() max by(bcs_cluster_id , namespace, statefulset) (kube_statefulset_status_replicas{bk_job="kube-state-metrics"})) and (max by(bcs_cluster_id, namespace, statefulset) (changes(kube_statefulset_status_replicas_updated{bk_job="kube-state-metrics"}[10m]) ) == 0) |>0 | 1 time in 5 cycles
[kube statefulset] statefulset deployment version mismatch | max by(bcs_cluster_id, namespace, statefulset) (kube_statefulset_status_observed_generation{bk_job="kube-state-metrics"}) - on(bcs_cluster_id, namespace, statefulset) group_right() max by(bcs_cluster_id, namespace, statefulset) (kube_statefulset_metadata_generation{bk_job="kube-state-metrics"}) | >0| 1 time in 5 cycles

## kube-deployment policy

Policy name | Alarm expression | Threshold | Count
---|---|---|---
[kube deployment] deployment replica number mismatch | (avg by(bcs_cluster_id, namespace, deployment) (avg_over_time(kube_deployment_spec_replicas{deployment!=""}[1m])) - on(bcs_cluster_id, namespace, deployment) group_right() avg by (bcs_cluster_id, namespace, deployment) (avg_over_time(kube_deployment_status_replicas_available{deployment!=""}[1m]))) and (avg by(bcs_cluster_id, deployment, namespace) (changes(kube_deployment_status_replicas_updated{deployment!=""}[10m]) ) == 0) | >0 | 1 time in 5 cycles
[kube deployment] deployment deployment version mismatch | avg by(bcs_cluster_id, namespace, deployment) (avg_over_time(kube_deployment_status_observed_generation{bk_job="kube-state-metrics",deployment!=""}[1m])) - on(bcs_cluster_id, namespace, deployment) group_right() avg by(bcs_cluster_id, namespace, deployment) (avg_over_time(kube_deployment_metadata_generation{bk_job="kube-state-metrics",deployment!=""}[1m])) |>0 | 5 cycles 1 Second-rate

## kube-hpa policy

Policy name | Alarm expression | Threshold | Count
---|---|---|---
[kube hpa] The number of replicas does not match the HPA | (avg by(bcs_cluster_id, namespace, hpa) (avg_over_time(kube_hpa_status_desired_replicas{hpa!=""}[1m])) - on(bcs_cluster_id, namespace, hpa) group_right() avg by(bcs_cluster_id, namespace, hpa) (avg_over_time(kube_hpa_status_current_replicas{hpa!=""}[1m]))) and (avg by(bcs_cluster_id, namespace, hpa) (changes(kube_hpa_status_current_replicas{hpa!=""}[10m] )) == 0) | >0 | 1 time in 5 cycles
[kube hpa] The number of replicas reaches the maximum HPA value | avg by(bcs_cluster_id, namespace, hpa) (avg_over_time(kube_hpa_status_current_replicas{hpa!=""}[1m])) - on(bcs_cluster_id, namespace, hpa) group_right() avg by (bcs_cluster_id, namespace, hpa) (avg_over_time(kube_hpa_spec_max_replicas{hpa!=""}[1m])) | =0 | 1 time in 5 cycles

## kube-volume policy

Policy name | Alarm expression | Threshold | Count
---|---|---|---
[kube hpa] The number of replicas does not match the HPA | `avg(avg_over_time(kube_persistentvolume_status_phase{bk_job="kube-state-metrics",phase=~"^(Failed|Pending)$"}[1m]))` | >0 | 1 time for 5 cycles

## kube-kubelet strategy

Policy name | Alarm expression | Threshold | Count
---|---|---|---
[kube kubelet] PLEG is time consuming kubelet_pleg_relist | histogram_quantile(0.99, sum by(bcs_cluster_id, bk_instance, le, bk_node) (rate(kubelet_pleg_relist_duration_seconds_bucket[5m]))) * on(bk_instance, bcs_cluster_id, bk_node) group_left() av g by( bk_instance, bcs_cluster_id, bk_node) (avg_over_time(kubelet_node_name{bk_job="kubelet"}[1m])) | >=10 | 4 times in 5 cycles
