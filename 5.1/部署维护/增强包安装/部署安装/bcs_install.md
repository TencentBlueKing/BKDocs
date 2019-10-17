# 安装部署

> 首先保证基础平台安装完成后，在安装容器管理平台

**安装社区版**

- 安装社区版 5.1， 并部署好标准运维等 SaaS

    > 1. 安全前注意调整 globals.env 中的各类密码，不能带有特殊字符。详情查看 [环境准备-globals.env](../../基础包安装/环境准备/get_ready.md#globals)。
    > 2. nginx 需要 1.10 + 以上。
    > 3. openssl 需要 1.0.2 以上版本。

- 安装步骤略
    > Note: 若安装时选择了 https 模式，并且证书是自签名的(默认自带方式安装的证书)，需要在浏览器中将证书添加到可信任列表中。


**安装后台**

准备 YUM 源。在部署 bcs 的第一个步骤中，需要初始化中控机的 docker 环境。脚本会自动添加 docker 官方 YUM 源来安装 docker-ce 所以需要保证服务器到外网的连通性，保证以下命令可用：

```bash
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce
```

- 使用集成安装方式：

```bash
  ./bk_install bcs

  步骤说明：
  1. 该步骤首先初始化容器环境，添加 docker yum 源并安装启动 docker。

  2. 若社区版是运行了一段时间后，新加入一批主机到 install.config 中用于部署 bcs，则接下来需要为新的机器上做免密登陆，安装 consul，同步基础开源组件包等步骤。

  3. 同步所有依赖额服务包。

  4. 安装 MySQL，ZK，etcd，MongoDB 等。

  5. 安装 iam。

  6. 安装 Harbor，导入镜像。

  7. 安装并初始化 bcs，devops，thanos 等服务。

  8. 启动各服务进程。

  9. 安装 SaaS。
```

> 在启动 etcd 的步骤，可能卡住，出现这种情况时，按一次 `CTRL+C`。跳过

- 打开 PaaS，点击容器管理平台，开始使用容器管理平台，请参考 [容器管理平台白皮书](5.1/bcs/Introduction/README.md)
