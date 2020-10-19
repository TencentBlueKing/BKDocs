1\. 安装Proxy时分发文件超时（或已安装好Proxy，可以执行脚本作业，分发文件超时）

>   安装Proxy时填写的“通信IP”需要填写Proxy的外网IP，若填错则会出现问题中的情况。当网络策略未开通时，也会出现此情况。

2\. 安装Windows时任务超时卡住。

>   按以下步骤排查
```
	1.  检查文件共享相关服务，确认以下服务均已开启
	    - Function Discovery Resource Publication 
	    - SSDP Discovery 
	    - UPnP Device Host
	    - Server
	    - NetLogon // 如果没有加入域，可以不启动这个
	    - TCP/IP NetBIOS Helper
	2. 开启网卡 Net BOIS 
	3. 开启文件共享
	4. 检查防火墙是否有放开 139/135/445 端口
```
