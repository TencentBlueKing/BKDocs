## 容器管理平台使用前准备 {#getready}

### 资源下载  {#bcsdownload}

- 增值包： [bkce_bcs-1.0.7.tar.gz](http://bkopen-1252002024.file.myqcloud.com/upload_files/bkce_bcs-1.0.7.tar.gz)（该包仅适用于在已安装社区版5.1的基础上安装bcs时适用的bcs包，不包含社区版的基础安装包）

- 下载包：[bcs_cluster-ce-190507.tar.gz](http://bkee-1252002024.file.myqcloud.com/bcs/bcs_cluster-ce-190507.tar.gz)（724M, 集群服务所需）

- 标准运维作业模板：[bksops_bcs_cluster-ce-190521.dat](http://bkee-1252002024.file.myqcloud.com/bcs/bksops_bcs_cluster-ce-190521.dat)

- 蓝鲸容器管理平台 [白皮书](https://docs.bk.tencent.com/bcs/)

### 配置hosts

在个人电脑的 hosts 中配置

```
devops.<BK_DOMAIN> devops(navigotr)所在IP
api-devops.<BK_DOMAIN> devops(navigotr)所在IP
hub.<BK_DOMAIN> harbor(server)所在IP
```

2. 容器管理平台使用前准备

>　集群机器需使用CentOS 7.4及以上版本OS 并确保带有NAT模块

  - 解压集群层脚本安装包至miniweb目录下
  ```bash
  source ${CTRL_DIR}/utils.fc
  # 解压集群层脚本安装包至miniweb目录下
  ssh $NGINX_IP "tar xf bcs_cluster-ce-190507.tar.gz -C ${INSTALL_PATH}/miniweb/"
  ```

  - BCS 业务集群支持K8S，MESOS


3. 打开PaaS, 点击容器管理平台SaaS，开始使用容器管理平台，请参考 [指引文档](https://docs.bk.tencent.com/bcs/Container/QuickStart.html)
