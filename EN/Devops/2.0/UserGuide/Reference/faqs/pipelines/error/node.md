 ## Q1: Failed to start BK-CI hosted agent 

 No Docker VM available 

 ![](../../../../assets/image-20220301101202-ceNsG.png) 

 No ci-dockerhost available, need to check: 

 1. execute/data/src/ci/scripts/ www.example.com list on the ci-dispatch node BK-CI-op.sh to see if there are any lines with status true. 

 2. If it still does not schedule, you need to check the ci-dispatch log for anything abnormal. Or the log that includes the dockerhost ip. 

 The reason is that when deploying BK-CI, due to limited service resources, putting the agent microservice gateway on a machine led to high ramUsageRate of the builder, and no available builder could be found when buildEnvType. Now these errors have disappeared before deploying the builder to other machines. 

 3. Insufficient host resources will also cause startup to fail.  Please confirm that the BK-CI hosted agent node Disk_LOAD<95%, CPU_LOAD<100%, MEM_LOAD <80% 

 --- 

 ## Q2: The BK-CI hosted agent failed to start occasionally 

 **Get credential failed** The problem is known. 

 The problem is known. delete dispatch-docker/lib/bcprov-jdk15on-1.64.jar, which is a soft link. Delete it and restart the dispatch-docker service `systemctl restart BK-CI-dispatch-docker.service'. 

 --- 

 ## Q3: Pipeline buildFail. Agent HEARTBEAT_TIMEOUT/Agent dead. Please check the agent status 

 **Reason ①**: It is common to run memory compilation task on BK-CI hosted agent, resulting in container oom. 

 Run `grep oom /var/log/messages` on a public build machine and you will usually see matching records. If multiple tasks run on the same build machine at the same time and oom occurs, you may want to adjust the memory threshold of the scheduling algorithm to avoid running too many tasks on a single build machine; if a single compile task triggers oom, it is recommended to increase the memory of the agent, or use a self-hosted agent with more memory. 



 **Cause ②**: The service response timeout or service abnormal is caused by the high load of the CI machine. 

 The BK-CI page has frozen.  While pipeline is running, use top to the CI machine to see that the machine load is very high. 

 This problem often occurs when the upload file is too large.  The size of the upload packet is affected by the configuration, IO, and network of the BK-CI machine. It is generally not recommended to upload packets with a single size greater than 8G. 

 --- 

 ## Q4: The machine cannot connect to the network. The BK-CI hosted agent/noEnv cannot download the image. The boot failed. 

 Currently, the BK-CI Hosted Agent can use any image, noEnv needs to download the image network. 

 You must deploy the noEnv on a network accessible gateway and allow access to the Docker Hub address. 

 Fill in the mirror address for your private docker registry in the BK-CI hosted agent. 

 And manually transfer the BK-CI/ci:latest on the docker hub to the private docker registry. 


--- 

## Q5: Public/Private build step is stuck PREPARE_ENV 

![](../../../../assets/WeComscreenshot_16419529383724.png) 

If it is a **BK-CI hosted agent**, the priority is to check if the public builder BK-CI-dockerhost.service is normal. 

This situation is often seen in **self-hosted agents**, and is usually caused by an abnormal agent installation. Here are some known causes: 

1. Network reasons, such as unable to resolve BK-CI domain name, BK-CI service unreachable, etc. 2. agentVersion install error, such as installing Linux agent package on Mac, in this case, delete the BK-CIagent installation package and reinstall the appropriate version of agent 3. Too many open files' can be seen in the agentDaemon.log log under the logs of the BK-CIagent installation directory. The result of running `ulimit -n' on the machine indicates that the number of files that can be opened is too small. The default is 1024. Increase the value and reinstall BK-CIagent. 

![](../../../../assets/wecom-temp-2cf366a83acf24ef09ae7dff30c47354.png) 

![](../../../../assets/wecom-temp-2eadbe319d03b3049c6b4cf300cda012.png) 



4. When you view the build log, you find the following error 

   UnknownHostException|request(Request{method=PUT,url=http://devgw.xxxx.xxx.com/ms/process/api/build/builds/started,tag=null}),error is :java.net.UnknownHostException: xx.xx.xx.com: nodename nor servname provided, or not known, try to retry 5. 

   ![](../../../../assets/start_agent_fail.png) 

   

   Reason: It describes that proxy software such as Proxifier is installed locally, which intercepts the network request when the agent starts. 

   Workaround: Pause the agent software.