# 私有构建机方案
## 概述
私有构建机，也称为 “第三方构建机” ，是对和特定项目绑定的 Agent 的泛称。一般用于敏感项目、资源隔离、定制硬件或构建环境等场景。

我们默认提供了基于 Docker 技术的公共构建机，公共构建机默认向所有项目开放，使用统一的容器规格。

我们已经在标准运维流程模板“`[蓝鲸持续集成][CI]部署或升级流水线`”中提供了私有构建机的部署流程，仅默认部署了 Linux 系统的支撑环境。

如需在 Windows 及 MacOS 系统下安装私有构建机，需要您手动实施部分步骤。

## 服务端（私有构建机支撑环境）
### 补充软件包
#### jre.zip
中控机 `/data/src/bkci-agent-package-patch/jre` 下需要放置 Linux / Windows / MacOS 对应的 jre.zip 文件。
请务必使用 JDK8 的 tgz 安装包为基础，**注意，是JDK，不是jre， 只是打包后命名为jre.zip**

参考制作命令：
``` bash
jdk_macos="/data/src/jdk-macos.tar.gz"  # 请自行修改路径
jdk_windows="/data/src/jdk-windos.zip"  # 请自行修改路径
mkdir -p /data/src/bkci-agent-package-patch/jre/macos /data/src/bkci-agent-package-patch/jre/windows
/data/src/ci/scripts/bk-ci-gen-jrezip.sh macos "$jdk_macos" /data/src/bkci-agent-package-patch/jre/macos/jre.zip
/data/src/ci/scripts/bk-ci-gen-jrezip.sh windows "$jdk_windows" /data/src/bkci-agent-package-patch/jre/windows/jre.zip
```

#### unzip.exe

windows 需要 `unzip.exe` ，放在中控机 `/data/src/bkci-agent-package-patch/packages/windows/` 目录下。

推荐使用 GnuWin 项目编译的 Info-ZIP： [http://gnuwin32.sourceforge.net/packages/unzip.htm](http://gnuwin32.sourceforge.net/packages/unzip.htm)

### 部署

在完成了软件包补充工作后，进入“标准运维”，重新使用模板“`[蓝鲸持续集成][CI]部署或升级流水线`”创建任务即可。

### 检查部署情况

请安装客户端测试。

## 客户端（私有构建机实例）
### 选型要求

1. 第三方构建机需要能直接（不通过代理）访问 `$BK_CI_PUBLIC_URL` 。如果不能满足，请自行处理网络互通问题。
2. 需要准备至少 2GB 空闲内存，以及 10GB 以上的磁盘空间。

## 安装私有构建机

在创建或编辑流水线界面。选择添加新的“ Job 类型”，一般选择“ Linux ”。在“构建资源类型”下拉框里选择“新增第三方构建机”。
请选择构建机的系统，遵循页面提示安装 agent ，并导入构建机。

一些关于 agent 的信息：
1. 每个 agent 实例是和项目绑定的，无法跨项目分享。但同一个主机上能安装多个 agent 。
2. agent 会把当前执行安装命令的位置作为工作目录。所有的构建时产物及日志都存放于此，请确保空间足够。
3. 不同的 agent 实例请勿共享安装目录，这样会导致问题。
4. 当安装了多个 agent 实例（尤其是跨项目时），请做好运行用户及权限的控制与隔离。

>**提示**
>
>agent 安装目录选择建议：
>1. agent 安装目录需要有足够的磁盘空间。
>2. agent 实例是项目专属的，建议 agent 目录命名和所属项目具备相关性。在多 agent 共存时便于维护及排查。

安装过程中会自动启动进程，最终目录如下：
```text
[devops@VM-5-42-centos p-demo]$ ls -Ap
.agent.properties  devopsDaemon  jre.zip    runtime/  uninstall.sh
agent.zip          install.sh    logs/      start.sh  worker-agent.jar
devopsAgent        jre/          README.md  stop.sh   workspace/
```

## 使用私有构建机

如“安装私有构建机”章节的提示，找到“构建资源类型”，选择类型为 “私有：单构建机”。
如果有通过环境管理设置构建环境，则选择类型为“私有：构建集群”。

## 私有构建机管理

蓝盾顶部导航 → 环境管理

在左侧的“环境”选项卡里，可以对多个构建机进行编组。

## 私有构建机维护
### 检查 agent 状态

确认构建机上 agent 进程（ `devopsDaemon` ， `devopsAgent` ）已存在，页面查看 agent 状态处于正常状态。
```bash
ps -ef | grep  devops
```
windows 构建机请检查任务管理器。

### 卸载及重装

Linux / MacOS：
1. 进入 agent 安装目录。 agent 安装目录可以在 **环境管理**→**节点**→ 点击**别名**链接进入**构建机详情**页面 → 下方**基本信息**→**安装路径** 查到。`agent GO_20190612` 之前版本因为没有采集 agent 安装目录信息，需要通过在构建机上查看进程来追溯安装目录，命令为 `ps -ef | grep devops`
2. 执行 `./uninstall.sh` 卸载 agent ，同时**删除 agent.zip 文件**。卸载后确认 agent 进程已退出，如果没有退出可以手动强制杀掉进程。至此**卸载**完成，如需重装，请继续操作。
3. 从上面步骤 1 的构建机详情页右上角**复制安装命令**，在 agent 安装目录执行安装命令。重装时无需在蓝盾“环境管理”中重新导入。
4. 检查 agent 状态。

Windows ：
参考操作和 Linux 类似。不过使用 任务管理器 确定进程信息。

## 私有构建机问题排查
### 私有构建机安装失败
1. 请检查部署时有无提供对应平台的 jre.zip 。
2. 请检查 jre.zip 内是否有 `bcprov-jdk16-1.46.jar` 。
3. 请检查 Linux / MacOS 系统中是否有 `unzip` 命令。（ Windows 版本包含在 agent 里了）
4. 如果已经完成了上述步骤，请清空安装目录后重新安装。避免旧的错误安装包缓存造成干扰。

### 直接复制 agent 目录启动的 agent 不识别或任务调度异常
同一主机可以在不同的目录安装多个 agent 实例，不同的 agent 实例依靠 agent 安装目录下 `.agent.properties` 文件里的 `devops.agent.id` 区分。

如果 ID 相同，会被视作同一 agent 实例，因此产生心跳异常及调度问题。请卸载其中一个 Agent，并参考“安装私有构建机”章节重新操作。
