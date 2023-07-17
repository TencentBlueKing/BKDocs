---
coverY: 0
---

----

## 还没想好要怎么归类 FAQ

### Q1: BKCI流水线构建出的产物如何支持服务器分发限速配置?（没想好）

调整分发源的限速，如下图。 对于已经安装agent的机器，可以先移除，再安装。 分发源机器IP: 192.168.5.134

![](../../../assets/image-20220301101202-PluSB.png)



### Q2: 项目名称是否支持修改？（放到project FAQ）

项目名称可在项目管理内更改，项目英文缩写（即项目id）不能更改。

![](../../../assets/image-20220301101202-qTzdw.png)

![](../../../assets/image-20220301101202-FyiDk.png)



### Q3: 如何通过BKCI将构建产物自动分发到指定服务器？（应放到示例文档中）

有了部署机器，我们可以将构件分发至测试机上了。首先添加一个无编译环境Job 3-1，添加插件作业平台-构件分发并完成配置。

![](../../../assets/image-20220301101202-vGRcA.png)



### Q5: 可以通过BKCI流水线上传构建产物到指定私有GitLab仓库吗？（应放到示例文档中）

BKCIgit插件暂无push功能。用户可将ssh私钥放置构建机上，在Batch Script插件或者Bash插件里使用git命令push产物达到临时解决方案。

### Q6: 节点机器，显示正常，为什么监控网络io没有数据？（环境管理）

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

### Q7:构建里面如何使用docker build 打包镜像，然后推送镜像到harbor，我的是dockerbuild环境 里面没有docker命令（还没想好）

可以使用私有构建机. 容器内是没有dockerd的, 出于安全考虑, 容器内是不能操作主机的dockerd的，或者如果BKCI使用者是受信任的话，可以使用我们交付团队的DinD**方案**

---

## 权限相关 FAQ

### Q1: 为什么有时候会出现需要申请流水线权限的情况，但是F5刷新之后恢复？（权限中心）

存在权限冲突，在用户组权限里，是有多个流水线的权限。 但是自定义里面只有一个流水线的权限。 后续更新版本会修复这个问题。解决方案为删除自定义权限。后续会通过版本更新修复该问题。

![](../../../assets/image-20220301101202-HIaKn.png)

## 蓝鲸相关

### Q1: 有方法可以从标准运维调用BKCI吗？（蓝鲸）

流水线stage-1 trigger选择remote. 然后标准运维调用job快速执行脚本, 调用remote插件里提示的url.

## 镜像相关（研发商店）

### Q1:上传镜像报错，程序默认把http方式换成https了（研发商店）

![](../../../assets/image-20220301101202-UayBz.png)

docker默认是https的, 这个要改服务端的docker. 需要在dockerhost机器的/etc/docker/daemon.json添加insecure-registry.

BKCI这边推送镜像默认都走https，如果要走http需要把仓库域名配置进insecure

走https的话如果仓库域名不是docker客户端开始装的时候对应的那个证书的话，需要在构建机导入这个域名对应的证书

### Q: 哪里可以查看上传到 制品库 的jar包？使用默认方式（不知道）

蓝鲸社区参考：[https://bk.tencent.com/s-mart/community/question/2380](https://bk.tencent.com/s-mart/community/question/2380)

### Q: 拉取镜像失败，错误信息：status 500（研发商店）（构建机）

![](../../../assets/image-20220301101202-CVycR.png)

用户自行配置的仓库，需要先保证网路可达

### Q:新增完凭据之后 选择的时候没有（凭据管理）

检查创建完毕后浏览器有无报错, 检查 ci-auth 及 ci-ticket 的日志有无异常.

如果是普通用户创建的, 可以切换到管理员账户查看是否成功创建.



### Q: 研发商店：插件配置文件\[task.json]atomCode字段与工作台录入的不一致（研发商店）

![](../../../assets/image-20220301101202-WRucB.png)

上传的，可能不是插件发布包，是源代码。发布过程看插件的readme

如果上传的是正确的发布包可以临时编辑插件zip包内的task.json, 修改atomCode(和上传界面一致, 不含下划线)后重新打包上传.

### Q: 配置平台里的业务，如何关联到容器管理平台？（蓝鲸）

![](../../../assets/企业微信截图_16412880662873.png)

![](../../../assets/企业微信截图_16412881057362.png)

1. 权限中心中检查，该用户账号是否具有local-k8s」的配置平台权限
2. 配置平台中检查，「资源-业务-运维人员」中是否有配置该账号用户

![](../../../assets/wecom-temp-ac68ebc38b2022819c8540b00100d2fb.png)



### Q:项目的英文名称可以修改吗(项目)

暂不支持修改

### Q: 在浏览器里完成了BKCI登录，在同一浏览器不同tab访问BKCI，还需要再次登录（还没想好）

这种情况是登录cookie过期了，现在默认应该是两小时，过期时间可调

---

### Q: 服务器磁盘满了，这些目录文件可以删吗(系统磁盘)

![](../../../assets/企业微信截图_1635304491832.png)

这些都是构建产物，目前对构建产物没有过期清理策略，用户可以视情况删除

### Q: 1.5.4版本CI，如何调用openapi（API）

版本还未开启OpenAPI。可以升级到1.5.30及以上版本，该版本已开启OpenAPI。

### Q: 如何查看凭证里的信息（凭证）

![](../../../assets/企业微信截图_16372883269771-4480877.png)

出于安全考虑，该内容为加密的，不支持查看

### Q: 代码检查是否支持lua（codecc）

代码检查暂不支持lua

### Q: 我是否可以自行扩展代码检查的规则（codecc）

目前自行扩展功能还在开发中，暂不支持用户自行扩展代码检查的规则

### Q: 如何让流水线task变成可选

`在插件里选择「Skip some on manual trigger」`

![](../../../assets/wecom-temp-ef4f873c64f962cc9582479c26442f2f.png)

### Q: 这个业务ID是啥（蓝鲸）

![](../../../assets/企业微信截图_1638426248456.png)

配置平台中的「业务ID」，作业平台里也可看到

![](../../../assets/image-20220210194131021.png)

![](../../../assets/image-20220210194135210.png)





### Q: 代码检查里某些规则不适用于我们公司，如何修改规则？（codecc）

规则的内容不支持修改，但是规则集可以修改。代码检查是以规则集为单位进行代码扫描的，如果发现有些规则不适用，可以将其从规则集中去掉，如果该规则集是默认规则集不允许用户增删，可以选择在此基础上创建自定义规则集，创建的规则集就可以由用户自行增删其中的某些具体的规则了

### Q: 代码检查失败，Unknown Error：Unexpected char 0x5468 at 0 in X-DEVOPS-UID value：xxx（codecc）

![](../../../assets/企业微信截图_1630326503372.png)

这一步会读取gitlab 的fullname，设置为英文可以解决问题，暂时还不支持中文的gitlab fullname，个人信息用户名显示上方就是fullname，如这里的vinco huang，可以通过这里的「Edit profile」进入修改页面

![](../../../assets/企业微信截图_16303286841990.png)



### Q: 可以针对流水线设置权限嘛，比如一个项目下的十个流水线，A可以看到一部分，B只能看到另一部分，想根据职能划分一下（蓝鲸）

权限中心可以针对单个流水线进行管理，首先要给特定用户授予项目的权限，然后再授予单个流水线的权限

![](../../../assets/wecom-temp-478bbf51b9813c4ec50828781038028b.png)

![](../../../assets/wecom-temp-d29b308520dfa33da51158b2d5c055a9.png)

![](../../../assets/wecom-temp-1e44f6048453bb9873ad1cc81c869a5e.png)

### Q: BKCI的执行历史有设置上限的地方，我这个定时流水线可能1分钟一次，数据会浪费磁盘

频率高的定时任务，建议使用蓝鲸的作业平台

### Q: Ubuntu蓝鲸agent安装失败，no enough space left in /tmp，但机器是有磁盘空间剩余的（蓝鲸）

![](../../../assets/企业微信截图_16316948048063.png)

一般是由于Ubuntu机器无法正常执行awk命令导致的，执行awk会有如下报错：

`awk: symbol lookup error: /usr/local/lib/libreadline.so.8: undefined symbol: UP`

可以参考这个方法，进行替换：

![](../../../assets/wecom-temp-62020c1b6e41f1f9e6e421bfe0a7dc70.png)

### Q: 关联镜像的时候，镜像验证不通过（研发商店）（镜像）

![](../../../assets/企业微信截图_16328099498489.png)

![](../../../assets/wecom-temp-96f388a0cface3bdddafa174084719a1.png)

镜像在私有仓库，docker默认不支持非https协议的私有仓库，需要修改公共构建机上的/etc/docker/daemon.json，在`insecure-registries`字段里添加私有仓库地址，然后重启docker服务

![](../../../assets/image-20220301101202-lncwv.png)

### Q: bkci的镜像有基于Ubuntu系统的吗（研发商店）（镜像）

没有现成的基于Ubuntu的bkci镜像，用户可以根据指引来打包自己的镜像：[构建并托管一个CI镜像](../../../../../../Devops/2.0/UserGuide/Services/Store/ci-images/docker-build.md)





### Q:Download artifacts为什么下载不了文件？

**1、download 时不要带路径**

例如上传时，制品源填写为 dir1/test.txt ，upload 只会将文件上传，而不将目录上传。

download 的时候只需要填写 test.txt 即可。











