## 安装部署 {#setup}

1. **安装社区版**

  - 安装社区版5.1， 并部署好标准运维，权限中心等 SaaS
  > 1. 安装前注意调整 globals.env 的各类米看吗
  > 2. nginx 需要1.1.0+以上版本
  > 3. openssl 需要1.0.2以上版本

  - 安装步骤请参考基础包安装指南（链接待补充）
  > Note：若安装时选择了https模式，并且证书是自签名的（默认自带方式安装的证书），需要在浏览器中将证书添加到可信任列表中

  - 导入标准运维作业模版

    1. 管理员账号登录标准运维
    2. 执行导入
    3. 导入时选择保留ID

2. **安装后台**

  - 准备yum源
      在部署bcs的第一个步骤中，需要初始化中控机的docker环境，脚本会自动添加docker官方yum源来安装docker-ce 所以需要保证服务器到外网的连通性，保证以下命令可用：

  ```bash
  yum install -y yum-utils device-mapper-persistent-data lvm2
  yum-config-manager --add-repo \
  https://download.docker.com/linux/centos/docker-ce.repo
  yum -y install docker-ce
  ```

  - 对新增的机器配置免密登录

  ```bash
  bash configure_ssh_without_pass
  ```

  - 使用集成安装方式：

  ```bash
  ./bk_install bcs
  ```

  > 步骤说明：
  > 1. 该步骤首先初始化容器环境，添加docker yum源并安装启动docker
  > 2. 若社区版是运行了一段时间后，新加入一批主机到install.config中用于部>>署bcs，则接下来需要为新的机器上做免密登陆，安装consul，同步基础开源组件包等步骤
  > 3. 同步所有依赖额服务包
  > 4. 安装mysql，zk，etcd，mongodb等
  > 5. 安装iam
  > 6. 安装harbor, 导入镜像
  > 7. 安装并初始化bcs，devops，thanos等服务
  > 8. 启动各服务进程
  > 9. 安装saas

**在启动etcd的步骤，可能卡住，出现这种情况时，按一次CTRL-C. 跳过。若该步骤退出，重新执行即可。**