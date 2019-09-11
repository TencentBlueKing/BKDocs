## 环境准备

### 下载容器平台安装包

- [从官网下载容器平台安装包](https://bk.tencent.com/download_sdk/)

```bash
tar xf bkce_bcs-x.x.x.tgz  # 跟 src 保持同级目录
```

### 修改 install.config 配置



使用 sampl 文件 ( **install.config.new.sample** )，将下面的 bcs 相关配置追加到原 install.config 里面。

>**注意：** 部署 `BCS 蓝鲸平台机器不能与业务机器（k8s，mesos）混用`

**如下示例：**

```ini
[bcs-web]
10.0.0.4    bcs(web_console),bcs(cc),bcs(monitor),mysql01(bcs),thanos(query),devops(navigator)
10.0.0.5    bcs(grafana),devops(pm),harbor(api),harbor(server),thanos(rule)

[bcs-server]
10.0.0.6	zk01(bcs),etcd(bcs),mongodb01(bcs),bcs(api),bcs(storage),bcs(health-master),bcs(dns-service),bcs(health-slave),bcs(ops),iam(server)
10.0.0.7	zk01(bcs),etcd(bcs),mongodb01(bcs),bcs(api),bcs(storage),bcs(health-master),bcs(dns-service),bcs(health-slave),bcs(ops)
10.0.0.8	zk01(bcs),etcd(bcs),mongodb01(bcs),bcs(api),bcs(storage),bcs(health-master),bcs(dns-service),bcs(health-slave),bcs(ops)
```

> Note:
1. zk(config)，zk01(bcs) 属于两个不同的集群实例，用 01，02 等数字区域，生成的环境变量则统一通过标签区分。
2. devops(navigator) 和 harbor(server) 不能配置到相同的主机上。
3. bcs-server 部分的 etcd， zk，mongodb 都需要加上 bcs 标签识别。写法为：服务名(标识名)，如：etcd(bcs)。
4. 检查 globals.env 内的 redis 密码是否含有特殊字符，如果有需要去掉特殊字符，详情参考 [Redis 密码修改](https://docs.bk.tencent.com/bkce_maintain_faq/component/redis.html#%E4%BF%AE%E6%94%B9redis%E5%AF%86%E7%A0%81)
5. harbor，devops 不能与 nginx 相关部署在同一台。


### 修改 install/bcs/ports.env 配置

```bash
export BCS_MONITOR_IFACE="eth0"
```

> Note:
>
> 1. 登陆 install.config 中的 bcs(monitor) 模块所在的机器，查看该机器实际网卡名称并替换 BCS_MONITOR_IFACE 该变量的值。


### 修改 install/bcs/globals.env 配置

```bash
# 根据业务需求设置访问域名

export HARBOR_SERVER_FQDN=hub.$BK_DOMAIN
export DEVOPS_NAVIGATOR_FQDN=devops.$BK_DOMAIN
```
### 配置免密

```bash
bash  install/configure_ssh_without_pass  # 新增机器配置免密
```
### 配置本地 hosts

```bash
devops.<BK_DOMAIN>    devops(navigotr)所在IP
api-<DEVOPS_NAVIGATOR_FQDN>    devops(navigotr)所在IP
hub.<BK_DOMAIN>       harbor(server)所在IP
```
