# PaaS 启动提示 FATAL Exited too quickly

**表象**：此问题多为正常状态情况下，supervisord.sock 被清理，用 stop paas 提示可以停掉，status paas 时也显示 EXIT，实际的进程还是异常的

```bash
[10.X.X.X] open_paas    appengine                        FATAL     Exited too quickly (process log may have details)
[10.X.X.X] open_paas    esb                              FATAL     Exited too quickly (process log may have details)
[10.X.X.X] open_paas    login                            FATAL     Exited too quickly (process log may have details)
[10.X.X.X] open_paas    paas                             FATAL     Exited too quickly (process log may have details)
[root@rbtnode1 /data/install]# ./bkcec stop paas
[10.X.X.X]20180730-094141 117   stopping open_paas(ALL) on host: 10.X.X.X
Shut down
[root@rbtnode1 /data/install]# ./bkcec status paas
---------------------------------------------------------------------------------------------------------
[10.X.X.X] open_paas: EXIT

[root@paas-1 /root]# ps auxf|grep open_paas
root     28606  0.0  0.6 534188 54916 ?        Sl   Jul27   0:42 /data/bkce/.envs/paas/bin/uwsgi --ini /data/bkce/etc/uwsgi-open_paas-paas.ini
root     28676  0.0  0.4 534188 37572 ?        S    Jul27   0:00  \_ /data/bkce/.envs/paas/bin/uwsgi --ini /data/bkce/etc/uwsgi-open_paas-paas.ini
```

**思路方法**：解决办法，杀掉已经不正常的进程（此情况 rabbitmq 在异常时，也可以杀掉 epmd 及 beam）

```bash
# 可选
[root@paas-1 /root]# /data/bkce/.envs/open_paas/bin/python /data/bkce/.envs/open_paas/bin/supervisorctl -c /data/bkce/etc/supervisor-open_paas.conf shutdown
# 可尝试删掉supervisor.sock文件，再重新创建，但需注意赋权，设置为srwx------
[root@paas-1 /data/bkce/logs/open_paas]# chown o+s supervisor.sock
# 可选
[root@paas-1 /root]# /data/bkce/.envs/open_paas/bin/python /data/bkce/.envs/open_paas/bin/supervisord -c /data/bkce/etc/supervisor-open_paas.conf
[root@paas-1 /root]# for x in `ps auxf|grep open_paas|awk '{print $2}'`;do kill -9 $x;done
-bash: kill: (8230) - 没有那个进程
[root@paas-1 /root]# ps auxf|grep open_paas
root      8269  0.0  0.0 115748   720 pts/0    S+   09:47   0:00          \_ grep --color=auto open_paas
```

再重新启动

```bash
[root@rbtnode1 /data/install]# ./bkcec start paas
[10.X.X.X]20180730-094728 78   starting open_paas(ALL) on host: 10.178.138.39
[root@rbtnode1 /data/install]# ./bkcec status paas
---------------------------------------------------------------------------------------------------------
[10.X.X.X] open_paas    appengine                        RUNNING   pid 9803, uptime 0:00:06
[10.X.X.X] open_paas    esb                              RUNNING   pid 9802, uptime 0:00:06
[10.X.X.X] open_paas    login                            RUNNING   pid 9801, uptime 0:00:06
[10.X.X.X] open_paas    paas                             RUNNING   pid 9800, uptime 0:00:06
```
