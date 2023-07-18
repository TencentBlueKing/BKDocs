# 脚本采集下发提示 connection refused

## 判断 rabbitmq 服务是否正常

bkeec status rabbitmq

## 判断 rabbitmq 是否没有添加 bk_monitor 账户信息

1. 登录 rabbitmq 机器，运行`rabbitmqctl list_vhosts | grep monitor`
2. 运行`rabbitmqctl list_users |grep monitor`

若账号均没有，解决方法如下：

1. 中控机上`source utils.fc`，`add_app_token bk_monitor "$(_app_token bk_monitor)" "监控平台- new"`
2. `./bkeec sync common`
3. rabbitmq 机器上：

```bash
source utils.fc
rabbitmqctl add_user "bk_monitor" "$(_app_token bk_monitor)"`
rabbitmqctl set_user_tags bk_monitor  management
rabbitmqctl set_permissions -p bk_monitor bk_monitor ".*" ".*" ".*"
```

4. 重新部署一下监控 SaaS
