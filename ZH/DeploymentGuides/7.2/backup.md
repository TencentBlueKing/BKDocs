TODO 临时占位文件。


# 备份部署脚本

备份当前的 部署 目录
```bash
cp -a -r ${$INSTALL_DIR%/}{,$(date +%Y%m%d-%H%M%S).bak}
```

# 备份数据库

## MySQL

### 蓝鲸公共实例 bk-mysql


### 蓝鲸其他 MySQL 实例
可以参考上述方法进行。


### 自定义 MySQL 服务
你的自定义存储服务需要自行备份。

可以借鉴上述文档，使用 `mysqldump` 命令或者其他工具完成备份。


## MongoDB

### 蓝鲸公共实例 bk-mongodb


### 蓝鲸其他 MongoDB 实例
可以参考上述方法进行。


### 自定义 MongoDB 服务
你的自定义存储服务需要自行备份。

可以借鉴上述文档，使用 `mongodump` 命令或者其他工具完成备份。

# 备份其他资源

