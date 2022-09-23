# 安装步骤

## 工作目录初始化

## 创建公共目录

在服务器上创建公共目录。

`${BK_HOME}/cmdb`

## 解压 cmdb_ee-x.x.x.tgz

到`${BK_HOME}/cmdb`目录下，将安装包解压出来。

## 安装 supervisord

略，具体在蓝鲸企业版公共组件中会提供

## 修改配置文件

修改`${BK_HOME}/cmdb/support-files/templates`目录下的配置文件，要根据依赖的外部服务修改，`supervisor-cmdb-server.conf`置于`{BK_HOME}/etc`下，server#conf#*前缀的文件置于`${BK_HOME}/cmdb/server/conf`下

## 启动 CMDB 服务器

依次按以下步骤执行命令：
- 用 supervisor 启动 CMDB 服务：`supervisord -c ${BK_HOME}/etc/supervisor-cmdb-server.conf`
- 检查 12 个 CMDB 进程是否已经启动
- 初始化数据库：请求`{server_ip:port}/migrate/v3/migrate/enterprise/0`
- 打开浏览器确认页面正常显示
