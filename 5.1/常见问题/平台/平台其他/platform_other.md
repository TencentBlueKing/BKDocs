# 平台其他常见问题

## 变更域名

- 修改 globale.env 中的域名配置信息。
- 修改 每台机器上的/etc/hosts 匹配上新的域名
- 修改完成后按如下命令顺序执行：

```bash
# V4.0版本及以前的需要执行，V4.1以后的无需执行
./bkcec clean cron

./bkcec sync common
echo fta bkdata job cmdb paas nginx | xargs -n 1 ./bkcec stop
echo fta bkdata job cmdb paas nginx | xargs -n 1 ./bkcec render
echo nginx paas cmdb job bkdata fta | xargs -n 1 ./bkcec start

# V4.0版本及以前的需要执行，V4.1以后的无需执行
./bkcec install cron
```

如果有安装 SaaS，到`开发者中心-Smart应用-已上线`的 SaaS 操作栏里的**部署**按钮，重新一键部署 SaaS

##  装蓝鲸后主机名被自动修改了可以改回去吗

主机名可以改回去，但是要注意/etc/hosts 里自动添加的 rbtnode1 的映射不能去掉，rabbitmq 组件依赖它解析 NODENAME

## root 邮箱每分钟都收到 mail 告警

内容包含类似 “xxxx is running” 的信息

这是因为 crontab 里配置了进程监控，但是没有重定向 STDOUT 和 STDERR，当前版本可以自己手动添加：

比如将

```bash
* * * * * export INSTALL_PATH=/data/bkce; /data/bkce/bin/process_watch mysql
```

改为

```bash
* * * * * export INSTALL_PATH=/data/bkce; /data/bkce/bin/process_watch mysql &>/dev/null
```

