# 使用二进制来实现 WebHook

## WebHook 实例演示

### 编译生成所需要的二进制 （可选）

（如果所需要启动的程序本身就有二进制提供就可以跳过这一节）
以 bosun 的 webhook 为例，它以 golang 写成，进入到项目目录执行：

```bash
go build
```

得到二进制文件`webhook`

### 将二进制文件添加到版本控制

将`webhook`放到项目的`bin`路径下：

```bash
svn add bin/webhook
```

### 在 Procfile 中添加启动入口

Procfile:

```yaml
web: bin/webhook $PORT
```

其中 `$PORT` 是对外提供服务的监听端口，请保证服务能够正确读取到 `$PORT` 的值，并监听在此端口。

###  提交代码并重新部署

提交代码：

```bash
svn ci -m 'adding webhook procss'
```

在『应用引擎-部署管理』中重新部署。

部署成功后，在『应用引擎-进程管理』中查看启动情况

![-w2021](../../images/docs/2017-09-16-11-53-46.jpg)

访问应用：

![-w2021](../../images/docs/2017-09-16-11-54-28.jpg)

