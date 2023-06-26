## Q1:公共构建机启动失败

no available Docker VM

![](../../../../assets/image-20220301101202-ceNsG.png)

没有可用的ci-dockerhost，需要检查:

1\. 在ci-dispatch节点执行 /data/src/ci/scripts/bkci-op.sh list 查看是否有状态为true的行.

2\. 如果依旧无法调度, 需要检查ci-dispatch的日志有无异常. 或者涉及dockerhost ip的日志.

原因是当时部署BKCI的时候因为服务器资源有限，把构建机 微服务 网关都放到一台机器上 导致构建机内存使用率过高，构建环境的时候找不到可用构建机，现在把构建机单独部署到别的机器上 之前的那些报错就都没了。

3、主机资源不足时也会导致启动失败。请确认公共构建机节点 DISK_LOAD<95%，CPU_LOAD<100%，MEM_LOAD <80%

---

## Q2: 公共构建机偶现启动失败

**Get credential failed**

已知问题，将dispatch-docker/lib/bcprov-jdk15on-1.64.jar删除，这是个软链，删除即可，然后重启dispatch-docker服务`systemctl restart BKCI-dispatch-docker.service`

---

## Q3: 流水线构建失败，Agent心跳超时/Agent Dead，请检查构建机状态

**原因①**：常见于在公共构建机上运行耗费内存的编译任务，导致容器oom。

在公共构建机上执行`grep oom /var/log/messages`通常能看到匹配记录，如果是因为多个任务同时跑在同一台构建机上导致oom，可以通过调整调度算法的内存阈值，避免单台构建机上运行过多任务；如果单个编译任务就触发oom，建议调高构建机的内存，或者使用内存更高的私有构建机



**原因②**：CI 机器负载过高，导致服务响应超时或服务异常

BKCI页面变的卡顿。在流水线执行时，到 CI 机器使用 top 查看机器负载非常高。

当 upload 的文件包体过大时常发此问题。上传包体可以承受的大小受BKCI机器的配置及IO、网络影响，通常不建议上传单体超过8G的包体。

---

## Q4:机器无法连网，公共构建机/无编译环境无法下载镜像，构建启动失败

目前公共构建机可以使用任意镜像, 无编译环境需要联网下载镜像.

目前需要你将无编译环境部署到可联网的区域, 并放行访问docker hub的地址.

公共构建机填写镜像地址为你们的私有docker registry.

并人工转存docker hub上的bkci/ci:latest到私有docker registry.



---

## Q5: 公共/私有构建步骤卡在准备构建环境中

![](../../../../assets/企业微信截图_16419529383724.png)

如果是**公共构建机**，优先考虑公共构建机BKCI-dockerhost.service服务是否正常

这种情况多见于**私有构建机**，多为agent安装异常导致，这里列举一些已知的原因：

1. 网络原因，如无法解析BKCI域名、BKCI服务不可达等
2. agent版本安装错误，如在mac上安装linux的agent包，这种情况，将BKCIagent安装包删除，重新安装对应版本agent即可
3. 在BKCIagent安装目录的logs下的agentDaemon.log日志里可见`too many open files`,在机器上执行`ulimit -n`结果显示，可打开的文件数值太小，默认为1024，将其数值调大，重新安装BKCIagent即可

![](../../../../assets/wecom-temp-2cf366a83acf24ef09ae7dff30c47354.png)

![](../../../../assets/wecom-temp-2eadbe319d03b3049c6b4cf300cda012.png)



4. 如果查看构建日志发现如下报错：

   UnknownHostException|request(Request{method=PUT,url=http://devgw.xxxx.xxx.com/ms/process/api/build/builds/started,tag=null}),error is :java.net.UnknownHostException: xx.xx.xx.com: nodename nor servname provided, or not known, try to retry 5

   ![](../../../../assets/start_agent_fail.png)

   

   原因：说明本地应该是安装了Proxifier之类的代理软件，拦截了构建机启动任务时的网络请求。

   解决办法：停止代理软件。

