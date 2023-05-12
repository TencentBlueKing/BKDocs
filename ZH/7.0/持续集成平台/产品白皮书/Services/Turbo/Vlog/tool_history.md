# Linux C++ 工具包版本记录

## Linux C++ 工具包安装说明：

```bash
/bin/bash -c "$(curl http://xxxx/turbo-client/disttask/install.sh)" // 安装版本 v1.19.1-22.06.29
/bin/bash -c "$(curl http://xxxx/turbo-client/disttask/install_latest.sh)" // 安装最新版本
/bin/bash -c "$(curl http://xxxx/turbo-client/disttask/install_${VERSION}.sh)" // 安装指定版本 (ex. install_v1.23.5-23.02.20.sh)
```

## 版本：v1.24.1-23.04.03
**fix:**
- bk-booster --global_slots  导致编译不可用 bug修复

**feat:**
- 优化申请资源失败时的并发数
- 参数 --no_local 逻辑调整





## 版本： v1.23.5-23.02.20

**fix:**
bk-ubt-tool和bk-shader-tool 个别异常错误信息捕获

**feat:**
- pump模式优化（基于原生编译工具，新增支持clang，新增支持mac）

- bk-ubt-tool 控制台打印日志格式调整

- 新增远端worker的异常和恢复检测

- ue工具默认参数调整（默认资源空闲时间调整为1800）

- mac m1机型特殊编译命令支持（ue源码的修改）



## 版本：v1.20.5-22.10.24
**fix:**
- 预创建资源，在恢复数据时，加载的deleting数据，需要只加载本队列的
- 获取k8s资源信息时，没有判断接口调用是否正常，会导致资源使用信息计算错误
- 在客户端申请了多份资源的情况下，统计数据需要和每份资源关联

feat:
- gcc/g++ -gsplit-dwarf 参数支持
- gateway新增获取client版本列表接口
- 优化 bk-dist-worker计算cpu负载的算法
- 在自动申请资源过程中，任务转本地执行，无需等待资源申请完成 



## 版本：v1.19.3-22.09.21
**fix:**
- bazel无法增量编译问题修复
- Server配置文件keep_starting_timeout 字段默认值未生效 

**feat:**
- windows下ue的pump模式支持
- 支持以相对路径查找pch文件

## 版本：v1.19.2-22.08.10"
**fix:**
**feat:**
- 工具链路径查找逻辑优化,issue: Tencent#7339

- 当资源拉起超时，优化task启动逻辑,issue: Tencent#7291