# NFS 方案

## 方案选择

NFS 负责存储作业平台上用户上传的作业文件（不可丢失）以及作业执行日志（可定期清理），所以解决方案偏向于由**企业用户**提供专业可靠的存储来保证数据不丢失，以及高可用。

### 方案一：共用存储

企业提供两台存储服务器**共用一个存储**，存储硬盘采用**RAID**保证冗余。
多台作业平台服务器上挂载这两台存储服务器 mount 出来的 NFS，可以保证一台挂载的 NFS 物理机挂掉或 NFS 服务异常之后，作业平台可以自动的快速切换到另一台 NFS 挂载点，因为数据都是共用一个存储，**所以数据冗余机制由外部存储保证，减少作业平台重复写文件和日志的重复消耗。**

优点：

数据存储在同一块存储，不存在数据不一致的情况。实际上两台存储服务器**都是主存储了**。建议用这种方案。

### 方案二：rsync 同步

企业提供两台存储服务器，但各自有独立的存储，存储硬盘采用 RAID 保证冗余。多台作业平台服务器上挂载这两台存储服务器 mount 出来的 NFS，两台存储间的数据通过 rsync 做互相同步。

缺点：

**延迟可能数据存在丢失情况**，这种方案对于如果主存储服务器挂掉后（可能性 2 分），因为**rsyns 同步的延迟关系**，会导致文件没同步到备份存储服务器（影响度 3 分）。

## 实施

### NFS 源初始化

*只需要在两台存储服务器上，设置 NFS 源，设置完全一样。*

在**两台存储机器**上创建 NFS 源目录 `/data/bkee/job/data`

并且修改目录权限，否则业务机器对文件只能读不能写

`/data/bkee/job/data/localupload` **是用户作业上传的文件的存储目录**

`/data/bkee/job/data/logs`        **是用户作业执行日志文件的存储目录**

```bash
mkdir -p /data/bkee/job/data/localupload
mkdir -p /data/bkee/job/data/logs

chmod 777 /data/bkee/job/data/
chmod 777 /data/bkee/job/data/localupload/
chmod 777 /data/bkee/job/data/logs/
```

给要挂载 NFS 的所有作业平台服务器添加 IP 权限,实际情况请看企业提供的 NFS 或 SAN 来决定

`vi /etc/exports`
内容：`/data/enterprise/job` **job 服务器 IP1**(rw) **job 服务器 IP2**(rw)

**启动服务：**
```bash
    service rpcbind start
    service nfs start
```
如未安装，请`yum install rpcbind –y && yum install nfs-utils`
在另外一台存储服务器也采取相同的操作。

如果采用方案一，则 rsync 就可以不用设置

###  方案二: rsync 文件同步

此步骤用于企业没有专业存储**（共享存储）**，需要我们通过 rsync 去同步两台存储服务器中的数据。

在两台**存储服务器**上设置 rsync，使得文件相互同步，2 台机器的略有不同。见 path
```bash
vi /etc/rsyncd.conf

 gid = users
 # read only = true
 use chroot = true
 transfer logging = true
 log format = %h %o %f %l %b
 log file = /var/log/rsyncd.log
 hosts allow = 10.0.0.1
 slp refresh = 300

 [JOB_DATA_SYNC]
     path = /data/enterprise/job/data
     comment = JOB DATA NEED TO SYNC

 加载rsync服务
     rsync --daemon --config=/etc/rsyncd.conf
 添加定时任务
     crontab -e
 内容如下：

 # Backup JOB file
 */2 * * * * /usr/bin/rsync -avz –progress --bwlimit=2000 root\@10.0.0.1::**JOB_DATA_SYNC**
 /data/enterprise/job/data

 这样便实现了两台服务器的目录 /data/enterprise/job/data，每2分钟交错文件自动备份。

 添加自启动项
    echo "rsync --daemon --config=/etc/rsyncd.conf" \>\> /etc/rc.d/rc.local
```
