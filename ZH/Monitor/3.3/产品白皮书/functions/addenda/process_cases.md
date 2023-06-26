# 各种进程配置方法

进程有很多种启动方式，也有各种的使用场景。在多种进程配置下如何在 CMDB 中配置来满足进程监控的需求。

如下介绍了多种进程配置案例，并且给出配置方法和可行性。

### 情况一：同机同二进制名(相同路径)不同参数启动

如 Java、Python 解释器类的启动方式.

```bash
root     13670  0.9 17.8 48339468 17593272 ?   Sl   1月01 290:11 java -server -Xms24g -Xmx24g -XX:MaxDirectMemorySize=32g -XX:+ExitOnOutOfMemoryError -Duser.timezone=UTC -Dfile.encoding=UTF-8 -Djava.io.tmpdir=var/tmp -Djava.util.logging.manager=org.apache.logging.log4j.jul.LogManager -cp /data/mapleleaf/druid/conf/druid/cluster/query/broker:/data/mapleleaf/druid/conf/druid/cluster/query/_common:/data/mapleleaf/druid/conf/druid/cluster/query/_common/hadoop-xml:/data/mapleleaf/druid/conf/druid/cluster/query/../_common:/data/mapleleaf/druid/conf/druid/cluster/query/../_common/hadoop-xml:/data/mapleleaf/druid/bin/../lib/* org.apache.druid.cli.Main server broker
root     27012  0.2  0.5 14885784 538188 ?     Sl   1月15  24:30 java -server -Xms512m -Xmx512m -XX:+ExitOnOutOfMemoryError -Duser.timezone=UTC -Dfile.encoding=UTF-8 -Djava.io.tmpdir=var/tmp -Djava.util.logging.manager=org.apache.logging.log4j.jul.LogManager -cp /data/mapleleaf/druid/conf/druid/cluster/data/middleManager:/data/mapleleaf/druid/conf/druid/cluster/data/_common:/data/mapleleaf/druid/conf/druid/cluster/data/_common/hadoop-xml:/data/mapleleaf/druid/conf/druid/cluster/data/../_common:/data/mapleleaf/druid/conf/druid/cluster/data/../_common/hadoop-xml:/data/mapleleaf/druid/bin/../lib/* org.apache.druid.cli.Main server middleManager
```

* 配置方法：
    * 进程名称：不带路径的二进制名称，如`java`
    * 进程别名：显示的可识别的，如`druid-broker`
    * 启动参数：能够唯一区分的参数名称，如`/data/mapleleaf/druid/conf/druid/cluster/query/broker`

### 情况二：同二进制名称，不同路径，无参数

这类要么不需要启用端口，要么配置采用和二进制同工作目录等。

```bash
/opt/gosuv
/usr/local/gosuv
```

* 配置方法：暂时不支持，功能待完善。

###  情况三：同机同二进制名，不同路径，参数相同

如 Nginx,MySQL,Redis 等支持相对路径参数的服务。

```bash
/usr/local/bin/redis-server ./redis.conf
/usr/bin/redis-server ./redis.conf
```

* 配置方法：暂时不支持，功能待完善。

### 情况四：同机同二进制名，不同路径，同进程显示，参数相同

如 Nginx,MySQL,Redis 等支持相对路径参数的服务。因为使用了 cd 到目的目录再进行启动，这类是不建议配置的，因为导致管理的复杂度。

```bash
./redis-server ./redis.conf
./redis-server ./redis.conf
```

* 配置方法：暂时不支持，功能待完善。

### 情况五：进程的维度标识无法定义，是由程序动态生成的

其他都是一样的，只有 containers 的部分不一样：

```bash
    /bin/java -Xms30720m -Xmx30720m -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -server -Djava.awt.headless=true -Dfile.encoding=UTF-8 -Djna.nosys=true -Dio.netty.noUnsafe=true -Dio.netty.noKeySetOptimization=true -Dlog4j.shutdownHookEnabled=false -Dlog4j2.disable.jmx=true -Dlog4j.skipJansi=true -XX:+HeapDumpOnOutOfMemoryError -Des.path.home=/data1/containers/1495608881000003411/es -cp /data1/containers/1495608881000003411/es/lib/* org.elasticsearch.bootstrap.Elasticsearch -d
```

想要最终上报的维度名有一个为`/containers/1495608881000003411`。

进程是动态由主程序 fork 出来的，如游戏开房。

这种情况的属于程序动态生成的进程程序不管是监控本身还是人工检测都是保证不了的，只能由主程序来提供性能数据。

* 配置方法：暂时不支持，待完善。

### 情况六：windows 的进程是大小写

* 配置方法：进程名全部改为小写，功能待完善。

### 情况七：软连接的进程

```bash
mysql    26921  0.0  0.1 116352  1876 ?        Ss   00:41   0:00 /bin/sh /usr/bin/mysqld_safe --basedir=/usr
mysql    27120  0.0  8.0 1103564 82072 ?       Sl   00:41   0:24 /usr/libexec/mysqld --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib64/mysql/plugin --log-error=/var/log/mariadb/mariadb.log --pid-file=/var/run/mariadb/mariadb.pid --socket=/var/lib/mysql/mysql.sock
```

mysqld_safe 进程是 sh 其实是软链接 所以当前只能配置 bash。

![-w2021](../../guide/media/15809113169064.jpg)

功能待完善。

### 情况八：只有端口没有进程名

这种情况的不属于进程监控，是属于本地端口的探活。

* 配置方法：通过插件写脚本方式实现。
