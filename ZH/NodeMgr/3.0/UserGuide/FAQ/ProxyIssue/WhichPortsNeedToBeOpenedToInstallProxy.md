# 安装 Proxy 需要开通哪些端口

安装 Proxy 及 Proxy 正常运行所需的网络连通分为三个方向，具体端口以环境中 GSE 服务和节点管理服务的实际配置为准：

## 1. 安装源 → Proxy 主机

- SSH 登录端口（默认 22）：在线自动安装时，安装源（Server 或上游 Relay）需要通过 SSH/SFTP 登录 Proxy 主机触发安装并传输文件。

## 2. Proxy → 上游接入点

Proxy 需要访问所属管控单元选定的上游接入点中的三组通道地址：

- `cluster`：GSE 信令通道，承载节点与上游的信令通信；
- `file`：GSE 文件通道，承载单元之间的文件传输；
- `data`：GSE 数据通道，承载节点数据上报。

每组通道可配置多个地址，端口以实际 GSE / 上游 Proxy 的服务配置为准。

## 3. 单元内 Agent → Proxy

- Relay `download` 端口：单元内节点从 Proxy 上的 Relay 插件拉取安装包；
- Relay `callback` 端口：单元内节点向 Relay 插件回写执行状态；
- Proxy 服务 IP（`advertise_ip`，未填写时按内网 IP 处理）上 GSE Proxy 暴露给下游 Agent 连接的地址与端口。

> Relay 插件监听地址使用 Proxy 的**首个内网 IP**，安装时请确保该地址是同单元内节点可访问的真实内网地址。直连单元的 Agent 则需要能访问节点管理 Backend 的 `callback` 端口（默认 28103）和 File 的下载服务端口。

端口方向示意：

```text
                        ┌──────────────────────────────┐
                        │   蓝鲸管控面（节点管理 Server） │
                        │  Backend callback / File download │
                        └──────────────▲───────────────┘
                                       │ ② Proxy → 上游接入点
                                       │    cluster（信令）/ file（文件）/ data（数据）
┌────────────┐  ① 安装源 → Proxy       │
│ 安装源      │ ──────────────────────▶│
│ Server 或  │   SSH（默认 22）  ┌─────┴───────┐
│ 上游 Relay  │                  │ Proxy 节点   │
└────────────┘                  │  Relay 插件  │
                                └─────▲───────┘
                                      │ ③ 单元内 Agent → Proxy
                                      │    Relay download / callback
                                ┌─────┴───────┐
                                │ 单元内 Agent │
                                └─────────────┘
```
