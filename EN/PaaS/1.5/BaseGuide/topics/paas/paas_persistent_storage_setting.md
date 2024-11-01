# Persistent Storage Configuration Guide

The persistent storage feature in the Developer Center provides a shared data source for multiple modules and processes, enabling data sharing and interaction, while ensuring data persistence and integrity in the event of system failures or restarts.
The persistent storage feature in the Developer Center is based on [Kubernetes StorageClass](https://kubernetes.io/zh-cn/docs/concepts/storage/storage-classes/), therefore, related configurations need to be enabled in the application cluster of the Developer Center to use this feature.

## Creating a StorageClass

If the application cluster is on a BCS cluster, and the Kubernetes provider is TencentCloud, specific configurations can be viewed at `BCS Container Platform --> Cluster Management --> Cluster --> Basic Information`. The Developer Center recommends using [CFS (Tencent Cloud File Storage)](https://cloud.tencent.com/document/product/457/44234) as the provider for persistent storage.

### [Install File Storage Extension Component](https://cloud.tencent.com/document/product/457/44234)

1. Log in to the [Container Service Console](https://console.qcloud.com/tke2), and select Clusters in the left navigation bar.
2. In the cluster list, click on the target cluster ID to enter the cluster details page.
3. Select **Component Management** in the left menu bar, and click **New** on the Component Management page.
4. Check CFS (Tencent Cloud File Storage) in the **New Component Management** page.
5. Click to complete the component creation.

### [Create a CFS StorageClass](https://cloud.tencent.com/document/product/457/44235)

1. [Create a subnet](https://cloud.tencent.com/document/product/215/36517), which may have been configured when creating the cluster and can be reused directly.
2. [Create a permission group](https://cloud.tencent.com/document/product/582/10951), log in to the [File Storage Console](https://console.cloud.tencent.com/cfs), click on the permission group on the left, create a permission group, and then add permission group rules.
3. Create StorageClass

   - Log in to the Container Service Console
   - Click on Clusters on the left, enter the cluster details page according to the cluster ID
   - Click on Storage on the left, add StorageClass, fill in the form with the previously created subnet, permissions, etc., and it is recommended to set the StorageClass name to cfs

## Configure the Developer Center

Configure `DEFAULT_PERSISTENT_STORAGE_CLASS_NAME = your_storage_class_name` in the Developer Center (the default value is cfs). If your StorageClass name is cfs, you can skip this configuration.

## Enable Persistent Storage Feature for SaaS Applications

In the Developer Center admin42, open `Application Details Page --> Basic Settings --> Feature Management --> Enable Persistent Storage Mount Volume`