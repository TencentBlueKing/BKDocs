## Q1：bkiam v3 failed

![](../../assets/bkiam_failed.png)

此错误一般是由于机器重启后，权限中心SaaS 未启动导致的。需要手动拉起 SaaS

中控机执行 ``` /data/install/bkcli start saas-o```

其他机器重启的需要的操作，请查看 [机器重启](../../../../../DeploymentGuides/6.1/产品白皮书/维护手册/日常维护/host_reboot.md) 



## Q2：点击插件时报错：服务正在部署中，请稍候

![](../../assets/touch_plugin.png)

常见于 mongodb 异常导致。

中控机执行 ``` /data/install/bkcli restart mongod```

随后检查 mongodb 状态是否正常  ``` /data/install/bkcli status mongod```



## Q3：导航栏视图显示异常

![](../../assets/view_error.png)

应该是project启动的时候，这些数据还没写入到redis中，导致流水线读取不到。

可以通过重启 project 服务进行恢复。

systemctl restart BKCI-project.service



## Q4：BKCICI机器，空间占用过高

可以具体检查是什么文件占用了空间。

通常来说是构建产物占用较多空间，可以使用蓝鲸作业平台，定时清理构建产物。



## Q5：BKCI机器和蓝鲸MySQL之间带宽占用非常大

查看后主要是 BKCI-misc.service 进程在收发流量。

这是BKCI的定时任务，间隔12秒会去做一次扫描清理。流量高的原因主要是跑数据清理的逻辑。

如果带宽占用过大影响使用，可以通过build.data.clear.maxThreadHandleProjectNum这个配置把清理线程数调小一点来减少mysql的操作。
