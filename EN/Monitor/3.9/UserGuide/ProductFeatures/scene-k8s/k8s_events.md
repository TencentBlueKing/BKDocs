
# K8s EventsEvents

## View events

Method One: Data Exploration - Event Retrieval
![](media/16921713477243.jpg)

Method 2: Observation Scenario - Kubernetes - Events
![](media/16921719512339.jpg)


## Event description

### Configuration Events

-FailedValidation

    Failed pod configuration validation.


### Container Events

- BackOff

    Back-off restarting failed the container.

- Created

    Container created.

- Failed

    Pull/Create/Start failed.

- Killing

    Killing the container.

- Started

    Container started.

- Preempting

    Preempting other pods.

- ExceededGracePeriod

    Container runtime did not stop the pod within specified grace period.



### Health Events

- Unhealthy

    Container is unhealthy.



### Image Events

- BackOff

    Back off Ctr Start, image pull.

- ErrImageNeverPull

    The image’s NeverPull Policy is violated.

- Failed

    Failed to pull the image.

- InspectFailed

    Failed to inspect the image.

- Pulled

    Successfully pulled the image or the container image is already present on the machine.

- Pulling

    Pulling the image.



### Image Manager Events

- FreeDiskSpaceFailed

    Free disk space failed.

- InvalidDiskCapacity

    Invalid disk capacity.



### Node Events

- FailedMount

    Volume mount failed.

- HostNetworkNotSupported

    Host network not supported.

- HostPortConflict

    Host/port conflict.

- InsufficientFreeCPU

    Insufficient free CPU.

- InsufficientFreeMemory

    Insufficient free memory.

- KubeletSetupFailed

    Kubelet setup failed.

- NilShaper

    Undefined shaper.

- NodeNotReady

    Node is not ready.

- NodeNotSchedulable

    Node is not schedulable.

- NodeReady

    Node is ready.

- NodeSchedulable

    Node is schedulable.

- NodeSelectorMismatching

    Node selector mismatch.

- OutOfDisk

    Out of disk.

- Rebooted

    Node rebooted.

- Starting

    Starting kubelet.

- FailedAttachVolume

    Failed to attach volume.

- FailedDetachVolume

    Failed to detach volume.

- VolumeResizeFailed

    Failed to expand/reduce volume.

- VolumeResizeSuccessful

    Successfully expanded/reduced volume.

- FileSystemResizeFailed

    Failed to expand/reduce file system.

- FileSystemResizeSuccessful

    Successfully expanded/reduced file system.

- FailedUnMount

    Failed to unmount volume.

- FailedMapVolume

    Failed to map a volume.

- FailedUnmapDevice

    Failed unmaped device.

- AlreadyMountedVolume

    Volume is already mounted.

- SuccessfulDetachVolume

    Volume is successfully detached.

- SuccessfulMountVolume

    Volume is successfully mounted.

- SuccessfulUnMountVolume

    Volume is successfully unmounted.

- ContainerGCFailed

    Container garbage collection failed.

- ImageGCFailed

    Image garbage collection failed.

- FailedNodeAllocatableEnforcement

    Failed to enforce System Reserved Cgroup limit.

- NodeAllocatableEnforced

    Enforced System Reserved Cgroup limit.

- UnsupportedMountOption

    Unsupported mount option.

- SandboxChanged

    Pod sandbox changed.

- FailedCreatePodSandBox

    Failed to create pod sandbox.

- FailedPodSandBoxStatus

    Failed pod sandbox status.


### Pod Worker Events

- FailedSync

    Pod sync failed.



### System Events

- SystemOOM

    There is an OOM (out of memory) situation on the cluster.



### Pod Events

- FailedKillPod

    Failed to stop a pod.

- FailedCreatePodContainer

    Failed to create a pod contianer.

- Failed

    Failed to make pod data directories.

- NetworkNotReady

    Network is not ready.

- FailedCreate

    Error creating: `<error-msg>`.

- SuccessfulCreate

    Created pod: `<pod-name>`.

- FailedDelete

    Error deleting: `<error-msg>`.

- SuccessfulDelete

    Deleted pod: `<pod-id>`.

### Horizontal Pod AutoScaler Events

- SelectorRequired

    Selector is required.

- InvalidSelector

    Could not convert selector into a corresponding internal selector object.

- FailedGetObjectMetric

    HPA was unable to compute the replica count.

- InvalidMetricSourceType

    Unknown metric source type.

- ValidMetricFound

    HPA was able to successfully calculate a replica count.

- FailedConvertHPA

    Failed to convert the given HPA.

- FailedGetScale

    HPA controller was unable to get the target’s current scale.

- SucceededGetScale

    HPA controller was able to get the target’s current scale.

- FailedComputeMetricsReplicas

    Failed to compute desired number of replicas based on listed metrics.

- FailedRescale

    New size: `<size>`; reason: `<msg>`; error: `<error-msg>`.

- SuccessfulRescale

    New size: `<size>`; reason: `<msg>`.

- FailedUpdateStatus

    Failed to update status.

### Network Events (kube-proxy)

- NeedPods

    The service-port `<serviceName>:<port>` needs pods.

### Volume Events

- FailedBinding

    There are no persistent volumes available and no storage class is set.

- VolumeMismatch

    Volume size or class is different from what is requested in claim.

- VolumeFailedRecycle

    Error creating recycler pod.

- VolumeRecycled

    Occurs when volume is recycled.

- RecyclerPod

    Occurs when pod is recycled.

- VolumeDelete

    Occurs when volume is deleted.

- VolumeFailedDelete

    Error when deleting the volume.

- ExternalProvisioning

    Occurs when volume for the claim is provisioned either manually or via external software.

- ProvisioningFailed

    Failed to provision volume.

- ProvisioningCleanupFailed

    Error cleaning provisioned volume.

- ProvisioningSucceeded

    Occurs when the volume is provisioned successfully.

- WaitForFirstConsumer

    Delay binding until pod scheduling.

###  Lifecycle hooks

- FailedPostStartHook

    Handler failed for pod start.

- FailedPreStopHook

    Handler failed for pre-stop.

- UnfinishedPreStopHook

    Pre-stop hook unfinished.

### Deployments

- DeploymentCancellationFailed

    Failed to cancel deployment.

- DeploymentCancelled

    Cancelled deployment.

- DeploymentCreated

    Created new replication controller.

- IngressIPRangeFull

    No available ingress IP to allocate to service.

### Scheduler Events

- FailedScheduling

    Failed to schedule pod: `<pod-namespace>/<pod-name>`. This event is raised for multiple reasons, for example: AssumePodVolumes failed, Binding rejected etc.

- Preempted

    By `<preemptor-namespace>/<preemptor-name>` on node `<node-name>`.

- Scheduled

    Successfully assigned `<pod-name>` to `<node-name>`.

###  DaemonSet Events

- SelectingAll

    This daemon set is selecting all pods. A non-empty selector is required.

- FailedPlacement

    Failed to place pod on `<node-name>`.

- FailedDaemonPod

    Found failed daemon pod `<pod-name>` on node `<node-name>`, will try to kill it.

###  LoadBalancer Service Events

- CreatingLoadBalancerFailed

    Error creating load balancer.

- DeletingLoadBalancer

    Deleting load balancer.

- EnsuringLoadBalancer

    Ensuring load balancer.

- EnsuredLoadBalancer

    Ensured load balancer.

- UnAvailableLoadBalancer

    There are no available nodes for LoadBalancer service.

- LoadBalancerSourceRanges

    Lists the new LoadBalancerSourceRanges. For example,` <old-source-range> → <new-source-range>`.

- LoadbalancerIP

    Lists the new IP address. For example,` <old-ip> → <new-ip>`.

- ExternalIP

    Lists external IP address. For example, Added: `<external-ip>`.

- UID

    Lists the new UID. For example, `<old-service-uid> → <new-service-uid>`.

- ExternalTrafficPolicy

    Lists the new ExternalTrafficPolicy. For example, `<old-policy> → <new-ploicy>`.

- HealthCheckNodePort

    Lists the new HealthCheckNodePort. For example, `<old-node-port> → new-node-port>`.

- UpdatedLoadBalancer

    Updated load balancer with new hosts.

- LoadBalancerUpdateFailed

    Error updating load balancer with new hosts.

- DeletingLoadBalancer

    Deleting load balancer.

- DeletingLoadBalancerFailed

    Error deleting load balancer.

- DeletedLoadBalancer

    Deleted load balancer.

## Reference link

https://stackoverflow.com/questions/66687989/all-possible-kubernetes-events-with-type
https://docs.openshift.com/container-platform/3.11/dev_guide/events.html

