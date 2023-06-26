# 增强服务：对象存储（Ceph）

## 实例使用指南

蓝鲸对象存储服务拥有与 [Amazon S3](https://aws.amazon.com/cn/s3/) 完全兼容的 API。

你可以在项目中使用各语言 SDK 来操作它，例如 [在 Django 项目中使用 bkstorages](../../../sdk/bkstorages/index.md)。其他编程语言也可以直接搜索各自的 AWS S3 SDK 使用文档。

你还可以用各类工具来访问它，比如用 s3cmd 方便的上传或下载文件。甚至还可以结合 Job 作业系统完成文件分发，具体请查阅：

- [使用 boto3 访问 s3](../../../sdk/bkstorages/blueking_boto3.md)
- [使用 s3cmd 访问 s3](../../../sdk/bkstorages/s3cmd.md)
- [使用 job 分发文件](../../../sdk/bkstorages/job_distribute_file.md)