# 【Linux-C/C++加速】脚本配置详细指引

在注册了一个加速方案，并准备好了构建环境之后，我们详细介绍各个构建系统、以及脚本样例的配置办法。


## 1. Bazel构建接入

<font color = red>bazel建议 升级到4.0以上，接入使用更方便</font>

bazel构建接入分为几个类别
在这里定义bazel的基本



**1.1 若项目没有自定义toolchain**

若你的项目没有修改或声明任何自定义的toolchain，则bazel会使用默认的toolchain来编译你的项目。

原编译指令为：
```bash
bazel build //target/foo:bar
```
若你的bazel版本是0.24.0（含）以下，则修改指令为：
```bash
bk-booster -bt cc -p $TURBO_PLAN_ID -a "CC=$(pwd)/.tbs/gcc bazel --jobs=@BK_JOBS --local_resources 102400,102400,1 build //target/foo:bar" --launcher
```
若你的bazel版本是0.25.0（含）以上，则修改指令为：
```bash
bk-booster -bt cc -p $TURBO_PLAN_ID -a "CC=$(pwd)/.tbs/gcc bazel build --jobs=@BK_JOBS --local_cpu_resources 1024 --local_ram_resources 102400 //target/foo:bar" --launcher
```

**1.2 若项目有自定义的toolchain**

若你的项目有自己修改toolchain，并自定义了CROSSTOOL，则需将自定义编译脚本中的编译指令，加上/usr/local/bin/bk-dist-executor指令，并在一开始source环境变量，以绕过sandbox。

例如，原CROSSTOOL gcc脚本为：
```bash
gcc "$@"
```

则需改为：
```bash
source ~/bk_env.sh
/usr/local/bin/bk-dist-executor gcc "$@"
```

若你的bazel版本是0.24.0（含）以下，则修改指令为：
```bash
bk-booster -bt cc -p $TURBO_PLAN_ID -a "bazel build --jobs=@BK_JOBS --local_resources 102400,102400,1 //target/foo:bar" --output_env_source_file=~/bk_env.sh
```
若你的bazel版本是0.25.0（含）以上，则修改指令为：
```bash
bk-booster -bt cc -p $TURBO_PLAN_ID -a "bazel build --jobs=@BK_JOBS --local_cpu_resources 1024 --local_ram_resources 102400 //target/foo:bar" --output_env_source_file=~/bk_env.sh
```
注意，这里CROSSTOOL gcc脚本中source的~/bk_env.sh，需要在执行booster的时候导出来。



**1.3 若bazel版本低于4.0且没有太多的host_cpu action**

若含有过多的host_cpu action可能导致本地oom，需要考虑使用1.1中的方案。若不多，则可以忽略并使用较为简单的hook模式。

原命令为：
```bash
bazel build //target/foo:bar
```
若你的bazel版本是0.24.0（含）以下，则修改指令为：
```bash
bk-booster -bt cc -p $TURBO_PLAN_ID -a "bazel build --jobs=@BK_JOBS --local_resources 102400,102400,1 //target/foo:bar" --hook --bazel_plus
```
若你的bazel版本是0.25.0（含）以上，则修改指令为：
```bash
bk-booster -bt cc -p $TURBO_PLAN_ID -a "bazel build --jobs=@BK_JOBS --local_cpu_resources 1024 --local_ram_resources 102400 //target/foo:bar" --hook --bazel_plus
```

**1.4 若bazel版本高于（含）4.0**

bazel在4.0以上支持了host action env的定义，也可以直接使用hook模式。

原命令为：
```bash
bazel build //target/foo:bar
```
修改指令为：
```bash
bk-booster -bt cc -p $TURBO_PLAN_ID -a "bazel build --jobs=@BK_JOBS --local_cpu_resources 1024 --local_ram_resources 102400 //target/foo:bar" --hook --bazel4_plus
```

## 2. 复杂脚本接入
有时候我们的编译脚本并不直接是make all或bazel build，而是更为精细的控制脚本，如bash或python脚本。

此时我们依然可以使用简单的方式接入。但这种方式不适用于1.3和1.4的接入方案。

原命令为：
```bash
sh build.sh target
```
修改命令为：
```bash
bk-booster -bt cc -p $TURBO_PLAN_ID -a "sh build.sh target" --hook
```
即可快速接入加速。但需要注意的时，若原本build.sh脚本没有预留并发控制参数，需要修改脚本来支持，例如从环境变量JOBS中获取并发参数，则可以修改命令为：
```bash
bk-booster -bt cc -p $TURBO_PLAN_ID -a "JOBS=@BK_JOBS sh build.sh target" --hook
```







