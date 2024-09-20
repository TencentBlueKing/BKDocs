# 配置开发环境

开始应用开发前，你的机器上需要安装好 NodeJS 及蓝鲸应用所需的第三方模块。

针对不同的操作系统，环境配置方式可能略有不同。请跟随你所使用的操作系统内容进行配置。

## 开发环境配置

### 1. 安装 Docker

访问 [Docker 官方下载页面](https://docs.docker.com/get-docker/)，建议下载官方提供的稳定版本

安装完成后，在命令行输入 **docker version** 命令验证安装：

```
Client:
 Version:           20.10.10
 API version:       1.41

Server: Docker Engine - Community
 Engine:
  Version:          20.10.10
  API version:      1.41 (minimum version 1.12)
```

### 2. 登录个人账户

```
# 以下方括号内容为需要根据实际需求替换的字符串
# 登录至软件源 docker registry，[user]为账号名，[token]为软件源系统分配，可以通过【快捷指令】获取
sudo docker login --username [user] --password [token] mirrors.tencent.com
```

如果你需求使用公网的镜像，由于 [Docker Hub](https://registry.hub.docker.com/) 限制了限制匿名的 pull 频率, 建议登录个人账户, 避免无法正常拉取镜像。

## 完成开发环境配置

恭喜你！如果你在上面的各项安装没有碰到过任何问题，那么，你的开发环境就已经配置完成啦。
