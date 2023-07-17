# 流水线FAQ

## GitLab FAQ

### Q1: gitlab事件触发插件无法触发事件?

1. 查看下devops\_ci\_process.T\_PIPELINE\_WEBHOOK表是否有注册这条流水线， SELECT \* FROM devops\_ci\_process.T\_PIPELINE\_WEBHOOK WHERE pipeline\_id = ${pipeline\_id}，${pipeline\_id}可以从url地址获取
2. 如果没有注册
   1. 查看repository服务到gitlba的网络是否能通
   2. 查看gitlab仓库的权限是否是master权限
   3. 在repository服务部署的机器上，执行grep "Start to add the web hook of " $BK\_HOME/logs/ci/repository/repository-devops.log查找注册失败原因，$BK\_HOME默认是/data/bkce
3. 如果已注册，还是没有触发，
   1. 到gitlab的webhook页面，查看是否有注册成功，如图1
   2. 如果gitlab中有注册的url，url是 [http://域名/external/scm/codegit/commit](http://xn--eqrt2g/external/scm/codegit/commit) 然后点击编辑，查看发送的详情，如图2
   3. 查看gitlab没有发送的详情，如图3
4. 如果上面都没问题，在process服务部署的机器上，执行grep "Trigger gitlab build" $BK\_HOME/logs/ci/process/process-devops.log 搜索日志，查找触发的入口日志

![](<../../../assets/image (58) (1).png>)

![](<../../../assets/image (59).png>)

![](<../../../assets/image (57).png>)

### Q2:关联GitLab代码库报错常见原因

![](../../../assets/repo_gitlab.png)

1、应该使用 Personal Access Tokens 而非项目令牌。

2、确认Access_Tokens生成时是否给予了对应权限。必须要包含对应的API权限。

3、如果是自建的 GitLab，请确认”repository/branches“API接口是否能通。

https://docs.gitlab.com/ee/api/branches.html

4、如果GitLab为https访问。请确认代码库是否有做 http-->https 跳转。BKCI默认以 http 方式进行代码库访问。

若未做跳转，请按此临时方案，修改BKCI文件：

```bash
vim /data/bkce/etc/ci/application-repository.yml

#修改application-repository.yml文件，把apiUrl 修改为 https
#gitlab v4.
gitlab:
apiUrl: https://devops.bktencent.com/api/v4
```

重启 BKCI-repository.service 服务

systemctl restart BKCI-repository.service

## 流水线信息 FAQ

### Q1: 流水线的各个状态代表什么意思？

流水线的状态汇总如下：

![](../../../assets/image-20220301101202-uphlD.png)

### Q2: BKCI流水线进度条是如何计算的？

进度条是BKCI前端根据流水线相关的数据做出的预估。此进度不是准确的时间，仅供参考。

![](../../../assets/进度条.png)



### Q4: BKCI有哪些全局变量？


-  [预定义常量/变量](../../../intro/terminology/pre-define-var/README.md)


### Q5: 如何获取流水线id？

流水线url中，pipeline后的参数分别为项目id和流水线id。如：http://devops.bktencent.com/console/pipeline/iccentest/p-8f3d1b399897452e901796cf4048c9e2/history 中，iccentest 为项目id，p-xxx 即为流水线id。

### Q6: 流水线执行失败了，插件为什么没有重试按钮？

只有最新一次的构建可以重试。

### Q7: BKCI流水线中的视图管理、标签管理有什么用？

对流水线进行分类，当流水线数量较多时，标签、视图会有更大作用。

### Q8: 查看日志时，如何查看时间戳？

查看日志页，Show/Hide Timestamp

![](../../../assets/image-20220301101202-QERjn.png)

## 构建机 FAQ

### Q1:使用docker build生成镜像是不是只能使用私有构建机才行？

建议使用私有构建机, 公共构建机DinD方案存在安全隐患, 所以需要私有构建机制作镜像.

如果BKCI使用者是受信任的话，可以使用我们交付团队的DinD**方案**

### Q2: 一台mac只能装一个agent吗

可以多个, 在不同目录启动agent即可. 每个agent实例需要全新安装, 不能直接复制已有agent目录.

### Q3:公共构建机，这几类都支持吗？

![](../../../assets/image-1646103610029.png)

公共构建机依赖docker, 只能运行linux. 目前只能运行基于我们 bkci/ci:alpine (debian系统)制作的构建镜像.

### Q4:私有构建机必须是物理机吗？可以是docker容器吗?

私有构建机和项目绑定, 且需安装agent并注册. 建议使用物理机/虚拟机等变动少的场景. 容器化使用公共构建机即可.

### Q5:公共构建机 no available Docker VM

![](../../../assets/image-20220301101202-ceNsG.png)

是没有可用的ci-dockerhost.需要:

1\. 在ci-dispatch节点执行 /data/src/ci/scripts/bkci-op.sh list 查看是否有状态为true的行.

2\. 如果依旧无法调度, 需要检查ci-dispatch的日志有无异常. 或者涉及dockerhost ip的日志.

原因是当时部署BKCI的时候因为服务器资源有限，把构建机 微服务 网关都放到一台机器上 导致构建机内存使用率过高，构建环境的时候找不到可用构建机，现在把构建机单独部署到别的机器上 之前的那些报错就都没了。

3、主机资源不足时也会导致启动失败。请确认 DISK_LOAD<95%，CPU_LOAD<100%，MEM_LOAD <80%

----

## 还没想好要怎么归类 FAQ

### Q1: BKCI流水线构建出的产物如何支持服务器分发限速配置?

调整分发源的限速，如下图。 对于已经安装agent的机器，可以先移除，再安装。 分发源机器IP: 192.168.5.134

![](../../../assets/image-20220301101202-PluSB.png)



### Q2: 项目名称是否支持修改？

项目名称可在项目管理内更改，项目英文缩写（即项目id）不能更改。

![](../../../assets/image-20220301101202-qTzdw.png)

![](../../../assets/image-20220301101202-FyiDk.png)



### Q3: 如何通过BKCI将构建产物自动分发到指定服务器？

有了部署机器，我们可以将构件分发至测试机上了。首先添加一个无编译环境Job 3-1，添加插件作业平台-构件分发并完成配置。

![](../../../assets/image-20220301101202-vGRcA.png)

### Q4: python的环境变量添加后，在job执行的时候未生效。（job报错“系统找不到指定的文件”）

因为BKCIagent和蓝鲸agent使用的账户是system，所以加到administrator的环境变量不生效 需要把python.exe和pip3.exe pip.exe加入到系统环境变量里，再重启操作系统

### Q5: 可以通过BKCI流水线上传构建产物到指定私有GitLab仓库吗？

BKCIgit插件暂无push功能。用户可将ssh私钥放置构建机上，在Batch Script插件或者Bash插件里使用git命令push产物达到临时解决方案。

### Q6: 节点机器，显示正常，为什么监控网络io没有数据？

![](../../../assets/image-20220301101202-Lkelb.png)

没有启用. 这个监控并无意义, 也不影响调度. 建议使用蓝鲸监控等专门的监控系统负责.

如果要启用:

```
1. 配置 bin/03-userdef/ci.env 
2. 添加 BK_CI_ENVIRONMENT_AGENT_COLLECTOR_ON=true
3. 然后添加 influxdb相关的配置项.
4. 重新安装ci-environment. 可以直接使用 ./bk_install ci 安装.
5. 修改已有agent:编辑.agent.properties , 配置devops.agent.collectorOn=true, 重启agent.
```

### Q7:构建里面如何使用docker build 打包镜像，然后推送镜像到harbor，我的是dockerbuild环境 里面没有docker命令

可以使用私有构建机. 容器内是没有dockerd的, 出于安全考虑, 容器内是不能操作主机的dockerd的，或者如果BKCI使用者是受信任的话，可以使用我们交付团队的DinD**方案**

---

## 权限相关 FAQ

### Q1: 为什么有时候会出现需要申请流水线权限的情况，但是F5刷新之后恢复？

存在权限冲突，在用户组权限里，是有多个流水线的权限。 但是自定义里面只有一个流水线的权限。 后续更新版本会修复这个问题。解决方案为删除自定义权限。后续会通过版本更新修复该问题。

![](../../../assets/image-20220301101202-HIaKn.png)

## 是否还需要存在的FAQ

### Q1: 如何在bash插件之间传递变量，上一个bash插件输出变量，下一个bash插件能引用到？

BKCI为bash插件提供了 setEnv 命令来设置BKCI的全局变量, `setEnv '变量名' '变量值'` 如：

`setEnv 'cmdb' '3.2.16'`

setEnv 设置的是当前bash的输出参数，在下游才会生效，当前的bash里打印不出来的。

在windows batchscript插件里使用`call:setEnv "FILENAME" "package.zip"` 然后在后续的batchscript插件中使用%FILENAME%引用这个变量

## 蓝鲸相关

### Q1: 有方法可以从标准运维调用BKCI吗？

流水线stage-1 trigger选择remote. 然后标准运维调用job快速执行脚本, 调用remote插件里提示的url.

## 日志相关FAQ

### Q1:ci不显示日志

![](../../../assets/image-20220301101202-xwkmo.png)

查看对应微服务日志 /data/bkce/logs/ci/log/

![](../../../assets/image-20220301101202-bduGg.png)

一个index占了12个shards，超过了es7 设置的shards最大值，这是es7的限制

解决方法：清理一些无用的索引

```
查看目前所有的索引
source /data/install/utils.fc
curl -s -u elastic:$BK_ES7_ADMIN_PASSWORD -X GET http://$BK_ES7_IP:9200/_cat/indices?v
删除索引 # index 是索引名称
curl -s -u elastic:$BK_ES7_ADMIN_PASSWORD -X DELETE http://$BK_ES7_IP:9200/index
# 注意：不能删除 .security-7
```

![](../../../assets/image-20220301101202-RWPNo.png)

**另一种可能是用户未安装es7**

### Q2: 如何让自己的流水线日志显示带上不同颜色

在流水线日志组件中，我们定义了以下关键字供插件开发者使用。

| 关键字          | 作用                             | 备注                                           |
| --------------- | -------------------------------- | ---------------------------------------------- |
| ##\[section]    | 一个Job或者插件的开头            | 如果是插件开头，必须包含在一个Job的Starting内  |
| ##\[endsection] | 一个Job或者插件的结尾            | 如果是插件结尾，必须包含在一个Job的Finishing内 |
| ##\[command]    | 将后面的字符串以ShellScripts高亮 | #0070BB                                        |
| ##\[info]       | 将后面的字符串标记为info颜色     | #48BB31                                        |
| ##\[warning]    | 将后面的字符串标记为warning颜色  | #BBBB23                                        |
| ##\[error]      | 将后面的字符串标记为error颜色    | #DE0A1A                                        |
| ##\[debug]      | 将后面的字符串标记为debug颜色    | #0D8F61                                        |
| ##\[group]      | 一个折叠的开始                   |                                                |
| ##\[endgroup]   | 一个折叠的结束                   |                                                |

**以Bash插件为例：**

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

你将看到如下图所示效果

![](../../../assets/image2020-1-9\_21-59-12.png)

## 镜像相关

### Q1:上传镜像报错，程序默认把http方式换成https了

![](../../../assets/image-20220301101202-UayBz.png)

docker默认是https的, 这个要改服务端的docker. 需要在dockerhost机器的/etc/docker/daemon.json添加insecure-registry.

BKCI这边推送镜像默认都走https，如果要走http需要把仓库域名配置进insecure

走https的话如果仓库域名不是docker客户端开始装的时候对应的那个证书的话，需要在构建机导入这个域名对应的证书

### Q: 哪里可以查看上传到 制品库 的jar包？使用默认方式

蓝鲸社区参考：[https://bk.tencent.com/s-mart/community/question/2380](https://bk.tencent.com/s-mart/community/question/2380)

### Q: 拉取镜像失败，错误信息：status 500

![](../../../assets/image-20220301101202-CVycR.png)

用户自行配置的仓库，需要先保证网路可达



### Q: windos构建机 流水线执行用python去打开exe 失败

windows下，agent无法拉起有UI界面的exe

这个是windows session 0 限制

### Q: failed to connect to gitlib.xxx.com port 443:connection timed out 构建失败 提示连接443端口超时

![](../../../assets/image-20220301101202-AaxCJ.png)

这里断网的原因是dockerhost启动后, 执行过sysctl -p等价的命令, 导致 net.ipv4.ip\_forward 被重置为0, 导致容器断网.

```
sysctl -p | grep -F net.ipv4.ip_forward
net.ipv4.ip_forward = 0
单独启动一个测试容器:
docker run -it --rm centos 
应该会看到
WARNING: IPv4 forwarding is disabled. Networking will not work.
容器内执行命令, 等待后会看到提示超时:
curl -m 3 -v paas.service.consul
然后执行 systemctl restart BKCI-docker-dns-redirect
单独启动一个测试容器:
docker run -it --rm centos 
容器内执行命令, 可以看到网络恢复:
curl -v paas.service.consul
```

### Q:agent里面需要连网下docker，服务器连不了网，要如何处理呢？

目前公共构建机可以使用任意镜像, 无编译环境需要联网下载镜像.

目前需要你将无编译环境部署到可联网的区域, 并放行访问docker hub的地址.

公共构建机填写镜像地址为你们的私有docker registry.

并人工转存docker hub上的bkci/ci:latest到私有docker registry.

### Q:新增完凭据之后 选择的时候没有

检查创建完毕后浏览器有无报错, 检查 ci-auth 及 ci-ticket 的日志有无异常.

如果是普通用户创建的, 可以切换到管理员账户查看是否成功创建.

### Q: 挂载如何使用， 下拉框没数据

![](../../../assets/image-20220301101202-sxXbU.png)

这个需要维护一个NFS共享存储服务，不太推荐使用了，后续有可能移除

最好的做法是，将依赖工具打包到镜像里，有2个阶段

阶段A 里面的 job 有个 task-A ：是克隆git 代码后构建编译打包jar

阶段B 里面的 job 有个 task-B：是把 task-A 中构建好的 jar scp 到部署发布到服务器 。

验证下来的结果是 这两个阶段的 workspace 是不共通的。目前的做法是我都放到一个 Job里面才行，这样才能共用一个 workspace 里面构建生产的 jar文件。

设计如此，CI的产物如果要部署出去，必须走到制品库，用maven私服的思路没错

### Q: 研发商店：插件配置文件\[task.json]atomCode字段与工作台录入的不一致

![](../../../assets/image-20220301101202-WRucB.png)

上传的，可能不是插件发布包，是源代码。发布过程看插件的readme

如果上传的是正确的发布包可以临时编辑插件zip包内的task.json, 修改atomCode(和上传界面一致, 不含下划线)后重新打包上传.

### Q: 插件包上传失败

![](../../../assets/image-20220301101202-iJWQt.png)

可以先检查下blueking用户能否正常读写 artifactory数据目录: /data/bkce/public/ci/artifactory/

然后检查artifactory日志文件, 看看报错.

### Q: BKCI添加节点的时候报错 bkiam v3 failed

![](../../../assets/image-20220301101202-MyIAk.png)

### 然后根据给出的文档排查了日志

/data/bkce/ci/environment/logs/environment-devops.log

/data/bkce/ci/environment/logs/auth-devops.log

![](../../../assets/image-20220301101202-GyIic.png)

排查发现ci auth库下的 T\_AUTH\_IAM\_CALLBACK表 为空

原因是集群初始配置失败，但脚本并没有终止

```
ci初始化
reg ci-auth callback.
[1] 19:29:00 [SUCCESS] 172.16.1.49
{
  "timestamp" : 1626291190535,
  "status" : 500,
  "error" : "Internal Server Error",
  "message" : "",
  "path" : "/api/op/auth/iam/callback/"
}Stderr: * About to connect() to localhost port 21936 (#0)
解决方法：可尝试手动 注册ci-auth的回调.
source /data/install/load_env.sh
iam_callback="support-files/ms-init/auth/iam-callback-resource-registere.conf"
./pcmd.sh -H "$BK_CI_AUTH_IP0" curl -vsX POST "http://localhost:$BK_CI_AUTH_API_PORT/api/op/auth/iam/callback/" -H "Content-Type:application/json" -d @${BK_PKG_SRC_PATH:-/data/src}/ci/support-files/ms-init/auth/iam-callback-resource-registere.conf
```

### Q: Upload artifacts这个上传功能是上传到当前使用stage的构建的构建机里面还是有单独的仓库位置

归档构件，是把构建机上的产物归档到专用的产物仓库，产物仓库和构建机无关，由 Artifactory 服务决定。

CI 的归档，是将产物暂存到仓库，方便流水线下游操作使用，或者作为后续部署的来源，目前没有支持归档时根据当前构建机所在的云指定构件存储方式。

你描述的，看起来像是构件的分发，通过部署工具去操作可能更合理。

或者你也可以自定义插件自行实现归档

### Q: bkci插件如何开发有文件说明吗？

插件开发指引：https://docs.bkci.net/store/plugins/create-plugin

### Q: JOOQ;uncategorized SQLException for SQL

![](../../../assets/image-20220301101202-rtxbB.png)

旧sql没有清理的缘故

```
# 清理flag文件, 重新导入全部sql文件
for sql_flag in $HOME/.migrate/*_ci_*.sql; do
chattr -i "$sql_flag" && rm "$sql_flag"
done
# 导入数据库 SQL 仅在中控机执行
cd ${CTRL_DIR:-/data/install}
./bin/sql_migrate.sh -n mysql-ci /data/src/ci/support-files/sql/*.sql
```

### Q: private configuration of key JOB\_HOST is missing

![](../../../assets/image-20220301101202-QtZoR.png)

job脚本执行插件链接：[https://github.com/TencentBlueKing/ci-executeJobScript](https://github.com/TencentBlueKing/ci-executeJobScript)

私有配置缺少JOB\_HOST字段，按照上图配置好即可

![](../../../assets/脚本执行配置1.png)

### Q: 发送邮件插件不可用

![](../../../assets/企业微信截图\_16408694122894.png)

插件的执行环境分为有编译和无编译，发送邮件插件的执行环境为无编译环境，在创建Job的步骤时，需要选Job类型为无编译环境，即Agentless

![](../../../assets/image-20220301101202-SfGeA.png)

![](../../../assets/image-20220301101202-dhitX.png)

### Q: 发送邮件插件执行成功，但没收到邮件

1. 首先配置ESB的邮件信息，参考：[https://bk.tencent.com/s-mart/community/question/2532](https://bk.tencent.com/s-mart/community/question/2532)
2. 配置插件的私有配置，参考：[https://github.com/TencentBlueKing/ci-sendEmail](https://github.com/TencentBlueKing/ci-sendEmail)

### Q: 发送邮件插件的sender配置不是我配置的sender

![](../../../assets/image-20220301101202-gdDMH.png)

sender需要在插件的「私有配置」里设置，独立于ESB的mail\_sender

「研发商店」-「流水线插件」-「工作台」-「选择发送邮件插件」-「基本设置」-「私有配置」-「增加sender字段」

![](../../../assets/wecom-temp-de1f999781431e708256b5e9a9ecc1d6.png)

![](../../../assets/wecom-temp-79503b33558fb2f05c4579c99280f8e7.png)

![](../../../assets/wecom-temp-ad2da5032b4af609e41012bd4113bf84.png)

![](../../../assets/wecom-temp-888da4cdb34f2bbcdc3869f7f4ff6dda.png)

![](../../../assets/wecom-temp-8f040f0a22d3e9b0ff75a6b3ff40410b.png)

![](../../../assets/wecom-temp-db0217ab76483f286bfb63cd7047f353.png)

除了sender字段，还需要配置其他字段，请参考：[https://github.com/TencentBlueKing/ci-sendEmail](https://github.com/TencentBlueKing/ci-sendEmail)

### Q: 配置平台里的业务，如何关联到容器管理平台？

![](../../../assets/企业微信截图\_16412880662873.png)

![](../../../assets/企业微信截图\_16412881057362.png)

1. 权限中心中检查，该用户账号是否具有local-k8s」的配置平台权限
2. 配置平台中检查，「资源-业务-运维人员」中是否有配置该账号用户

![](../../../assets/wecom-temp-ac68ebc38b2022819c8540b00100d2fb.png)

### Q: 如何使用Merge-Request-Accept-Hook，我为什么没触发？我希望分支feature\_lzj\_test123123213合并到feature\_lzj\_test0117时触发流水线

![](../../../assets/image-20220301101202-RtEPQ.png)

Merge Request Accept Hook会在源分支**成功merge到目标分支时触发**

比如，需要将feat\_1合并到dev分支时，分支名称写dev，监听源分支写feat\_1（也可以使用\*号的模糊匹配功能，如feat\_\*）

![](../../../assets/image-20220301101202-pxOZb.png)

### Q: gitlab触发器在哪里配置webhook地址，jenkins是需要手动配置一个url的

不需要配置这个hook，蓝BKCI是会自己注册webhook，选择事件类型后保存，就会自动注册webhook

![](../../../assets/wecom-temp-d5c48ee99a96d373426491d14d56e404.png)

### Q: gitlab触发失败

1. 检查分支是否匹配
2. 查看下devops\_ci\_process.T\_PIPELINE\_WEBHOOK表是否有注册这条流水线， SELECT \* FROM devops\_ci\_process.T\_PIPELINE\_WEBHOOK WHERE pipeline\_id = ${pipeline\_id}，${pipeline\_id}可以从url地址获取
3.  如果gitlab webhook页面没有注册webhook的记录，如

    <img src="../../../assets/image-20220128124536187.png" alt="" data-size="original">

    1. 查看repository服务到gitlab的网络是否能通，比如是否配置gitlab的域名解析
    2.  查看gitlab仓库的权限是否是master权限，即生成accesstoken的用户需要是仓库的`maintainer`角色，且accesstoken需要的Scopes是`api`

        <img src="../../../assets/wecom-temp-fe0a7bc1e72a97ec39e0a4e51e3e1e58.png" alt="" data-size="original">

        <img src="../../../assets/image-trigger-gitlab-accesstoken-maintainer.png" alt="需要选择maintainer" data-size="original">

        <img src="../../../assets/image-trigger-gitlab-accesstoken-view.png" alt="需要是maintainer" data-size="original">
    3. 在repository服务部署的机器上，执行`grep "add the web hook of " $BK_HOME/logs/ci/repository/repository-devops.log`查找注册失败原因，$BK\_HOME默认是/data/bkce
4.  如果gitlab上有webhook注册记录，如

    <img src="../../../assets/image (58) (1) (1).png" alt="" data-size="original">

    如果还是没有触发：

    1.  点击对应webhook的Edit，查看webhook的发送详情，查看View detail

        <img src="../../../assets/image-gitlab-webhook-viewdetail.png" alt="" data-size="original">
    2.  查看发送的错误详情，检查gitlab到BKCI机器的网络是否可达，如gitlab服务器是否能解析BKCI域名

        <img src="../../../assets/image-gitlab-webhook-request-detail.png" alt="" data-size="original">
5.  如果上面都没问题，在process服务部署的机器上，执行grep "Trigger gitlab build" $BK\_HOME/logs/ci/process/process-devops.log 搜索日志，查找触发的入口日志。查看gitlab push过来的请求体，对比请求体中的`http_url`字段和代码库里代码仓库的地址是否**完全**匹配，如果一个是域名形式的url，另一个是ip形式的url，则不匹配，如下所示：

    <img src="../../../assets/image-trigger-gitlab-webhook-post-body.png" alt="" data-size="original">

    <img src="../../../assets/image-trigger-gitlab-repo-ip-view.png" alt="" data-size="original">

### Q: batchscript插件无法执行bat文件，bat文件里有从系统中读取的变量，是当前用户设置的

![](../../../assets/企业微信截图\_16285831782937.png)

将对应的agent服务的启动用户改为当前用户，执行命令`services.msc`打开windows服务管理界面，找到服务`devops_agent_${agent_id}`(注意：每个agent\_id是不同的，agent\_id的值可以在配置文件.agent.properties中找到)

右键->属性，在登录页签下选择此账户

如果是如入域构建机，账户名填写`域名\用户名`，例如`tencent\zhangsan`;如果没有入域的构建机，账户名填入`.\用户名`,例如`.\admin、.\administrator、.\bkdevops`，输入密码后，点击确认按钮

![](../../../assets/image-20220128181627246.png)

右键 -> 重新启动，重启服务

![](../../../assets/image-20220128181720819.png)

打开任务管理器，查看进程devopsDaemon.exe和的vopsAgent.exe是否存在，查看两个进程的启动的用户名是否为当前登录用户

### Q: batchscript中的命令路径有空格，执行失败

![](../../../assets/企业微信截图\_16285852671573.png)

可以将有空格的命令用引号""括起来

### Q: 如何通过接口获取项目\*\*

curl -X GET [https://devops.bktencent.com/prod/v3/apigw-app/projects/](https://devops.bktencent.com/prod/v3/apigw-app/projects/) -H "Content-Type: application/json" -H "X-DEVOPS-UID: admin"

### Q: 这个「只有在前面插件运行失败才执行」条件，感觉没有用，成功了也执行了

![](../../../assets/wecom-temp-c6aa0d74275116c38ff7f592563616c7.png)

这个条件的实际意思是：在这个插件前面的任何一个插件运行失败，就符合触发条件，而不是指『上一个』插件失败时运行

### Q:项目的英文名称可以修改吗

暂不支持修改

### Q: 如何获取项目名称，我想要在企业微信通知消息里带上

使用全局变量`${BK_CI_PROJECT_NAME}`

### Q: 在浏览器里完成了BKCI登录，在同一浏览器不同tab访问BKCI，还需要再次登录

这种情况是登录cookie过期了，现在默认应该是两小时，过期时间可调

### Q: 有条流水线是通过gitlab触发的，但查看代码变更记录为空，说明此次触发的构建，并没有新代码变更，那为啥为触发

可能的原因是，触发器监听了整个代码库的commit事件，但代码拉取插件只拉取了某一个特定分支的代码，而此分支并没有代码变更，比如，插件监听了整个代码库commit事件，但代码拉取插件只拉取了master分支的代码，而提交commit的是dev分支，代码变更记录显示的是所拉取的分支相交上一次体检的变更，master分支没有变更，所以没有变更记录。

### Q: 流水线跟流水线可以设置互斥吗? 或者流水线A 启动, 流水线B启动的时候, 流水线B等待流水线A结束

现在只能对流水线中的JOB进行互斥组配置，如果这两个流水线只有一个JOB，那就这个JOB配置一个相同的互斥组就可以了。如果流水线有多个JOB，需要给两个流水线上再套一个流水线，然后在两条主流水线上配置互斥组，通过这个主流水线拉起任务。

![](../../../assets/wecom-temp-0427b67401a386578f79c2495a2009f8.png)

### Q: BKCI脚本里会起一个gradle daemon进程。最近发现，构建完就关闭。怀疑是不是devops agent处理的？

![](../../../assets/wecom-temp-d4178631b527e498ee7d8a0778c1fb09.png)

BKCIagent执行完构建任务后，会自动停止所有由agent启动的子进程，如果不需要结束子进程，可以在启动进程前设置环境变量：set DEVOPS\_DONT\_KILL\_PROCESS\_TREE=true，在bash脚本里设置`setEnv "DEVOPS_DONT_KILL_PROCESS_TREE" "true"`

### Q: 可以设置 一个变量值, 根据这个变量, 判断是否运行某个 插件 吗

在插件下方选择「自定义变量全部满足时才运行」，自定义变量写需要依赖的变量名称和值

![](../../../assets/image-20220210120321712.png)

### Q: 插件变量的值如何获取、如何写才对，比如我想获取插件里flushDB的值，然后在脚本里进行判断，我发现这么写是错误的？

![](../../../assets/企业微信截图\_16318512177997.png)

![](../../../assets/企业微信截图\_16318512474377.png)

![](../../../assets/企业微信截图\_16318513189348.png)

右上角点击引用变量，然后点右边复制变量，然后粘贴到你需要的地方就可以

![](../../../assets/wecom-temp-edfeb72810d972dae34d3f8d98232ec6.png)

### Q: 如何在日志每一行前面加上时间戳

占位，待解决

### Q:运行锁定, 有没有同一个时间最多运行一个构建任务, 后执行的强制取消先执行的任务

目前还没有这样的功能

### Q: 我们有用一个 cat 去显示Log, 这个方式能用, 但有个问题, 每次打开速度都很慢, 差不多要3秒以上才显示Log 数据, 有没什么其他的比较好的方式显示log

关于3秒以上的问题，主要因为这个task对应的日志数据较大，日志内容在3MB，所以时间花在download上

### Q: 流水线在执行中，unity的构建日志不会实时显示

其原因是「脚本中先执行unity编译构建操作，同时将日志写入文件，但在该操作结束前，不会执行后续的cat命令，导致日志无法实时在web页面上显示」。 针对此场景，可尝试以下解决方式：

```
 nohup $UNITY_PATH -quit -batchmode -projectPath $UNITY_PROJECT_PATH -logFile $UNITY_LOG_PATH -executeMethod CNC.Editor.PackageBuilderMenu.BuildPC "${isMono} ${isDevelop} $UNITY_OUT_PATH" & echo $! > /tmp/unity_${BK_CI_BUILD_ID}.pid unity_main_pid=$(cat /tmp/unity_${BK_CI_BUILD_ID}.pid) tail -f --pid ${unity_main_pid} $UNITY_LOG_PATH
```

### Q:如何有条件的执行CallPipeline插件

插件下面有一个流程控制，在流程控制中根据需要添加运行条件可以满足需求

![](../../../assets/wecom-temp-70083f622bd2a6c839f9eb1b9436aac2.png)

### Q: CallPipeline 这样传递参数好像不行？

![](../../../assets/wecom-temp-3d80fac2503d5be8620e76b0d8175798.png)

需要这样引用变量`${flushDB}`

### Q: 如何引用全局变量，我这么引用$BK\_CI\_BUILD\_FAIL\_TASKS好像不行

变量引用需要加花括号`${BK_CI_BUILD_FAIL_TASKS}`

### Q: 选中的参数改变的时候能不能隐藏其他参数，比如我operator选中build，tag参数隐藏掉，就像js里option组件的change event

![](../../../assets/企业微信截图\_1634710197325.png)

暂时还不支持

### Q: 我点击执行的时候，参数下拉列表里的值是能通过自定义的接口获取来吗？

不支持接口自定义

### Q: 服务器磁盘满了，这些目录文件可以删吗

![](../../../assets/企业微信截图\_1635304491832.png)

这些都是构建产物，目前对构建产物没有过期清理策略，用户可以视情况删除

### Q: 如何在流水线执行过程中改变参数的值？

如果是shell插件的话，可以这么修改参数的值`setEnv "{KEY}" "{VALUE}"`

### Q: 1.5.4版本CI，如何调用openapi

版本还未开启OpenAPI。可以升级到1.5.30及以上版本，该版本已开启OpenAPI。

### Q: 如何查看凭证里的信息

![](../../../assets/企业微信截图\_16372883269771-4480877.png)

出于安全考虑，该内容为加密的，不支持查看

### Q: 代码检查是否支持lua

代码检查暂不支持lua

### Q: 我是否可以自行扩展代码检查的规则

目前自行扩展功能还在开发中，暂不支持用户自行扩展代码检查的规则

### Q: 如何让流水线task变成可选

`在插件里选择「Skip some on manual trigger」`

![](../../../assets/wecom-temp-ef4f873c64f962cc9582479c26442f2f.png)

### Q: 让BKCI的日志窗口保留颜色吗？想让失败的案例更明显点

参考[https://docs.bkci.net/reference/faqs/log-colors](https://docs.bkci.net/reference/faqs/log-colors)

### Q:job-作业执行插件是灰色的，但我已经安装了

![](../../../assets/企业微信截图\_16384260669700.png)

这个是无编译环境使用的插件，需要在选择JOB类型时选择linux编译环境

![](../../../assets/image-20220210193855866.png)

### Q: 这个业务ID是啥

![](../../../assets/企业微信截图\_1638426248456.png)

配置平台中的「业务ID」，作业平台里也可看到

![](../../../assets/image-20220210194131021.png)

![](../../../assets/image-20220210194135210.png)

### Q: 如果我想通过shell或者bat执行一个python任务，那BKCI的变量我只有通过python命令行透传进去嘛,而且无法将变量回写到BKCI？

问题一：可以通过获取环境变量的方式来获取BKCI的变量

```
# 单行python例子，var为用户在本步骤或者其他步骤定义的变量名，BK_CI_START_USER_NAME是BKCI的全局变量
python -c "import os; print(os.environ.get('var'))"
python -c "import os; print(os.environ.get('BK_CI_START_USER_NAME'))"

# 如果你知道自己定义的变量名字，也可以在自己的python文件里通过os.envion.get('var')来获取
cat << EOF > test.py
import os
print(os.environ.get('var'))
EOF
python test.py
```

问题二：如何将变量回写到BKCI

```
# 如果是常量，shell可以使用setEnv，bat可以使用call:setEnv来将变量回写到BKCI
setEnv "var_name" "var_value" # shell
call:setEnv "var_name" "var_value"  # bat

# 将python脚本输出结果写回BKCI
var_value=`python script.py` # script.py里需要有print输出，如print("test")
setEnv "var_name" "${var_value}" # var_name="test"

# 把变量写到一个文件中，然后在shell中读取这个文件，然后setEnv
python script.py > env.sh # 假设env.sh里为file_name="test.txt"
source env.sh
setEnv "var_name" "${file_name}"
```

问题三：bat 脚本中调用 python ，将 python 输出回写到BKCI

````
for /F %%i in('python3 D:\mytest.py') do (set res=%%i)
echo %res%
call:setEnv "var_name" %res%
````





### Q: gitlab webhook 报错 URL '[**http://devops.bktencent.com/ms/process/api/external/scm/gitlab/commit**](http://devops.bktencent.com/ms/process/api/external/scm/gitlab/commit)' is blocked: Host cannot be resolved or invalid

需要在gitlab的机器上配置devops.bktencent.com的hosts解析

### Q: 请问这个红框框如何进入？

![](../../../assets/企业微信截图\_16257162702433.png)

「研发商店 」-「工作台」

![](../../../assets/wecom-temp-f1631f05683e7125be01a6b4e79492dd.png)

### Q: 我看每个job是有自己独立的workspace的，那是否存在多个job公用一个workspace的情况呢？

如果用的单构建机（私有构建机），多个job就会共用一个workspace

### Q: bkiam v3 failed错误？

![](../../../assets/企业微信截图\_16273862334714.png)

这个问题一般是由于机器重启导致权限中心的saas容器没有启动导致，将容器重新拉起即可解决

### Q: 如果我想在提pr的时候强制做一次代码扫描，应该如何配置？

如果是使用gitlab托管代码，直接配置gitlab触发器，触发的事件类型有：

1. Commit Push Hook 代码提交时触发
2. Tag Push Hook 提交有tag的代码时触发
3. Merge Request Hook 当有代码合并时触发
4. Merge Request Accept Hook 当代码合并后触发

### Q: 代码检查里某些规则不适用于我们公司，如何修改规则？

规则的内容不支持修改，但是规则集可以修改。代码检查是以规则集为单位进行代码扫描的，如果发现有些规则不适用，可以将其从规则集中去掉，如果该规则集是默认规则集不允许用户增删，可以选择在此基础上创建自定义规则集，创建的规则集就可以由用户自行增删其中的某些具体的规则了

### Q: 代码检查失败，Unknown Error：Unexpected char 0x5468 at 0 in X-DEVOPS-UID value：xxx

![](../../../assets/企业微信截图\_1630326503372.png)

这一步会读取gitlab 的fullname，设置为英文可以解决问题，暂时还不支持中文的gitlab fullname，个人信息用户名显示上方就是fullname，如这里的vinco huang，可以通过这里的「Edit profile」进入修改页面

![](../../../assets/企业微信截图\_16303286841990.png)

### Q: 我想在发送的企微消息通知里面附带当前build的一个artifacts文件的链接，该如何构造附件的下载链接？

[http://devops.bktencent.com/ms/artifactory/api/user/artifactories/file/download/local?filePath=/bk-archive/panda/](http://devops.bktencent.com/ms/artifactory/api/user/artifactories/file/download/local?filePath=/bk-archive/panda/)${BK\_CI\_PIPELINE\_ID}/${BK\_CI\_BUILD\_ID}/{你的artifacts文件名}

### Q: docker公共构建 支持自己的镜像吗？

支持，参考[https://docs.bkci.net/store/ci-images](https://docs.bkci.net/store/ci-images)

### Q: BKCI支持私有构建集群里选一台空闲的机器运行流水线吗，比如我们编译打包服务器，可能同时会有多个人操作不同分支的打包。

如果有多台私有构建机，可以构成私有构建集群，选择这个集群后，BKCI流水线按照一定的算法选择其中一台进行构建：

**算法如下：**

**最高优先级的agent:**

1. 最近构建任务中使用过这个构建机
2. 当前没有任何构建任务

**次高优先级的agent:**

1. 最近构建任务中使用过这个构建机
2. 当前有构建任务，但是构建任务数量没有达到当前构建机的最大并发数

**第三优先级的agent:**

1. 当前没有任何构建任务

**第四优先级的agent:**

1. 当前有构建任务，但是构建任务数量没有达到当前构建机的最大并发数

**最低优先级：**

1. 都没有满足以上条件的

### Q: [**https://docs.bkci.net/**](https://docs.bkci.net)打不开

![](../../../assets/企业微信截图\_16342628987332.png)

这个文档是由gitbook托管的，需要访问谷歌的一些资源，如果用户网络访问不了谷歌，会出现这样的问题

### Q: 机器断电后重启，但蓝鲸有些服务没起来，这些服务没有设置开机自启动吗？

服务之间有依赖关系，比如蓝鲸的一些服务依赖于mysql，如果这些服务先于mysql启动，那就会出现启动失败的情况

### Q: 我有pipeline A,可单独执行，我又有pipeline B,B里面会去调用A，等待A的一个结果，这种如何做互斥呢

**占位，待补充**

### Q: 可以针对流水线设置权限嘛，比如一个项目下的十个流水线，A可以看到一部分，B只能看到另一部分，想根据职能划分一下

权限中心可以针对单个流水线进行管理，首先要给特定用户授予项目的权限，然后再授予单个流水线的权限

![](../../../assets/wecom-temp-478bbf51b9813c4ec50828781038028b.png)

![](../../../assets/wecom-temp-d29b308520dfa33da51158b2d5c055a9.png)

![](../../../assets/wecom-temp-1e44f6048453bb9873ad1cc81c869a5e.png)

### Q: 请问流水线的变量能联动吗，比如我下拉选择了变量1的值为A，变量2的值自动变为A？

暂时还不支持联动，如果值没什么变化，可以设置默认值

### Q: 有支持git push的插件吗，想push一些东西到代码仓库上

可以试着用账密的方式push： git push [http://username:passwd@xxx](http://username:passwd@xxx)，username和passwd可以使用凭证管理起来，username和passwd不允许有特殊字符，BKCI在渲染变量的时候，不会转义特殊字符

### Q: 如何重启私有构建上的BKCIagent

可以到BKCIagent的安装目录下，先执行stop.sh脚本（在windows上是stop.bat批处理文件），再执行start.sh（在windows上时start.bat文件）

### Q: 私有构建机如何重装BKCIagent

1. 在linux/Mac上，可以支持重新执行安装命令，如果之前遇到安装错误，建议先uninstall，然后删除干净安装目录，重新跑安装命令
2. windows上需要先uninstall，然后删除安装目录，重新下载安装包，重复安装过程即可

### Q: 如何使用流水线的视图功能

视图可以将流水线分类，允许用户根据流水线的创建人或者流水线的名称来进行分类，多个条件之间支持与/或关系，条件的键值是include的逻辑，不支持模糊匹配以及正则表达式，比如当流水线的名称对应的键值为`vinco`时，会匹配到该项目中所有流水线名称中包含`vinco`字样的流水线

![](../../../assets/image-20220125152014075.png)

![](../../../assets/image-20220125152350168.png)

### Q: TGit插件无法选择gitlab代码库

TGit对接的是腾讯的工蜂代码库，无法使用gitlab代码库

### Q: 定时触发的流水线，时间显示不对，触发时间也不对

![](../../../assets/wecom-temp-26d5087b12647b6801f5d8471eeb3ee6.png)

请检查BKCI服务器的时间是否正常

### Q:流水线的历史页面，能显示自定义内容吗，比如同一条流水线，有时候是打包安卓，有时候是打包ios，单看历史页面，无法分辨出来构建内容

![](../../../assets/企业微信截图\_16364221097534.png)

可以在流水线里加个shell**插件**，通过设置`BK_CI_BUILD_REMARK`这全局变量的值，来实现想要的备注，流水线结束了，该字段才会显示

![](../../../assets/wecom-temp-a4453da39a470d74b7ed3d6da14120c0.png)

![](../../../assets/wecom-temp-9418a7960b89c65268c6947f46d95f72.png)

### Q: windows构建机上安装BKCIagent失败，子目录或文件已经存在，拒绝访问

![](../../../assets/企业微信截图\_16393825053890-3096967.png)

这种情况一般是由于用户重复安装BKCIagent导致，可以先执行uninstall脚本，卸载当前agent，然后删除该agent的安装目录，然后重新下载agent包，再次安装

### Q: BKCI的执行历史有设置上限的地方，我这个定时流水线可能1分钟一次，数据会浪费磁盘

频率高的定时任务，建议使用蓝鲸的作业平台

### Q: Ubuntu蓝鲸agent安装失败，no enough space left in /tmp，但机器是有磁盘空间剩余的

![](../../../assets/企业微信截图\_16316948048063.png)

一般是由于Ubuntu机器无法正常执行awk命令导致的，执行awk会有如下报错：

`awk: symbol lookup error: /usr/local/lib/libreadline.so.8: undefined symbol: UP`

可以参考这个方法，进行替换：

![](../../../assets/wecom-temp-62020c1b6e41f1f9e6e421bfe0a7dc70.png)

### Q: 关联镜像的时候，镜像验证不通过

![](../../../assets/企业微信截图\_16328099498489.png)

![](../../../assets/wecom-temp-96f388a0cface3bdddafa174084719a1.png)

镜像在私有仓库，docker默认不支持非https协议的私有仓库，需要修改公共构建机上的/etc/docker/daemon.json，在`insecure-registries`字段里添加私有仓库地址，然后重启docker服务

![](../../../assets/image-20220301101202-lncwv.png)

### Q: bkci的镜像有基于Ubuntu系统的吗

没有现成的基于Ubuntu的bkci镜像，用户可以根据指引来打包自己的镜像：[构建并托管一个CI镜像](../../../../../../Devops/2.0/UserGuide/Services/Store/ci-images/docker-build.md)

### Q: 如果我有多个公共构建机，公共构建机的调度算法是什么样的，什么情况任务会调度到另一台构建机上执行？

算法会优先选择上一次构建的机器（亲和性），上一次构建的机器的某一项资源超过以下阈值，就会寻找另一台构建机进行构建任务

```
 内存阈值：80% 磁盘IO：85% 磁盘空间：90%
```

### Q: 如何调整调度算法中的资源阈值

目前只支持调整内存阈值，默认是80%，即当公共构建机的内存使用率达到80%时，如果其他构建机还有空闲资源，任务会被调度到其他构建机，这个阈值是可以修改的，修改方法如下，登录到BKCIdispatch-docker服务的机器上， 执行：

```
 # threshold的值即为阈值百分比，这里以将内存阈值调整为70%为例 curl -H 'Accept:application/json;charset="utf-8"' -H 'Content-Type:application/json;charset="utf-8"' -H "X-DEVOPS-UID: admin" -X POST --data '{"threshold":"70"}' http://127.0.0.1:21938/api/op/dispatchDocker/docker/threshold/update
```

### Q: 偶现启动构建机启动失败，Get credential failed

已知问题，将dispatch-docker/lib/bcprov-jdk15on-1.64.jar删除，这是个软链，删除即可，然后重启dispatch-docker服务`systemctl restart BKCI-dispatch-docker.service`

### Q: 如何删除公共构建机

登录到BKCIdispatch-docker服务的机器上，执行`/data/src/ci/scripts/bkci-op.sh list`获取所有的公共构建机，执行`/data/src/ci/scripts/bkci-op.sh del`操作

### Q: 构建步骤卡在准备构建环境这一环

![](../../../assets/企业微信截图\_16419529383724.png)

如果是公共构建机，优先考虑公共构建机BKCI-dockerhost.service服务是否正常

这种情况多见于私有构建机，多为agent安装异常导致，这里列举一些已知的原因：

1. 网络原因，如无法解析BKCI域名、BKCI服务不可达等
2. agent版本安装错误，如在mac上安装linux的agent包，这种情况，将BKCIagent安装包删除，重新安装对应版本agent即可
3. 在BKCIagent安装目录的logs下的agentDaemon.log日志里可见`too many open files`,在机器上执行`ulimit -n`结果显示，可打开的文件数值太小，默认为1024，将其数值调大，重新安装BKCIagent即可

![](../../../assets/wecom-temp-2cf366a83acf24ef09ae7dff30c47354.png)

![](../../../assets/wecom-temp-2eadbe319d03b3049c6b4cf300cda012.png)

### Q: 流水线构建失败，Agent心跳超时/Agent Dead，请检查构建机状态

常见于在公共构建机上运行耗费内存的编译任务，导致容器oom，在公共构建机上执行`grep oom /var/log/messages`通常能看到匹配记录，如果是因为多个任务同时跑在同一台构建机上导致oom，可以通过调整调度算法的内存阈值，避免单台构建机上运行过多任务；如果单个编译任务就触发oom，建议调高构建机的内存，或者使用内存更高的私有构建机

### Q: trigger 的监听和排除有优先级吗？

监听 > 排除

假设 trigger 既配置了监听选项，又配置了排除选项，且事件中既包含监听又包含排除，那么将会触发该流水线。

### Q:监听的路径可以进行通配吗？

不支持通配符功能。目前可以支持前缀匹配功能。

例如在监听目录中填写 source，而 sourceabc 目录进行了变更，也会监听到该事件。

### Q:Download artifacts为什么下载不了文件？

**1、download 时不要带路径**

例如上传时，制品源填写为 dir1/test.txt ，upload 只会将文件上传，而不将目录上传。

download 的时候只需要填写 test.txt 即可。

### Q:Upload artifacts 常见问题

**使用类问题**

**1、upload后文件去哪了？**

upload 后，文件上传到了BKCI服务器当中。

**2、Artifacts 是什么？**

Artifacts 是BKCI服务器的路径。

 /data/bkce/public/ci/artifactory/bk-archive/${项目名称}

**3、制品 upload 的绝对路径是什么？**

比如项目名称是vincotest，114514.txt实际存放路径就是BKCI机器上：

/data/bkce/public/ci/artifactory/bk-archive/vincotest/${流水线id}/${构建id}/114514.txt

项目名称、流水线ID、构建ID都可以从流水线url里读取到

![](../../../assets/image-20220607165825062.png)



，





**报错类常见问题**

**1、制品源问题**

![](../../../assets/uploadsrcfile.png)

原因：没有匹配到对应的文件

常见于文件路径问题导致的报错。upload时默认从BKCI的 ${WORKSPACE} 开始以相对路径匹配制品。

因此如果对应的制品在${WORKSPACE}的更下一级目录时，需要填写 路径/文件

**2、空间不足**

upload 时会使用到 /tmp 目录，因此 /tmp 也需要保持足够的空间。



### Q:checkout 常见问题

**常见报错**

**1、checkout 卡死在 Fetching the repository 阶段**

![](../../../assets/check_ugit.png)

构建机使用的是Ugit

BKCI需要使用原生的 git 拉取代码。如果构建机使用了 Ugit 则会导致BKCI checkout 失败。需要重新安装一次原生 git 。

**2、"git拉取代码" 这个插件的时候，报这个错是啥原因呀。使用的是ssh私钥**

![](../../../assets/企业微信截图_16266633248073.png)

这是因为旧版git拉取代码插件不支持在windows构建机上使用，最新版插件已经支持

**3、checkout 拉取代码时，偶现报错**

![](../../../assets/checkout_error_sometimes.png)

①此为旧版插件的问题，现已修复。

②如果仍有报错，一般是由于BKCI服务器和构建机上 bcprov-jdk 版本不一致导致的问题。

请检查版本是否一致：

构建机：agent目录\jre\lib\ext

BKCI服务器：/data/bkce/ci/ticket/lib/

如不一致，进行重装构建机agent重装即可解决。



