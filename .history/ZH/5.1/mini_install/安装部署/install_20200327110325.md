# 部署安装

- 在符合环境要求的服务器上，将下载的软件包解压:
```shell
tar zxf bkce_mini_install-5.1.26.tar.gz
```

- 进入安装目录 bkce_mini_5.1，并执行安装脚本:
```shell
cd bkce_mini_5.1
./install_bkce5.1-mini_for_docker.sh <本机 IP> 
# 本机 IP:用于与被管控的服务器（安装有 GSE_Agent 的服务器）进行网络通讯，一般使用内网 IP 会更安全
```

- 安装成功后会提示 **BK web page access instructions**，否则会提示安装错误信息，请解决完错误后，再次执行 install_bkce5.1-mini_for_docker.sh 脚本即可
![install](./../images/install.png)

- 安装完成后，数据默认保存在 /data/bk_data 目录中，**请勿动该目录，防止数据丢失，用户也可以自行修改数据目录位置。**
![change_data_dir](./../images/change_dir.png)

- 在需要访问的蓝鲸页面的电脑上添加域名映射，此服务器必须可以访问到蓝鲸社区版 5.1 mini 体验版 服务器的 HTTP 端口（80 端口），Linux 和 MacBook 编辑 **/etc/hosts** 文件，Windows 编辑 **C:\Windows\System32\drivers\etc\hosts** 文件，添加以下内容：
```shell
bk_server_ip paas.bk.com
bk_server_ip job.bk.com
bk_server_ip cmdb.bk.com
```
bk_server_ip 是你刚刚安装蓝鲸社区版5.1 mini体验版 的服务器 IP(如果无法通过内网 IP 访问服务器的 80 端口，这里需要配置外网 IP)，例如：
```shell
192.168.1.100 paas.bk.com
192.168.1.100 job.bk.com
192.168.1.100 cmdb.bk.com
```

