## 蓝鲸日常维护

### 变更 DEFAULT_HTTP_PORT 端口

安装好后的蓝鲸访问端口默认是 80 ，如果安装成功后想修改它，需要按以下步骤：

1. 修改 ports.env 文件里的 `DEFAULT_HTTP_PORT` 值为新的端口

2. 同步配置到其他机器：`./bkcec sync common`

3. 渲染涉及到的进程的模块文件

    ```bashplainplainplainplainplain
    ./bkcec render $module
    ```
    知道如何操作以及为什么需要这样操作：

修改 DEFAULT_HTTP_PORT 后，PAAS_HTTP_PORT CMDB_HTTP_PORT JOB_HTTP_PORT，这些端口都发生了变化。我们需要了解哪些配置文件模板引用了他们。所以，执行命令：

```bash
grep -lrE "(JOB|CMDB|PAAS|DEFAULT)_HTTP_PORT" /data/src/*/support-files/
```

发现，涉及的文件所在模块为：`bkdata,cmdb,fta,gse,job,miniweb,open_paas,paas_agent,nginx`。所以这些文件均需要重新 `render` 配置，然后重启模块生效。

以下模块需要 `render` 操作：

```bash
echo cmdb job gse paas appo bkdata fta | xargs -n 1 ./bkcec render
```

APPO(paas_agent) 的配置需要一个特殊操作：

```bash
./bkcec initdata appo
```

Nginx 和 miniweb 较为特殊，需要以下命令：

```bash
./bkcec install nginx
./bkcec stop nginx
./bkcec start nginx
```

重启其余进程:

```bash
for module in cmdb job gse paas appo bkdata fta; do ./bkcec stop $module ; sleep 2; ./bkcec start $module ;done
```