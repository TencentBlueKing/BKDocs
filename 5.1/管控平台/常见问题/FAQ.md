##常见问题
###通过JOB执行任务报错“GSE SERVER FAILED”
（1）检查gse_task进程状态是否正常
（2）检查gse_task是否正常监听48669端口
（3）检查作业平台和管控平台的证书是否匹配
（4）检查作业平台部署主机到管控平台部署主机的48669端口策略是否开通
（5）检查gse.service.consul是否解析正常

###通过作业平台执行任务报错“can not find agent by ip …”
（1）检查对应ip机器上的gse_agent是否正常
（2）检查gse_agent的48668连接是否正常
（3）检查gse_agent与gse_task的证书是否匹配
（4）检查该ip在配置平台上的业务及云区域id是否正确

###文件传输任务超时失败
（1）根据作业平台打屏信息，判断是上载还是下载超时
（2）检查bt传输的端口策略是否开通

###节点管理SaaS或作业平台显示Agent异常
（1）检查对应ip机器上的gse_agent是否正常
（2）检查gse_agent的48668连接是否正常
（3）检查gse_agent与gse_task的证书是否匹配
（4）检查该ip在配置平台上的业务及云区域id是否正确
（5）若以上检查结果均正常，检查gse_api日志是否有“no db proxy server addr found”报错，若有则重启gse_api

###通过作业平台重启gse_agent环境变量不生效 
- 问题现象

  安装python后，添加python环境变量，通过`restart.bat`脚本重启Agent后环境变量不生效。
- 问题原因
  
  通过作业平台执行Agent，环境变量是不会生效的，因为环境变量是基于当前上下文环境的，通过Agent重启时，Agent上本身没有最新的环境变量信息，所以也不会生效。
- 解决方案  

  需要在能获取到最新环境变量的状态下重启gseagent，比如登录到机器重启gse_agent进程。

###PA机器上的Agent显示未安装 
- 问题现象

  手动安装proxy，主机监控数据上报正常，p-agent数据及agent状态也正常，但是proxy这台代理服务器在主机监控及作业平台均显示 agent 未安装。
通过JOB执行任务报错，提示agent未安装。
- 问题原因

  有些用户的机器连接gse server时看到的ip和本机ip不一致，做了NAT转换，所以agent安装部署时导入cmdb的ip使用 identityip 作为标识。
proxy上的agent实际在本机建立连接，未经过nat转换，所以实际通信的ip就是本机真实ip。
- 解决方案

  1.在cmdb上导入agentip中配置的ip
  2.两台proxy情况，建议这种网络情况下，交叉配置另一台proxy 的ip，这种就可以统一用identifyip在cmdb中导入
