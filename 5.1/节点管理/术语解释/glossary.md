# 术语解释

- **Proxy**：Proxy Server 常被用来建立不同的局域网之间的联系。Proxy Server 与不同云区域下的 GSE Server 和 P-Agent 同时连接，相当于 P-Agent 与 GSE Server 之间的桥梁，可以间接实现 P-Agent 与 GSE Server 之间的通信。

- **P-Agent**：在云区域下，由 Proxy 管理的 Agent 类型，简称 P-Agent。

- **云区域**：一组服务器代表一个云区域，云区域内的服务器之间可以通过局域网相互访问。

- **直连区域**：本篇中，安装 Agent 的受控主机 和 GSE Server 同属一个局域网内（非跨云），此时 Agent 的安装区域叫直连区域。

- **非直连/跨云区域**：本篇中，安装 Agent 的受控主机 和 GSE Server 不属于一个局域网内（跨云），此时 Agent 的安装区域叫非直连/跨云区域。

- **APPO**：蓝鲸 APP（SaaS）运行的正式环境。

- **APPT**：蓝鲸 APP （SaaS）运行的测试环境。
