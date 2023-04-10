# gitlab事件触发插件无法触发事件?

1. 查看下devops\_ci\_process.T\_PIPELINE\_WEBHOOK表是否有注册这条流水线， SELECT \* FROM devops\_ci\_process.T\_PIPELINE\_WEBHOOK WHERE pipeline\_id = ${pipeline\_id}，${pipeline\_id}可以从url地址获取
2. 如果没有注册
   1. 查看repository服务到gitlba的网络是否能通
   2. 查看gitlab仓库的权限是否是master权限
   3. 在repository服务部署的机器上，执行grep "Start to add the web hook of " $BK\_HOME/logs/ci/repository/repository-devops.log查找注册失败原因，$BK\_HOME默认是/data/bkce
3. 如果已注册，还是没有触发，
   1. 到gitlab的webhook页面，查看是否有注册成功，如图1
   2. 如果gitlab中有注册的url，url是 [http://域名/external/scm/codegit/commit](http://域名/external/scm/codegit/commit) 然后点击编辑，查看发送的详情，如图2
   3. 查看gitlab没有发送的详情，如图3
4. 如果上面都没问题，在process服务部署的机器上，执行grep "Trigger gitlab build" $BK\_HOME/logs/ci/process/process-devops.log 搜索日志，查找触发的入口日志

![](../../assets/image%20%2858%29%20%281%29.png)

![](../../assets/image%20%2859%29.png)

![](../../assets/image%20%2857%29.png)

