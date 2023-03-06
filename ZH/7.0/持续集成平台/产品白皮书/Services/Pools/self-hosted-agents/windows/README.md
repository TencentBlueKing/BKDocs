# 导入Windows构建机

{% hint style="danger" %}
1. 托管前，请先准备好执行环境：[第三方构建机环境准备](../prepara-agent.md)\*\*\*\*
2. **如果您的windows构建需要在流水线中启动UI程序**（比如打开浏览器做自动化测试），请参阅[windows agent启动界面程序的解决办法](run-ui.md)）
3. agent资源是按项目隔离的，如果多个项目导入第三方构建机，需要在不同的项目下各自导入agent，安装在不同的目录下。（每个agent的安装包/安装脚本是不一样的）
{% endhint %}

## 在BKCI获取Agent包

根据[将你的构建机托管至 BKCI](../) 指引，选择Windows，下载Agent包

## 在Windows构建机上创建agent安装目录

```text
new-item C:\data\landun -itemtype directory
```

## 解压安装agent <a id="id-&#x6784;&#x5EFA;Agent&#x5BFC;&#x5165;Windows&#x7248;-3&#x89E3;&#x538B;&#x5B89;&#x88C5;agent"></a>

将下载好的Agent包解压至上一步创建的文件夹下

![](../../../../assets/image%20%2854%29.png)

以管理员身份运行 install.bat

![](../../../../assets/image%20%2855%29.png)

## 切换agent服务启动用户 <a id="id-&#x6784;&#x5EFA;Agent&#x5BFC;&#x5165;Windows&#x7248;-4&#x5207;&#x6362;agent&#x670D;&#x52A1;&#x542F;&#x52A8;&#x7528;&#x6237;"></a>

上面的操作将agent安装为系统服务，服务的启动用户为windows的内置用户`system`。为了在流水线过程中可以读取到用户环境变量和用户目录等信息，`需要将系统服务的启动用户改为登录用户`

执行命令`services.msc`打开windows服务管理界面，找到服务`devops_agent_{agent_id}`（每个agent\_id都是不同的，agent\_id的值可以在配置文件`.agent.properties`中找到）

右键-&gt;属性，在登录页签下选择`此账户`

如果是入域的构建机，账户名填写`域名\用户名`，例如`tencent\xxx`；如果没有入域的构建机，账户名填写`.\用户名`，例如`.\admin`、`.\administrator`、`.\bkci`

输入密码后，点击`确认`按钮

![](../../../../assets/image%20%2853%29.png)

右键-&gt;重新启动，重启服务

![](../../../../assets/image%20%2852%29.png)

## 检查状态

打开任务管理器，查看进程 devopsDaemon.exe 和 devopsAgent.exe 是否存在，查看两个进程的启动的用户名是否为当前登录用户

## 页面导入 <a id="id-&#x6784;&#x5EFA;Agent&#x5BFC;&#x5165;Windows&#x7248;-5&#x9875;&#x9762;&#x5BFC;&#x5165;"></a>

在构建导入页面点击`刷新`按钮，可以看到agent状态变为`正常`

