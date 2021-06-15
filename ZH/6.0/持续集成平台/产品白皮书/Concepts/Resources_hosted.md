# bk-ci 云托管的构建资源

为了让你更友好的接入 CI，我们提供了包含以下类型的公共构建资源，你可放心使用。

## Linux Docker 母机

在部署好 bk-ci 之后默认内置的公共构建资源（如无法选择，请联系你的 CI 平台管理员），我们会在你的物理机/虚拟机上运行 Docker 服务来运行你的 CI 编译镜像，你只需要在流水线里指定一个镜像地址即可开始编译。

![Resource](../assets/resource_1.png)

## 自定义 CI 镜像

我们在 dockerhub 上内置了两个最基础的 CI docker 镜像：

image | dockerfile
--- | ---
bkci/ci:latest | https://github.com/ci-plugins/base-images/blob/master/ci-build/Dockerfile
bkci/ci:alpine | https://github.com/ci-plugins/base-images/blob/master/ci-build-less/Dockerfile

你也可以将这两个镜像作为基础镜像来制作你自己的 CI 镜像，当然，这需要一点点[Docker build](https://docs.docker.com/engine/reference/commandline/build/)相关知识。

制作自定义 CI 镜像请参考：[构建并托管一个 CI 镜像](../Services/Store/docker-build.md)
