# 社区版 CICDKit 部署指南

1. 官网下载 **V1.0.0 CICDKit 软件包** 和 **bkce_install_cicdkit-1.0 脚本安装包**

    >注意：部署 CICDKit 属于增值部署，需提前部署好蓝鲸基础社区版环境，脚本需基于 V1.4.13 版本之上部署

    ```bash
    tar -xf bkce_cicdkit-1.0.0.tgz -C /data
    tar -xf install_ce-cicdkit_fix-1.0.2.tar -C /data
    ```

2. 安装 CICDKit 的机器可用配置不能低于 4C8G，系统版本不能低于 Centos7.0，建议单独一台机器部署

3. 修改配置：
    - 中控机 install/third/globals_cicdkit.env 域名信息(CICDKIT_FQDN)
    - install.config 新增 CICDKit 及其依赖的 mysql5.7 的配置

      ```txt
      10.0.0.0 mysql57,cicdkit  
      ```
4. 安装 CICDKit 后台

   ```bash
   ./bkcec sync common
   ./bkco_install cicdkit

   # 配置每台机器的hosts
   #该解析只供ESB解析使用，和cicdkit-saas嵌套的sonarqube使用
   source /data/install/utils.fc
   echo $CICDKIT_FQDN  #测试是否能获取到正确值,默认为：cicdkit.bk.com
                       #若不能可多执行一次source
   for ip in ${ALL_IP[@]};do
     ssh $ip "echo $CICDKIT_IP $CICDKIT_FQDN >>/etc/hosts"; done
     #检查/etc/hosts/的cicdkit解析域名是否正常

   #重启进程
   ./bkcec stop cicdkit self
   ./bkcec start cicdkit self
   ```

5. 从 S-mart 市场下载[CICDKit-Saas](http://bk.tencent.com/s-mart)部署，cicdkit 的持续部署功能依赖`标准运维V3`版本
