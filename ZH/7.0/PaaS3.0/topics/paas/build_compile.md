# 部署前置命令

## 什么是部署前置命令

部署前置命令，即一个用户可以在部署阶段使用的钩子。

要想了解部署前置命令，我们先来看看部署的过程。
蓝鲸应用的部署过程分为两个阶段：
- build 阶段，从源码包构建可运行实体（简称 `slug.tgz`）
- release 阶段，由 `slug.tgz` 部署成应用实例

其中，`slug.tgz` 是一个包含 **用户代码** 和 **运行时所需依赖** 的软件包。在构建 `slug.tgz` 时，会根据应用的配置文件，安装依赖的软件包，这一过程称为 compile。**部署前置命令**是对 compile 过程的扩充，支持开发者自定义 compile 的前置和后置操作。

以蓝鲸开发框架为例，平台会根据 requirements.txt 文件，安装运行所需的 python 包。然而，会有一些特殊的情况：
- 有些 python 包会有系统库依赖，需要提前安装这些依赖才能完成最终的安装
- 有些操作需要在 release 阶段之前完成，例如数据库变更

利用部署前置命令，就能轻松解决这些问题。

## 如何使用部署前置命令

你只需要使用 pre-compile 和 post-compile 文件即可。其中 pre-compile 定义 compile 的前置行为，post-compile 定义后置行为，

它们支持 bash 语法，并且可以使用所有环境变量。（关于环境变量，可以参看 [如何使用自定义环境变量](./custom_configvars.md) 了解更多）

你需要将它们存放在项目的`bin/`目录下。如果使用开发框架，则默认有 post-compile 文件。

post-compile 使用示例：

```bash
#!/bin/bash
python manage.py migrate
```

表示 python 包安装完成后，执行 migrate 操作，从而保证了在 release 阶段之前，数据库是最新的结构。

以此类推，如果需要跳过此次 migrate，除了删除掉相应的 migration 文件，也可以执行：

```bash
#!/bin/bash
python manage.py migrate --fake
```

> 注意： pre-compile 和 post-compile 的行为，请确保 ***对文件系统的修改*** 最终都是在 ***项目目录*** 下，并且请以项目目录为根目录，所有操作都使用相对路径，否则不会被构建到 `slug.tgz` 中。

