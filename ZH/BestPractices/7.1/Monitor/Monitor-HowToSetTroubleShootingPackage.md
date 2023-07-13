>通常告警触发时，除了发送告警通知，还可以有告警处理的相关动作，如告警回调，告警处理等功能。处理套餐将告警和运维系统联动起来使用，实现故障的自动处理，自动愈合。

### 默认的处理套餐类型

>套餐是业务运维人员设计制作的一套恢复故障的方案，可以复用于不同的告警，也可作为原子套餐用于制作组合套餐。

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615161425/20044/20230615161425/--063e0c2728ff2177ea85e869df5c0607.png)

- http回调，将告警内容透传给另外一个服务，然后做自定义的处理
- 作业平台，在告警之后执行一个清理磁盘的作业
- 标准运维，在告警之后执行一个完整的流程（如转移故障主机到故障模块）
- 流程服务，在告警之后触发一个工单流程（如更换主机的审核工单）

### 实操演示
新增一个简单的清理磁盘的作业执行的处理套餐，当配置了磁盘告警的，可以选择使用该套餐。

#### 1.新建清理磁盘的作业执行方案
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615161516/20044/20230615161516/--a0e426c51f3727579d056071a4cd6566.png)

（新建了一个简单的清理磁盘的执行方案)

#### 2.新建处理套餐
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615161531/20044/20230615161531/--ea64fe18bf8a541183847e0e3ec760e9.png)

可以先调试下处理套餐中的执行方案

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615161549/20044/20230615161549/--b6e1bf96103791f163fbf91e150cd858.png)

>作业平台里的全局变量host_list，在执行处理套餐时，实际就是传入的告警的目标ip，也就是监控里的target.host.bk_host_innerip

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615161600/20044/20230615161600/--c0bf6a9a946d8a037a5a36f5e4ee6c1d.png)

调试成功保存套餐即可


#### 3.配置告警策略
比如在一个磁盘使用的告警策略里，告警处理-告警触发时选择前面创建作业平台磁盘清理的处理套餐
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615161618/20044/20230615161618/--6b0bbf7bfc7d3eecfc68cdc424cb9e4f.png)


#### 4.查看处理套餐执行记录
- 告警详情-流转记录里查看

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615161632/20044/20230615161632/--89fae468305f7918d013e3eaca6ca4a8.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615161637/20044/20230615161637/--7371566b47d25e4d84ae347fcc1ab07b.png)

- 总处理记录里查看

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615161650/20044/20230615161650/--fffed5cf46ea79ac50fafde4464d94aa.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615161655/20044/20230615161655/--d53512060e3ef25236436326fe515ab4.png)

如此，便完成了一个最简单的处理套餐配置过程。更多丰富复杂的套餐（标准运维、http回调等)可以自行尝试。