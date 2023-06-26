# 蓝鲸对象存储服务 backend 参考文档

## 相关配置项

以下配置项均需要设置在 Django settings 中才能生效，部分配置项支持通过环境变量设置。

### RGW_ACCESS_KEY_ID

蓝鲸 PaaS3.0 开发者中心为您分配的 access_key_id，支持通过环境变量设置。

### RGW_SECRET_ACCESS_KEY

蓝鲸 PaaS3.0 开发者中心为您分配的 secret_access_key，支持通过环境变量设置。

### RGW_STORAGE_BUCKET_NAME

蓝鲸 PaaS3.0 开发者中心为您分配的 bucket 名称，支持通过环境变量设置。

### RGW_ENDPOINT_URL

蓝鲸 PaaS3.0 开发者中心对象存储服务地址，具体请查看使用指南。

### RGW_LOCATION

前缀地址，比如设置为 /static/ 后，所以上传文件会被放在 /static/ 目录下。其他尝试修改非 /static/ 子目录的操作，都会抛出 SuspiciousOperation 异常。默认为 ''

### RGW_FILE_NAME_CHARSET

文件名编码，默认为 utf-8

### RGW_OBJECT_PARAMETERS

需要为文件设置的元数据字典，默认为 {}。可选值列表请参考 [boto3 官方文档](http://boto3.readthedocs.io/en/latest/reference/services/s3.html#S3.Object.put)。

### RGW_STATIC_LOCATION

静态文件上传前缀地址，默认为 '/static'。

### RGW_STATIC_OBJECT_PARAMETERS

静态文件元数据，默认为：

- **CacheControl**: max-age=86400

### RGW_FILE_OVERWRITE

对于相同名称的文件，是否覆盖旧文件，默认为 True。
