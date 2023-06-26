# 通用问题

## Q1：插件安装后无法使用

大致分为两种情况

①：插件安装后，选择插件时没有对应的插件：

插件还需要安装到对应项目，才可以在项目里选择插件。具体请参考：

[插件安装](https://docs.bkci.net/store/plugins/plugin_install_demo#liu-an-zhuang-cha-jian)

②：插件安装后，插件为灰色状态无法选择

![](../../../../assets/企业微信截图_16384260669700.png)

插件分为：有编译插件和无编译插件。编译插件又分三种环境：Linux、windows、macOS

新建 stage 时，要选择和插件对应环境的 stage，才能选择对应的插件。

job 插件为无编译环境插件，需要选择无编译环境的stage才可以。

## Q2：插件报错 bk_username can not empty

![](../../../../assets/bk_username_empty.png)

插件的私有配置未进行配置。私有配置的方法请参考

[插件私有配置](https://docs.bkci.net/store/plugins/plugin_install_demo#si-cha-jian-pei-zhi)



## Q3：插件执行报错 download plugin fail

![](../../../../assets/download_plugin_fail.png)

常见于 mongodb 异常导致。

中控机执行 ``` /data/install/bkcli restart mongod```

随后检查 mongodb 状态是否正常 ``` /data/install/bkcli status mongod```

---

# checkout

## Q1: failed to connect to gitlib.xxx.com port 443:connection timed out 构建失败 提示连接443端口超时

![](../../../../assets/image-20220301101202-AaxCJ.png)

这里断网的原因是dockerhost启动后, 执行过sysctl -p等价的命令, 导致 net.ipv4.ip\_forward 被重置为0, 导致容器断网.

```
sysctl -p | grep -F net.ipv4.ip_forward
net.ipv4.ip_forward = 0
单独启动一个测试容器:
docker run -it --rm centos 
应该会看到
WARNING: IPv4 forwarding is disabled. Networking will not work.
容器内执行命令, 等待后会看到提示超时:
curl -m 3 -v paas.service.consul
然后执行 systemctl restart BKCI-docker-dns-redirect
单独启动一个测试容器:
docker run -it --rm centos 
容器内执行命令, 可以看到网络恢复:
curl -v paas.service.consul
```

## Q2：卡死在 Fetching the repository

![](../../../../assets/check_ugit.png)

构建机使用的是Ugit

BKCI需要使用原生的 git 拉取代码。如果构建机使用了 Ugit 则会导致BKCI checkout 失败。需要重新安装一次原生 git 。

## Q3: 获取凭证失败

![](../../../../assets/企业微信截图_16266633248073.png)

这是因为旧版git拉取代码插件不支持在windows构建机上使用，最新版插件已经支持

## Q4:拉取代码时，偶现报错

Such issues can arise if a bad key is used during decryption.

![](../../../../assets/checkout_error_sometimes.png)

①此为旧版checkout插件的问题，现已修复。

②如果仍有报错，一般是由于BKCI服务器和构建机上 bcprov-jdk 版本不一致导致的问题。

请检查版本是否一致：

构建机：agent目录\jre\lib\ext

BKCI服务器：/data/bkce/ci/ticket/lib/

如不一致，进行重装构建机agent重装即可解决。

# Upload artifacts

## Q1:没有匹配到任何待归档文件

![](../../../../assets/uploadsrcfile.png)

原因：没有匹配到对应的文件

常见于文件路径问题导致的报错。upload时默认从BKCI的 ${WORKSPACE} 开始以相对路径匹配制品。

因此如果对应的制品在${WORKSPACE}的更下一级目录时，需要填写 路径/文件



Q2:构建列表不显示产物

![](../../../../assets/image-20220923105815460.png)

排查日志错误为空间不足。

1. 上传 时会使用到 /tmp 目录，/tmp 空间磁盘容量不足导致。因此 /tmp 也需要保持足够的空间。

---

# python 插件

## Q1: python的环境变量添加后，在job执行的时候未生效。（job报错“系统找不到指定的文件”）

因为BKCIagent和蓝鲸agent使用的账户是system，所以加到administrator的环境变量不生效 需要把python.exe和pip3.exe pip.exe加入到系统环境变量里，再重启操作系统

## Q2: windows构建机 流水线执行用python去打开exe 失败

windows下，agent无法拉起有UI界面的exe

这个是windows session 0 限制

## Q3：windows构建机，python 打印工作空间失败

如果构建机指定了工作路径，例如 **D:\testworkspace\source** , 在python中直接 print 打印工作空间将会失败。

因为python会把 \ 作为转义符转义。需要以 r'' 的形式打印

```python
print(r'${workspace}')
```



---

# executeJobScript

## Q1: private configuration of key JOB\_HOST is missing

![](../../../../assets/image-20220301101202-QtZoR.png)

job脚本执行插件链接：[https://github.com/TencentBlueKing/ci-executeJobScript](https://github.com/TencentBlueKing/ci-executeJobScript)

私有配置缺少JOB\_HOST字段，按照上图配置好即可

![](../../../../assets/脚本执行配置1.png)

# sendmail

## Q1: 发送邮件插件执行成功，但没收到邮件

1. 首先配置ESB的邮件信息，参考：[https://bk.tencent.com/s-mart/community/question/2532](https://bk.tencent.com/s-mart/community/question/2532)
2. 配置插件的私有配置，参考：[https://github.com/TencentBlueKing/ci-sendEmail](https://github.com/TencentBlueKing/ci-sendEmail)

## Q2: 发送邮件插件的sender配置不是我配置的sender

![](../../../../assets/image-20220301101202-gdDMH.png)

sender需要在插件的「私有配置」里设置，独立于ESB的mail\_sender

1. 首先配置ESB的邮件信息，参考：[https://bk.tencent.com/s-mart/community/question/2532](https://bk.tencent.com/s-mart/community/question/2532)
2. 配置插件的私有配置，参考：[https://github.com/TencentBlueKing/ci-sendEmail](https://github.com/TencentBlueKing/ci-sendEmail)

## Q3：插件执行时报错缺少依赖 not recognized

![](../../../../assets/not_recognized.png)

插件执行时，机器上缺少pip，需要在对应的stage选择的构建机上安装相应的依赖程序。



# batchscript

## Q1: batchscript插件无法执行bat文件，bat文件里有从系统中读取的变量，是当前用户设置的

![](../../../../assets/企业微信截图_16285831782937.png)

将对应的agent服务的启动用户改为当前用户，执行命令`services.msc`打开windows服务管理界面，找到服务`devops_agent_${agent_id}`(注意：每个agent\_id是不同的，agent\_id的值可以在配置文件.agent.properties中找到)

右键->属性，在登录页签下选择此账户

如果是如入域构建机，账户名填写`域名\用户名`，例如`tencent\zhangsan`;如果没有入域的构建机，账户名填入`.\用户名`,例如`.\admin、.\administrator、.\bkdevops`，输入密码后，点击确认按钮

![](../../../../assets/image-20220128181627246.png)

右键 -> 重新启动，重启服务

![](../../../../assets/image-20220128181720819.png)

打开任务管理器，查看进程devopsDaemon.exe和的vopsAgent.exe是否存在，查看两个进程的启动的用户名是否为当前登录用户

## Q2: batchscript中的命令路径有空格，执行失败

![](../../../../assets/企业微信截图_16285852671573.png)

可以将有空格的命令用引号""括起来

## Q3：构建机本地执行 Unity bat 脚本时成功，BKCI执行报错

查看**脚本执行日志**后发现，本地执行时开启了88个线程的UnityShaderCompiler，但是BKCI执行时，有些UnityShaderCompiler就吊起失败了。

报错：Failed to get ipc connection from UnityShaderCompiler.exe shader compiler!

原因：BKCI需要为用到的exe开启进程，来收集错误和日志，创建的进程数超出了限制，会导致进程开启失败，导致流程失败。

解决办法：需增加系统可开启的进程数。

---

## Q4：无法执行带UI界面的程序

具体表现：同样的脚本在目标机器执行bat脚本没问题， 在BKCI或者job平台不能执行

BKCI开发团队给出的解释：

BKCI私有构建机windows agent默认以系统服务的方式启动，通过agent启动带界面UI的程序时会报错或者碰到界面被不可见的问题

原因：Windows Service启动的进程都运行在Session0内，Session0限制了不能向桌面用户弹出信息窗口、UI 窗口等信息。

 

碰到这种情况可以换一种方式启动agent，方式如下：

1. 如果agent已经安装成系统服务，执行 uninstall.bat 卸载agent服务

2. 双击 devopsDaemon.exe启动agent，注意**不要关掉弹出窗口**



**注1：这种方式启动的agent没有开机启动功能。**

**注2：BKCIagent执行完构建任务后，会自动停止所有由agent启动的子进程，如果不需要结束子进程，可以在启动进程前设置环境变量：set DEVOPS_DONT_KILL_PROCESS_TREE=true**

**目前只有这种临时解决方式， 因为agent最开始设计就是如此**

---

## Q5:batch插件，无法识别带回车的文本框变量

BKCI是通过一种提前渲染的方式进行变量渲染。已经把变量渲染好，替换插件中内容。

batch 插件模拟命令行执行，碰到了带回车的文本框时，就会识别为执行。

![](../../../../assets/QQ截图20221228175342.png)

例如：

此时 batch 插件执行   echo ${{a}}

结果将等于在命令行如下输入：

echo a
b
c

---

## Q6：本地执行 coscmd 正常，使用插件执行会报错

![](../../../../assets/batch_coscmd_error.png)

本地执行时，和使用 agent 执行时用的用户不同导致此问题。agent 执行时的用户可通过环境管理查看

![](../../../../assets/agent_start_user.png)

需要使用本地执行时成功的账户，重装 agent，使其用户一致。





---

# Shell script

## Q1：macos机器无法执行 shell 和 python 插件

问题如下：macOs的私有构建机使用shell插件执行命令报错， 什么命令都无法执行

![](../../../../assets/clip_image001.png)

使用python插件如下报错：

![](../../../../assets/clip_image002.png)

排查问题：

1. 确认macOs的默认shell环境是否正常cat /etc/shells、echo $SHELL，如下显示为正常

![](../../../../assets/clip_image003.png)

2. 查看构建机日志set up job日志，查看环境变量，查看环境变量是否都正常

![](../../../../assets/clip_image004.png)

 本次案例排查出环境变量LANG异常， 字符集LANG设置为zh_CN.eucCN 是错误的， 应该设置为zh_CN.UTF-8

![](../../../../assets/clip_image005.png)

原因：LANG字符集影响了中文值的变量export，导致整个sh脚本出错

解决方案：修改字符集为正确的字符集即可解决

 

## Q2：shell脚本执行异常

报错：java.io.IOException: No such file or directory

![](../../../../assets/clip_image006.png)

 排查问题：

1. 检查是否设置workspace，如设置先去掉再执行shell看是否成功， 如成功则是workspace设置问题

2. 检查workspace的目录创建的位置是否在用户目录下， 如果不是流水线无法访问到

 

原因：workspace权限问题

解决方法：正确创建workspace位置， 把权限设置对
