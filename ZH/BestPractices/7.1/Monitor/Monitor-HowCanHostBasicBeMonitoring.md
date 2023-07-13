>主机基础性能数据CPU、内存等是由bkmonitorbeat插架采集上报，是监控平台最常见的监控对象。

## 确认agent及插件是否正常安装
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230605170705/20044/20230605170705/--07583637b139eefcbf3e8393e93ab0a4.png)

（在节点管理里确认agent和bkmonitorbeat插件状态正常才能采集)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230605170731/20044/20230605170731/--99bf5f399e8e014b2de5e8775dbac754.png)

（主机监控首页，展示所有业务下主机的采集情况)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230605170739/20044/20230605170739/--5243dcd11fdad6123305386cc2e55424.png)

（正常采集的某主机基础性能视图)

>agent及插件未安装的可以参考
agent安装操作见：[节点管理-直连区域和非直连区域的agent如何安装](https://bk.tencent.com/s-mart/community/question/10079)
插件安装及说明见：[有哪些插件？如何安装插件？](https://bk.tencent.com/s-mart/community/question/11241)

## 实操演示

例：配置一个业务模块下所有主机CPU整体使用率监控

Ps:丰富的主机监控指标可见：[监控平台内置的主机监控指标](https://bk.tencent.com/s-mart/community/question/11441)

### 配置告警策略
>监控平台部署完之后内置了常见的告警策略，也可以直接修改使用
内置告警策略详解见：

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230605170953/20044/20230605170953/--e9b995e08a365979f8f82000fc8ddc08.png)
>说明：监控平台提供三种告警级别

- 提醒
- 预警
- 致命

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230605171041/20044/20230605171041/--4a72245e1670ec1e6767a868783ec5ac.png)

（新建告警策略)

>说明：一个周期默认是一分钟

策略建好之后可以根据情况对策略进行关停、调整、增删告警目标等操作

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230605171058/20044/20230605171058/--fd1f5737d30e751345c27ab0aee8c687.png)



还可以对多条告警策略进行批量操作。需要说明的是，批量处理的场景，表示操作产生的结果都保持一样。比如修改告警组，两个告警策略都会修改为相同的。

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230605171113/20044/20230605171113/--933eba700641e1c4349d0d3523395357.png)

### 告警事件查看

在告警事件中可以通过告警策略来检索告警并查看详情
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230605171136/20044/20230605171136/--921aa0e51710ad69e6e4779116c32355.png)

也可以在策略页面快捷查看相关告警
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230605171150/20044/20230605171150/--d5f5fb468668e974974fe222e962e818.png)

以上便是一个最简单的CPU使用率告警策略配置流程，这里涉及到的一些具体配置方法另外的指引单独说明，如告警组的配置，可以详见：  