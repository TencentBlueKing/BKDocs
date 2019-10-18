# 蓝鲸日常维护

## 变更域名

- 修改 globale.env 中的域名配置信息。

- 修改 每台机器上的 `/etc/hosts` 匹配上新的域名。

- 修改完成后按如下命令顺序执行：

```bash
./bkcec sync common
echo fta bkdata job cmdb paas nginx | xargs -n 1 ./bkcec stop
echo fta bkdata job cmdb paas nginx | xargs -n 1 ./bkcec render
echo nginx paas cmdb job bkdata fta | xargs -n 1 ./bkcec start

```

如果有安装 SaaS ，到 **开发者中心-Smart 应用-已上线** 的 SaaS 操作栏里的【部署 】按钮，重新【一键部署】 SaaS。
