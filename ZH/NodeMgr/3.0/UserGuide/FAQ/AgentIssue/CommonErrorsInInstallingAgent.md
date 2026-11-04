# 安装 Agent 常见报错

安装任务失败后，请先在「任务历史」中点击失败的主机查看子任务执行日志，再根据以下常见场景排查。

## 场景一：目标主机无法下载安装包或回写状态

现象：日志中安装包下载或状态回调步骤超时、连接失败。

排查：

- 直连单元的主机，确认其能访问 File 服务的 `download` 地址与 Backend 的 `callback` 地址；
- 非直连单元的主机，确认其能访问本单元 Proxy 上 Relay 插件的 `download` / `callback` 端口，且 Relay 插件运行正常；
- 若网络确实不通，改用手动安装方式。

## 场景二：非直连单元的 Proxy 上没有安装能力

现象：在空的非直连单元中直接安装 Agent / Proxy 失败。

原因：空单元中的第一台 Proxy 不能通过本单元安装，需要先通过**跨单元安装**（从其他具备安装能力的单元发起）或**离线安装**建立第一台 Proxy。

## 场景三：Proxy 安装后 Relay 地址不可达

现象：Proxy 安装成功，但单元内 Agent 安装/状态回写失败。

排查：Proxy 的**首个内网 IP** 会被用作 Relay 插件的监听地址和本机回调地址。如果填写了多个内网 IP 且顺序错误，可能导致 Relay 监听或状态回写地址不可达。请确认首个内网 IP 是同单元内 Agent / Proxy 能访问的真实内网地址。

## 场景四：SSH 登录失败

排查：确认登录端口（通常 SSH 为 22）、登录账户（Linux/macOS 使用 root，Windows 使用 Administrator）与认证方式（密码/密钥）正确，且安装源到目标主机的 SSH/WMI 通道可达。

> 更多服务端排查方法，可参考源码仓库的 [FAQ 文档](https://github.com/TencentBlueKing/bk-nodemgr/tree/master/docs/faq) 与[故障排查手册](https://github.com/TencentBlueKing/bk-nodemgr/tree/master/docs/operation/troubleshooting)。
