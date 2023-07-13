# 蓝鲸对象存储服务 Django 1.3 legacy 版本参考文档

## 相关配置项

以下配置项均需要设置在 Django settings 中才能生效，部分配置项支持通过环境变量设置。

### RGW_ACCESS_KEY_ID

蓝鲸 PaaS3.0 开发者中心为您分配的 access_key_id，支持通过环境变量设置。

### RGW_SECRET_ACCESS_KEY

蓝鲸 PaaS3.0 开发者中心为您分配的 secret_access_key，支持通过环境变量设置。

### RGW_STORAGE_BUCKET_NAME

蓝鲸 PaaS3.0 开发者中心为您分配的 bucket 名称，支持通过环境变量设置。

### RGW_ENDPOINT_HOST

蓝鲸 PaaS3.0 开发者中心对象存储服务主机地址，具体请查看使用指南。

### RGW_BUCKET_PREFIX

前缀地址，比如设置为 static 后，所以上传文件会被放在 /static/ 目录下。默认为 ''

### RGW_FILE_OVERWRITE

对于相同名称的文件，是否覆盖旧文件，默认为 True。
