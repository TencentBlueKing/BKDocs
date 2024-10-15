# FAQ related to host monitoring

### How CPU indicators are calculated

* BlueKing monitoring: (user + system + nice + iowait + irq + softirq + steal + guest + guestnice + stolen total )/
(user + sys + nice + iowait + irq + softirq + steal + guest + guestnice + stolen total +idle)

For more metric calculations, see [Host-Operating System-Metrics](../functions/addenda/host-metrics.md).

### How is the application memory usage indicator calculated?


"Application memory usage": Read the /proc/meminfo file (MemTotal-MemAvailable)/(MemTotal*100.0). If there is no MemAvailable field, then MemAvailable=MemFree+Buffers+Cached

For specific explanations, see the kernel documentation [https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=34e431b0ae398fc54ea69ff85ec700722c9da773](https://git.kernel.org /pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=34e431b0ae398fc54ea69ff85ec700722c9da773).

For more metric calculations, see [Host-Operating System-Metrics](../functions/addenda/host-metrics.md).