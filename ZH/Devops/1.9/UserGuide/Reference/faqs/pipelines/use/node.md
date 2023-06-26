# 公共构建机

## Q1: 有多个公共构建机时，流水线调度策略是什么？

算法会优先选择上一次构建的机器（亲和性），上一次构建的机器的某一项资源超过以下阈值，就会寻找另一台构建机进行构建任务

```
 内存阈值：80% 磁盘IO：85% 磁盘空间：90%
```

## Q2：是否可以修改调度策略的阈值？

目前只支持调整内存阈值，默认是80%，即当公共构建机的内存使用率达到80%时，如果其他构建机还有空闲资源，任务会被调度到其他构建机，这个阈值是可以修改的，修改方法如下，登录到BKCIdispatch-docker服务的机器上， 执行：

```
 # threshold的值即为阈值百分比，这里以将内存阈值调整为70%为例 curl -H 'Accept:application/json;charset="utf-8"' -H 'Content-Type:application/json;charset="utf-8"' -H "X-DEVOPS-UID: admin" -X POST --data '{"threshold":"70"}' http://127.0.0.1:21938/api/op/dispatchDocker/docker/threshold/update
```

## Q3: 公共构建机挂载如何使用？

![](../../../../assets/image-20220301101202-sxXbU.png)

这个需要维护一个NFS共享存储服务，不太推荐使用了，后续有可能移除

最好的做法是，将依赖工具打包到镜像里，有2个阶段

阶段A 里面的 job 有个 task-A ：是克隆git 代码后构建编译打包jar

阶段B 里面的 job 有个 task-B：是把 task-A 中构建好的 jar scp 到部署发布到服务器 。

验证下来的结果是 这两个阶段的 workspace 是不共通的。目前的做法是我都放到一个 Job里面才行，这样才能共用一个 workspace 里面构建生产的 jar文件。

设计如此，CI的产物如果要部署出去，必须走到制品库，用maven私服的思路没错

## Q4:公共构建机，支持哪些系统？

![](../../../../assets/image-1646103610029.png)

公共构建机依赖docker, 只能运行linux. 目前只能运行基于我们 bkci/ci:alpine (debian系统)制作的构建镜像.

---

## Q5: 公共构建机可以使用自己的镜像吗？

可以，参考[https://docs.bkci.net/store/ci-images](https://docs.bkci.net/store/ci-images)

---

## Q6: 如何删除公共构建机

登录到BKCIdispatch-docker服务的机器上，执行`/data/src/ci/scripts/bkci-op.sh list`获取所有的公共构建机，执行`/data/src/ci/scripts/bkci-op.sh del`操作

---

# 私有构建机

## Q1：私有构建集群的调度策略是什么？

如果有多台私有构建机，可以构成私有构建集群，选择这个集群后，BKCI流水线按照一定的算法选择其中一台进行构建：

**算法如下：**

**最高优先级的agent:**

1. 最近构建任务中使用过这个构建机
2. 当前没有任何构建任务

**次高优先级的agent:**

1. 最近构建任务中使用过这个构建机
2. 当前有构建任务，但是构建任务数量没有达到当前构建机的最大并发数

**第三优先级的agent:**

1. 当前没有任何构建任务

**第四优先级的agent:**

1. 当前有构建任务，但是构建任务数量没有达到当前构建机的最大并发数

**最低优先级：**

1. 都没有满足以上条件的

---

## Q2: BKCI脚本启动gradle daemon进程，每次构建完会关闭，是由devops agent管控的吗？

![](../../../../assets/wecom-temp-d4178631b527e498ee7d8a0778c1fb09.png)

是的。BKCIagent执行完构建任务后，会自动停止所有由agent启动的子进程，如果不需要结束子进程，可以在启动进程前设置环境变量：set DEVOPS\_DONT\_KILL\_PROCESS\_TREE=true，在bash脚本里设置`setEnv "DEVOPS_DONT_KILL_PROCESS_TREE" "true"`

---

## Q3：同一个私有构建机可以被多个项目使用吗？

可以。在私有构建机的不同目录下分别安装agent，并导入到相应项目即可。



## Q4:使用docker build生成镜像是不是只能使用私有构建机才行？

建议使用私有构建机, 公共构建机DinD方案存在安全隐患, 所以需要私有构建机制作镜像.

如果BKCI使用者是受信任的话，可以使用我们交付团队的DinD**方案**

