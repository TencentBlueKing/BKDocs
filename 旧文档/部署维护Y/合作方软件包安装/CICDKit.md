## CICDKit

1. 官网下载 **V1.0.0 CICDKit软件包** 和 ** bkce_install_cicdkit-1.0脚本安装包**
    >注意：部署CICDKit，脚本需基于V1.4.13版本上部署

    ```bash
    tar -xf bkce_cicdkit-1.0.0.tgz -C /data
    tar -xf install_ce-cicdkit_fix-1.0.2.tar -C /data
    ```

2. 安装CICDKit的机器可用配置不能低于4C8G，系统版本不能低于Centos7.0，建议单独一台机器部署

3. 修改配置：
    - 中控机install/third/globals_cicdkit.env 域名信息(CICDKIT_FQDN)
    - install.config 新增cicdkit及其依赖的mysql5.7的配置

      ```txt
      10.0.0.0 mysql57,cicdkit  
      ```
4. 安装CICDKit后台

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
   
   #重启进程
   ./bkcec stop cicdkit self
   ./bkcec start cicdkit self
   ```

5. 从S-mart市场下载 [CICDKit-SaaS](http://bk.tencent.com/s-mart) 部署，CDDIKit的持续部署功能依赖 [标准运维 V3](http://bk.tencent.com/s-mart) 版本