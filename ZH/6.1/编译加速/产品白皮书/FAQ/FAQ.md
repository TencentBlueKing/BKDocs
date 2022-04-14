# 常见问题

## FAQ

### 产品使用

#### 加速的资源数量如何调整

加速资源的数量由系统管理员在 op 中配置，每个加速方案配置的资源数量都是相同的，加速时独占且互不干扰。

#### 加速方案中的编译环境如何选择

方案中的**编译环境**指定了分布式资源的环境配置，应当根据自己的构建机实际情况，选择与之相同的编译环境作为加速配置。

若选项中没有想要的环境配置，请联系系统管理员适配。

### 问题排查

#### 1. 加速效果不明显，或编译时机器卡死、编译器触发 OOM

接入加速并成功编译后，应打开**dashboard**页面来查看详细的数据。

若**远程编译任务**一栏数量为 0，则说明没有成功分发编译任务，此时检查构建的编译器配置，如`CC`，`CXX`等，指定的编译器名字必须在`/etc/bk_dist/bk_cc_rules.json`中。

若编译器名字不在其中，如当前编译器名称为`gcc73`，则需要手动用软链接兼容编译器名称。如

```bash
ln -s /usr/bin/gcc73 /usr/local/bin/gcc
ln -s /usr/bin/gcc++73 /usr/local/bin/g++
```

然后再尝试编译加速。



#### 2. 使用加速后 gcc/clang 错误信息颜色丢失

gcc/clang 提供一个参数来强制输出颜色格式：

gcc 参数

```plain
-fdiagnostics-color=always
```

clang 参数

```plain
-fcolor-diagnostics
```

只要在 ccflags 里加上这个参数，那么启用加速也能够获得颜色了。



#### 3. 信息：init booster failed: unknown handler

若执行`bk-booster`报`unknown handler`，是`-bt`参数指定错误或未指定。

在 LinuxC/C++加速场景下，指定`-bt cc`

在 UE4 加速场景下，指定`-bt ue4`



#### 4. 信息：apply resource failed | project no found

若执行`bk-booster`报`project no found`，是`-p`参数指定错误或未指定。

需要确认所指定的方案 ID 是否存在，或在页面上新建一个方案。

可以通过`curl $gateway/api/v1/disttask/resource/project/`查询数据库中的方案。

不同的场景，`-p`所指定的方案 ID 是不同的，也有可能是`-bt`指定的场景不对，导致在该场景下找不到该方案 ID。



#### 5. 信息：apply resource failed | worker no found

若执行`bk-booster`报`worker no found`，是方案中配置的编译环境不存在。

需要确认所指定的编译环境是否存在。

可以通过`curl $gateway/api/v1/disttask/resource/worker/`查询数据库中的编译环境。



#### 6. 信息：busy compiling now, no enough resource left, degrade to local compiling

若执行`bk-booster`报`busy compiling`，则是所指定的资源无法在规定时间内得到满足。

需要确认方案所属的`queue_name`在 server 的配置中是否有对应的`queue_list`配置来消费。

然后确认所属的`queue_name`下的资源是否能够满足`least_cpu`指定的数量。


#### 7. 快速确认是否已经成功申请资源

在执行`bk-booster`后，若没有输出 taskID，则说明没有申请到资源，可以关注具体的输出信息。

若有输出 taskID，分为几种情况：

* 若状态一直处于 starting，且最终超时转本地编译（degraded to local），则说明创建资源容器失败，需要关注 bcs 的错误信息。
* 若状态一直处于 staging，且最终超时转本地编译，则说明等待资源超时，当前没有充足的资源
    1. 可以观察 server 的日志（关键字"City:"），来查看对应的资源分组是否有足够的 available-instance 和 CPU-Left
    2. 若 available-instance 不足，则查看 server 的配置文件中，crm_bcs_cpu_per_instance 和 crm_bcs_mem_per_instance 参数，是否指定过大
    3. 若 CPU-Left 不足，查看 bcs 的 node 节点，是否打上了对应的 label
* 若资源数量不符合预期，可以在客户机的~/.bk_dist/logs/bk-dist-controller.INFO 中，可以通过关键字"success to apply resources and get host"来查看申请到的资源数量和 IP

#### 8. 快速确认是否成功加速

在确认"成功申请资源"后，对于`bk-booster`执行后打印的 taskID

在编译结束之后，访问 dashboard 并输入 taskID 查询

* 若"远程成功任务"一栏有数值，说明成功进行了编译加速
* 若"远程成功任务"一栏为空，且"本地成功任务"有数值，说明任务都集中在了本地执行，则
    1. 可能没有可用的资源，查看"远程 CPU"一栏是否有数值，若为 0，则需要排查资源是否申请成功。
    2. 可能为本地临时文件写入权限有问题，考虑对临时目录`/tmp/.bk_dist`做权限放行。
* 若"远程编译失败"一栏数值很大，说明大部分任务在加速机上执行失败，打开浏览器的 F12，选择`console`，输入`fast_re()`并执行，可以得到执行失败的日志。
