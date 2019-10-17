# SAAS 部署常见问题

## SaaS 部署提示超时

可修改 paas_agent 的 paas_agent_config.yaml，将 EXECUTE_TIME_LIMIT 调大，重启 paas_agent 即可

```bash
$ /data/bkce/paas_agent/paas_agent/etc/paas_agent_config.yaml
EXECUTE_TIME_LIMIT: 300
```

## 节点管理部署问题

```bash
------create virtualenv for bk_nodeman------
------create virtualenv success------
------Extract app_code for bk_nodeman------
------Extract app_code success------
------yum install------
error: rpmdb: BDB0113 Thread/process 3864/139771538343936 failed: BDB1507 Thread died in Berkeley DB library
error: db5 error(-30973) from dbenv->failchk: BDB0087 DB_RUNRECOVERY: Fatal error, run database recovery
error: cannot open Packages index using db5 -  (-30973)
error: cannot open Packages database in /var/lib/rpm
CRITICAL:yum.main:

Error: rpmdb open failed
------yum gcc python-devel openssl-devel libffi libffi-devel fail------
```

出现这种问题，原因为 rpm 数据库损坏

可以尝试重启机器，再使用`yum list all`，若能够列出软件包则 OK。还有问题参考下面的解决方法

```bash
$ yum list all
已加载插件：fastestmirror
Loading mirror speeds from cached hostfile
......
```

解决方法（重新构建 rpm 数据库）

```bash
$ cd /var/lib/rpm
$ ls
Basenames __db.001 __db.003 Group Name Packages Requirename Sigmd5
Conflictname __db.002 Dirnames Installtid Obsoletename Providename Sha1header Triggername
rm -rf __db.*
$ rpm --rebuilddb
$ yum clean all
```
