# 【Linux-C/C++加速】在私有构建机上使用加速

**1. 首先在机器上安装加速工具包，在root下执行脚本**
```bash
/bin/bash -c "$(curl http://xxxx/turbo-client/disttask/install.sh)"
```

**2. 拷贝已经注册的加速方案的方案ID，作为$planID**

![1](../../../../assets/image2021-6-11_16-57-0.png)



**3. 用加速工具来启动加速**

例如原来的编译脚本为
```bash
make -j gamesvr
```

用步骤1中安装的工具，结合步骤2中的方案ID，来执行加速：
```bash
bk-booster -bt cc -p $planID --hook -a "make -j@BK_JOBS gamesvr"
```
其中bk-booster是插件提供的加速器，用来启动加速。

命令中的参数含义分别为

- -bt cc，指定场景为cc，用于linux下的c/c++编译。
- -p $planID，指定方案ID。
- --hook，开启命令hook，会自动劫持gcc/clang等编译器，实现加速。
- -a "make -j@BK_JOBS gamesvr"，指定要执行的编译命令，其中@BK_JOBS作为占位符，在运行时会自动替换为推荐的并发数量。


