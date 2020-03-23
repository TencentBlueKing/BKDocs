# 手动安装 Agent

- 下载 [GSE 安装包](https://bk.tencent.com/download_sdk/)到需要管控的服务器，目前只支持 64 位的 Linux 操作系统：

- 解压 GSE 安装包并安装
```shell
tar zxf bkce_mini_gse_agent-5.1.26.tar.gz
cd bkce5.1_mini_gse_agent 
./gse_agent_install.sh <本机 IP 地址> <蓝鲸社区版 server 的 IP 地址>
```

- 如果服务器上已经安装 gse_agent，需要重新安装的时候，加上 -f 参数即可
```shell
cd bkce5.1_mini_gse_agent
./gse_agent_install.sh <本机 IP 地址> <蓝鲸社区版 server 的 IP 地址> -f
```

- 安装过程脚本会先尝试 systemd 方式安装，失败后会用使用 crontab 方式安装启动

- 安装成功结果如下，安装失败后请根据错误提示手工解决后再次执行安装脚本安装：
![](./../images/hand_install_agent.png)


## 管理 GSE Agent

### system 管理 GSE Agent
- 启动 gse_agent 服务：
```shell
systemctl start gse_agent
```
- 停止 gse_agent 服务：
```shell
systemctl stop gse_agent
```
- 获取 gse_agent 服务状态：
```shell
systemctl stop gse_agent
```
- 重启 gse_agent 服务：
```shell
systemctl restart gse_agent
```

### gsectl 管理 GSE Agent
- 启动 gse_agent 服务：
```shell
/usr/local/gse/agent/bin/gsectl start agent
```

- 停止 gse_agent 服务：
```shell
/usr/local/gse/agent/bin/gsectl stop agent
```
- 添加 gse_agent 定时任务：
```shell
* * * * * /usr/local/gse/agent/bin/gsectl watch
```
