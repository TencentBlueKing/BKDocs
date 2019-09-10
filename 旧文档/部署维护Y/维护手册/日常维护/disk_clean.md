### 磁盘清理 {#disk_clean}

可能产生比较大数据量的目录有：

- /data/bkce/logs

- /data/bkce/public

- /data/bkce/service

logs 目录可以按需设置自动清理N天前的日志。

public 目录一般不能手动删除，一般比较大的组件可能有

* MySQL 数据库太大
* Kafka 数据
* Elasticsearch 数据