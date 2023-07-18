>蓝鲸智云节点管理，以下简称节点管理

蓝鲸 Agent，是实现主机与蓝鲸通讯的专用程序。在主机上安装了蓝鲸 Agent 以后，您可以通过蓝鲸对主机管控，包含文件分发、作业执行、数据上报、基础信息采集等。

## 直连agent

蓝鲸平台所在服务器和需要安装 Agent 的主机同属于一片网络区域时，填写/选择主机、端口、密码/密钥信息后可以直接安装蓝鲸 Agent，安装 Agent 需要保证目标机器的 SSH 通道是打开的。

> 安装方式：(普通安装/Excel 导入安装)

以普通安装为例，又区分远程安装和手动安装

### 远程安装：
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221222162055/20044/20221222162055/--d9f1793251ae595af2146ad564874ada.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221222162059/20044/20221222162059/--6c85babd8deabeb484dd95fd72b6015c.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221222162109/20044/20221222162109/--9283d07ef2dfa785c166b933717776c2.png)


### 手动安装：

选择手动安装

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221222162122/20044/20221222162122/--bd1ce862250905a37dd78116e34206c3.png)

打开手动安装agent `操作指引`

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221222162136/20044/20221222162136/--948b9fa88c2dc0e592d954111a3dae3a.png)

复制`命令` 到目标agent机器执行安装

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221222162152/20044/20221222162152/--1e3755956525267946cf00c35bed71e8.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221222162200/20044/20221222162200/--5610b5dd72de3c6433c566bdc35dd443.png)

执行后可以在`节点管理-任务历史`中查看到安装agent流程正在执行了

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221222162211/20044/20221222162211/--d2f6ee4f0c21e7e9ba3193eeb11190b9.png)

部署后成功再目标机器上查看到agent进程  

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221222162229/20044/20221222162229/--6d5535474ebde252c1e0e16eb69a8ffb.png)



## 非直连agent

- 云区域：云区域是对分布在不同 IDC 或内网相互隔离的网络环境中一组服务器, 在网络层面的一个统称。 通常是 GSE Server 与受控主机之间的网络无法直接路由的场景。 云区域中至少有一台主机需要能与 GSE 通信。可以通过将这台安装成 Proxy 节点。

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221222162252/20044/20221222162252/--501c135ccb93e13bfb11f35f9612d562.png)

在云区域中安装proxy，每个云区域支持多个proxy

查看每个配置项的说明

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221222162307/20044/20221222162307/--863258b54c89e784aa10aced39c466c9.png)

`填写 Proxy 安装参数`

安装所需要的参数说明：

●内网 IP：与 Agent 可以进行网络通讯的 IP

●对外通讯 IP：与接入点可以进行网络通讯的 IP

●登录 IP：从蓝鲸可以 SSH 登录到此 Proxy 主机的 IP。此为可选配置，如果没有填写默认使用内网 IP

●认证方式：支持密码或者密钥的方式

●操作系统：作为 Proxy 的主机必须为 64 位的 Linux 系统

●登录端口：可以进行 SSH 连接的端口

●登录账号：建议为 root 账户，如果不能够使用 root 账户，要求所填写账户可以免密 sudo 执行 /tmp/setup_agent.sh 脚本

●归属业务：用于定义 Proxy 安装完成后，录入到蓝鲸配置平台的哪个业务下

>  需要注意的是，您必须获取蓝鲸配置平台的业务权限才可以进行此操作

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221222162332/20044/20221222162332/--078d835dcfda02e84fed2fd3b2133c60.png)

登录到proxy机器查看proxy相关进程

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221222162342/20044/20221222162342/--3cb109d1dd582e9e1de7c8cdaccfc0ef.png)

