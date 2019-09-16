## 安装 P-Agent

在安装好 Proxy，Proxy 节点的状态正常后，才能开始安装 P-Agent。


**安装要求**

在非直连区域安装 P-Agent ，主机要求如下：
 - 满足网络策略要求，参考 [开通网络策略-2,-3](/network_policy.md)。
 - 任意 Proxy 所在机器必须能通过 SSH 登陆到 Agent 机器。
 - Agent 所在机器可以访问到 Proxy 的端口。
 - 仅支持 ``Linux / Windows/ AIX（企业版）`` 操作系统。
 - 仅支持 `root/Administrator` 账户。
 - 若为 `Windows`，需要开通 SMB 服务（网上邻居）的 `139、445` 端口，参考 [Windows 开 139,445 端口](/smb.md) 。

>**Note**：目前只有节点管理（企业版）支持 AIX 操作系统。



**安装流程**

**填写信息 -> 查看满足条件 ->点击开始安装 -> 查看安装步骤详情 -> 查看状态栏，安装成功**

1、点击【 +添加 P-Agent 】，输入 IP 等信息，与安装直连区域相似

![image-20190915234254450](../assets/pagent/image-20190915234254450.png)

> Note:
>
> 若 添加 P-Agent 按钮为灰色不可点击状态，说明，该云区域下无可用的 Proxy 节点，若无 Proxy 则需要先添加 Proxy。有 Proxy 但状态不正常时，需要先检查安装 Proxy 的条件，网络策略，服务器上的进程情况。确保 Proxy 正常后再进行 P-Agent 的安装

页面与安装直连 Agent 有小小的差异如下图红框中所示。

![image-20190915234827714](../assets/pagent/image-20190915234827714.png)

2、点击安装即可。后面步骤则与安装 Agent 相同，请参照 [直连区域的 Agent 安装](/installation/agent.md) 。



**注意事项**

在安装 Proxy 时，P-Agent 所需的安装包已经下载到 Proxy 机器的/tmp 目录下暂存，因此 升级 P-Agent 必须先重装 Proxy 以更新其下暂存的 P-Agent 安装包。然后再升级 P-Agent 节点。
