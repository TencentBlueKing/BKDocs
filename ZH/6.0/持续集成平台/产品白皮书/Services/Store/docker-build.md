# 构建并托管一个 CI 镜像

bk-ci 提供了默认的 Ubuntu 镜像，但不一定能满足所有编译场景，你可以通过这篇文章基于默认镜像制作自定义镜像。

- 默认镜像： [bkci/ci:latest](https://github.com/ci-plugins/base-images)

## 准备材料

- [docker build](https://docs.docker.com/engine/reference/commandline/build/)相关
知识
- 一台 linux 构建机
- 一个可以在机器上成功构建出镜像的 Dockerfile 工程

## 自定义 CI 镜像

1. 登录构建机，将 Dockerfile 工程同步到构建机，进入 Dockerfile 工程目录

Dockerfile 示例：

```CMD
FROM bkci/ci:latest

RUN yum install -y mysql-devel
```

2. 执行 docker build

> 重要提示：
>
> - 因为流水线里面的容器是通过 CMD，使用/bin/sh 启动的，因此必须保证镜像里面存在/bin/sh 以及 curl 命令（用来下载 Agent）
> - 不要设置 ENTRYPOINT
> - 确保为 64 位镜像
> - 用户用 root，如需普通用户可以在 bash 里面切换，否则流水线任务启动不了

```CMD
docker build -t XXX.com/XXX/YYY:latest -f Dockerfile .
```

3. 执行 docker login

```CMD
docker login XXX.com
```

4. 执行 docker push

```CMD
docker push XXX.com/XXX/YYY:latest
```

## 注意

- 插件可能使用 Java、Python、Golang、Nodejs 其中一种或多种语言开发，镜像环境需支持多种语言执行

  - [Python 插件执行环境](prepare-python.md)
  - [NodeJS 插件执行环境](prepare-node.md)

## 接下来你可能需要

- [发布一个容器镜像](release-new-image.md)
