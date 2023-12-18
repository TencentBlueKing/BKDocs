# 镜像仓库使用指南

蓝鲸容器服务采用 Harbor 做镜像存储，用户除了可以使用 Harbor 的管理页面对项目、用户和镜像做管理外，还提供与容器服务配套的 API，方便容器服务和仓库使用。

## Harbor 镜像仓库简介

Harbor 是 Vmware 公司开源的企业级 Docker Registry 管理项目，开源项目地址：[Harbor](https://github.com/vmware/harbor)。

在 Harbor 仓库中，镜像在被推送到仓库之前都需要有一个自己所属的项目。用户和仓库都是基于项目进行组织的，而用户基于项目可以拥有不同的权限。

Harbor 项目类型分为公共仓库和私有仓库两种类型，其中

- 公共仓库：任何使用者都可以获取这个仓库中的镜像。
- 私有仓库：只有被授予权限的用户可以获取这个仓库中的镜像。

更多关于 Harbor 项目和用户的使用指引，请参考 [Harbor 的用户手册](https://github.com/goharbor/harbor/blob/master/docs/user_guide.md)。

## BCS 中的 Harbor 仓库
### 获取项目仓库账号

选中【Helm】菜单中的【Charts 仓库】，点击右上角【如何推送 Helm Chart 到项目仓库】帮助，可以获取仓库账号。

![-w1566](../assets/15675920013542.jpg)

包含以下信息：
- 镜像仓库地址：`<Registry_URL>`；Web 端也可以访问。注意：地址包含端口。
- 镜像仓库账号、密码 （Harbor 中的一个项目账号，可以上传 **镜像** 和 **Charts**）
- 项目 ID：`<Project_ID>`，如上图中的`joyfulgame`

### 登录镜像仓库

```bash
docker login --username=<USERNAME> <Registry_URL>
Password:
Login Succeeded
```
注意：镜像仓库地址包含端口。

### 推送镜像

推送镜像之前，要先将镜像 tag 为满足 **Harbor 项目前缀要求的格式**。

例如需要将本地镜像`nginx:1.17.0`推送到当前项目下，首先将镜像按下面的命令重新 tag。

```bash
docker tag nginx:1.17.0 <Registry_URL>/<Project_ID>/nginx:1.17.0
docker push <Registry_URL>/<Project_ID>/nginx:1.17.0
```

### 拉取镜像

拉取项目镜像前需先完成登录，拉取公共镜像可以不登录。

```bash
docker pull <Registry_URL>/<Project_ID>/nginx:1.17.0
```

## 登录 Harbor Web 仓库
### 获取 Harbor 账号

- 获取项目仓库账号

在 *获取项目仓库账号* 中可以获取 Harbor 的项目账号，可以访问项目（BCS 中新建的项目）仓库。


- 获取 Harbor 管理员账号

在[部署 BCS 的文档](../../../部署指南/产品白皮书/增强包安装/机器评估/bcs_evaluate.md) 中有一个环境变量文件 `globals.env` ，其中可以找到 Harbor 的用户名（`HARBOR_SERVER_ADMIN_USER`）以及密码（`HARBOR_SERVER_ADMIN_PASS`）。

### 访问 Harbor Web 端

- 项目仓库账号 Web 端

在 *获取项目仓库账号* 中可以获取 Harbor 的 Web 端访问 URL，进来可以看到项目列表，包含 **公共项目** 和 **私有项目**。

![-w1565](../assets/15675973703087.jpg)

在上图中点击 项目仓库 `joyfulgame`，可以看到有 2 个镜像。

![-w1570](../assets/15675973839581.jpg)

点击 【Helm Charts】页面，可以看到仓库中上传的 [Charts](helm/ServiceAccess.md)。

![-w1566](../assets/15675973941768.jpg)

- Harbor 管理员账号 Web 端

使用管理员账号，可以实现用户管理、仓库管理、复制管理、配置管理。

![-w1563](../assets/15675975535096.jpg)
