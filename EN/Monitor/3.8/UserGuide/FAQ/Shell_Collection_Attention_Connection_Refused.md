# Script collection and delivery prompt connection refused

## Determine whether the rabbitmq service is normal

bkeec status rabbitmq

## Determine whether rabbitmq has not added bk_monitor account information

1. Log in to the rabbitmq machine and run `rabbitmqctl list_vhosts | grep monitor`
2. Run `rabbitmqctl list_users |grep monitor`

If there are no accounts, the solution is as follows:

1. `source utils.fc` on the central control machine, `add_app_token bk_monitor "$(_app_token bk_monitor)" "Monitoring platform-new"`
2. `./bkeec sync common`
3. On the rabbitmq machine:

```bash
sourceutils.fc
rabbitmqctl add_user "bk_monitor" "$(_app_token bk_monitor)"`
rabbitmqctl set_user_tags bk_monitor management
rabbitmqctl set_permissions -p bk_monitor bk_monitor ".*" ".*" ".*"
```

4. Redeploy the monitoring SaaS