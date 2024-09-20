 # Pipeline FAQ 

 ## GitLab FAQ 

 ### Q1: Can't gitlab event trigger Plugin trigger events? 

1. Check whether the pipeline is registered in the devops\_ci\_process.T\_PIPELINE\_WEBHOOK table, SELECT \* FROM devops\_ci\_process.T\_PIPELINE\_WEBHOOK WHERE pipeline\_id = ${pipeline\_id}, ${pipeline\_id} can be obtained from the url address
 2. if not register    
    1. view if the repository service is connected to the gitlba network    
    2. view whether the gitlab repository has master permissions    
    3. On the machine where the repository service Deploy, execute grep "Start to add the web hook of " $BK\_HOME/logs/ci/repository/repository-devops.log to find the reason for the registration failed. The default value for $BK\_HOME is/data/bkce 
3. if it is register,    
    1. Go to the webhook page of gitlab and view whether the registration is Success, as shown in Figure 1.    
    2. If there is a registered URL in gitlab, the URL is [http://domain/external/scm/codegit/commit](http://xn--eqrt2g/external/scm/codegit/commit) and edit to view the sending detail, as shown in Figure 2    
    3. view the detail that gitlab has not sent, as shown in Figure 3. If all the above are OK, on the machine where the process service Deploy, execute grep "Trigger gitlab build" $BK\_HOME/logs/ci/process/process-devops.log to search for the log of the trigger entry. 

![](<../../../assets/image (58) (1).png>)

![](<../../../assets/image (59).png>)

![](<../../../assets/image (57).png>)

 ### Q2: Common reasons for errors associated link GitLab Code Repository 

 ![](../../../assets/repo_gitlab.png) 

 Personal Access Tokens should be used instead of project tokens. 

 2. Confirm whether the corresponding auth is given when Generate Access_Tokens.  The corresponding API auth Must be included. 

 3. If it is a self-built GitLab, please Confirm whether the "repository/branches" API is available. 

 https://docs.gitlab.com/ee/api/branches.html 

 4. If GitLab is accessed through https.  Please Confirm if the Code Repository does http-->https location.  By default, BK-CI uses http for Code Repository access. 

 If no location is made, please Revise the BK-CI file according to this temporary scheme: 

 ```bash 
 vim /data/bkce/etc/ci/application-repository.yml 

 #Revise the application-repository.yml file and change the apiUrl to https #gitlab v4. 
 gitlab: 
 apiUrl: https://devops.bktencent.com/api/v4 
 ``` 

 restart bkci-repository.service 

 systemctl restart bkci-repository.service 

 ## Pipeline FAQ 

 ### Q1: What do the Pipeline mean? 

 The status of Pipeline is summarized as follows: 

 ![](../../../assets/image-20220301101202-uphlD.png) 

 ### Q2: How is the BK-CI Pipeline progress bar Processing? 

 The progress bar is an estimate made by the BK-CI front-end based on data related to Pipeline.  This progress is not an accurate time and is for informational purposes only. 

 ![](../../../assets/progress bar.png) 



 ### Q4: What are the Global Variables of BK-CI? 


 -  [Predefined Constants/var](../../../intro/terminology/pre-define-var/README.md) 


 ### Q5: How do I get pipelineId? 

 In the Pipeline URL, the Parameter after pipeline are Project ID and pipelineId respectively.  For example, in http://devops.bktencent.com/console/pipeline/iccentest/p-8f3d1b399897452e901796cf4048c9e2/history, iccenter is the Project ID, and p-xxx is pipelineId 

 ### Q6: Why doesn't the Plugin have a retry button when the Pipeline fail? 

 Only One most recent build can be retry. 

 ### Q7: What is the use of viewManage and labelManage in BK-CI Pipeline? 

 Service Classification Pipeline. When the Quantity of pipelines is large, label and view will have greater effect. 

 ### Q8: How can I view the Timestamp when viewLog? 

 viewLog page, Show/Hide Timestamp 

 ![](../../../assets/image-20220301101202-QERjn.png) 

 ## FAQ for agent 

 ### Q1: Can I only use a Self hosted agent to Generate images with docker build? 

 It is recommended to use a Self hosted agent. The BK-CI hosted agent DinD solution has Safety risks, so it needs a private build mechanism as an image. 

 If BK-CI consumers are trusted, they can use our delivery team's DinD**solution** 

 ### Q2: Can only one agent be installed on One Mac 

 You can have more than one. You can Start Up the agent in different directories. Each agent instance needs to be completely install, and the existing agent directory cannot be copy directly. 

###  Q3: BK-CI hosted agent, are these supported? 

 ![](../../../assets/image-1646103610029.png) 

 The BK-CI hosted agent relies on docker and can only Run linux. At the moment you can only Run Build Image based on our bkci/ci:alpine (debian system). 

 ### Q4: Does the Self hosted agent Must to be a physical machine?  Can it be a Docker container? 

 Self hosted agent and project Binding, and need to RUNNING and register. It is recommended to use Scene with few changes such as physical machines/virtual machines. Containerization uses the BK-CI hosted agent. 

 ### Q5: No Docker VMs available for BK-CI hosted agent 

 ![](../../../assets/image-20220301101202-ceNsG.png) 

 There is no ci-dockerhost available. Need: 

 1\. execute/data/src/ci/scripts/ www.example.com list on the ci-dispatch node bkci-op.sh to view if there are any rows with status true. 

 2\. If it still cannot be Schedule, you need to check the ci-dispatch log for abnormal. Or log involving the dockerhost ip. 

 The reason is that when Deploy BK-CI, due to limited service resources, putting the agent microservice Gateway on One machine led to high ramUsageRate of the builder, and no available builder could be found when buildEnvType. Now, those errors before deploying the builder to other machines are gone. 

 3. Insufficient Host resources will also cause Start Up failed.  Please Confirm that Disk_LOAD<95%, CPU_LOAD<100%, MEM_LOAD <80% 

 ---- 

 ## Not sure how to categorize FAQ 

 ### Q1: How does the product build by the BK-CI Pipeline support service distribution speed limit setting? 

 Adjust the speed limit of distribution source, as shown in the figure below. For machines where the agent has been installed, you can remove it first and then install it. IP: 192.168.5.134 

 ![](../../../assets/image-20220301101202-PluSB.png) 



 ### Q2: Can the projectName be Revise? 

 The projectName can be modify within projectManage, the englishName (i.e. Project ID) cannot be changed. 

 ![](../../../assets/image-20220301101202-qTzdw.png) 

 ![](../../../assets/image-20220301101202-FyiDk.png) 



 ### Q3: How to auto distribute the build products to the specified service approve BK-CI? 

 With the Deploy machine, we can distribute the artifactory to the Test machine.  First append One noEnv Job 3-1, Add plugin Job System distribution and complete setting. 

 ![](../../../assets/image-20220301101202-vGRcA.png) 

 ### Q4: After Python Env Variables append, they do not Take Effect during job execute.  (Job error "The system cannot find the specified file") 

 Because the account used by BK-CI agent and BlueKing agent is system, the Env Variables added to administrator does not Take Effect. You need to add python.exe and pip3.exe pip.exe to the system environment variable, and then restart The operating system 

 ### Q5: Can I upload a build product to a specified Private GitLab repository approve the BK-CI Pipeline? 

 BK-CIgit Plugin No data push function.  user can place the sshKey on the agent and use the git command in the Batch Script Plugin or Bash plugin to push the product to a temporary solution. 

 ### Q6: The node machine Display normal. Why is there no data in the monitoring networkIo? 

 ![](../../../assets/image-20220301101202-Lkelb.png) 

 Not Enable. This monitoring is meaningless and does not affect Schedule. It is recommended to use a special monitoring system such as BK Monitor. 

 To Enable: 

 ```
 1. setting bin/03-userdef/ci.env 
 2. append BK_CI_ENVIRONMENT_AGENT_COLLECTOR_ON=true 3. Then append the influxdb related configItem. 
 4. install ci-environment. Can be used directly./  bk_install ci install. 
 5. Revise an existing agent: edit.agent.properties , setting devops.agent.collectorOn=true, restart agent. 
 ``` 

 ### Q7: How to use docker build to package an image and then Push image to Harbor? My docker build environment does not have docker commands. 

 Self hosted agent can be used. There is no dockerd in the container. For Safety reasons, the dockerd of the Host cannot be Operation in the container, or if the BK-CI consumer is trusted, we can use the DinD **solution of our delivery team** 

 --- 

 ## auth FAQ 

 ### Q1: Why do I sometimes need to apply Pipeline auth, but it is restore after F5 reflash? 

 There is a auth conflict. In the userGroup permission, there are permissions for multiple Pipeline. However, there is only One Pipeline auth in the customize. A later Update will fix this issue.  The workaround is to delete customize auth.  The issue will be fixed approve version Update. 

 ![](../../../assets/image-20220301101202-HIaKn.png) 

 ## Do you need an existing FAQ 

 ###  Q1: How to pass var between bash Plugin, One bash atomOutput variables, the next bash plugin can reference? 

 BK-CI provided the setEnv command for the bash Plugin to Set the Global Variables of BK-CI.`setEnv 'Name and' value '` are as follows: 

 `setEnv 'cmdb' '3.2.16'` 

 setEnv Set the Output Parameters of the current bash, which will Take Effect only in the downstream. The current bash cannot print them. 

 Use `call:setEnv "FILENAME" " www.example.com "` in the windows batchscript Plugin package.zip and then use %FILENAME% to reference this var in subsequent batchscript plug-ins 
 
## BlueKing Related 

### Q1: Is there a way to call BK-CI from Standard OPS? 

Pipeline stage-1 trigger select remote. Then the Standard OPS calls job to quickly execute the Script, and calls the URL prompted in the remote Plugin. 

## log FAQ 

### Q1:ci does not Display log 

![](../../../assets/image-20220301101202-xwkmo.png) 

The requested log was not found on this server. 

![](../../../assets/image-20220301101202-bduGg.png) 

One index that accounts for 12 shards exceeds the Maximum shards Set by es7, which is the Limit of es7 

Solution: Clean up some useless indexes 

source /data/install/utils.fc curl -s -u elastic:$BK_ES7_ADMIN_PASSWORD -X GET http://$BK_ES7_IP:9200/_cat/indices? v delete index # index is the index name curl -s -u elastic:$BK_ES7_ADMIN_PASSWORD -X DELETE http://$BK_ES7_IP:9200/index #Note: Cannot delete.security-7 ``` 

![](../../../assets/image-20220301101202-RWPNo.png) 

**One possibility is that the user does not have es7 installed** 

### Q2: How to make your Pipeline log Display with different colors 

in Pipeline log Components, we definition the following keywords for use by Develop Plugin. 

 | keywords          | function                             | remark                                           | 
 | --------------- | -------------------------------- | ---------------------------------------------- | 
 | ##\[section]    | The beginning of One Job or Plugin            | if it is that begin of a Plugin, it Must be included in the star of One Job| 
 | ##\[endsection] |End of One Job or Plugin            | If it is the end of a Plugin, it Must be included in the Finishing of One Job| 
 | ##\[command]    | Highlight the following string with ShellScripts|  #0070BB                                        | 
 | ##\[info]       | Mark the following string as info color     | #48BB31                                        | 
 | ##\[warning]    | Mark the following string as the warning color|  #BBBB23                                        | 
 | ##\[error]      | Marks the following string with the error color    | #DE0A1A                                        | 
 | ##\[debug]      | Mark the following string as debug color    | #0D8F61                                        | 
 | ##\[group]      | The beginning of One collapse                   |                                                | 
 | ##\[endgroup]   | One collapse end                   |                                                | 

 **Take the Bash Plugin as an example:** 

```bash
echo "##[command]whoami"
whoami
echo "##[command]pwd"
pwd
echo "##[command]uptime"
uptime
echo "##[command]python --version"
python --version

echo "##[info] this is a info log"
echo "##[warning] this is a warning log"
echo "##[error] this is a error log"
echo "##[debug] this is a debug log"

echo "##[group] Print SYSTEM ENV"
env
echo "##[endgroup]"
```

 You will see the effect shown below 

 ![](../../../assets/image2020-1-9\_21-59-12.png) 

 ## Image Related 

 ### Q1: An error occurred when upload images. The program changed the http method to https by default. 

 ![](../../../assets/image-20220301101202-UayBz.png) 

 Docker default is https, this needs to change the service docker. You need to append insecure-registry to/etc/docker/daemon.json on the dockerhost machine. 

 By default, BK-CI uses https to Push images. If you want to use http, you need to setting the repository domain name to insecure. 

 If you use https, if the repository domain name is not the certificate that corresponds to the docker client when it is installed, you need to import the certificate corresponding to this domain name in the agent 

 ### Q: Where can I view the jar packages upload to the BK-Repo?  Use Default 

 BlueKing Community Reference: [https://bk.tencent.com/s-mart/community/question/2380](https://bk.tencent.com/s-mart/community/question/2380) 

 ### Q: failed to Pull image. Error Message: status 500 

 ![](../../../assets/image-20220301101202-CVycR.png) 

 user repositories, network accessibility must be ensured first 



 ### Q: failed to open exe with python in the Pipeline runs of Windos agent 

 Under windows, the agent cannot pull up the exe with UI interface. 

 This is the Windows Session 0 Limit 

 ### Q: failed to connect to gitlib.xxx.com port 443:connection timed out 

 ![](../../../assets/image-20220301101202-AaxCJ.png) 

 The reason for the network disconnection is that after dockerhost Start Up, the command equivalent to sysctl -p is execute, causing net.ipv4.ip\_forward to be Reset to 0, causing the container to be disconnected from the network. 

```
sysctl -p | grep -F net.ipv4.ip_forward
net.ipv4.ip_forward = 0
Start a test container alone:
docker run -it --rm centos
should see
WARNING: IPv4 forwarding is disabled. Networking will not work.
Execute the command in the container, and after waiting, you will see a prompt timeout:
curl -m 3 -v paas.service.consul
Then execute systemctl restart BK-CI-docker-dns-redirect
Start a test container alone:
docker run -it --rm centos
Execute the command in the container, you can see the network recovery:
curl -v paas.service.consul
```

###  Q: The agent needs to connect to docker, the service can not connect to the network, how to deal with it? 

 At present, the BK-CI hosted agent can use any image, noEnv needs to download the image network. 

 You need to Deploy the noEnv to a network-accessible gateway and allow access to the docker hub address. 

 The BK-CI hosted agent Fill In in the mirror address for your Private docker registry. 

 And manually transfer the bkci/ci:latest on the docker hub to the Private docker registry. 

 ### Q: No credentials are select after new ticket 

 Check whether the browser has an error after create, and check whether the log of ci-auth and ci-ticket are abnormal. 

 If it was create by a Normal user, you can switch to the Administrator account to view if it was Success created. 

 ### Q: How to use mount? There is no data in the drop-down box 

 ![](../../../assets/image-20220301101202-sxXbU.png) 

 This requires maintaining One NFS Shared Storage service, which is not Recommended and may be remove later 

 OK practice is to package the dependent tools into the image in two Stage 

 The job in Stage A has a task A: Is to Clone the git Code and build the compiled package jar 

 The job in Stage B has a task-B: It is to deploy OK jar scp build in task-A to the service. 

 It turns out that the two Stage of the workspace are not common.  The current practice is to put them all into One Job, so that we can share a workspace build the production jar file. 

 Design so, CI products if you want to Deploy out, you Must go to the BK-Repo, with maven private server idea is right 

 ### Q: store: The atomCode Field in the Plugin Config file\[task.json] is inconsistent with the one entered in the workbench 

 ![](../../../assets/image-20220301101202-WRucB.png) 

 upload, may not be Plugin Release package, is the source Code.  The Release process looks at the readme of the Plugin 

 If you are upload the correct Release package, you can temporarily edit the task.json in the plugin ZIP package, Revise atomCode(consistent with the upload interface, without underscores), and then repackage and upload. 

 ### Q: failed to upload Plugin package 

 ![](../../../assets/image-20220301101202-iJWQt.png) 

 You can first check whether the blueking user can read and write the artifactory Data directory normal: /data/bkce/public/ci/artifactory/ 

 Then check the artifactory log file to see the error. 

 ### Q: BK-CI reported an error when append node bkiam v3 failed 

 ![](../../../assets/image-20220301101202-MyIAk.png) 

 ### Then I checked the log according to the given The document 

 /data/bkce/ci/environment/logs/environment-devops.log 

 /data/bkce/ci/environment/logs/auth-devops.log 

 ![](../../../assets/image-20220301101202-GyIic.png) 

 Troubleshooting found that the T\_AUTH\_IAM\_CALLBACK table under ci Auth library is empty 

 the reason is that that initial setting of the cluster failed, but the Script did not terminate 

```
Ci initialization 
reg ci-auth callback.
[1] 19:29:00 [SUCCESS] 172.16.1.49
{
  "timestamp" : 1626291190535,
  "status" : 500,
  "error" : "Internal Server Error",
  "message" : "",
  "path" : "/api/op/auth/iam/callback/"
}Stderr: * About to connect() to localhost port 21936 (#0)
Solution: Try to manual register the callback of ci-auth. 
source /data/install/load_env.sh
iam_callback="support-files/ms-init/auth/iam-callback-resource-registere.conf"
./pcmd.sh -H "$BK_CI_AUTH_IP0" curl -vsX POST "http://localhost:$BK_CI_AUTH_API_PORT/api/op/auth/iam/callback/" -H "Content-Type:application/json" -d @${BK_PKG_SRC_PATH:-/data/src}/ci/support-files/ms-init/auth/iam-callback-resource-registere.conf
```

###  Q: Is the Upload artifacts upload function uploaded to the agent current using the stage build or has a separate repository location 

Archive artifactory is to archive the products on agent to a dedicated product repository. The product repository is independent of the builder and is determined by the Artifactory service. 

The Archive of CI is to temporarily store the product in the warehouse for convenient use by downstream Operation of the Pipeline or as the source of subsequent Deploy. Currently, it is not supported to specify the artifactory Storage method according to the cloud where the current agent is located during archiving. 

What you description looks like the distribution of artifactory, and it might make more sense to Operation so approve a Deploy tool. 

Or you can customize Plugin to implement your own Archive 

### Q: Is there a file Description how to Develop the BK-CI Plugin? 

Develop Plugin Guide: docs.BK-CI.net/store/plugins/create-plugin 

### Q: JOOQ;uncategorized SQLException for SQL 

![](../../../assets/image-20220301101202-rtxbB.png) 

The old SQL was not cleaned. 

```
#  Clean up the flag file and import All sql files 
for sql_flag in $HOME/.migrate/*_ci_*.sql; do
chattr -i "$sql_flag" && rm "$sql_flag"
done
#  import Database SQL is only execute in the central console 
cd ${CTRL_DIR:-/data/install}
./bin/sql_migrate.sh -n mysql-ci /data/src/ci/support-files/sql/*.sql
```

### Q: private configuration of key JOB\_HOST is missing

![](../../../assets/image-20220301101202-QtZoR.png)

job Script execute Plugin link: [https://github.com/TencentBlueKing/ci-executeJobScript](https://github.com/TencentBlueKing/ci-executeJobScript)

The JOB\_HOST Field is missing in the Private setting. You can configure it According to shown above 

![](../../../assets/脚本执行配置1.png)

###  Q: The Send Email Plugin is not available 

![](../../../assets/WeComscreenshot\_16408694122894.png)

The execute environment of the Plugin is divided into compiled environment and non-compiled environment. The execution environment of the plug-in for sending Email is non-compiled environment. When create a Job, you need to select the Job type as non-compiled environment, i.e. Agentless 

![](../../../assets/image-20220301101202-SfGeA.png)

![](../../../assets/image-20220301101202-dhitX.png)

### Q:  Send Email Plugin SUCCEED, but no mail was received 

 1. First, setting the ESB mail information. For more information, please see: [https://bk.tencent.com/s-mart/community/question/2532](https://bk.tencent.com/s-mart/community/question/2532)
 2. setting the Private configuration of the Plugin, see: [https://github.com/TencentBlueKing/ci-sendEmail](https://github.com/TencentBlueKing/ci-sendEmail)

### Q: The sender setting of the send Email Plugin is not the sender I configured 

 ![](../../../assets/image-20220301101202-gdDMH.png) 

 sender needs to be Set in the "Private setting" of the Plugin, independent of the mail\_sender of the ESB 

 "store"-"Pipeline Plugin"-"Workbench"-"select Send Email Plugin"-"Settings"-"Private setting"-"Add Sender Field" 

![](../../../assets/wecom-temp-de1f999781431e708256b5e9a9ecc1d6.png)

![](../../../assets/wecom-temp-79503b33558fb2f05c4579c99280f8e7.png)

![](../../../assets/wecom-temp-ad2da5032b4af609e41012bd4113bf84.png)

![](../../../assets/wecom-temp-888da4cdb34f2bbcdc3869f7f4ff6dda.png)

![](../../../assets/wecom-temp-8f040f0a22d3e9b0ff75a6b3ff40410b.png)

![](../../../assets/wecom-temp-db0217ab76483f286bfb63cd7047f353.png)

 In addition to the sender Field, Other fields need to be setting. Please refer to: [https://github.com/TencentBlueKing/ci-sendEmail](https://github.com/TencentBlueKing/ci-sendEmail)

###  Q: How can Business Name in the Configuration System be link with the BlueKing Container Service? 

 ![](../../../assets/WeCom screenshot\_16412880662873.png) 

 ![](../../../assets/WeCom screenshot\_16412881057362.png) 

 1. Check whether The user Account has the "local-k8s" Configuration System permission in the accessCenter. 
 2. In the Configuration System, check whether The Account user in "resources-Business Name-OPS Personnel" 

 ![](../../../assets/wecom-temp-ac68ebc38b2022819c8540b00100d2fb.png) 

 ### Q: How to use Merge-Request-Accept-Hook? Why is it not triggered?  I want the Pipeline to trigger when the Branch feature\_lzj\_test123123213 merges into feature\_lzj\_test0117 

 ![](../../../assets/image-20220301101202-RtEPQ.png) 

 The Merge Request Accept Hook is triggered when the source Branch ** Success merges into the target branch ** 

 For example, if you need to merge feat\_1 into the dev Branch, write dev for the branch and feat\_1 for the listening source branch (you can also use the fuzzy match function with\*, such as feat\_\*) 

 ![](../../../assets/image-20220301101202-pxOZb.png) 

 ### Q: Where is the webhook address configured for gitlab Triggers? You need to manual configure One URL for jenkins. 

 You do No Need to setting this hook. Blue BK-CI will register the webhook by itself. After select the Event type and save, the webhook will be registered auto. 

 ![](../../../assets/wecom-temp-d5c48ee99a96d373426491d14d56e404.png) 

 ### Q: failed to trigger gitlab 

1. Check if the Branch match 
2. Check the devops\_ci\_process.T\_PIPELINE\_WEBHOOK table to see if this pipeline is registered, SELECT \* FROM devops\_ci\_process.T\_PIPELINE\_WEBHOOK WHERE pipeline\_id = ${pipeline\_id}, ${ pipeline\_id} can be obtained from the url address
3. If the gitlab webhook page does not have a webhook registration record, such as

    <img src="../../../assets/image-20220128124536187.png" alt="" data-size="original">

     1. Check whether the network between the repository service and gitlab can be communicated, such as whether to configure gitlab's domain name resolution
     2. Check whether the authority of the gitlab warehouse is the master authority, that is, the user who generates the accesstoken needs to be the `maintainer` role of the warehouse, and the scopes required by the accesstoken are `api`

        <img src="../../../assets/wecom-temp-fe0a7bc1e72a97ec39e0a4e51e3e1e58.png" alt="" data-size="original">

        <img src="../../../assets/image-trigger-gitlab-accesstoken-maintainer.png" alt="需要选择maintainer" data-size="original">

        <img src="../../../assets/image-trigger-gitlab-accesstoken-view.png" alt="需要是maintainer" data-size="original">
    3. On the machine where the repository service is deployed, execute `grep "add the web hook of " $BK_HOME/logs/ci/repository/repository-devops.log` to find the reason for the registration failure. The default value of $BK\_HOME is /data/bkce
4.  If there is a webhook registration record on gitlab, such as

    <img src="../../../assets/image (58) (1) (1).png" alt="" data-size="original">

    If still not triggered:

    1.  Click Edit corresponding to the webhook to view the sending details of the webhook and view View detail

        <img src="../../../assets/image-gitlab-webhook-viewdetail.png" alt="" data-size="original">
    2.  View the error details sent, and check whether the network from gitlab to the BK-CI machine is reachable, such as whether the gitlab server can resolve the BK-CI domain name

        <img src="../../../assets/image-gitlab-webhook-request-detail.png" alt="" data-size="original">
5.  If there is no problem with the above, on the machine where the process service is deployed, execute grep "Trigger gitlab build" $BK\_HOME/logs/ci/process/process-devops.log to search the log to find the triggered entry log. Check the request body from gitlab push, and compare whether the `http_url` field in the request body matches the address of the code warehouse in the code library **exactly**. If one is a url in the form of a domain name and the other is a url in the form of an ip, then does not match, as follows:

    <img src="../../../assets/image-trigger-gitlab-webhook-post-body.png" alt="" data-size="original">

    <img src="../../../assets/image-trigger-gitlab-repo-ip-view.png" alt="" data-size="original">

###  Q: The batchscript Plugin cannot execute the bat file. The bat file contains var read from the system and Set by the current user. 

![](../../../assets/WeComscreenshot\_16285831782937.png)

Change the starting user of the corresponding agent service to the current user, execute the command `services.msc` to open the windows service management interface, and find the service `devops_agent_${agent_id}` (note: each agent\_id is different, agent\_id The value can be found in the configuration file .agent.properties)

Right-click -> Properties, select this account under the login page

If it is a build machine that enters the domain, fill in `domain name\user name` for the account name, such as `tencent\zhangsan`; if there is no build machine that enters the domain, fill in `.\username` for the account name, such as `.\admin, .\administrator, .\bkdevops`, after entering the password, click the confirm button

![](../../../assets/image-20220128181627246.png)

Right click -> Restart, restart the service

![](../../../assets/image-20220128181720819.png)

Open the task manager, check whether the processes devopsDaemon.exe and vopsAgent.exe exist, and check whether the user name of the two processes started is the currently logged-in user

### Q: There is a space in the command path in the batchscript, and the execution fails

![](../../../assets/WeComscreenshot\_16285852671573.png)

Commands with spaces can be enclosed in quotation marks ""

### Q: How to get the project through the interface\*\*

curl -X GET [https://devops.bktencent.com/prod/v3/apigw-app/projects/](https://devops.bktencent.com/prod/v3/apigw-app/projects/) -H "Content-Type: application/json" -H "X-DEVOPS-UID: admin"

### Q: The condition of "execute only if the previous plugin fails" feels useless, and it is executed if it succeeds.

![](../../../assets/wecom-temp-c6aa0d74275116c38ff7f592563616c7.png)

The actual meaning of this condition is: any plug-in before this plug-in fails to run, it meets the trigger condition, not when the "previous" plug-in fails to run

### Q: Can the English name of the project be modified?

Modification is not currently supported

### Q: How to get the project name, I want to bring it in the enterprise WeChat notification message

Use the global variable `${BK_CI_PROJECT_NAME}`

### Q: I have completed the BK-CI login in the browser, but I need to log in again to access BK-CI in different tabs of the same browser

In this case, the login cookie has expired. Now the default should be two hours, and the expiration time is adjustable.

### Q: There is a pipeline triggered by gitlab, but the code change record is empty, indicating that there is no new code change in the triggered build, so why is it triggered?

The possible reason is that the trigger listens to the commit event of the entire code base, but the code pull plug-in only pulls the code of a specific branch, and there is no code change in this branch. For example, the plug-in listens to the commit event of the entire code base , but the code pull plug-in only pulls the code of the master branch, and the commit is submitted to the dev branch. The code change record shows that the pulled branch intersects with the changes of the last physical examination. The master branch has not changed, so there is no change record .

### Q: Can pipelines and pipelines be mutually exclusive? Or when pipeline A starts and pipeline B starts, pipeline B waits for pipeline A to end

Now only the mutex group can be configured for the JOBs in the pipelines. If there is only one JOB in the two pipelines, then it is enough to configure the same mutex group for the JOB. If the pipeline has multiple jobs, it is necessary to add another pipeline to the two pipelines, and then configure mutual exclusion groups on the two main pipelines, and pull up tasks through this main pipeline.

![](../../../assets/wecom-temp-0427b67401a386578f79c2495a2009f8.png)

### Q:  The BK-CI Script starts One gradle daemon process.  It was Recent discovered that it was close when it was built.  Is it possible that the DevOps agent is involved? 

![](../../../assets/wecom-temp-d4178631b527e498ee7d8a0778c1fb09.png)

 After the BK-CI agent execute the buildTask, it will auto pause all sub-processes Start Up by the agent. If you do No Need to end the sub-processes, you can Set the Env Variables before starting the process: set DEVOPS\_DONT\_KILL\_PROCESS\_TREE=true. Set `setEnv "DEVOPS_DONT_KILL_PROCESS_TREE" "true"` in the bash Script. 

### Q:  Can I Set One value to determine whether to Run a Plugin based on this variable 

 select "varMatch" under the Plugin, and write the name and value that the custom variable needs to depend on 

![](../../../assets/image-20220210120321712.png)

### Q:  How to get the value of the Plugin var, how to write it right, for example, I want to get the value of flushDB in the plug-in, and then judge it in the Script, I found that writing this is Error? 

![](../../../assets/WeComscreenshot\_16318512177997.png)

![](../../../assets/WeComscreenshot\_16318512474377.png)

![](../../../assets/WeComscreenshot\_16318513189348.png)

右上角点击引用变量，然后点右边复制变量，然后粘贴到你需要的地方就可以

![](../../../assets/wecom-temp-edfeb72810d972dae34d3f8d98232ec6.png)

### Q:  How to add a Timestamp before each line of the log 

 Occupancy, to be resolved 

 ### Q: Is there a maximum of one buildTask to be run at a time, and the task execute later is forced to cancel the task executed first 

 There is currently no such feature 

 ### Q: We use One cat to Display Log. This method can be used, but there is a problem. The opening speed is very slow every time. It takes about 3 Second to display Log data. Is there any Other OK way to display log 

 About the problem of more than 3 Second, the main reason is that the log data corresponding to this task is large, and the Log Content is 3MB, so the time is spent on download 

 ### Q: While the Pipeline is executing, the build log of unity is not Display in Real time 

 The reason is that "the Script first execute the unity compilation build Operation, and at the same time writes the log to the file, but before The operation ends, the subsequent cat command will not be executed, resulting in the log not being Display on the web page in Real time." For this Scene, try the following workarounds: 

 ``` 
 nohup $UNITY_PATH -quit -batchmode -projectPath $UNITY_PROJECT_PATH -logFile $UNITY_LOG_PATH -executeMethod CNC.Editor.PackageBuilderMenu.BuildPC "${isMono} ${isDevelop} $UNITY_OUT_PATH" & echo $! > /tmp/unity_${BK_CI_BUILD_ID}.pid unity_main_pid=$(cat /tmp/unity_${BK_CI_BUILD_ID}.pid) tail -f --pid ${unity_main_pid} $UNITY_LOG_PATH 
 ``` 

 ### Q: How to conditionally execute CallPipeline Plugin 

 There is One Flow control under the Plugin, in which you can append Run conditions as needed to meet your requirements 

 ![](../../../assets/wecom-temp-70083f622bd2a6c839f9eb1b9436aac2.png) 

 ### Q: CallPipeline doesn't Parameter like this? 

 ![](../../../assets/wecom-temp-3d80fac2503d5be8620e76b0d8175798.png) 

 The variable `${flushDB}` needs to be referenced like this 

 ### Q: How to reference Global Variables? It seems that it is not possible to reference $BK\_CI\_BUILD\_FAIL\_TASKS like this 

 var references need curly braces `${BK_CI_BUILD_FAIL_TASKS}` 

### Q:  Can I Hide Other parameters when the selected Parameter are changed? For example, if I select build for operator, the tag parameter is hidden, just like the change event of the option Components in js 

 ![](../../../assets/WeComscreenshot\_1634710197325.png) 

 Not yet 

 ### Q: When I click execute, can I get the values in the Parameter drop-down list approve the customize API? 

 Interface customize is not supported 

 ### Q: The service Disk full. Can I delete these directory file? 

 ![](../../../assets/WeComscreenshot\_1635304491832.png) 

 These are all build artifacts. Currently, there is no expired cleanup Alert Rules for build artifacts. user can delete them as appropriate 

 ### Q: How can I change the Parameter value during Pipeline runs? 

 If it is a shell Plugin, you can Revise the Parameter value `setEnv "{KEY}" "{VALUE}"` as follows. 

 ### Q: How to call openapi in CI version 1.5.4 

 version does not enable OpenAPI.  You can upgrade to version 1.5.30 and above, The has OpenAPI enable. 

 ### Q: How to view the information in the voucher 

 ![](../../../assets/WeComscreenshot\_16372883269771-4480877.png) 

 For Safety reasons, The content is encryption and cannot be view 

 ### Q: Check whether the code supports lua 

 Lua is not supported for Code Analysis 

 ### Q: Can I extend the rules for Code Analysis by myself 

 Currently, the self-extension function is still In development, and the rules for self-extension Code Analysis are not supported. 

 ### Q: How to make Pipeline task optional 

 "Skip some on manual trigger" 

 ![](../../../assets/wecom-temp-ef4f873c64f962cc9582479c26442f2f.png) 

 ### Q: Do you want the BK-CI log window to retain its color?  Trying to make the failed more obvious 

 See [https://docs.bkci.net/reference/faqs/log-colors](https://docs.bkci.net/reference/faqs/log-colors) 

 ### Q: The job-job execute Plugin is grayed out, but I have already install it 

 ![](../../../assets/WeComscreenshot\_16384260669700.png) 

 This is a Plugin for noEnv. You need to select the linux compilation environment when select the JOB type. 

 ![](../../../assets/image-20220210193855866.png) 

 ### Q: What is this serviceId 

 ![](../../../assets/WeComscreenshot\_1638426248456.png) 

 serviceId in the Configuration System, which can also be seen in the Job System 

 ![](../../../assets/image-20220210194131021.png) 

 ![](../../../assets/image-20220210194135210.png) 

 ### Q: If I want to execute One python Task approve shell or bat, can I only pass BK-CI var through python command line, and I can't write variables back to BK-CI? 

 Problem One: You can get BK-CI variables approve getting Env Variables 

```
#  Single-line python example, var is the Name definition by the user in this step or Other steps, and BK_CI_START_USER_NAME is the Global Variables of BK-CI 
python -c "import os; print(os.environ.get('var'))"
python -c "import os; print(os.environ.get('BK_CI_START_USER_NAME'))"

#  If you know the name of the var you are definition, you can also get it in your own python file approve os.envion.get ('var ') 
cat << EOF > test.py
import os
print(os.environ.get('var'))
EOF
python test.py
```

 Question Two: How to write var back to BK-CI 

```
#  If it is a constant, the shell can use setEnv, and the bat can use call:setEnv to write the var back to BK-CI 
setEnv "var_name" "var_value" # shell
call:setEnv "var_name" "var_value"  # bat

#  Write python Script Output result to BK-CI 
var_value=`python script.py` # script.py里需要有print输出，如print("test")
setEnv "var_name" "${var_value}" # var_name="test"

#  Write the var to One file, then read the file in the shell, then setEnv 
python script.py > env.sh # 假设env.sh里为file_name="test.txt"
source env.sh
setEnv "var_name" "${file_name}"
```

 Question Three: Call python in the bat Script and write python Output back to BK-CI 

````
for /F %%i in('python3 D:\mytest.py') do (set res=%%i)
echo %res%
call:setEnv "var_name" %res%
````





### Q: gitlab webhook  error report  URL '[**http://devops.bktencent.com/ms/process/api/external/scm/gitlab/commit**](http://devops.bktencent.com/ms/process/api/external/scm/gitlab/commit)' is blocked: Host cannot be resolved or invalid

 You need to setting hosts resolution for devops.bktencent.com on your gitlab machine 

 ### Q: How can I Enter this red box? 

 ![](../../../assets/WeComscreenshot\_16257162702433.png) 

 "store"-"Workbench" 

 ![](../../../assets/wecom-temp-f1631f05683e7125be01a6b4e79492dd.png) 

 ### Q: I see that each job has its own independent workspace. Is there a case where multiple jobs share One workspace? 

 If you use a single (Self hosted agent) agent, multiple jobs will share One workspace 

 ### Q: bkiam v3 Error? 

 ![](../../../assets/WeComscreenshot\_16273862334714.png) 

 This problem is usually caused by the failure to Start Up the saas container in the accessCenter due to the restart of the machine. It can be solved by pulling up the container again 

 ### Q: If I want to force One Code scan when I propose a PR, how should I setting it? 

 If you are using gitlab managed Code, setting the gitlab Triggers directly. The types of events triggered are: 

 1. Commit Push Hook Triggered when Code is submit 
 2. Tag Push Hook Triggered when Code with tag is submitted 
 3. Merge Request Hook Triggered when there is a Code merge 
 4. Merge Request Accept Hook Triggered when Code is merged 

 ### Q: Some rules in Code Analysis are not applicable to our company. How can I Revise the rules? 

 The content of a rule cannot be Revise, but the Checkersets can be modified.  Code Analysis is performed by taking Checkersets as the unit. If some rules are found to be inapplicable, they can be removed from the rule set. If The rule set is the default rule set, user are not Allow to add or delete them. You can select to create a customize rule set Base on this rule set. Users can add or delete some specific rules in the created rule set 

 ### Q: Code Analysis failed. Unknown Error: Unexpected char 0x5468 at 0 in X-DEVOPS-UID value： xxx 

 ![](../../../assets/WeComscreenshot\_1630326503372.png) 

 One step will read the gitlab fullname, Set to English to solve the problem, currently does not support the Chinese gitlab fullname, the profile username is displayed above the fullname, such as vinco huang here, you can Enter the Revise page approve the "Edit profile" here 

 ![](../../../assets/WeComscreenshot\_16303286841990.png) 

 ### Q: I want to attach a link to the current built artifacts file to the message notification sent by the enterprise and micro-enterprise. How do The construct the downloadLink of the attachment? 

[http://devops.bktencent.com/ms/artifactory/api/user/artifactories/file/download/local?filePath=/bk-archive/panda/](http://devops.bktencent.com/ms/artifactory/api/user/artifactories/file/download/local?filePath=/bk-archive/panda/)${BK\_CI\_PIPELINE\_ID}/${BK\_CI\_BUILD\_ID}/{你的artifacts文件名}

### Q:  Does the docker public build support its own images? 

 support, reference [https://docs.bkci.net/store/ci-images](https://docs.bkci.net/store/ci-images)

### Q: Does KCI support selecting One idle machine in the Private build cluster Run Pipeline? For example, if we compile the packaging service, there may be multiple people Operation the packaging of different Branch at the same time. 

 If there are multiple Self hosted agent, a private build cluster can be formed. After select this cluster, the BK-CI Pipeline selects one of them to build According to a certain algorithm: 

 **The Algorithm is as follows:** 

 **Agent with highest Priority:** 

 1. This agent was used in a Recent buildTask 
 2. There are current no buildTask 

 **Next highest Priority agent:** 

 1. This agent was used in a Recent buildTask 
 2. There are current buildTask, but the Quantity of build tasks does not reach the maxConcurrency of the current agent 

 **Agent with the Three Priority:** 

 1. There are current no buildTask 

 **Agent with the Four Priority:** 

 1. There are current buildTask, but the Quantity of build tasks does not reach the maxConcurrency of the current agent 

 **Minimum Priority:** 

 1. None of the above conditions are met 

 ### Q: [**https://docs.bkci.net /** ](docs.bkci.net) cannot be opened 

 ![](../../../assets/WeComscreenshot\_16342628987332.png) 

 This The document is hosted by gitbook and requires access to some of Google's resources, which can be problematic if the user's network does not have access to Google 

 ### Q: The machine was restart after power failure, but some service of BlueKing did not start up. Are these services not Set boot Start Up? 

 There are dependencies between service. For example, some services of BlueKing dependOn MySQL. If these services are Start Up before MySQL, the startup will failed. 

 ### Q: I have pipeline A, which can be execute independently, and I have pipeline B, which will call A and wait for One result of A. How to implement mutual exclusion 

 **Reserved, to be supplemented** 

 ### Q: You can Set auth for Pipeline. For example, A can see part of the 10 pipelines under One project, while B can only see the other part. You want to divide them according to their functions. 

 The accessCenter can Manage a single Pipeline. First, grant project permission to a specific user, and then grant permission to a single pipeline 

![](../../../assets/wecom-temp-478bbf51b9813c4ec50828781038028b.png)

![](../../../assets/wecom-temp-d29b308520dfa33da51158b2d5c055a9.png)

![](../../../assets/wecom-temp-1e44f6048453bb9873ad1cc81c869a5e.png)

###  Q: Can the var of Pipeline be linked? For example, if I select the value of variable 1 as A, the value of variable 2 will auto change to A? 

 Linkage is not supported for the time being. If the value does not changed, you can Set the defaultValue 

 ### Q: Is there a Plugin that supports git push? I want to push something to Code repository. 

 You can try to push with account password: git push [http://username:passwd@xxx](http://username:passwd@xxx), username and passwd can be managed using credentials, username and passwd are not Allow to have special characters, BK-CI will not escape special characters when rendering var 

 ### Q: How to restart the BK-CIagent on a Private build 

 You can go to the install directory of BK-CI agent and execute the stop.sh Script (stop.bat batch file on windows) first, and then execute start.sh (start.bat file on windows) 

 ### Q: How to reinstall BK-CI agent on Self hosted agent 

 1. On linux/Mac, you can support Re-run the installCommand. If you encounter an installation Error before, it is recommended to uninstall first, then delete the clean installation directory and run the installation command again. 2. On windows, you need to uninstall first, then delete the install directory, downloadInstallationPackage again, and repeat the installation process 

 ### Q: How to use the view feature of Pipeline 

 view can Service Classification Pipeline by pipeline creator or pipeline name. Multiple conditions support AND/OR relationship. The key value of a condition is include logic. Fuzzy matching and Regular Expression are not supported. For example, when the key value corresponding to the pipeline name is `vinco`, all pipelines containing `vinco` in the pipelineName in The project will be matched. 

 ![](../../../assets/image-20220125152014075.png) 

 ![](../../../assets/image-20220125152350168.png) 

 ### Q: The TGit Plugin cannot select the gitlab Code Repository 

 TGit is connected to Tencent's worker bee Code Repository, and cannot use gitlab code base 

 ### Q: For the Pipeline triggered by fixed time, the time Display is incorrect, and the Trigger Time is also incorrect. 

 ![](../../../assets/wecom-temp-26d5087b12647b6801f5d8471eeb3ee6.png) 

 Please check whether the time of BK-CI service is normal 

 ### Q: Can I Display customize content on the history page of the Pipeline? For example, the same pipeline is sometimes packaged with Android and sometimes with iOS. I can't tell the build content from the history page alone. 

 ![](../../../assets/WeComscreenshot\_16364221097534.png) 

 You can add a shell** Plugin ** to the Pipeline approve Set the value of the Global Variables `BK_CI_BUILD_REMARK` to implement the desired remark. The Field will not be displayed until the pipeline ends. 

 ![](../../../assets/wecom-temp-a4453da39a470d74b7ed3d6da14120c0.png) 

 ![](../../../assets/wecom-temp-9418a7960b89c65268c6947f46d95f72.png) 

 ### Q: failed to install BK-CI agent on windows build. Subdirectory or file already exists. Access is refuse 

 ![](../../../assets/WeComscreenshot\_16393825053890-3096967.png) 

 This situation is usually caused by user repeatedly install BK-CIagent. You can first execute the uninstall Script to uninstall the current agent, then delete the installation directory of The agent, and then Re-download the agent package again and install it again 

 ### Q: There is Set upper limit for the pipelinesHistory of BK-CI. My timed Pipeline may run One a minutes, data will waste Disk 

 For high-frequency Cron, it is recommended to use the operation platform of BlueKing. 

 ### Q: Ubuntu BlueKing Agent Install failed, no enough space left in /tmp, but the machine has Disk space Remaining 

 ![](../../../assets/WeComscreenshot\_16316948048063.png) 

 Generally, the Ubuntu machine cannot execute the awk command normal, and the following error occurs when executing awk: 

 `awk: symbol lookup error: /usr/local/lib/libreadline.so.8: undefined symbol: UP` 

 You can refer to this method and Replace: 

 ![](../../../assets/wecom-temp-62020c1b6e41f1f9e6e421bfe0a7dc70.png) 

 ### Q: Image verification Fail when link image 

 ![](../../../assets/WeComscreenshot\_16328099498489.png) 

 ![](../../../assets/wecom-temp-96f388a0cface3bdddafa174084719a1.png) 

 The image is in a Private repository. Docker does not support private repositories other than https by default. You need to Revise on the BK-CI hosted agent, append the private repository address in the `insecure-registries` Field, and then restart the docker service 

 ![](../../../assets/image-20220301101202-lncwv.png) 

 ### Q: Is there an image of BK-CI based on Ubuntu system 

 There is no ready-made Ubuntu-based BK-CI image, user can follow the guidelines to package their own image: [https://bk.tencent.com/docs/document/6.0/129/7518](https://bk.tencent.com/docs/document/6.0/129/7518) 

 ### Q: If I have multiple BK-CI hosted agent, what is the Schedule Algorithm of the public builder? Under what circumstances will the Task be scheduled to another builder for execute? 

 The Algorithm will give priority select One build machine (affinity), and if a resources of the last build machine exceeds the following Threshold, it will find another agent to buildTask 

 ```Memory Threshold: 80% diskIo: 85% Disk Space: 90% ```

 ### Q: How to adjust the resources Threshold in the Schedule Algorithm 

 Currently, you can only adjust the Memory Threshold. The default is 80%. That is, when the ramUsageRate of a BK-CI hosted agent reaches 80%, if Other builders have Idle resources, Task will be Schedule to other builders. This threshold can be Revise. The modification method is as follows: signIn in to the BK-CI dispatch-docker service machine and execute: 

 ``` #The value of threshold is the Threshold percentage. Here, adjust the Memory threshold to 70% as an example. curl -H 'Accept:application/json; charset="utf-8"' -H 'Content-Type:application/json; charset="utf-8"' -H "X-DEVOPS-UID: admin" -X POST --data '{"threshold":"70"}' http://127.0.0.1:21938/api/op/dispatchDocker/docker/threshold/update``` 

 ### Q: failed to start the occasional Start Up agent. Get credential failed 

 The problem is known. delete dispatch-docker/lib/bcprov-jdk15on-1.64.jar, which is a soft link. Delete it and restart the dispatch-docker service `systemctl restart bkci-dispatch-docker.service`. 

 ### Q: How to delete a BK-CI hosted agent 

 signIn in to the BK-CIdispatch-docker server, execute `/data/src/ci/scripts/bkci-op.sh list` to obtain all BK-CI hosted agent, and execute `/data/src/ci/scripts/bkci-op.sh del` 

 ### Q: The build step is stuck in the preparation of the buildEnvType 

 ![](../../../assets/WeComscreenshot\_16419529383724.png) 

 If it is a BK-CI hosted agent, the priority is to check whether the public builder BK-CI-dockerhost.service normal 

 This situation is more common in Self hosted agent, mostly caused by Agent Install Abnormal. Here are some known reasons: 

 1. Network reasons, such as unable to resolve BK-CI domain name, BK-CI service unreachable, etc. 2. agentVersion install Error, such as installing linux agent package on mac, in this case, delete the BK-CIagent installation package and reinstall the corresponding version of agent 3. `too many open files` can be seen in the agentDaemon.log log under the logs of the BK-CIagent install directory. The result of execute `ulimit -n` on the machine Display that the number of file that can be opened is too small. The default value is 1024. Increase the value and reinstall BK-CIagent. 

 ![](../../../assets/wecom-temp-2cf366a83acf24ef09ae7dff30c47354.png) 

 ![](../../../assets/wecom-temp-2eadbe319d03b3049c6b4cf300cda012.png) 

 ### Q: Pipeline buildFail. Agent HEARTBEAT_TIMEOUT/Agent Dead. Please check the status of the agent 

 It is common to Run a Memory compilation Task on a public build machine, resulting in container oom. When you execute `grep oom /var/log/messages` on the public build machine, you can usually see match records. If multiple tasks run on the same build machine at the same time, you approve adjust the memory Threshold of the Schedule Algorithm to avoid running too many tasks on a single build machine. If a single compile Task triggers oom, it is recommended to increase the Memory of the agent, or use a Self hosted agent with higher memory 

 ### Q: Is there a Priority for monitoring and excluding triggers? 

 Monitor> Exclude 

 Assuming that the trigger setting both listening and excluding options configured, and that the event contains both listening and excluding, The Pipeline will fire. 

 ### Q: Can the listening path be wildcarded? 

 Wildcard functionality is not supported.  Prefix match is currently supported. 

 for example Fill In source in the listening directory and the sourceabc directory is changed, The event will also be heard. 

 ### Q:Download artifacts Why can't I download file? 

 **1. Do not include a path when downloading** 

 for example when upload, Fill In Artifact source as dir1/test.txt, upload will only upload the file, not the directory. 

 To download, just Fill In test.txt. 

 ### Q:Upload artifacts FAQ 

 **Usage Questions** 

 **1. Where did the file go after upload?** 

 After upload, the File Upload to the BK-CI service. 

 **What are Artifacts?** 

 Artifacts is the path to the BK-CI service. 

 /data/bkce/public/ci/artifactory/bk-archive/${projectName} 

 **3. What is the absolute path of Artifact upload?** 

 For example, the projectName is vincotest, and the actual storage path of 114514.txt is on the BK-CI machine: 

 /data/bkce/public/ci/artifactory/bk-archive/vincotest/${pipelineId}/${build}/114514.txt 

 The projectName, pipelineId, and build ID can all be read from the pipeline url 

 ![](../../../assets/image-20220607165825062.png) 



，





 **FAQ about Error Reporting** 

 **1. Artifact source problem** 

 ![](../../../assets/uploadsrcfile.png) 

 Reason: No corresponding file is match 

 Common in the file path problems caused by the error.  When uploading, the default is to match Artifact with relative path starting from ${WORKSPACE} of BK-CI. 

 Therefore, if the corresponding Artifact is in the lower directory of ${WORKSPACE}, you need to Fill In the path/file 

 **2. Insufficient space** 

 The/tmp directory is used for upload, so/tmp also needs to keep enough space. 



 ### Q: FAQ on checkout 

 **Common Error Reports** 

 **1. Checkout is stuck in Fetching the repository Stage**

 ![](../../../assets/check_ugit.png) 

 The agent uses Ugit 

 BK-CI requires native git Pull Code.  BK-CI checkout will failed if the agent uses Ugit.  You need to install native git. 

 **2. What is the reason for this error when "git Pull" this Plugin.  Use sshKey** 

 ![](../../../assets/WeComscreenshot_16266633248073.png) 

 This is because Old Version git Pull Plugin do not support using the windows build machine, and New plug-ins do 

 **3. An error is occasionally reported when checkout Pull Code** 

 ![](../../../assets/checkout_error_sometimes.png) 

 ① This is a problem with Old Version Plugin, which has been fixed. 

 ② If there is still an error, it is usually caused by the inconsistent version of bcprov-jdk on the BK-CI service and the agent. 

 Please check if the version are consistent: 

 agent: agent directory\jre\lib\ext 

 BK-CI service: /data/bkce/ci/ticket/lib/ 

 If they are inconsistent, reinstall agent agent to resolve them. 