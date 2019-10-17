# 部署常见问题

## 部署 PaaS 常见问题

## 部署 CMDB 常见问题

### prot 31001 start failed，please check 先检查 cmdb 服务状态

![](../assets/cmdb-31001.png)
./bkcec status cmdb 若服务装状态都是 RUNNING 则 dig zk.service.consul 查看能否解析（非单机部署） dig 服务名.service.consul 解析异常处理方法：

 1.1、检查内部域名解析，运行 dig 域名 @127.0.0.1 看是否能解析，如果不能解析，说明 consul 有问题 
 1.2、检查 consul 服务是否正常
 1.3、检查三台服务器 resolv.conf  首行是否有配置 nameserver 127.0.0.1，如无，请添加
 1.4、重启或重装 consul 服务
 
```bash
./bkcec stop consul  #(或在consul服务所在的三台主机，ps -ef |grep consul | awk '{print $2}'  |xargs kill -9)
./bkcec install consul 1
./bkcec start consul

```


### 若安装 consul 报错
 
2.1 检查/data/src/service/consul/是否有这两个文件夹 bin ，conf；bin 文件夹下是否有文件
 2.2 备份一下 src 下的.pip/pip.conf 文件，然后重新解压一下 bkce_src 安装包，继续检查是否有文件，如果还没有
 2.3 解压时直接用 tar xf 包名，不要加-C，还没有文件去官网下载新包重新解压
 2.4 对比包的 md5 是否和官网一致
 2.5 检查防火墙端口是否有开（8300，8301，8302）
 2.6 查看日志，登录所在机器的路径：/data/bkce/logs

### cmdb-adminserver 服务状态 failed 
 3.1.检查依赖服务是否正常 redis mongodb nginx gse zk 
 3.2.查看 cmdb-adminserver 日志（/data/bkce/logs/cmdb/）

### 检查 cmd b 服务进程，参照下图
```bash
./bkcec status cmdb

```
![](../assets/cmdb-faq.png)


### cmdb-nginx 服务状态 failed 
 5.1 检查 yum info nginx 
 5.2 安装 epel yum 源, 重装 cmdb

```bash
./bkcec stop cmdb 
./bkcec install cmdb 1 
./bkcec start cmdb 
./bkcec initdata cmdb

```
三台机器的 yum 源都更新一致，确保 yum 源能安装 nginx
其他进程状态 EXIT，请前往 cmdb 所在服务器
/data/bkce/logs/cmdb/目录下查看相应的日志


## 部署 JOB 常见问题



## 部署 App_mgr 常见问题

![](../assets/saas-faq.png)

该报错是激活 paas_agent 失败，需要查看的是 appo 还是 appt，再检查进程是否正常。
```bash
./bkcec status appo
./bkcec status appt 
```
若是异常重启进程，启动失败需要查看日志详情/data/bkce/logs/paas_agent/
进程正常启动后再激活
```bash
./bkcec activate appo
./bkcec activate appt
```
## 部署 BKDATA 常见问题

### MySQL-python 安装失败

./bk_install bkdata 报错原因：
- 系统缺乏对应的库文件；
- 版本不对应；
- 库文件的链接错误；
- 库文件路径设置问题； 

![](../assets/bkdata-faq1.png)

- 解决方案：

1. 确保 mysql-devel 已经安装
可用 which mysql-devel 来确认

2. 建立软连接
```bash
ln -s /usr/lib64/mysql/libmysqlclient_r.so /usr/lib/libmysqlclient_r
ln -s /usr/lib64/mysql/libmysqlclient.so /usr/lib/libmysqlclient.so
ln -s /usr/lib64/mysql/libmysqlclient.so.18 /usr/lib/libmysqlclient.so.18
ln -s /usr/lib64/mysql/libmysqlclient.so.18.0.0 /usr/lib/libmysqlclient.so.18.0.0
```
![](../assets/bkdata-faq2.png)

重新部署 bkdata 即可恢复

### 安装 python-snappy 包失败

原因是缺少 snappy-c.h 导致 pip 安装 python-snappy 包失败

![](../assets/bkdata-faq3.png)

- 解决方案：

    通过安装 snappy-devel 解决,yum install -y snappy-devel 

### 启动报 "dataapi.service.consul start failed ERROR： init_snapshot_config"  

启动 bkdata 报错：dataapi.service.consul start failed ERROR： init_snapshot_config (databus.tests.DatabusHealthTestCase) 
![](../assets/bkdata-faq4.png)

- 解决方案
    登陆到 bkdata 机器（社区版 5.1 登陆到 databus 所在机器）查看 consul 配置是否生成 databus.json 配置。
    
    ```bash
    /data/bkce/etc/consul.d/bkdata.json 
  
    # 若无则重装consul
    ./bkcec stop consul
    ./bkcec install consul 1
    ./bkcec start consul
    ./bkcec status consul
  
    # 登陆到databus所在机器查看
    ls /data/bkce/etc/consul.d/bkdata.json
  
    # 启动 bkdata
    ./bkcec start bkdata
   ```

## 部署 SaaS 常见问题

**安装 saas-o 报错 KeyError: "name='bk_csrftoken', domain=None, path=None"**
![](../assets/saas-key.png)

- 解决方案
确认是否是在 PaaS 页面个人信息重置了密码后，但是 `globals.env` 文件没同步更新。 请在 `globals.env` 文件中更新重置后的密码后确认是否恢复正常。
```bash
./bkcec sync common
```




 