>进程是监控平台最常见的监控对象，也是业务纬度最重要的监控场景之一

## 两种进程监控场景

在实际的业务场景里，主要有两种进程监控方式
- 进程名+固定端口，如nginx服务，固定监控80端口，nginx+80
- 进程名+随机端口，如一些对外服务进程，建立链接时监听随机端口

### 固定端口的进程监控配置
固定端口的进程监控主要是基于配置平台里服务模板或单主机上定义好的进程名及端口，然后由采集器bkmonitorbeat来实现采集上报。

#### 监控原理
```
bkmonitorbeat进程监控逻辑：
1.CMDB主机-服务实例 配置端口
2.gse server从CMDB同步端口数据
3.gse_agent收到数据写入到本机/var/lib/gse_bkte/host/hostid
4.bkmonitorbeat通过inotify监听/var/lib/gse_bkte/host/hostid文件变化，读取需要监听的进程端口信息
5.对指定的端口从Linux内核通过netlink读取监听状态，将进程端口数据上报
6.上报的数据中，未监听的端口产生告警
```

#### 实操演示
例：监控nginx模块下主机上的nginx进程，监听的端口为80。

##### 1、在配置平台里创建服务进程
创建服务进程可以通过服务模板或者直接在主机上添加进程两种方式，具体详细指引可见：[配置平台如何创建服务实例（添加进程和端口)](https://bk.tencent.com/s-mart/community/question/11178)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615152717/20044/20230615152717/--a91e736dfd2ed779d21289747db45cbb.png)

（通过服务模板的方式添加进程信息)

>注意“进程名称”必须是OS中实际存在的进程名，"进程启动参数"是第2次的过滤条件，为匹配进程的关键字，其实现原理类似于
>ps -ef|grep "进程名称" |grep "进程启动参数"
>![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615152749/20044/20230615152749/--36113435ebd1641ab21976c0e160a8bf.png)
>
>进程匹配的原则：
>1.优先匹配/proc/${pid}/status中的进程名称

>![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615152757/20044/20230615152757/--547bebfce6daa5466b65f2e8e4b03cec.png)
>
>2.匹配/proc/${pid}/cmdline中的进程名
><br>3.匹配/proc/${pid}/exe中的名称

##### 2、转移主机到nginx模块（确保已安装agent和bkmonitorbeat插件）
如未安装可以查看：[节点管理有哪些插件？如何安装插件？](https://bk.tencent.com/s-mart/community/question/11241)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615153006/20044/20230615153006/--966b52e6ec4a1ce35c04a472275a32ef.png)

（转移主机到nginx模块)

##### 3、查看进程监控
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615154518/20044/20230615154518/--ea87383b7d5416974dbf4ac3eb556ba9.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615154524/20044/20230615154524/--9dad8ef0aab083d9db1955fb95fe05b1.png)

##### 4、进程端口告警
###### 4.1、进程端口基础告警（进程存活、端口监听）
- 默认的内置进程端口告警策略

> 可以修改直接使用，但是因为内置的告警策略默认监控目标是所有主机，所以建议是单独新建告警策略。

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615154551/20044/20230615154551/--ca192391927ef0443392d02dc3deb1b7.png)



- 新建端口告警策略

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615154629/20044/20230615154629/--d5d3865fa981c815ab505a1c058b3b30.png)

（新建一个Nginx80端口监控的策略)

停掉nginx进程，模拟进程挂掉
```
service nginx stop
```
当进程挂掉之后，则会收到端口告警，可以根据配置的告警通知方式查收告警。
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615154658/20044/20230615154658/--77286e8303b7b2b774da2709b0f9694e.png)



###### 4.2、进程指标监控（如进程CPU的使用率）

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615154708/20044/20230615154708/--d190fd456b91b32265367bcedf36425d.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615154714/20044/20230615154714/--b0ece867e1cd3023a9182e56fc226a98.png)

（配置进程指标告警策略)

同理，当触发告警时，可以在告警事件根据告警策略查看相关的告警信息及详情。

附：bkmonitorbeat插件采集的默认指标说明

**Linux 采集**

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615154813/20044/20230615154813/--c990f83aee3ce33dd58dc3f96e02817b.png)



**Windows 采集**

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615154850/20044/20230615154850/--e946f9099e3b8a3070a07a518753f7a8.png)

