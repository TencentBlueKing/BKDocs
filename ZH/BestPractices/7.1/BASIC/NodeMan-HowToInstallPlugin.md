>节点管理里的插件指的是gse插件，是由gse_agent托管的具有一定特定功能的程序。

目前提供的插件主要是监控平台/日志平台采集器使用。

## 插件有哪些？

### 6.1版本之前

| 插件名 | 功能描述 | 安装方式 | 操作方法 |
| --- | --- | --- | --- |
| basereport | 主机操作系统等基础信息 | agent安装过程自动安装 | 节点管理托管 |
| processbeat | 主机进程信息采集 | agent安装过程自动安装 | 节点管理托管 |
| exceptionbeat | 主机系统事件信息采集 | agent安装过程自动安装 | 节点管理托管 |
| bkmonitorbeat | 日志关键字事件, 插件和采集,服务拨测,SDK,CMDB主机数据上报 | agent安装过程自动安装 | 节点管理托管 |
| bkunifylogbeat | 日志文件采集 | 使用日志采集功能时触发安装 | 日志平台页面触发 |
| bkmonitorproxy | 自定义上报(事件/指标) ping服务 | 非直连随安装proxy而安装 | 节点管理托管 |
| gsecmdline | 脚本命令行自定义上报 | agent安装过程自动安装 | 节点管理托管 |


### 6.1版本之后

6.1版本发布之后，针对采集器做了合并优化，原basereport、processbeat、exceptionbeat的功能统一合并到了**bkmonitorbeat**。

| 插件名 | 功能描述 | 安装方式 | 操作方法 |
| --- | --- | --- | --- |
| bkmonitorbeat | 主机操作系统、进程、系统事件、日志关键字事件, 插件和采集,服务拨测,SDK,CMDB主机数据上报 | agent安装过程自动安装<br>节点管理托管 | - |
| bkunifylogbeat | 日志文件采集 | 使用日志采集功能时触发安装 | 日志平台页面触发 |
| bkmonitorproxy | 自定义上报(事件/指标) ping服务 | 非直连随安装proxy而安装 | 节点管理托管 |
| gsecmdline | 脚本命令行自定义上报 | agent安装过程自动安装 | 节点管理托管 |
|bk-collector|调用链(tracec)上报服务,支持 OT、Jaeger、Zipkin 等多种数据协议格式|agent安装过程自动安装|节点管理托管|

>Ps：需要注意的是，6.1版本插件虽然进行了合并，但是老的几个插件并没有直接下掉，因为需要兼容旧版本，所以如果部署的是6.1版本或者升级到了6.1版本，可以在节点管理取消托管并停掉basereport、processbeat、exceptionbeat三个插件。同时在节点管理后台配置默认不再自动安装以上三个插件。

**停止旧插件（需要确保bkmonitorbeat已经成功起来了）**

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230517153502/20044/20230517153502/--6dada96267e2a98c643a3a4feabeffae.png)

**配置不再默认自动安装旧插件**

打开：xxxx(蓝鲸平台域名)/o/bk_nodeman/admin_nodeman/node_man/globalsettings/

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230517153525/20044/20230517153525/--4003887e421a50e8f524ea73e07d1c67.png)

按需保留即可。（bkunifylogbeat是高性能日志采集用，如果暂时没用到日志采集场景，可以不用默认安装）

## 如何安装插件？
### 1、随agent安装自动安装
即agent安装成功之后，便自动安装了，并且由gse_agent托管。当gse_agent启动后，被gse_agent托管的采集器会自动启动。如机器重启后，或者采集器被意外终止，只要gse_agent存活，则采集器都会被自动拉起。

### 2、页面触发安装
比如bkunifylogbeat，日志平台接入日志采集时会触发安装。

### 3、节点管理手动更新安装
如果没有配置插件更新策略，可以手动到节点管理更新插件版本

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230517153556/20044/20230517153556/--2b42ef850d67374df8720c80c8bfc77b.png)