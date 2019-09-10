## 脚本采集下发提示connection refused

## 判断rabbitmq服务是否正常
bkeec status rabbitmq

## 判断rabbitmq是否没有添加bk_monitor账户信息

1. 登陆rabbitmq机器，运行`rabbitmqctl list_vhosts | grep monitor`
2. 运行`rabbitmqctl list_users |grep monitor`

若账号均没有，解决方法如下：

1. 中控机上`source utils.fc`，
`add_app_token bk_monitor "$(_app_token bk_monitor)" "蓝鲸监控- new"`
2. `./bkeec sync common`
3. rabbitmq机器上：
```
source utils.fc
rabbitmqctl add_user "bk_monitor" "$(_app_token bk_monitor)"`
rabbitmqctl set_user_tags bk_monitor  management
rabbitmqctl set_permissions -p bk_monitor bk_monitor ".*" ".*" ".*"
```
4. 重新部署一下监控SaaS

