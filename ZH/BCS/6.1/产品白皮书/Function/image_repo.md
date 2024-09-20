# 仓库

容器服务采用 Harbor 做镜像仓库。仓库分为公共镜像和项目镜像，公共镜像可以被所有项目共享，项目镜像只有当前项目有权限访问。

![-w2020](../assets/image_repo.png)

## Harbor 镜像仓库简介

[Harbor](https://github.com/vmware/harbor) 是 VMware 公司开源的企业级 Docker Registry 管理项目。在 Harbor 仓库中，用户和仓库都是基于项目进行组织，用户基于项目可以拥有不同的权限。

Harbor 项目类型分为公共仓库和私有仓库两种类型，其中

- 公共仓库：任何使用者都可以获取这个仓库中的镜像。
- 私有仓库：只有被授予权限的用户可以获取这个仓库中的镜像。

更多关于 Harbor 项目和用户的使用指引，请参考 [Harbor 的用户手册](https://github.com/goharbor/harbor/blob/main/docs/README.md)。

## 容器服务中的 Harbor 仓库
### 获取项目仓库账号

选中【Helm】菜单中的【Charts 仓库】，点击右上角【如何推送 Helm Chart 到项目仓库】指引，可以获取仓库信息。

![-w1566](../assets/repo_info.png)

具体包含以下内容：
- 镜像仓库地址，下文用`<registry_url>`表示(注意：地址包含端口)。`<registry_url>`实际是服务上(如集群中的 Node 节点)配置的内网 consul 域名，如果需要浏览器或者本地终端访问，可以本地配置 hosts，如`10.0.0.1 <registry_url>`，其中`10.0.0.1`是`<registry_url>`后端服务器上的 IP(如外网 IP，保证本地可访问)
- 镜像仓库用户名和密码 （Harbor 中的一个项目账号，可以上传 **镜像** 和 **Charts**）
- 项目 code，下文用`<project_code>`表示，如上图中的`demoproj1`


### 登录镜像仓库

```bash
docker login --username=<username> <registry_url>
Password:
Login Succeeded
```
注意：镜像仓库地址包含端口。

### 推送镜像

推送镜像之前，要先将镜像 tag 为满足 **Harbor 项目前缀要求的格式**。

例如需要将本地镜像`nginx:1.18.0`推送到当前项目下，首先将镜像按下面的命令重新 tag。

```bash
docker tag nginx:1.18.0 <registry_url>/<project_code>/nginx:1.18.0
docker push <registry_url>/<project_code>/nginx:1.18.0
```

### 拉取镜像

拉取项目镜像前需先完成登录，拉取公共镜像可以不登录。

```bash
docker pull <registry_url>/<project_code>/nginx:1.18.0
```

## 登录 Harbor Web 仓库
### 获取 Harbor 账号

- 获取项目仓库账号

在 【Chart 仓库】菜单下，点击【查看项目 Chart 仓库配置信息】后，可以获取 Harbor 的项目账号，访问项目（BCS 中新建的项目）仓库。

- 获取 Harbor 管理员账号

在[常用环境变量](../../../../DeploymentGuides/6.1/产品白皮书/增强包维护/BCS/Env_variable.md) 中可以找到 Harbor 的用户名`HARBOR_SERVER_ADMIN_USER`以及密码`HARBOR_SERVER_ADMIN_PASS`。

### 访问 Harbor Web 端

- 项目仓库账号视角

通过浏览器可以访问地址 `<registry_url>`，进入 Harbor 管理页面，从中可以看到项目的访问级别有“公开”和“私有”。

![-w1565](../assets/15675973703087.jpg)

在上图中点击 项目仓库 `joyfulgame`，可以看到有 2 个镜像，其中`joyfulgame`是`<project_code>`。

![-w1570](../assets/15675973839581.jpg)

点击 【Helm Charts】页面，可以看到仓库中上传的 [Charts](helm/ServiceAccess.md)。

![-w1566](../assets/15675973941768.jpg)

- Harbor 管理员账号视角

使用管理员账号，可以实现用户管理、仓库管理、复制管理、配置管理。

![-w1563](../assets/15675975535096.jpg)
