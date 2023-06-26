# 数据库与文件存储类数据库与文件存储类

### 怎么导出数据库里的数据？

目前，并非所有语言的应用都支持数据导出功能。

如果你是 Python 应用，可以参考下面的资料：[如何导出 Django 数据模型](../topics/tricks/py_how_to_export_django_models_data.md)

### 如何迁移其它数据库的内容到蓝鲸提供的数据库内？

可以参考这里：

[如何导出数据](../topics/tricks/py_how_to_export_django_models_data.md)

### 使用蓝鲸对象存储服务，在 devnet 上面手动上传文件失败

devnet 机器可以使用 s3cmd 访问, 请参考: [使用 s3cmd 访问 蓝鲸对象存储服务](../sdk/bkstorages/s3cmd.md)

### 使用 ceph 存储后，访问提示 NoSuchKey ，测试环境正常，正式环境异常。

NoSuckKey 是文件不存在。可能是正式环境存储容量已满，而导致文件没有传上去，可以自主扩容下。

