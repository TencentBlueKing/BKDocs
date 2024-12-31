# Error Codes

## Overview of Error Codes

| Error Code | Description |
| ---------- | ----------- |
| 4311001    | Failed to query deployment information |
| 4311002    | Failed to query deployment phase information |
| 4311003    | Deployment failed |
| 4311004    | Deployment failed, there is an ongoing deployment task, please refresh to check |
| 4311005    | The application has not been published in this environment |
| 4311006    | Deployment permission control is enabled, only administrators can operate |
| 4311007    | Log stream pipeline does not exist |
| 4311008    | Failed to abort deployment |
| 4312001    | Repository binding failed |
| 4312002    | Failed to obtain source code information |
| 4312003    | OAUTH authorization information has not been bound |
| 4312004    | Failed to get code version |
| 4312005    | Failed to switch source code repository type |
| 4312006    | Failed to create Svn tag |
| 4312007    | Unsupported source code type |
| 4312008    | Unsupported source code source |
| 4312009    | Source code package already exists |
| 4312010    | Missing version information |
| 4312011    | Object storage service exception |
| 4313001    | Failed to bind runtime |
| 4313010    | Enhanced service binding failed |
| 4313020    | Failed to configure resource instances |
| 4313021    | Failed to get cluster information |
| 4313022    | Resource pool is empty |
| 4313040    | Service deletion failed |
| 4313050    | Failed to share enhanced service |
| 4313081    | CI related resource deletion failed |
| 4313082    | Failed to read enhanced service instance information |
| 4314001    | No S-mart APP package to be created found |
| 4314002    | Missing APP description file |
| 4314003    | Analysis of APP description file exception |
| 4314004    | Access to container image repository exception |

### 4313021 Failed to Get Cluster Information

Failed to get cluster information, troubleshooting steps are as follows:

1. In the management backend ({PaaS3.0 Developer Center Access Address}/backend/admin42/platform/clusters/manage/), confirm whether the certificate or Token information is correctly filled in the application cluster configuration.

The platform manages K8S clusters, including but not limited to: creating or deleting namespaces, creating or deleting BlueKing applications (`Deployment` / `Service` / `Ingress`, etc.).

Therefore, it is necessary to configure the relevant information of the corresponding cluster, including:

- Apiserver access address, access identity, and `cluster-admin` permissions
- Application cluster access method and entry domain name

Note: After modifying the page, you must restart all processes of the apiserver module to take effect.

2. In the `bkpaas3` helm release, confirm whether the `bkpaas3-apiserver-generate-initial-cluster-state` job has been executed successfully.

If it fails, you can helm update and execute again.

3. Check the logs of the `bkpaas3-apiserver-worker` module, if there is a `403 Forbidden` error, refer to check whether the certificate or Token is configured correctly in the first step.

### 4313022 Resource Pool is Empty

The resource pool is empty, troubleshooting steps are as follows:

1. In the management backend ({PaaS3.0 Developer Center Access Address}/backend/admin42/platform/pre-created-instances/manage), confirm whether there are available service instances in the resource pool of the corresponding enhanced service plan.

2. If there are no available instances in the resource pool, you can add the corresponding service instances.