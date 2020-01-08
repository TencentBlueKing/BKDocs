# 手动安装 Agent 使用脚本
## 直连区域AIX

AIX 上 Agent 的 安装与 Windows 类似，都是从 Server 把包推到 AIX 机器上，然后执行脚本安装。差别在于推送和远程执行都是通过 ssh。

aix 要推送的文件有两个，一个安装包，一个脚本。
执行安装前需要保证 AIX 机器上有 tar 解压工具。

在 Nginx 服务器的 miniweb/download 目录执行一下命令。**注意自行替换命令中的 IP**
```bash
root@nginx-1 download#
root@nginx-1 download#
root@nginx-1 download# ssh root@10.0.0.1 -p 22 mkdir /tmp/byproxy
root@nginx-1 download# scp gse_client-aix_powerpc.tgz agent_setup_aix.ksh root@10.0.0.1:/tmp/
root@nginx-1 download# ssh root@10.0.0.1 "sh /tmp/agent_setup_aix.ksh -m client -i 0"
```
