# 蓝鲸日常维护

## 机器重启后

- 确认 /etc/resolv.conf 里第一个 nameserver 是 `127.0.0.1`， `option` 选项不能有 `rotate`
- 检查重启机器的 crontab ，是否有自动拉起进程的配置 `crontab -l | grep process_watch` ，重启后的自动拉起主要靠 crontab
- 中控机上确认所有进程状态： `./bkcec status all` , 正常情况下应该都是正常拉起 `RUNNING` 状态，如果有 `EXIT` 的，则尝试手动拉起。手动拉起的具体方法参考 [组件的启动停止](../../维护手册/日常维护/start_stop.md)
- 如果社区版所有机器同时重启，很大概率会有很多进程启动失败，因为不同机器上组件恢复的时间没法控制，导致依赖的组件还没启动起来，导致失败，连锁反应。所以这种情况，遵循和安装时的启动原则:
    1. 先启动 DB

    2. 启动依赖的其他开源组件及服务

    3. 启动蓝鲸产品

- 如果已经部署过 SaaS ，那么手动拉起。
    ```bash
    ./bkcec start saas-o # 正式环境
    ./bkcec start saas-t # 测试环境
    ```
