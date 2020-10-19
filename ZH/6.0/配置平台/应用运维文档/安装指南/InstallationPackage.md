# 安装包

安装包名：cmdb_ee-x.x.x.tgz

```bash
+--- errors    ---- 错误码语言包
+--- server
|   +--- bin   ----  cmdb 二进制文件
|   +--- conf  ----  cmdb 配置文件
+--- support-files
|   +--- templates ---- 配置文件模板
|   |   +--- #etc#admin.conf
|   |   +--- #etc#nginx#cmdb.conf
|   |   +--- #etc#nginx.conf
|   |   +--- #etc#supervisor-cmdb-server.conf
|   |   +--- server#conf#apiserver.conf
|   |   +--- server#conf#auditcontroller.conf
|   |   +--- server#conf#datacollection.conf
|   |   +--- server#conf#eventserver.conf
|   |   +--- server#conf#host.conf
|   |   +--- server#conf#hostcontroller.conf
|   |   +--- server#conf#migrate.conf
|   |   +--- server#conf#objectcontroller.conf
|   |   +--- server#conf#proc.conf
|   |   +--- server#conf#proccontroller.conf
|   |   +--- server#conf#topo.conf
|   |   +--- server#conf#webserver.conf
+--- VERSION  ---- 安装包版本信息文件
+--- web      ---- 前端 UI 文件
```
