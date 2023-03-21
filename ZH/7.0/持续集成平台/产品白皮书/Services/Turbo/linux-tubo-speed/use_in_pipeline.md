# 在流水线中进行编译加速

##  准备工作

如果你的流水线所选择的环境是**私有构建机**，那么需要提前在你的机器上以root权限安装 client。

```text
/bin/bash -c "$(curl http://<您的服务域名>/turbo-client/disttask/install.sh)"
```

 如果你的流水线选择的是公共构建机，则**无需这个步骤**。

## Step1 修改编译脚本

假设原编译脚本为：

```text
cd ${WORKSPACE}/master

./autogen.sh
./configure --disable-pump-mode

make clean
make -j all
```

可见，前面部分的命令在做一些准备工作，实际编译指令是：

```text
make -j all
```

我们只需要修改这句，用加速器来执行编译指令，即可获得加速。

```text
bk-booster -bt cc -p $TURBO_PLAN_ID --hook -a "make -j@BK_JOBS all"
```

其中bk-booster是插件提供的加速器，用来启动加速

命令中的参数含义分别为

* -bt cc，指定场景为cc，用于linux下的c/c++编译。
* -p $TURBO\_PLAN\_ID，指定方案ID，在“Turbo编译加速”插件中，会默认注入选中的方案的ID。
* --hook，开启命令hook，会自动劫持gcc/clang等编译器，实现加速。
* -a "make -j@BK\_JOBS all"，指定要执行的编译命令，其中@BK\_JOBS作为占位符，在运行时会自动替换为推荐的并发数量。

## Step2 打开流水线，添加 “**Turbo编译加速**”插件

![](../../../assets/image%20%2867%29.png)

注意：这个步骤之前需添加拉代码插件

## Step3 选择已注册好的加速方案

![](../../../assets/image%20%2860%29.png)

## Step4 配置编译脚本

编译脚本可以使用文件管理，提交到代码库，流水线中仅需填写脚本文件的相对路径即可：

![](../../../assets/image%20%2861%29.png)

也可以将编译脚本配置到插件里：

![](../../../assets/image%20%2856%29.png)



