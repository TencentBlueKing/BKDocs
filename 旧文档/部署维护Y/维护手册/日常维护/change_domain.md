### 变更域名 {#change_domain}

- 修改 globale.env 中的域名配置信息。
- 修改 每台机器上的 `/etc/hosts` 匹配上新的域名
- 修改完成后按如下命令顺序执行：

```bash
./bkcec clean cron # V4.0版本及以前的需要执行，V4.1以后的无需执行

./bkcec sync common
echo fta bkdata job cmdb paas nginx | xargs -n 1 ./bkcec stop
echo fta bkdata job cmdb paas nginx | xargs -n 1 ./bkcec render
echo nginx paas cmdb job bkdata fta | xargs -n 1 ./bkcec start

./bkcec install cron # V4.0版本及以前的需要执行，V4.1以后的无需执行
 ```

如果有安装 SaaS ，到开发者中心-Smart应用-已上线的 SaaS 操作栏里的**部署**按钮，重新一键部署 SaaS
