# Opentelemetry SDK 接入无数据排查思路

SDK接入流程中总是会遇到用户配置了，但平台上没有看到数据的情况 ，因为这个中间的环节比较多，而且涉及两方角色，所以沟通起来会比较费力。该文档提供一个排查思路，快速的进行问题的定位。



SDK接入流程判断: 

1. 获取所在业务/空间和应用名
2. 确认创建的应用token和上报地址是否符合
3. 直接给一个测试的demo程序，应用token和上报地址

    1. 确认用户的机器到达上报地址的网络连通性，获取发送地址IP
    2. 确认用户测试的环境，IDC还是dev，还是办公环境等
    3. 按配置接入正确加载SDK，确认debug日志输出是否正确

4. 检查Collector，是否有接收到数据


## DEMO程序

直接运行DEMO，如果有数据上报，说明链路都没有问题，可以关注下程序输出。

[原代码仓库]()


启动参数

```
Usage of ./ottraces:
  -downstream string
        downstream server address for testing (default "localhost:56099")
  -env string
        env used to switch report environment, optional: local/bkop/bkte (default "local")
  -exporter string
        exporter represents the standard exporter type, optional: stdout/http/grpc (default "stdout")
  -exporter-addr string
        specify the custom exporter address
  -token string
        authentication token (default "Ymtia2JrYmtia2JrYmtiaxUtdLzrldhHtlcjc1Cwfo1u99rVk5HGe8EjT761brGtKm3H4Ran78rWl85HwzfRgw==")
  -upstream string
        upstream server address for testing (default "localhost:56089")

```

如果想要上报到 bkop 环境的话则执行：`./ottraces_linux -exporter http -env bkop -token ${token}`。 



## 示例 traces 效果

![](media/16613347829465.jpg)



