# 环境准备

## 软件获取

-	下载安装包 [bkce_mini_install-5.1.26.tar.gz](https://bk.tencent.com/download/)


## 操作系统

- 建议使用 CentOS 7.x
```shell
cat /etc/redhat-release
或者
cat /etc/centos-release
```

-	内核版本在 3.10 以上
```shell
uname -r
```

-	查看内核是否开启 nat 模块，如未开启需开启
```shell
lsmod | grep 'iptable_nat'
```

-	关闭 selinux（/etc/sysconfig/selinux 的 SELINUX=disabled，并重启服务器）
```shell
setenforce 0  # 临时关闭
sed -i 's/^SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config  # 修改配置文件后，重启机器生效
```

## 用户权限
- 必须使用 root 用户权限执行

## 网络策略

如果只有 iptables 或 firewalld 服务器，无其他防火墙设备，安装脚本会自动放开端口无需处理，否则请放开以下端口：

-	被管控服务器(gse_agent) → 蓝鲸社区版 Server：

|协议|端口|
|:--:|:--:|
|TCP|58625，10020，59173，80，48533|
|UDP|10020，10030|

-	蓝鲸社区版 Server → 被管控服务器(gse_agent)

|协议|端口|
|:---:|:---:|
|TCP|60020|
|UDP|60020|

## docker 服务

-	如果服务器已经安装 docker，安装脚本会自动跳过 docker 安装步骤

-	安装脚本自动使用 yum 工具安装 docker 并启动 docker 服务

-	yum 工具安装或启动失败，安装脚本用安装包内自带 docker 安装

-	用自带 docker 安装包安装失败，建议用户手工安装
