### Linux 手动卸载 Agent
1、停进程
```bash
 /usr/local/gse/agent/bin/gsectl stop
```
2、删目录
```bash
rm -rf /run/gse
rm -rf /var/lib/gse
rm -rf /var/log/gse
rm -rf /use/local/gse
```
<br/>

### Windows 手动卸载 Agent

1、停服务
```bash
cd c:\gse\agent\bin
gsectl.bat stop agent
```

![16530466032174](../assets/16530466032174.png)



2、删目录

![](../assets/1653046582122.png)