# 全文检索

首页的全文检索，可以帮助用户通过关键字搜索 CMDB 已有资源。

## 开启全文检索功能

默认情况下，CMDB 的全文检索功能是关闭状态，如下图所示，只开放了主机的搜索功能。

您可以修改 CMDB 的配置文件，重启进程以后开启全文检索。

![1589787054331](../media/1589787054331.png)

全文检索的开启方式：
登录至 CMDB 机器
```bash
source /data/install/load_env.sh
ssh $BK_CMDB_IP
```


```bash
在common.conf的[site]条目下修改full_text_search = true
然后重启进程即可
```
```bash
社区版 6.0 CMDB 开启全文检索在/data/bkce/cmdb/server/conf/common.yaml的[es]条目下修改full_text_search = on

```
重启 CMDB 服务
```bash
systemctl restart bk-cmdb.target
```

如果您没有部署监控日志套餐，则默认不会安装 es7，需手动安装es7：
```bash
cd /data/install
install.config 新增 es7 模块

[root@node01 install]# cat install.config
# 单点部署蓝鲸基础版
[basic]
192.168.0.180 consul,nginx,mongodb,mysql,zk(config),rabbitmq
192.168.0.180 paas,usermgr,iam,ssm,cmdb,job,nodeman(nodeman)
192.168.0.180 license,appo,gse,redis,es7


./bkcli install es7 # 安装 es7
./bkcli start es7 # 启动 es7


```
部署 Monstache（CMDB机器上执行）

版本需 >= 6.0.0

官方仓库：https://github.com/rwynn/monstache/releases

下载地址：https://github.com/rwynn/monstache/releases/download/v6.7.1/monstache-07f855c.zip

解压包
```bash
unzip monstache-07f855c.zip && mv build /usr/local/monstaches
```
进入到 monstaches 目录新增配置文件

```bash
cd  /usr/local/monstaches/linux-amd64
```

写入配置文件内容：(可参考开源部署文档)
```bash
source /data/install/utils.fc
```
# 注意  $BK_ES7_ADMIN_PASSWORD、$BK_CMDB_MONGODB_PASSWORD 是否有获取到
```bash
echo $BK_ES7_ADMIN_PASSWORD
echo $BK_CMDB_MONGODB_PASSWORD
```
```bash
cat > /usr/local/monstaches/linux-amd64/config.toml << EOF
mongo-url =  "mongodb://cmdb:$BK_CMDB_MONGODB_PASSWORD@mongodb.service.consul:27017/cmdb"
elasticsearch-urls = ["http://es7.service.consul:9200"]

direct-read-namespaces = ["cmdb.cc_ApplicationBase","cmdb.cc_HostBase","cmdb.cc_ObjectBase","cmdb.cc_ObjDes"]

change-stream-namespaces = ["cmdb.cc_ApplicationBase","cmdb.cc_HostBase","cmdb.cc_ObjectBase","cmdb.cc_ObjDes"]


gzip = true
elasticsearch-user = "elastic"
elasticsearch-password = "$BK_ES7_ADMIN_PASSWORD"
elasticsearch-max-conns = 4
dropped-collections = true
dropped-databases = true
resume = true
resume-write-unsafe = false
resume-name = "default"
resume-strategy = 0
verbose = true


[[mapping]]
namespace = "cmdb.cc_ApplicationBase"
index = "cmdb.cc_applicationbase"

[[mapping]]
namespace = "cmdb.cc_HostBase"
index = "cmdb.cc_hostbase"

[[mapping]]
namespace = "cmdb.cc_ObjectBase"
index = "cmdb.cc_objectbase"

[[mapping]]
namespace = "cmdb.cc_ObjDes"
index = "cmdb.cc_objdes"

EOF
```

启动 monstache
```bash
nohup ./monstache -f config.toml &
```
创建对应索引
```bash
source /data/install/load_env.sh
curl  -XPUT  -u elastic:$BK_ES7_ADMIN_PASSWORD   http://es7.service.consul:9200/cmdb.cc_applicationbase
curl  -XPUT  -u elastic:$BK_ES7_ADMIN_PASSWORD   http://es7.service.consul:9200/cmdb.cc_objdes
curl  -XPUT  -u elastic:$BK_ES7_ADMIN_PASSWORD   http://es7.service.consul:9200/cmdb.cc_hostbase
curl  -XPUT  -u elastic:$BK_ES7_ADMIN_PASSWORD   http://es7.service.consul:9200/cmdb.cc_objectbase

```
等待数据刷入至es索引



开启全文检索下图所示，会多出一个标签卡可切换到全文检索功能。

![1589787086178](../media/1589787086178.png)
