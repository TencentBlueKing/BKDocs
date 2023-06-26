# 常见问题

### 通过 JOB 执行任务报错 “GSE SERVER FAILED”

（1）检查 gse_task 进程状态是否正常

（2）检查 gse_task 是否正常监听 48669 端口

（3）检查作业平台和管控平台的证书是否匹配

（4）检查作业平台部署主机到管控平台部署主机的 48669 端口策略是否开通

（5）检查 gse.service.consul 是否解析正常

### 通过作业平台执行任务报错 “can not find agent by ip ……”

（1）检查对应 ip 机器上的 gse_agent 是否正常

（2）检查 gse_agent 的 48668 连接是否正常

（3）检查 gse_agent 与 gse_task 的证书是否匹配

（4）检查该 ip 在配置平台上的业务及云区域 id 是否正确

### 文件传输任务超时失败

（1）根据作业平台打屏信息，判断是上传还是下载超时

（2）检查 BT 传输的端口策略是否开通

### 点管理 SaaS 或作业平台显示 Agent 异常

（1）检查对应 ip 机器上的 gse_agent 是否正常

（2）检查 gse_agent 的 48668 连接是否正常

（3）检查 gse_agent 与 gse_task 的证书是否匹配

（4）检查该 ip 在配置平台上的业务及云区域 id 是否正确

（5）若以上检查结果均正常，检查 gse_api 日志是否有 “no db proxy server addr found” 报错，若有则重启 gse_api

### 通过作业平台重启 gse_agent 环境变量不生效

- 问题现象

  安装 python 后，添加 python 环境变量，通过 `restart.bat` 脚本重启 Agent 后环境变量不生效。

- 问题原因

  通过作业平台执行 Agent，环境变量是不会生效的，因为环境变量是基于当前上下文环境的，通过 Agent 重启时，Agent 上本身没有最新的环境变量信息，所以也不会生效。

- 解决方案

  需要在能获取到最新环境变量的状态下重启 gse_agent，比如登录到机器重启 gse_agent 进程。

### PA 机器上的 Agent 显示未安装

- 问题现象

  手动安装 proxy，主机监控数据上报正常，p-agent 数据及 agent 状态也正常，但是 proxy 这台代理服务器在主机监控及作业平台均显示 agent 未安装。通过 JOB 执行任务报错，提示 agent 未安装。

- 问题原因

  有些用户的机器连接 gse server 时看到的 ip 和本机 ip 不一致，做了 NAT 转换，所以 agent 安装部署时导入 cmdb 的 ip 使用 identityip 作为标识。proxy 上的 agent 实际在本机建立连接，未经过 nat 转换，所以实际通信的 ip 就是本机真实 ip。

- 解决方案

  1. 在 cmdb 上导入 agentip 中配置的 ip。

  2. 两台 proxy 情况，建议这种网络情况下，交叉配置另一台 proxy 的 ip，这种就可以统一用 identifyip 在 cmdb 中导入。
