# 构建(Build)阶段钩子

## 什么是构建(Build)阶段钩子?

平台提供了 3 个 "hooks" 让用户可以在部署新版本应用时执行自定义脚本, 其中有两个 "hooks" 分别在构建(Build)阶段前, 和构建(Build)阶段后执行, 我们也分别称它们为构建前置指令和构建后置指令。

为了更好地了解构建(Build)阶段钩子, 我们先来看看部署的过程。
基于源码构建应用的部署过程分为两个阶段：

- build 阶段，从源码包构建可运行的镜像
- release 阶段，由镜像部署成应用实例

以蓝鲸开发框架为例，平台会根据 requirements.txt 文件，安装运行所需的 python 包。然而，会有一些特殊的情况：

- 有些 python 包会有系统库依赖，需要提前安装这些依赖才能完成最终的安装
- 有些操作需要在 release 阶段之前完成，例如数据库变更

利用构建(Build)阶段钩子，就能轻松解决这些问题。

## 如何使用构建(Build)阶段钩子？

平台约定了用户代码中的 `bin/pre-compile` 和 `bin/post-compile` 文件即为 `构建(Build)阶段钩子` 中执行的自定义脚本, 其中 `pre-compile` 定义构建前置钩子，`post-compile` 定义构建后置钩子。

在实际运行时, 构建阶段可以使用所有环境变量。（关于环境变量，可以参看 [如何使用自定义环境变量](./custom_configvars.md) 了解更多）

如果构建(Build)阶段钩子执行失败, 那么该次构建将被认为执行失败, 同时也不会进入「部署阶段」。

## 示例

### pre-compile 脚本示例:

```bash
#!/bin/bash
npm config set registry https://mirrors.tencent.com/npm/
echo `npm config list`
```

该脚本将在「构建」阶段执行前(即安装 node 依赖前), 设置 npm 依赖源的地址, 从而保证「构建」阶段时使用该依赖源。

### post-compile 脚本示例：

```bash
#!/bin/bash
echo "Post Hook: this runs after build"
```

{% include warning.html content=" pre-compile 和 post-compile 的行为，请确保 ***对文件系统的修改*** 最终都是在 ***项目目录*** 下，并且请以项目目录为根目录，所有操作都使用相对路径，否则不会被构建到镜像中" %}

## FAQ

### 如何保证构建(Build)阶段钩子中声明的所有命令都执行成功？

按照 bash 脚本的执行规则, 只有最后一条命令失败时, 才会认为脚本执行失败。如果要在第一条失败的命令上中止继续执行, 请在脚本的开头中添加 `set -e`，例如：

```bash
#!/bin/bash
set -e
python manage.py migrate --no-input
```

### 基于镜像部署的蓝鲸应用如何在 release 前执行自定义指令(如数据库变更)？

对于基于镜像部署的蓝鲸应用, 请使用 [部署前置命令](./release_hooks.md)
