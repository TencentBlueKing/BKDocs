# windows agent启动界面程序的解决办法

BKCI第三方构建机 windows agent 默认以系统服务的方式启动，通过agent启动带界面UI的程序时会报错或者碰到界面被不可见的问题

原因：Windows Service启动的进程都运行在Session0内，Session0限制了不能向桌面用户弹出信息窗口、UI 窗口等信息。

碰到这种情况可以换一种方式启动agent，方式如下：

1. 如果agent已经安装成系统服务，执行 uninstall.bat 卸载agent服务
2. 双击  devopsDaemon.exe 启动agent，注意不要关掉弹出窗口

> 这种方式启动的agent没有开机启动功能。
>
> agent执行完构建任务后，会自动停止所有由agent启动的子进程，如果不需要结束子进程，可以在启动进程前设置环境变量：set DEVOPS\_DONT\_KILL\_PROCESS\_TREE=true