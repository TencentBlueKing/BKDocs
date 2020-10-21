# 社区版 6.0 集成部署

## 一、安装前准备

### 解压相关资源包

1. 解压 src 包

   ```bash
   tar xvf bkce_product_6.xxxx.tgz -C /data
   ```

2. 解压 src包下的子包

   ```bash
   cd /data/src/; for f in *gz;do tar xf $f; done
   ```

2. 解压 python 包

   ```bash
   tar xvf bk_python-1.0.0.tgz -C /data/src
   ```

3. 解压 image 包

   ```bash
   tar xvf bk_image-1.0.3.tgz -C /data/src
   ```

4. 解压 rpm 包

   ```bash
   tar xvf bk_rpm-1.0.1.tgz -C /opt
   ```

5. 解压脚本包

   ```bash
   tar xvf install_ce-xxxx.tgz -C /data
   ```
   
6. 解压证书包（证书包需要从官网根据提示要求下载）

    ```bash
	mkdir /data/src/cert
	tar xvf ssl_certificates.tar.gz -C /data/src/cert/
    chmod 644 /data/src/cert/*
	```

7. 放置java8.tgz到 /data/src下，以tencent的jdk为例：

    ```bash
    wget https://github.com/Tencent/TencentKona-8/releases/download/v8.0.1-GA/TencentKona-8.0.1-242.x86_64.tar.gz -O /data/src/java8.tgz 
    ```

### 自定义安装配置

以下操作均相对/data/install/目录

1. 根据 install.config.3ip.simple 和当前机器资源合理分配，新增 install.config

   ```bash
   cp install.config.3ip.simple install.config
   vim install.config # 根据实际机器ip编辑
   ```

2. 对install.config中的主机执行ssh免密，需要依次输入每台机器的密码

   ```bash
   bash ./configure_ssh_without_pass
   ```

3. 自定义环境变量

   * 将需要修改的环境变量写入 $CTRL_DIR/bin/03-userdef 目录下对应的模块文件中

   * 对应存储组件和密码自定义也需提前定义

     * 域名修改示例

       ```bash
       cat << EOF >/data/install/bin/03-userdef/global.env
       BK_HOME=/data/bkce
       BK_DOMAIN=bk.com
	   BK_HTTP_SCHEMA=http
       BK_PAAS_PUBLIC_ADDR=paas.bk.com:80
       BK_PAAS_PUBLIC_URL=http://paas.bk.com:80
       BK_CMDB_PUBLIC_ADDR=cmdb.bk.com:80
	   BK_CMDB_PUBLIC_URL=http://cmdb.bk.com:80
       BK_JOB_PUBLIC_ADDR=job.bk.com:80
       BK_JOB_PUBLIC_URL=http://job.bk.com:80
       BK_JOB_API_PUBLIC_URL="http://api.job.bk.com:80"
       EOF
       ```

## 二、开始部署

1. 依赖资源部署, 生成环境最终部署环境变量，安装服务器所需资源，部署本地 yum 源并配置所有蓝鲸服务器

   ```bash
   ./bk_install common
   ./health_check/check_bk_controller.sh
   ```

2. 部署 PaaS 

   ```bash
   ./bk_install paas
   ```

5. 部署 app_mgr

   ```bash
   ./bk_install app_mgr
   ```

3. 部署 CMDB

   ```bash
   ./bk_install cmdb
   ```

4. 部署 Job

   ```bash
   ./bk_install job
   ```

6. 部署 bknodeman

   ```bash
   ./bk_install bknodeman
   ```
   
7. 部署 bkmonitorv3 

   ```bash
   ./bk_install bkmonitorv3
   ```

8. 部署 bklog 

   ```bash
   ./bk_install saas-o bk_log_search
   ./bk_install bklog
   ```

9. 部署 fta 

   ```bash
   ./bk_install fta
   ```
10. 部署SaaS
   
    ```bash
    ./bk_install saas-o bk_iam
    ./bk_install saas-o bk_user_manage
    ./bk_install saas-o bk_sops
    ./bk_install saas-o bk_itsm
    ./bk_install saas-o bk_fta_solutions
    ```



## 三、环境验证

- 脚本检测

```shell
# 进入到脚本目录，如果不是在/data下，请自行修改
cd /data/install/
./health_check/check_paas.sh
./health_check/check_job.sh
./health_check/check_gse.sh
```

- 进入到节点管理，检查 Agent 是否能够安装 


![](../images/1.png)

填写相关信息

![](../images/2.png)

安装完成后，状态会呈现 “正常” 状态，异常可通过最新执行日志查看原因

![](../images/3.png)

- 查看监控数据是否上报

![](../images/5.png)

如果数据未上报，请检查自监控的状态

![](../images/4.png)









