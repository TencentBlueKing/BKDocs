# 构建并托管一个 CI 镜像

bk-ci 提供了默认的 Ubuntu 镜像，但不一定能满足所有编译场景，你可以通过这篇文章基于默认镜像制作自定义镜像。

- 默认镜像： [bkci/ci:latest](https://github.com/TencentBlueKing/ci-base-images/blob/master/ci-build/Dockerfile)

## 准备材料

- [docker build](https://docs.docker.com/engine/reference/commandline/build/) 相关知识
- 一台linux构建机
- 一个可以在机器上成功构建出镜像的Dockerfile工程

## 自定义CI镜像

1. 登录构建机，将Dockerfile工程同步到构建机，进入Dockerfile工程目录

- **Dockerfile 示例1（以bkci默认镜像为基础镜像）：**

```CMD
FROM bkci/ci:latest

RUN yum install -y mysql-devel
```

- **Dockerfile 示例2（不以bkci默认镜像为基础镜像时，镜像环境基本要求如下）：**

```CMD
# ============= bkci基础环境 ================
FROM openjdk:8-jre-slim
RUN apt update && apt upgrade && apt autoremove -y
RUN apt install -y curl wget
RUN wget -q https://repo1.maven.org/maven2/org/bouncycastle/bcprov-jdk16/1.46/bcprov-jdk16-1.46.jar -O $JAVA_HOME/lib/ext/bcprov-jdk16-1.46.jar
RUN ln -sf $JAVA_HOME /usr/local/jre

# ============= 自定义环境 ================
# RUN whatever you want
RUN apt install -y git python-pip

```

> **重要提示**：
>
> - 因为流水线里的容器是通过CMD，使用/bin/sh启动的，因此必须保证镜像里面存在/bin/sh以及curl命令（用来下载Agent）
> - 不要设置ENTRYPOINT
> - 确保为64位镜像
> - 用户用root，如需普通用户可以在bash里面切换，否则流水线任务启动不了
> - 流水线插件有可能使用 python 或 nodejs 开发，建议准备好插件执行环境:
<br/>[Python 插件执行环境](./prepare-python.md)
<br/>[NodeJS 插件执行环境](./prepare-node.md)

2. 执行docker build

```CMD
docker build -t XXX.com/XXX/YYY:latest -f Dockerfile .
```

3. 执行docker login

```CMD
docker login XXX.com
```

4. 执行docker push

```CMD
docker push XXX.com/XXX/YYY:latest
```

## 接下来你可能需要

- [发布一个容器镜像](release-new-image.md)
