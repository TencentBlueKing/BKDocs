# 快速使用

为了验证刚部署安装的环境是否正常，除了从后台验证，也需要从页面上进行功能性的验证。

> 蓝鲸相关产品的更多使用详情，请前往 [官网文档中心](https://bk.tencent.com/docs/)

## 创建业务

> 更多使用详情请前往 [蓝鲸文档中心-配置平台](https://bk.tencent.com/docs/document/5.1/9/222)

- 首先在配置平台(CMDB) 上新建一个任务，将 admin 添加至运维人员。
![添加业务](./../images/add_business.png)

- 在业务下新建集群以及模块。(蓝鲸业务不支持集群及模块操作)
![添加模块](./../images/add_modul.png)

## 安装 Agent

> 更多使用详情请前往 [蓝鲸文档中心-节点管理](https://bk.tencent.com/docs/document/5.1/21/682)

- 在对应业务下安装主机 Agent。
![安装agent](./../images/agent.png)
![成功安装agent](./../images/success_agent.png)

- 成功安装完 Agent后，在配置平台(CMDB) 中的对应业务下，则会出现安装好 Agent 的主机。
![主机](./../images/hosts.png)

- 将资源池下的主机移动到模块下。
![分配主机](./../images/dis_host.png)



## 执行作业

> 更多使用详情请前往 [蓝鲸文档中心-作业平台](https://bk.tencent.com/docs/document/5.1/7/185)

- 测试快速执行脚本可用性。
![快速执行作业脚本](./../images/exec_job.png)

- 查看作业执行情况。
![作业执行成功](./../images/job_success.png)


- 测试快速分发文件可用性。

    上传测试文件，分发至目标主机。
![快速分发文件](./../images/exec_file.png)

    查看文件分发情况。
![文件分发成功](./../images/file_success.png)

    查看目标主机路径下是否存在该文件。
![主机存在文件](./../images/exist_file.png)

- 测试定时作业可用性。
    左侧导航栏选择【新建作业】，作业新建完成后，选择【定时作业】进行添加定时作业任务。然后启动任务。
![定时作业](./../images/add_script.png)
![新建定时作业](./../images/job_Timeing.png)
    左侧导航栏选择【执行历史】查看定时作业执行情况。
![定制作业执行情况](./../images/Timejobsuccess.png)


## 创建流程

> 更多使用详情请前往 [蓝鲸文档中心-标准运维](https://bk.tencent.com/docs/document/5.1/3/22)

- 新建一个业务流程模板。

    选择【快速执行脚本】，输入脚本内容，目标 IP 通过变量进行传入，类型选择【IP 选择器】，[IP 选择器（简单版）跟 IP 选择器的区别](https://github.com/Tencent/bk-sops/blob/V3.3.X/docs/features/variables_engine.md#ip%E9%80%89%E6%8B%A9%E5%99%A8%E7%AE%80%E5%8D%95%E7%89%88) 。
![新建流程模版](./../images/add_sops.png)

- 新建并认领流程任务。
![新建](./../images/add_sops_task.png)
![认领任务](./../images/select_sops_task.png)

- 查看参数无误并执行任务。
![执行任务](./../images/view_para.png)

- 任务执行完成后，点击步骤可以查看执行的详细信息。点击对应链接可以跳转至作业平台查看作业执行情况及信息。
![](./../images/sops_task_situation.png)
![](./../images/sops_task_situation2.png)

