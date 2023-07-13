>在[【监控平台】如何配置进程监控之固定端口方式](https://bk.tencent.com/s-mart/community/question/11541)中，分享了基于配置平台的固定进程名+端口的进程监控配置方法，那端口不固定的场景如何来实现呢。

## 实现方法
通过进程采集的方式来实现，依赖bkmonitorbeat采集器

## 实现原理
通过采集器配置需要监控的进程名，条件可以选择包含，不包含某些命令行的关键字，类似Linux命令grep，过滤出需要的进程，然后探测该进程是否开启端口(可选功能)，同时会采集该进程的相关使用情况
```
ps -ef | grep "包含的关键字"|grep -v "不包含的关键字"
```

## 实操演示
例：某台主机上包含nginx进程名的监控配置（没有在配置平台配置进程信息）

### 1、确保主机安装了gse_agent及bkmonitorbeat插件
如未安装可以查看：[节点管理有哪些插件？如何安装插件？](https://bk.tencent.com/s-mart/community/question/11241)
>如果监控平台版本是3.6.3084以上，会依赖bkmonitorbeat版本2.13.0+，监控及采集器更新可见[【单产品更新公告】【监控平台】](https://bk.tencent.com/s-mart/community/question/6431)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615155442/20044/20230615155442/--4d68aa989e2bc46a905a8ec6bd4d6116.png)

### 2、配置进程采集
集成-->数据采集-->新建
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615155500/20044/20230615155500/--8ffb9e0de996c0fd15403c49a3bf8078.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615155505/20044/20230615155505/--d65893532d98a9d9660552e6587cfa11.png)

（新建一个进程类的数据采集)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615155518/20044/20230615155518/--fc13b0e9449c070641b67150c4f120ba.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615155522/20044/20230615155522/--668153a2921591be814d9f401a8f2cb2.png)

（选择目标主机：选择一台没有走服务模板创建的模块下的主机，并且没有配置进程相关信息)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615155530/20044/20230615155530/--919aaa2af75572fd4568fc3ae1c6042a.png)

（下发采集配置)

成功下发之后可以查看数据视图
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615155550/20044/20230615155550/--432854f803da6c07c81c8bbb6374a7af.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615175409/20044/20230615175409/--47f694f0df4415aac0fe16b41f1d15de.png)


### 3、配置进程监控
- 进程是否存在监控

进程是否存在的事件告警依赖在配置平台里配置进程信息，所以如果是监听随机端口，又需要进程告警，可以只配置进程信息即可
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615155839/20044/20230615155839/--2df86ff3463536935f3f64df1f27701d.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615155845/20044/20230615155845/--7210426d5e37aeb48b4232ad9dc12a14.png)

（主机是直接配置进程信息，可以不配置端口监听信息)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615155913/20044/20230615155913/--d1661e8bc70446781277529ac0679f8e.png)

（配置一个进程端口告警的策略)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615155940/20044/20230615155940/--0b11096fa475a131d59761f4c6c2584c.png)

（对应的告警信息)

- 进程指标监控

  进程采集上来的信息覆盖了丰富的指标，如进程占用CPU、占用fd数等。除了最基本的进程存活监控，可以按需配置指标的监控
  如：监控nginx fd的打开数

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615160001/20044/20230615160001/--65e6d951b7b38883f204b33a58105c0a.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615160008/20044/20230615160008/--5258d4114e60fbe347bc1102fcf57eff.png)

（配置fd打开数的指标监控)

附：进程自定义采集方式采集的指标说明（跟bkmonitorbeat插件默认采集的指标不同）
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615160026/20044/20230615160026/--433373d919348ccfb6135ef5179e9a03.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615160046/20044/20230615160046/--660c7824cede9f0c4e060857292d1ef7.png)
