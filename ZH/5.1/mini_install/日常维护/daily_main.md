# 日常维护

## 蓝鲸社区版 5.1 mini 体验版服务使用

- 安装包内蓝鲸社区版 5.1 mini 体验版的管理工具 bk_container_ctl，在输入错误参数与没有输入参数时打印 HELP 信息
```shell
./bk_container_ctl
```

- 启动蓝鲸社区版 5.1 mini 体验版版容器：
```shell
./bk_container_ctl start
```

- 停止蓝鲸社区版 5.1 mini 体验版版容器：
```shell
./bk_container_ctl stop
```

- 获取蓝鲸社区版 5.1 mini 体验版版容器状态：
```shell
./bk_container_ctl status
```

- 重启蓝鲸社区版 5.1 mini 体验版版容器，**如果社区版功能发生任何异常，先重启社区版容器，看看问题是否可以被解决**
```shel
./bk_container_ctl restart
```

- 进入蓝鲸社区版 5.1 mini 体验版版容器，如果需要了解蓝鲸社区版在容器中部署的具体情况，可以进入蓝鲸社区版容器内，按快捷 `Ctrl + D` 可以退出容器
```shell
./bk_container_ctl into
```
