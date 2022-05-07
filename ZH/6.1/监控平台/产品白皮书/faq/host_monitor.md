# 主机监控相关的 FAQ

### CPU 指标如何计算的 

* 蓝鲸监控： (user + system + nice + iowait + irq + softirq + steal + guest + guestnice + stolen total )/
(user + sys + nice + iowait + irq + softirq + steal + guest + guestnice + stolen total +idle)

更多指标计算查看 [主机-操作系统-指标](../functions/addenda/host-metrics.md)。

### 应用内存使用率指标如何计算的


「应用内存使用率」：读取 /proc/meminfo 文件 (MemTotal-MemAvailable)/(MemTotal*100.0)，如果没有 MemAvailable 字段，则 MemAvailable=MemFree+Buffers+Cached

具体的解释查看 kernel 文档 [https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=34e431b0ae398fc54ea69ff85ec700722c9da773](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=34e431b0ae398fc54ea69ff85ec700722c9da773)。

更多指标计算查看 [主机-操作系统-指标](../functions/addenda/host-metrics.md)。
