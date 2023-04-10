# 在私有构建机上使用加速

## Step1  **首先在机器上安装加速工具包（使用root执行）**

```text
/bin/bash -c "$(curl http://<您的服务域名>/turbo-client/disttask/install.sh)"
```

## Step2 拷贝加速方案ID

可以在查看方案页面获得ID：

![](../../../assets/image%20%2862%29.png)

## Step3 使用加速工具来启动加速

例如原来的编译脚本为：

```text
make -j gamesvr
```

用步骤1中安装的工具，结合步骤2中的方案ID，来执行加速：

```text
bk-booster -bt cc -p <步骤2中拷贝的ID> --hook -a "make -j@BK_JOBS gamesvr"
```

其中bk-booster是插件提供的加速器，用来启动加速。

命令中的参数含义分别为

* -bt cc，指定场景为cc，用于linux下的c/c++编译。
* -p &lt;加速方案ID&gt;，指定方案ID。
* --hook，开启命令hook，会自动劫持gcc/clang等编译器，实现加速。
* -a "make -j@BK\_JOBS gamesvr"，指定要执行的编译命令，其中@BK\_JOBS作为占位符，在运行时会自动替换为推荐的并发数量。

