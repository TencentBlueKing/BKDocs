# 基础套餐单机部署

> 单机部署仅作为部署体验用，建议管控主机 10 台以内

## 环境准备

- 准备一台 CentOS 7.6 及以上操作系统的机器 (物理机和虚拟机均可，建议配置 8C 16G 100G 硬盘)。

- 按照安装 [环境准备](../../基础包安装/环境准备/get_ready.md) 章节中，主机和系统环境的要求做好相应设置。

- 配置好 YUM 源，包含 EPEL 仓库(可以通过 `yum info pssh` 测试下)。

- 从 [官网下载](http://bk.tencent.com/download/) 基础套餐，并解压到 /data 下。实际版本请以蓝鲸官网下载为准。

    ```bash
    tar xf bkce_basic_suite-6.1.1.tgz -C /data
    ```

  - 获取机器的 MAC 地址后，下载 [证书文件](https://bk.tencent.com/download_ssl/)，解压到 /data/src/cert 目录下

    ```bash
    install -d -m 755 /data/src/cert
    tar xf ssl_certificates.tar.gz -C /data/src/cert
    chmod 644 /data/src/cert/*
    ```

  - 解压各个产品软件包

    ```bash
    cd /data/src/; for f in *gz;do tar xf $f; done
    ```

  - 拷贝 rpm 软件包

    ```bash
    cp -a /data/src/yum /opt
    ```

- 修改 /data/install/bk_install 脚本

```bash
 cd /data/install/
 sed -i '/start job/i\\t./pcmd.sh\ -m\ job\ \"sed -i '\'/JAVA_OPTS/c\ JAVA_OPTS="-Xms128m -Xmx128m"\'\ /etc/sysconfig/bk-job-*\" bk_install
```

- install.config 这个文件安装脚本会自动生成，无需自行配置。

## 执行安装

如果部署全部组件，请执行：

```bash
cd /data/install
./install_minibk -y
```

[单机部署常见报错](https://bk.tencent.com/s-mart/community/question/5658?type=answer)

安装过程中遇到失败的情况，请先定位排查解决后，再重新运行失败时的安装指令。

执行完部署后，执行降低内存消耗脚本。以确保环境的稳定

```bash
# 执行降低内存消耗脚本
bash bin/single_host_low_memory_config.sh tweak all
```

## 加载蓝鲸相关维护命令

```bash
source ~/.bashrc
```

## 初始化蓝鲸业务拓扑

```bash
./bkcli initdata topo
```

[初始业务拓扑常见报错](https://bk.tencent.com/s-mart/community/question/5417?type=answer)

## 访问蓝鲸

> 下面介绍的操作均可能覆盖现有 hosts ，进行操作前请先确认是否需要备份。

### 配置 host

1. Windows 配置

    用文本编辑器（如 `Notepad++`）打开文件：

    ```bash
    C:\Windows\System32\drivers\etc\hosts
    ```

    将以下内容复制到上述文件内，并将以下 IP 需更换为本机浏览器可以访问的 IP，然后保存。

    ```bash
    10.0.0.2 paas.bktencent.com cmdb.bktencent.com job.bktencent.com jobapi.bktencent.com
    10.0.0.3 nodeman.bktencent.com
    ```

    **注意：** 10.0.0.2 为 nginx 模块所在的机器，10.0.0.3 为 nodeman 模块所在的机器。IP 需更换为本机浏览器可以访问的 IP。

    查询模块所分布在机器的方式：

    ```bash
    grep -E "nginx|nodeman" /data/install/install.config
    ```

    > 注意：如果遇到无法保存，请右键文件 hosts 并找到“属性” -> “安全”，然后选择你登录的用户名，最后点击编辑，勾选“写入”即可。

2. Linux / Mac OS 配置

    将以下内容复制到 `/etc/hosts` 中，并将以下 IP 需更换为本机浏览器可以访问的 IP，然后保存。

    ```bash
    10.0.0.2 paas.bktencent.com cmdb.bktencent.com job.bktencent.com jobapi.bktencent.com
    10.0.0.3 nodeman.bktencent.com
    ```

### 获取管理员账户名密码

在任意一台机器上，执行以下命令，获取管理员账号和密码。

```bash
grep -E "BK_PAAS_ADMIN_USERNAME|BK_PAAS_ADMIN_PASSWORD" /data/install/bin/04-final/usermgr.env
```

## 日常维护

日常维护和运维，单机部署和多机是一致的，请参考 [维护文档](../../维护手册/日常维护/maintain.md)。

## 使用蓝鲸

可参考蓝鲸 [快速入门](../../../../../QuickStart/7.0/quick-start-v7.0-info.md) 以及相关 [产品白皮书](https://bk.tencent.com/docs/)

如需部署监控日志套餐，请参考 [监控日志套餐部署](../多机部署/value_added.md) 。
