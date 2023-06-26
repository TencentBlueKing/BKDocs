## 错误排查需要的关键信息

1、当前所使用的CI版本号

2、问题出现的操作描述，及报错截图。

如果是页面出现的报错，请收集页面报错信息。

3、问题是否可复现？问题为偶现还是必现？

4、问题是一直存在还是突然出现的？出现前是否有做过什么操作？

5、服务日志。

6、构建日志。



---

## 构建日志收集

构建日志存放在构建机中，构建日志存放的路径位于：

**私有构建机**：{agent 安装目录}/logs/{构建号}

**公共构建机**：/data/bkce/logs/ci/docker/{构建号}



**私有构建机中，agent安装目录怎么看**：

BKCI---环境管理---节点---{对应使用的构建机}---安装路径

![agent安装目录](../../assets/build_log_url.png)

**构建号怎么看**：

流水线 URL 中，最后一串以 b- 开头的字符串即为构建号

![构建号](../../assets/build_id.png)



## 服务日志收集

进入CI机器

```find /data/bkce/logs/ci/ -name \*-devops.log -o -name \*-devops-error.log |xargs tar zcvf /root/bkci-log.tar.gz```

然后发送打包好的 **/root/bkci-log.tar.gz** 日志



## 页面报错信息收集

如遇到页面报错，浏览器 F12 打开控制台后再复现一次请求操作，并且：

①、打开 network 标签，点击错误的请求并截图。

![error_request](../../assets/error_request.png)



②、打开 console 标签，并截图。

![error_console](../../assets/weberror_console.png)

