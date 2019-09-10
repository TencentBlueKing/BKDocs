## 安装 P-Agent {#Pagent}

在安装好 Proxy，Proxy 节点的状态正常后，才能开始安装 P-Agent。


**安装要求**

在非直连区域安装 P-Agent ，主机要求如下：
 - 满足网络策略要求，参考 [开通网络策略-2,-3 ](/network_policy.md)。
 - 任意 Proxy 所在机器必须能通过 SSH 登陆到 Agent 机器。
 - Agent 所在机器可以访问到 Proxy 的端口。
 - 仅支持 ``Linux / Windows/ AIX（企业版）`` 操作系统。
 - 仅支持 `` root/Administrator `` 账户。
 - 若为 ``Windows ``，需要开通 SMB 服务（网上邻居）的 `139、445` 端口，参考 [Windows开 139,445 端口](/smb.md) 。

>**Note**：目前只有节点管理（企业版）支持 AIX 操作系统。

**安装流程**

**填写信息 -> 查看满足条件 ->点击开始安装 -> 查看安装步骤详情 -> 查看状态栏，安装成功**

1、点击【 +添加 P-Agent 】，输入 IP 等信息。

![添加P-agent](../assets/添加P-agent.png)

2、后面步骤则与安装 Agent 相同，请参照 [直连区域的Agent安装](/installation/agent.md) 。

**注意事项**

在安装 Proxy 时，P-Agent 所需的安装包已经下载到 Proxy 目录下暂存，因此 升级 P-Agent 必须先重装 Proxy 以更新其下暂存的 P-Agent 安装包。然后再升级 P-Agent 节点。
