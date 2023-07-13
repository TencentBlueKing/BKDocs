### Linux 手动卸载 Agent
1、节点管理 - 移除 agent 

![](../assets/001.png)

2、到配置平台把主机删除（如果需要重装 agent 并且是安装在同一个业务下，可以不删除）

 ```bash 
  把主机转移到空闲机—>转移到主机池, 切换到主机池删除即可 
  ``` 

3、停进程
```bash
/usr/local/gse/agent/bin/gsectl stop
```
4、删目录
```bash
rm -rf /run/gse
rm -rf /var/lib/gse
rm -rf /var/log/gse
rm -rf /use/local/gse
```
<br/>

### Windows 手动卸载 Agent

1、节点管理 - 移除 agent 

![](../assets/001.png)

2、到配置平台把主机删除（如果需要重装 agent 并且是安装在同一个业务下，可以不删除）

  ```bash 
  把主机转移到空闲机—>转移到主机池, 切换到主机池删除即可 
  ```

3、停服务
```bash
cd c:\gse\agent\bin
gsectl.bat stop agent
```

![16530466032174](../assets/16530466032174.png)



4、删目录

![](../assets/1653046582122.png)
