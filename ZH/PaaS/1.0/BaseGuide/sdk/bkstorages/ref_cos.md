# 腾讯云 COS backend 参考文档

## 腾讯云 COS 相关配置

### COS_APPID/QCLOUD_APPID

腾讯云 COS 中的 appid，支持从环境变量获取。

### COS_SECRET_ID/QCLOUD_SECRET_ID

腾讯云 COS 中的 secret_id，支持从环境变量获取。

### COS_SECRET_KEY/QCLOUD_SECRET_KEY

腾讯云 COS 中的 secret_key，支持从环境变量获取。

### COS_BUCKET_NAME

文件所在的 bucket 名称，因为当前 COS 不支持通过 API 方式创建 bucket，所以 bucket 需要预先创建。支持从环境变量获取。

### COS_LOCATION

前缀地址，比如设置为 /static/ 后，所以上传文件会被放在 /static/ 目录下。其他尝试修改非 /static/ 子目录的操作，都会抛出 SuspiciousOperation 异常。

默认为 None。

### COS_FILE_NAME_CHARSET

COS 文件名编码。

默认为 utf-8

### COS_DOMAIN_CDN

COS 所使用的 CDN 域名，默认为 `http://{bucket_name}-{appid}.file.myqcloud.com`。

### COS_DOMAIN_COS

COS 所使用的普通域名，默认为 `http://{bucket_name}-{appid}.cos.myqcloud.com`。

### COS_URL_USE_CDN

文件 URL 是否使用 CDN 地址，默认为 False。

### COS_FILE_GUESS_CONTENT_TYPE

是否通过文件内容猜测并设置 Content-Type 头信息值，默认为 False。

### COS_FILE_HEADERS

需要为文件设置的头信息字典，默认为 {}。

COS 默认只支持设置以下几种头信息：

- Cache-Control
- Content-Type
- Content-Disposition
- Content-Language
- Content-Encoding

### COS_STATIC_URL_USE_CDN

静态文件 URL 是否使用 CDN 地址，默认为 True。

### COS_STATIC_LOCATION

静态文件上传前缀地址，默认为 '/location'。
