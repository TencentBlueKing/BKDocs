## 离线部署

### YUM 源有 ISO 镜像文件时

1. 下载相关镜像文件。相关镜像下载链接请看文章末尾。

  - Centos7.x.iso

  - Centos7.x-epel.iso


2. 挂载到每台机器上：

    ```bash
    mkdir -p /mnt/centos7 /mnt/centos7-epel
    mount -t iso9660 xxxx.iso /mnt/centos7
    mount -t iso9660 xxx.iso /mnt/centos7-epel
    ```
3. 配置离线 repo。

    - /etc/yum.repos.d/offline-centos7.repo

        ```bash
        [offline-centos7]
        name=CentOS-$releasever - blueking
        baseurl=file:///mnt/centos7
        enabled=1
        gpgcheck=1
        gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
        ```

    - /etc/yum.repos.d/offline-centos7-epel.repo

        ```bash
        [offline-centos7-epel]
        name=CentOS-$releasever - blueking
        baseurl=file:///mnt/centos7-epel
        enabled=1
        exclude=epel-release
        gpgcheck=1
        gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
        ```

<!--
## YUM源无ISO镜像文件时

在一台有外网的centos 7机器上下载依赖的RPM：

```bash
depends=$(awk -F'[=()]' '/required/ { print $3 }' /data/install/dependences.env | sed 's/ /\n/g' | sort -u | xargs)
epel="nfs-client rpcbind rabbitmq-server nginx beanstalkd"
yum install yum-plugin-downloadonly yum-utils createrepo
mkdir /data/bk-rpms-root /data/bk-rpms
yum install --downloadonly --installroot=/data/bk-rpms-root --releasever=7 --downloaddir=/data/bk-rpms $depends $epel
createrepo --database /data/bk-rpms
rm -rf /data/bk-rpms-root
```

编辑 一个配置文件：

/etc/yum.repos.d/offline-bk.repo

```
[offline-bk]
name=CentOS-$releasever - blueking
baseurl=file:///data/bk-rpms
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
```

校验下是否有缺失的依赖：

repoclosure --repoid=offline-bk

将 /data/bk-rpms 目录打包压缩后，传到没有网络的centos7机器上，解压。同样拷贝
/etc/yum.repos.d/offline-bk.repo，到对应位置。

yum的离线配置DONE

查看来源于 epel repo的rpm包：

nginx,rabbitmq-server,beanstalk
```bash
yumdb search from_repo epel
-->

### PIP 包准备

PIP 包蓝鲸自带了离线包，所以无需单独下载。
不过 bkdata 和 fta 自带的包可能会和安装时的操作系统不匹配，导致安装失败。

在有网络环境下，可以用以下方式下载 pip 包：

```bash
mkdir /data/pip
pip download -d /data/pip -r requirements.txt
```

所以这里列举下蓝鲸 Python 工程的 requirements.txt 路径，以及下载离线包后应该存放的路径。


```bash
# bkdata 所需的 pip 包
src\bkdata\dataapi\requirements.txt
src\bkdata\monitor\requirements.txt

# 需要放到以下路径
src\bkdata\support-files\pkgs

# fta 角色所需的 pip 包
src\fta\fta\requirements.txt

# 需要放到以下路径
src\fta\support-files\pkgs

# open_paas 角色所需的 pip 包
src\open_paas\appengine\requirements.txt
src\open_paas\esb\requirements.txt
src\open_paas\login\requirements.txt
src\open_paas\paas\requirements.txt

# 需要放到以下路径
src\open_paas\support-files\pkgs

# paas_agent下的  pip 包其实时给 SaaS 部署用的。
src\paas_agent\paas_agent\requirements.txt

# 需要放到以下路径
src\paas_agent\support-files\pkgs
```

附： 相关镜像下载链接：
  - [CentOS7.2.1511_minimal_x86_64](http://bkopen-1252002024.file.myqcloud.com/dl/bk_offline_repo-7.2.1511.iso)

  - [CentOS7.3.1611_minimal_x86_64](http://bkopen-1252002024.file.myqcloud.com/dl/bk_offline_repo-7.3.1611.iso)

  - [CentOS7.4.1708_minimal_x86_64](http://bkopen-1252002024.file.myqcloud.com/dl/bk_offline_repo-7.4.1708.iso	)

  - [CentOS7.5.1804_minimal_x86_64](http://bkopen-1252002024.file.myqcloud.com/dl/bk_offline_repo-7.5.1804.iso)
