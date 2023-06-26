## Q1: gitlab触发插件无法触发流水线

1. 检查分支是否匹配

2. 查看下devops\_ci\_process.T\_PIPELINE\_WEBHOOK表是否有注册这条流水线， SELECT \* FROM devops\_ci\_process.T\_PIPELINE\_WEBHOOK WHERE pipeline\_id = ${pipeline\_id}，${pipeline\_id}可以从url地址获取

3. 如果没有注册

   1. 查看repository服务到gitlba的网络是否能通，比如是否配置gitlab的域名解析

   2. 查看gitlab仓库的权限是否是master权限。生成accesstoken的用户需要是仓库的`maintainer`角色，且accesstoken 的 Scopes需要具有`api`权限

   3. 在repository服务部署的机器上，执行grep "Start to add the web hook of " $BK\_HOME/logs/ci/repository/repository-devops.log查找注册失败原因，$BK\_HOME默认是/data/bkce

4. 如果已注册，还是没有触发，

   1. 到gitlab的webhook页面，查看是否有注册成功，如图1

   2. 如果gitlab中有注册的url，url是 [http://域名/external/scm/codegit/commit](http://xn--eqrt2g/external/scm/codegit/commit) 然后点击编辑，查看View detail，如图2

   3. 查看发送的错误详情，如图3。检查gitlab到BKCI机器的网络是否可达，如gitlab服务器是否能解析BKCI域名。

5. 如果上面都没问题，在process服务部署的机器上，执行grep "Trigger gitlab build" $BK\_HOME/logs/ci/process/process-devops.log 搜索日志，查找触发的入口日志，查看gitlab push过来的请求体。

   注意查看gitlab push过来的请求体，对比请求体中的`http_url`字段和代码库里代码仓库的地址是否**完全**匹配，如果一个是域名形式的url，另一个是ip形式的url，则不匹配。如图4、图5

![](<../../../../assets/image (58) (1).png>)

![](<../../../../assets/image (59).png>)

![](<../../../../assets/image (57).png>)

<img src="../../../../assets/image-trigger-gitlab-webhook-post-body.png" alt="" data-size="original"><img src="../../../../assets/image-trigger-gitlab-repo-ip-view.png">





6、gitlab 的 hook记录中，报错 Hook execution failed

这是因 gitlab 10.6 版本后为了安全，默认不允许向本地网络发送 webhook。需要解开 gitlab 的安全限制。

<img src="../../../../assets/QQ截图20221228192430.png">

<img src="../../../../assets/QQ截图20221228192953.png">

## Q3：gitlab webhook 报错 

URL '[**http://devops.bktencent.com/ms/process/api/external/scm/gitlab/commit**](http://devops.bktencent.com/ms/process/api/external/scm/gitlab/commit)' is blocked: Host cannot be resolved or invalid

gitlab 无法解析BKCI的域名。

需要在gitlab的机器上配置devops.bktencent.com的hosts解析





## Q4：偶现 webhook 触发不生效 

经排查日志，发现是流水线并行数量超过了限制的50个任务并发。

<img src="../../../../assets/max_parallel_error.png">

可以修改数据库
update devops_process.T_PIPELINE_SETTING set MAX_CON_RUNNING_QUEUE_SIZE=100 where PIPELINE_ID='${pipeline_id}'; 
建议最大不超过100





## Q5: 定时触发的流水线，时间显示不对，触发时间也不对

![](../../../../assets/wecom-temp-26d5087b12647b6801f5d8471eeb3ee6.png)请检查BKCI服务器的时间是否正常