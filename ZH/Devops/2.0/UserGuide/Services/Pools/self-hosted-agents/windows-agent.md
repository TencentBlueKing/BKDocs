# 导入Windows构建机

> 1. 托管前，请先准备好执行环境：[私有构建机环境准备](../prepara-agent.md)
> 2. **如果您的windows构建需要在流水线中启动UI程序**（比如打开浏览器做自动化测试），请参阅[windows agent启动界面程序的解决办法](windows-agent-run-ui.md)）
> 3. agent资源是按项目隔离的，如果多个项目导入私有构建机，需要在不同的项目下各自导入agent，安装在不同的目录下。（每个agent的安装包/安装脚本是不一样的）

## 在BKCI获取Agent包

根据[将你的构建机托管至 BKCI](../host-to-bkci.md) 指引，选择Windows，下载Agent包

## 在Windows构建机上创建agent安装目录

```text
new-item C:\data\landun -itemtype directory
```

## 解压安装agent 

将下载好的Agent包解压至上一步创建的文件夹下

![bkci-hosted-windows-agent-1](../../../assets/bkci-hosted-windows-agent-1.png)

以管理员身份运行 install.bat

![bkci-hosted-windows-agent-2](../../../assets/bkci-hosted-windows-agent-2.png)

## 切换agent服务启动用户

上面的操作将agent安装为系统服务，服务的启动用户为windows的内置用户`system`。为了在流水线过程中可以读取到用户环境变量和用户目录等信息，`需要将系统服务的启动用户改为登录用户`

执行命令`services.msc`打开windows服务管理界面，找到服务`devops_agent_{agent_id}`（每个agent\_id都是不同的，agent\_id的值可以在配置文件`.agent.properties`中找到）

右键-&gt;属性，在登录页签下选择`此账户`

如果是入域的构建机，账户名填写`域名\用户名`；如果没有入域的构建机，账户名填写`.\用户名`，例如`.\admin`、`.\administrator`、`.\bkci`

输入密码后，点击`确认`按钮

![bkci-hosted-windows-agent-3](../../../assets/bkci-hosted-windows-agent-3.png)

右键-&gt;重新启动，重启服务

![bkci-hosted-windows-agent-4](../../../assets/bkci-hosted-windows-agent-4.png)

## 检查状态

打开任务管理器，查看进程 devopsDaemon.exe 和 devopsAgent.exe 是否存在，查看两个进程的启动的用户名是否为当前登录用户

## 页面导入

在构建导入页面点击`刷新`按钮，可以看到agent状态变为`正常`

## windows agent启动界面程序的解决办法

BKCI私有构建机 windows agent 默认以系统服务的方式启动，通过agent启动带界面UI的程序时会报错或者碰到界面被不可见的问题

原因：Windows Service启动的进程都运行在Session0内，Session0限制了不能向桌面用户弹出信息窗口、UI 窗口等信息。

碰到这种情况可以换一种方式启动agent，方式如下：

1. 如果agent已经安装成系统服务，执行 uninstall.bat 卸载agent服务
2. 双击  devopsDaemon.exe 启动agent，注意不要关掉弹出窗口

> 这种方式启动的agent没有开机启动功能。
>
> agent执行完构建任务后，会自动停止所有由agent启动的子进程，如果不需要结束子进程，可以在启动进程前设置环境变量：set DEVOPS\_DONT\_KILL\_PROCESS\_TREE=true