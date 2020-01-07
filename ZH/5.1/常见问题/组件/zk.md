# ZooKeeper 常见问题
## ZooKeeper 无法启动

**表象**

使用`./bkcec start zk`提示 started，但很快 EXIT 退出

**原因**

1. java 是否安装正常
2. 2181 端口被占用
3. 上述 1、2 均正常，仍无法启动的异常

**解决方法**

- 原因 1 ：检查 java 版本及 java 环境是否正常

```bash
# 使用java或者java -version命令来验证
$ java
$ java -version
```

- 原因 2 ：检查端口是否被占用

```bash
# 检查端口
$ netstat -apn | grep 2181
tcp        0      0 :::2181                     :::*                        LISTEN      1403/java
$ kill -9 1403
$ netstat -apn | grep 2181
$
# 重新启动
```

- 原因 3 ：脏数据导致启动 zk 失败

通过查看 zk 日志如下报错则是 zk 脏数据问题

`/data/bkce/logs/zk/zookeeper.log`

```bash
[root@rbtnode1 /data/install]$ cat /data/bkce/logs/zk/zookeeper.log |grep version-2
2019-11-14 10:01:16,503 [myid:1] - INFO  [PurgeTask:PurgeTxnLog@147] - Removing file: Nov 13, 2019 6:16:55 AM	/data/bkce/public/zk/datalog/version-2/log.1003bbb20
2019-11-14 10:01:16,522 [myid:1] - INFO  [PurgeTask:PurgeTxnLog@147] - Removing file: Nov 13, 2019 6:16:55 AM	/data/bkce/public/zk/data/version-2/snapshot.1003cbc12
2019-11-14 10:01:16,612 [myid:1] - INFO  [main:FileSnap@171] - invalid snapshot /data/bkce/public/zk/data/version-2/snapshot.1003cbc12
java.io.FileNotFoundException: /data/bkce/public/zk/data/version-2/snapshot.1003cbc12 (No such file or directory)
2019-11-14 10:01:16,613 [myid:1] - INFO  [main:FileSnap@83] - Reading snapshot /data/bkce/public/zk/data/version-2/snapshot.10043a527
2019-11-14 10:01:18,416 [myid:1] - INFO  [QuorumPeer[myid=1]/10.0.5.92:2181:ZooKeeperServer@173] - Created server with tickTime 2000 minSessionTimeout 4000 maxSessionTimeout 40000 datadir /data/bkce/public/zk/datalog/version-2 snapdir /data/bkce/public/zk/data/version-
```

```bash
# 进入到zk data目录，找到zoo.conf中配置的dataDir和dataLogDir路径。然后删除两个文件夹下的version -2文件夹
$ cd /data/bkce/public/zk/data

# 把有zookeeper_server.pid以及version-X开头的文件和文件夹删掉
$ rm -rf version-1 zookeeper_server.pid

# 重新启动zk，即可解决
$ ./bkcec start zk
```

上述 3 条确认后，仍无法启动的，可能 zk.sh 版本不对，请和蓝鲸运营人员联系,联系蓝鲸助手 QQ: [800802001](http://wpa.b.qq.com/cgi/wpa.php?ln=1&key=XzgwMDgwMjAwMV80NDMwOTZfODAwODAyMDAxXzJf)
