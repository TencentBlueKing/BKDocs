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



### gse_agent 是否可以用普通用户启动？

可以，但是部分功能受限。

以下为非 root 账户运行评估

<table><tbody>
<tr ><td width="15%" >-</td><td width="20%">模块</td><td width="20%">功能</td><td width="45%">非root账户运行评估</td></tr>
<tr><td rowspan="7">gse_agent</td><td>任务</td><td>执行脚本任务</td><td>功能受限：<br>1、不能切换账户；<br>2、不能对切换的账户限权</td></tr>
<tr><td rowspan="2">进程</td><td>进程启停操作</td><td>功能受限：<br>1、如托管进程运行账户与非gse_agent运行账户不一致时，无法启停进程</td></tr>
<tr><td>进程状态托管</td><td>功能受限：<br>1、如托管进程运行账户以非gse_agent运行账户不一致时，无发托管</td></tr>
<tr><td rowspan="3">文件</td><td>文件上传</td><td>功能受限：<br>1、不能上传gse_agent运行账户无权限访问的文件</td></tr>
<tr><td>文件下载</td><td>功能受限：<br>1、不能下载到gse_agent运行账户无权访问的目录<br>2、如文件所属账户是非gse_agent运行账户，不能切换文件所属账户和权限(mod)</td></tr>
<tr><td>目录和正则传输</td><td>功能受限：<br>1、不能上传gse_agent运行账户无权限访问的目录或文件<br>2、不能下载到gse_agent运行账户无权访问的目录<br>3、如文件所属账户是非gse_agent运行账户，不能切换目录所属账户和权限(mod)</td></tr>
<tr><td>数据</td><td>接收并上报采集插件数据</td><td>功能受限：<br>1、如采集插件运行账户以非gse_agent运行账户不一致时，无法上报数据</td></tr>
<tr><td rowspan="15">采集插件</td><td>采集框架</td><td>-</td><td>功能正常</td></tr>
<tr><td>unifyTlogc</td><td>日志采集</td><td>功能受限：<br>1、如日志文件及目录所属账户非unifyTlogc运行账户，不能采集日志</td></tr>
<tr><td>basereport</td><td>基础性能采集</td><td>功能受损：<br>1、不能采集主机cpu,mem, disk等需要读取系统文件的指标</td></tr>
<tr><td>processbeat</td><td>进程采集</td><td>功能受损：<br>1、不能读取/proc下的进程文件，进程cpu, mem,fd等指标无法采集</td></tr>
<tr><td>bkmetricbeat</td><td>组件采集</td><td>功能正常</td></tr>
<tr><td>uptimecheckbeat</td><td>波测采集器</td><td>功能受损：<br>1、脚本采集方式不可用</td></tr>
<tr><td>netdevicebeat</td><td>网络采集（snmp）</td><td>功能受损：<br>1、不能采集链接到交换机上的主机</td></tr>
<tr><td>tcpbeat</td><td>采集中转</td><td>功能正常</td></tr>
<tr><td>mysqlbeat</td><td>mysql数据采集</td><td>功能正常</td></tr>
<tr><td>oraclebeat</td><td>oracle数据采集</td><td>功能正常</td></tr>
<tr><td>redis</td><td>redis数据采集</td><td>功能正常</td></tr>
<tr><td>dbbeat</td><td>db数据采集</td><td>功能正常</td></tr>
<tr><td>httpbeat</td><td>http采集</td><td>功能正常</td></tr>
<tr><td>cadvisorbeat</td><td>容器性能采集</td><td>功能受损：<br>1、不能读取容器性能数据的文件，性能指标数据无法采集</td></tr>
<tr><td>logbeat/bk_logbeat</td><td>容器文件采集（linux+win）</td><td>功能受限：<br>1、如日志文件及目录所属账户非logbeat/bk_logbeat运行账户，不能采集日志</td></tr>
<tr><td rowspan="2">其他关联产品</td><td>监控SaaS</td><td>插件配置下发</td><td>功能受限：<br>1、如下发配置所属账户，非gse_agent运行的账户，配置下发失败</td></tr>
<tr><td>节点管理SaaS</td><td>插件管理</td><td>功能受限：<br>1、如插件运行账户，非gse_agent运行的账户，不能进行插件的部署，更新等管理</td></tr>
</tbody></table>

