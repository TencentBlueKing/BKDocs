# 在私有构建机中使用 Linux C/C++ 编译加速

> Linux C/C++ 编译加速支持 pch、gcov、分布式预处理等功能<br/>
> 如下教程指引如何配置并进行 Linux C/C++ 编译加速

## 准备工作

1. 定制一个加速方案 [加速方案管理](../Services/turbo_plan.md)

## Step1 在机器上安装加速工具包

注意：使用 root 执行

```bash
/bin/bash -c "$(curl http://<您的服务域名>/turbo-client/disttask/install.sh)"
```

## Step2 拷贝加速方案 ID

拷贝最开始准备好的加速方案 ID

## Step3 使用加速工具来启动加速

例如原来的编译脚本为：

```bash
make -j gamesvr
```

用 Step1 中安装的工具，结合 Step2 中的方案 ID，来执行加速：

```bash
bk-booster -bt cc -p <步骤2中拷贝的ID> --hook -a "make -j@BK_JOBS gamesvr"
```

其中 bk-booster 是插件提供的加速器，用来启动加速。
命令中的参数含义分别为:

- -bt cc，指定场景为 cc，用于 linux 下的 c/c++编译。
- -p <加速方案 ID>，指定方案 ID。
- --hook，开启命令 hook，会自动劫持 gcc/clang 等编译器，实现加速。
- -a "make -j@BK_JOBS gamesvr"，指定要执行的编译命令，其中@BK_JOBS 作为占位符，在运行- 时会自动替换为推荐的并发数量。
