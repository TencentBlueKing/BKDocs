## CICDKit

### 环境准备
1. 官网下载 [CICDKit 软件包](https://bk.tencent.com/download_sdk/) 和  [CICDKit 脚本安装包](https://bk.tencent.com/download_sdk/)
>注意：部署 CICDKit 属于增值部署，需提前部署好蓝鲸基础社区版环境，脚本需基于 V1.4.13 版本之上部署。

    ```bash
    tar -xf bkce_cicdkit-1.0.0.tgz -C /data
    tar -xf install_ce-cicdkit_fix-1.0.2.tar -C /data
    ```

2. 安装 CICDKit 的机器可用配置不能低于 4C8G，系统版本不能低于 Centos 7.0，建议单独一台机器部署。

3. 修改配置：

    - **注意：** 请勿将 MySQL 57 同蓝鲸的 MySQL 部署在同一台机器上。
    - 中控机 install/third/globals_cicdkit.env 域名信息 (CICDKIT_FQDN)。

    - install.config 新增 cicdkit 及其依赖的 mysql 5.7 的配置。

      ```bash
      10.0.0.0 mysql57,cicdkit  
      ```

### 安装 CICDKit 后台

开始安装
```bash
./bkcec sync common
./bkco_install cicdkit
```
配置每台机器的 hosts，该解析只供 ESB 解析使用，和 cicdkit-saas 嵌套的 sonarqube 使用。
```bash
source /data/install/utils.fc
echo $CICDKIT_FQDN  #测试是否能获取到正确值,默认为：cicdkit.bk.com
                    #若不能可多执行一次 source
for ip in ${ALL_IP[@]};do
  ssh $ip "echo $CICDKIT_IP $CICDKIT_FQDN >>/etc/hosts"; done
```

重启进程

```bash
./bkcec stop cicdkit self
./bkcec start cicdkit self
 ```

- 从 S-mart 市场下载 [CICDKit-SaaS](http://bk.tencent.com/s-mart) 部署，CICDKit 的持续部署功能依赖 [标准运维 V3](http://bk.tencent.com/s-mart) 版本
