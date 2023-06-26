## Q1：如何卸载 agent

目前BKCI agent 没有限定安装目录，在 windows 系统上，agent安装包解压目录即为 agent 安装目录；在 linux 和 mac 系统上，执行 agent 安装脚本的目录即为agent安装目录。

因为没有限定安装目录，在执行agent卸载脚本（windows为 uninstall.bat, linux 和 mac 为 uninstall.sh）后，为防止误删除重要的系统文件，卸载脚本没有删除agent相关程序文件，需要用户自行清理。

**agent卸载需要清理的文件/文件夹如下：**
文件：
.agent.properties → agent配置文件
agent.zip → agent安装包
jre.zip → jre 压缩包
devopsAgent → agent程序
devopsDaemon → agent守护程序
worker-agent.jar → worker 程序
install.sh → 安装脚本
uninstall.sh → 卸载脚本
start.sh → 启动脚本
stop.sh → 停止脚本

**文件夹：**
jre → jre
logs → 日志
workspace → 工作空间，流水线文件操作默认存储目录
runtime → 运行时目录
tmp → 临时目录



如果 agent 安装在独立目录下，在执行卸载脚本后，删除 agent 安装目录即可。如果安装在非独立目录，可以参照上面的文件/文件夹说明自行删除文件。

**linux & mac 清理脚本参考：**
<font color="red">**注意：清理文件夹需要确认各文件夹下没有存储非agent的数据，需要确认workspace下的内容是否需要保留**</font>

```
CD $安装目录
./UNINSTALL.SH
RM -F .AGENT.PROPERTIES AGENT.ZIP JRE.ZIP DEVOPSAGENT DEVOPSDAEMON WORKER-AGENT.JAR INSTALL.SH UNINSTALL.SH STOP.SH START.SH TELEGRAF.CONF
RM -RF JRE LOGS RUNTIME
RM -RF WORKSPACE```
```

---

## Q2：如何重装 agent

**1.**   **用户数据安全注意事项：**

请安装Agent的同学注意安装目录，在执行安装命令时，会直接把 当前执行安装命令的位置作为Agent安装目录。所以我们建议您：

<font color="red">**不要随意在任意目录下安装，创建一个专门给Agent安装的目录，与用户数据，根目录，数据盘分开，避免Agent产生的日志数据对您的磁盘空间造成影响**</font>

 

**2.**   **Linux&MacOS系统：**

1. 进入agent安装目录。agent安装目录可以在 **环境管理 → 节点 → 点击“别名”链接进入构建机详情页面 → 下方基本信息 → 安装路径**查到。agent GO_20190612 之前版本因为没有采集agent安装目录信息，需要通过在构建机上查看进程来推测安装路径，命令为**ps -ef | grep devops**

2. 执行 **./uninstall.sh**  卸载agent(更老的版本命令为./agent_uninstall.sh) ，同时**删除agent.zip**文件。卸载后确认agent进程已退出，如果没有退出可以手动杀掉进程

3. 从上面步骤1的构建机详情页右上角**复制安装命令**，在agent安装目录执行安装命令

4. 确认agent进程（devopsDaemon，devopsAgent）已存在，页面查看agent状态处于正常状态。

 

**3.**   **Windows系统**

1. 进入agent安装目录。agent安装目录可以在 **环境管理 → 节点 → 点击“别名”链接进入构建机详情页面 → 下方基本信息 → 安装路径**查到。agent GO_20190612 之前版本因为没有采集agent安装目录信息，需要打开Windows任务管理器，查看devopsAgent.exe的程序路径来确认安装路径。

2. 执行 **./uninstall.sh** 卸载agent (更老的版本命令为./agent_uninstall.bat) 。卸载后任务管理器上确认agent进程（devopsDaemon.exe，devopsAgent.exe）已退出，如果没有退出可以手动结束进程。

3. 从上面步骤1的构建机详情页右上角链接**下载安装包**

4. 清理agent安装目录只保留**workspace**文件夹，将安装包解压到安装目录（也可以另建空目录安装agent）

5. 执行./install.sh安装agent

6. 确认agent进程（devopsDaemon.exe，devopsAgent.exe）已存在，页面查看agent状态处于正常状态

7. 切换agent安装用户

---

## Q3：如何重启构建机agent

可以到BKCIagent的安装目录下，先执行stop.sh脚本（在windows上是stop.bat批处理文件），再执行start.sh（在windows上时start.bat文件）



## Q4：私有构建机，一台mac只能装一个agent吗，一个构建机可以给多个项目使用吗

可以多个, 在不同目录启动agent即可. 每个agent实例需要全新安装, 不能直接复制已有agent目录。



## Q5：私有构建机必须是物理机吗？可以是docker容器吗?

私有构建机和项目绑定, 且需安装agent并注册. 建议使用物理机/虚拟机等变动少的场景. 容器化使用公共构建机即可.



## Q6：构建机的详情信息都没有显示

![](../../../assets/environment_monitor.png)

没有启用. 这个监控并无意义, 也不影响调度。建议使用蓝鲸监控等专门的监控系统负责。

如果一定要启用

1. 配置 bin/03-userdef/ci.env 

2. 添加 BK_CI_ENVIRONMENT_AGENT_COLLECTOR_ON=true
3. 然后添加 influxdb相关的配置项
4. 重新安装ci-environment. 可以直接使用 ./bk_install ci 安装
5. 修改已有agent:编辑.agent.properties , 配置devops.agent.collectorOn=true, 重启agent