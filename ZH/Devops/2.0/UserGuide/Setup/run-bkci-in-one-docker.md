# 使用 One-Docker 运行 BK-CI 的学习环境

我们提供了[BK-CI](https://hub.docker.com/r/blueking/BK-CI)的单容器的部署方案，仅供演示。

创建名为 bkci-demo 的容器, 并传递主机的80端口到容器内的80端口:

```text
docker run -p 80:80 --name bkci-demo -dit blueking/bkci
```

观察容器启动日志输出:

```text
docker logs -f bkci-demo
```

当服务全部启动成功, 会输出访问提示:

> 服务成功启动. 您可以在浏览器输入 [http://devops.bktencent.com](http://devops.bktencent.com/) 访问bkci了. \(请提前配置DNS或hosts\)

