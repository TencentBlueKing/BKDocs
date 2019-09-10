### Supervisor托管 {#supervisor}

supervisord 和 supervisorctl 都会使用 Python 虚拟环境(virtualenv) 来单独安装隔离。每个模块对应的虚拟环境名称，可以在机器上输入 `workon` 命令查看。

特别注意的是：Consul 使用全局的 `/opt/py27/bin/supervisord` 和 `/opt/py27/bin/supervisorctl`

Supervisor 托管的分两级维度， `module` 和 `project` ， `project` 可以单独启停。

例如：

```bash
./bkcec stop paas esb
./bkcec start paas esb
```

使用 Supervisor 托管的模块如下：

* bkdata/{monior,databus,dataapi}
* paas_agent
* open_paas
* fta ( FTA 比较特殊，单独封装了/data/bkce/fta/fta/bin/fta.sh 启停脚本)
* cmdb-server （配置平台的后台进程）
* consul （使用全局 Supervisor ）

以 bkdata/dataapi 为例，单独启动 dataapi 的进程：

```bash
# 进入虚拟环境
workon dataapi

# 启动
supervisord -c /data/bkce/etc/supervisor-bkdata-dataapi.conf

#临时停止，但不退出supervisord
supervisorctl -c /data/bkce/etc/supervisor-bkdata-dataapi.conf stop all

# 完全退出，包括supervisord
supervisorctl -c /data/bkce/etc/supervisor-bkdata-dataapi.conf shutdown
```
其他模块依此类推