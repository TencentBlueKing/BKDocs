# CMake 和 CLion 配置蓝盾编译加速

安装包 bk-booster 之后

以下为 Make Generator 的实例，使用 ninja 等其他 Generator 的场景可以参考。

在 CMake 配置中开启编译加速：
```bash
option(SVR_BUILD_LOCALLY "默认开启蓝盾编译加速构建, 开启此变量则可以切换为本地构建" OFF)
if (NOT SVR_BUILD_LOCALLY)
    set(CMAKE_MAKE_PROGRAM ${CMAKE_CURRENT_LIST_DIR}/booster_make.sh CACHE INTERNAL "蓝盾编译加速" FORCE)
endif ()
```
引用的脚本如下：
```
#!/bin/bash

pwdName=${PWD##*/}

# 过滤 CMake 处理过程中的测试构建，这些碎片代码的构建频繁拉起远程任务会非常慢
if [ "${pwdName}x" == "CMakeTmpx" ] || [ -z "${pwdName##*-subbuild}" ]; then
  param="$*"
  make ${param}
else
  # 将 -j@BK_JOBS 置于最后，确保即使传入额外的 -j 命令也不会影响效果
  param="make $* -j@BK_JOBS"
  bk-booster -bt cc -p ${job_id} --hook -a "${param}" --batch_mode
fi
```
CLion 中额外无需特殊配置。

如果希望临时切换到本地构建，在 CLion 的 CMake 选项中配置 -DSVR_BUILD_LOCALLY=ON 或在环境变量中指定都可以。