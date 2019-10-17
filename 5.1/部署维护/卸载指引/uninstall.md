# 蓝鲸卸载文档

如果您确认需要卸载蓝鲸，请注意先清理被蓝鲸管控的主机上安装的 Agent 和下发的采集器后。再卸载蓝鲸后台服务器上安装的服务，也就是 install.config 里配置 IP 地址上的蓝鲸后台服务。

## 卸载管控机器上的 Agent 和采集器

卸载 Agent 和采集器

- 如果使用 SaaS ：节点管理安装 Agent，则使用节点管理的卸载功能即可。

- 如果是手动安装， 按以下步骤来卸载：

  - 停 gse_agent ，`/usr/local/gse/agent/bin/gsectl stop` 。

  - 停采集器 ，`cd /usr/local/gse/plugins/bin/ && ./stop.sh basereport` 。

  - 默认只启动 basereport 和 processbeat 采集器，如果有配置过其他监控采集项，存在其他采集器进程，参考 basereport 方法停掉。 gse_agent 带的采集器进程均在 /usr/local/gse/plugins/bin/ 下。

  - 删除 GSE 相关目录 ，`rm -rf /usr/local/gse /var/log/gse /var/run/gse /var/lib/gse` 。


## 脚本卸载蓝鲸后台服务

**注意：** 该卸载操作不可逆，也不会备份任何数据，最终会删除 $INSTALL_PATH，$PKG_SRC_PATH，$CTRL_DIR 这三个目录。默认情况下分别是：/data/bce，/data/src，/data/install。请在运行脚本、输入 yes 之前，请三思！

在每台蓝鲸后台服务器上运行：

```bash
cd /data/install/ && cp uninstall/uninstall.sh .
bash uninstall.sh
```

## 手动卸载蓝鲸后台服务

- 手动卸载蓝鲸后台

  以下操作在中控机上执行:

  - 停止自动拉起 `./bkcec clean cron`。

  - 停止所有进程 `./bkcec stop all`。

  - 确保都停成功 `./bkcec status all`。


  以下操作在每台机器上执行：

  - 如果存在该目录，先解除只读权限，`chattr -i /data/install/.migrate/*`。

  - 删除目录： `rm -rf /data/install /data/bkce /data/src`。

  - 卸载蓝鲸自带的 Python ，`rpm -ev python27-2.7.9 python27-devel`。

  - 卸载 rpm 安装的：`yum remove nginx rabbitmq-server beanstalkd`。

  - 删除 Python 相关文件：`rm -f /usr/local/bin/*` 注意完整列表见下方。

  ```bash
   /usr/local/bin/easy_install           /usr/local/bin/pip            /usr/local/bin/supervisord
   /usr/local/bin/easy_install-2.7       /usr/local/bin/pip2           /usr/local/bin/virtualenv
   /usr/local/bin/echo_supervisord_conf  /usr/local/bin/pip2.7         /usr/local/bin/virtualenv-clone
   /usr/local/bin/pbr                    /usr/local/bin/python         /usr/local/bin/virtualenvwrapper_lazy.sh
   /usr/local/bin/pidproxy               /usr/local/bin/supervisorctl  /usr/local/bin/virtualenvwrapper.sh
  ```

- 手动清理环境残留

  以下操作在每台机器上执行：

  - /etc/hosts 里去掉自动添加的行。

  - /etc/resolv.conf 里去掉 nameserver 127.0.0.1。

  - 删除环境变量：`rm -f /root/.bkrc` ，删除后退出当前会话，重新登陆。

  - 删除文件：/etc/rc.d/bkrc.local。
