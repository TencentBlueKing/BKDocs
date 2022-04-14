# CMDB 如何管理进程

## 情景

应用的存储是 MariaDB，在 CMDB 中注册 MariaDB，以便在监控系统做进程监控。

## 前提条件

在配置平台中[新建业务](../../../配置平台/产品白皮书/快速入门/case1.md) 及业务拓扑。

## 步骤

- 服务模板中新建进程
- 服务模板实例同步
- 监控系统自动实现进程端口监控

### 服务模板中新建进程

在**业务 -> 服务模板 -> 新建或选择模板**中**新建进程**

![-w1300](../assets/20210408102939.png)

- 进程名称：程序的二进制名称：**mysqld**；
- 进程别名：对外显示的服务名：**MariaDB**；

在配置功能名称时，使用命令查询该程序的二进制名称

```bash
$ ps -ef | grep -i mysqld
mysql     7800     1  0 7月08 ?       00:00:00 /bin/sh /usr/bin/mysqld_safe --basedir=/usr
mysql     7980  7800  0 7月08 ?       00:01:55 /usr/libexec/mysqld --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib64/mysql/plugin --log-error=/var/log/mariadb/mariadb.log --pid-file=/var/run/mariadb/mariadb.pid --socket=/var/lib/mysql/mysql.sock
```

> 注：监控系统一般**完全匹配**二进制名称。
> 
> 获取二进制名称的方法：`basename $(readlink -f /proc/7980/exe)`

查询 mysqld 监听的 IP 和端口

```bash
$ netstat -antp | grep mysqld
tcp        0      0 10.0.4.29:3306          0.0.0.0:*               LISTEN      7980/mysqld
```

- IP：MariaDB 为存储层，一般绑定内网 IP，故选择**第一内网 IP**。
- Port：进程监听的端口，`3306`
- Protocol：`TCP`

### 服务模板实例同步

[CMDB 如何管理主机](./CMDB_management_hosts.md#主机分配) 提到依据业务架构来划分业务拓扑，业务拓扑中模块代表服务，而服务将由一个或多个进程监听的端口来对用户或其他模块提供服务。

所以，需要将**进程**绑定至对应的**模块**上，这里将**MariaDB**进程绑定至存储层模块上，点击**服务模板实例 -> 批量同步 -> 确认并同步**。

![-w1273](../assets/20210408104858.png)

![-w1273](../assets/20210408105033.png)

![-w1273](../assets/20210408105110.png)


### 监控系统自动实现进程端口监控

给模块 [分配主机](../../../配置平台/产品白皮书/快速入门/case1.md)

![-w1541](../assets/20210408110332.png)

等候一分钟，在蓝鲸自带的监控系统 [监控平台](../../../监控平台/产品白皮书/intro/README.md) 中可以看到 [进程的运行情况](../../../监控平台/产品白皮书/guide/process_monitor.md)。

![-w1570](../assets/15632804527438.jpg)

点击 MariaDB 图标，可以查看其占用的 CPU、内存使用率以及文件句柄数等进程占用的资源指标。

![-w1249](../assets/15626645050893.jpg)

## 扩展阅读

### 监控系统消费 CMDB 中进程配置背后的逻辑

当给模块分配完主机后，该主机的大部分 CI 属性将被自动推送至`/var/lib/gse/host/hostid`

```json
{
  .....
     "process" : [
      {
         "bind_ip" : "3",
         "bind_modules" : [ 68 ],
         "bk_func_id" : "",
         "bk_func_name" : "mysqld",  // 对应进程名称
         "bk_process_id" : 110,
         "bk_process_name" : "MariaDB",  // 对应进程别名
         "bk_start_param_regex" : "",
         "port" : "3306",
         "protocol" : "1"
      }
   ]
}
```

蓝鲸内置的进程监控采集器`processbeat`会读取该文件，并写入自身的配置文件`/usr/local/gse/plugins/etc/processbeat.conf`，以实现进程和端口的监控。

```yaml
......
processbeat.processes:
- name: mysqld // 二进制名称
  displayname: MariaDB
  protocol: tcp
  ports:
  - 3306
  paramregex: ""
  bindip: 10.0.4.29
```

### 二进制名称均为 java，该如何配置

如 ZooKeeper、Hadoop 的二进制均为**java**，可用进程启动参数区分

进程的功能名称均为`java`，`启动参数匹配规则`中分别输入`zookeeper`、`kafka`即可。

```bash
$ ps -ef | grep -i zookeeper

root      5897     1  0 Nov14 ?        01:49:00 /data/bkce/service/java/bin/java -Dzookeeper.log.dir=/data/bkce/logs/zk/ -Dzookeeper.root.logger=INFO,ROLLINGFILE -Dzookeeper.DigestAuthenticationProvider.superDigest=bkadmin:1bF5dHUwvnyrhMDaPLkHwFS1JOg= -cp /data/bkce/service/zk/bin/../build/classes:/data/bkce/service/zk/bin/../build/lib/*.jar:/data/bkce/service/zk/bin/../lib/slf4j-log4j12-1.6.1.jar:/data/bkce/service/zk/bin/../lib/slf4j-api-1.6.1.jar:/data/bkce/service/zk/bin/../lib/netty-3.10.5.Final.jar:/data/bkce/service/zk/bin/../lib/log4j-1.2.16.jar:/data/bkce/service/zk/bin/../lib/jline-0.9.94.jar:/data/bkce/service/zk/bin/../zookeeper-3.4.10.jar:/data/bkce/service/zk/bin/../src/java/lib/*.jar:/data/bkce/etc:/data/bkce/service/zk/conf:/data/bkce/service/java/lib: -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.local.only=false org.apache.zookeeper.server.quorum.QuorumPeerMain /data/bkce/etc/zoo.cfg
root     10220     1  2 Nov14 ?        13:17:41 /data/bkce/service/java/bin/java -Xmx1G -Xms1G -server -XX:+UseG1GC -XX:MaxGCPauseMillis=20 -XX:InitiatingHeapOccupancyPercent=35 -XX:+DisableExplicitGC -Djava.awt.headless=true -Xloggc:/data/bkce/logs/kafka/kafkaServer-gc.log -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dkafka.logs.dir=/data/bkce/logs/kafka -Dlog4j.configuration=file:./../config/log4j.properties -cp /data/bkce/service/java/lib::/data/bkce/service/kafka/bin/../libs/aopalliance-repackaged-2.5.0-b05.jar:/data/bkce/service/kafka/bin/../libs/argparse4j-0.7.0.jar:/data/bkce/service/kafka/bin/../libs/connect-api-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/connect-file-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/connect-json-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/connect-runtime-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/connect-transforms-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/guava-18.0.jar:/data/bkce/service/kafka/bin/../libs/hk2-api-2.5.0-b05.jar:/data/bkce/service/kafka/bin/../libs/hk2-locator-2.5.0-b05.jar:/data/bkce/service/kafka/bin/../libs/hk2-utils-2.5.0-b05.jar:/data/bkce/service/kafka/bin/../libs/jackson-annotations-2.8.0.jar:/data/bkce/service/kafka/bin/../libs/jackson-annotations-2.8.5.jar:/data/bkce/service/kafka/bin/../libs/jackson-core-2.8.5.jar:/data/bkce/service/kafka/bin/../libs/jackson-databind-2.8.5.jar:/data/bkce/service/kafka/bin/../libs/jackson-jaxrs-base-2.8.5.jar:/data/bkce/service/kafka/bin/../libs/jackson-jaxrs-json-provider-2.8.5.jar:/data/bkce/service/kafka/bin/../libs/jackson-module-jaxb-annotations-2.8.5.jar:/data/bkce/service/kafka/bin/../libs/javassist-3.20.0-GA.jar:/data/bkce/service/kafka/bin/../libs/javax.annotation-api-1.2.jar:/data/bkce/service/kafka/bin/../libs/javax.inject-1.jar:/data/bkce/service/kafka/bin/../libs/javax.inject-2.5.0-b05.jar:/data/bkce/service/kafka/bin/../libs/javax.servlet-api-3.1.0.jar:/data/bkce/service/kafka/bin/../libs/javax.ws.rs-api-2.0.1.jar:/data/bkce/service/kafka/bin/../libs/jersey-client-2.24.jar:/data/bkce/service/kafka/bin/../libs/jersey-common-2.24.jar:/data/bkce/service/kafka/bin/../libs/jersey-container-servlet-2.24.jar:/data/bkce/service/kafka/bin/../libs/jersey-container-servlet-core-2.24.jar:/data/bkce/service/kafka/bin/../libs/jersey-guava-2.24.jar:/data/bkce/service/kafka/bin/../libs/jersey-media-jaxb-2.24.jar:/data/bkce/service/kafka/bin/../libs/jersey-server-2.24.jar:/data/bkce/service/kafka/bin/../libs/jetty-continuation-9.2.15.v20160210.jar:/data/bkce/service/kafka/bin/../libs/jetty-http-9.2.15.v20160210.jar:/data/bkce/service/kafka/bin/../libs/jetty-io-9.2.15.v20160210.jar:/data/bkce/service/kafka/bin/../libs/jetty-security-9.2.15.v20160210.jar:/data/bkce/service/kafka/bin/../libs/jetty-server-9.2.15.v20160210.jar:/data/bkce/service/kafka/bin/../libs/jetty-servlet-9.2.15.v20160210.jar:/data/bkce/service/kafka/bin/../libs/jetty-servlets-9.2.15.v20160210.jar:/data/bkce/service/kafka/bin/../libs/jetty-util-9.2.15.v20160210.jar:/data/bkce/service/kafka/bin/../libs/jopt-simple-5.0.3.jar:/data/bkce/service/kafka/bin/../libs/kafka_2.12-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/kafka_2.12-0.10.2.0-sources.jar:/data/bkce/service/kafka/bin/../libs/kafka_2.12-0.10.2.0-test-sources.jar:/data/bkce/service/kafka/bin/../libs/kafka-clients-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/kafka-log4j-appender-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/kafka-streams-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/kafka-streams-examples-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/kafka-tools-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/log4j-1.2.17.jar:/data/bkce/service/kafka/bin/../libs/lz4-1.3.0.jar:/data/bkce/service/kafka/bin/../libs/metrics-core-2.2.0.jar:/data/bkce/service/kafka/bin/../libs/osgi-resource-locator-1.0.1.jar:/data/bkce/service/kafka/bin/../libs/reflections-0.9.10.jar:/data/bkce/service/kafka/bin/../libs/rocksdbjni-5.0.1.jar:/data/bkce/service/kafka/bin/../libs/scala-library-2.12.1.jar:/data/bkce/service/kafka/bin/../libs/scala-parser-combinators_2.12-1.0.4.jar:/data/bkce/service/kafka/bin/../libs/slf4j-api-1.7.21.jar:/data/bkce/service/kafka/bin/../libs/slf4j-log4j12-1.7.21.jar:/data/bkce/service/kafka/bin/../libs/snappy-java-1.1.2.6.jar:/data/bkce/service/kafka/bin/../libs/validation-api-1.1.0.Final.jar:/data/bkce/service/kafka/bin/../libs/zkclient-0.10.jar:/data/bkce/service/kafka/bin/../libs/zookeeper-3.4.9.jar kafka.Kafka ../config/server.properties


ps -ef | grep -i kafka
root     10220     1  2 Nov14 ?        13:17:44 /data/bkce/service/java/bin/java -Xmx1G -Xms1G -server -XX:+UseG1GC -XX:MaxGCPauseMillis=20 -XX:InitiatingHeapOccupancyPercent=35 -XX:+DisableExplicitGC -Djava.awt.headless=true -Xloggc:/data/bkce/logs/kafka/kafkaServer-gc.log -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dkafka.logs.dir=/data/bkce/logs/kafka -Dlog4j.configuration=file:./../config/log4j.properties -cp /data/bkce/service/java/lib::/data/bkce/service/kafka/bin/../libs/aopalliance-repackaged-2.5.0-b05.jar:/data/bkce/service/kafka/bin/../libs/argparse4j-0.7.0.jar:/data/bkce/service/kafka/bin/../libs/connect-api-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/connect-file-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/connect-json-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/connect-runtime-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/connect-transforms-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/guava-18.0.jar:/data/bkce/service/kafka/bin/../libs/hk2-api-2.5.0-b05.jar:/data/bkce/service/kafka/bin/../libs/hk2-locator-2.5.0-b05.jar:/data/bkce/service/kafka/bin/../libs/hk2-utils-2.5.0-b05.jar:/data/bkce/service/kafka/bin/../libs/jackson-annotations-2.8.0.jar:/data/bkce/service/kafka/bin/../libs/jackson-annotations-2.8.5.jar:/data/bkce/service/kafka/bin/../libs/jackson-core-2.8.5.jar:/data/bkce/service/kafka/bin/../libs/jackson-databind-2.8.5.jar:/data/bkce/service/kafka/bin/../libs/jackson-jaxrs-base-2.8.5.jar:/data/bkce/service/kafka/bin/../libs/jackson-jaxrs-json-provider-2.8.5.jar:/data/bkce/service/kafka/bin/../libs/jackson-module-jaxb-annotations-2.8.5.jar:/data/bkce/service/kafka/bin/../libs/javassist-3.20.0-GA.jar:/data/bkce/service/kafka/bin/../libs/javax.annotation-api-1.2.jar:/data/bkce/service/kafka/bin/../libs/javax.inject-1.jar:/data/bkce/service/kafka/bin/../libs/javax.inject-2.5.0-b05.jar:/data/bkce/service/kafka/bin/../libs/javax.servlet-api-3.1.0.jar:/data/bkce/service/kafka/bin/../libs/javax.ws.rs-api-2.0.1.jar:/data/bkce/service/kafka/bin/../libs/jersey-client-2.24.jar:/data/bkce/service/kafka/bin/../libs/jersey-common-2.24.jar:/data/bkce/service/kafka/bin/../libs/jersey-container-servlet-2.24.jar:/data/bkce/service/kafka/bin/../libs/jersey-container-servlet-core-2.24.jar:/data/bkce/service/kafka/bin/../libs/jersey-guava-2.24.jar:/data/bkce/service/kafka/bin/../libs/jersey-media-jaxb-2.24.jar:/data/bkce/service/kafka/bin/../libs/jersey-server-2.24.jar:/data/bkce/service/kafka/bin/../libs/jetty-continuation-9.2.15.v20160210.jar:/data/bkce/service/kafka/bin/../libs/jetty-http-9.2.15.v20160210.jar:/data/bkce/service/kafka/bin/../libs/jetty-io-9.2.15.v20160210.jar:/data/bkce/service/kafka/bin/../libs/jetty-security-9.2.15.v20160210.jar:/data/bkce/service/kafka/bin/../libs/jetty-server-9.2.15.v20160210.jar:/data/bkce/service/kafka/bin/../libs/jetty-servlet-9.2.15.v20160210.jar:/data/bkce/service/kafka/bin/../libs/jetty-servlets-9.2.15.v20160210.jar:/data/bkce/service/kafka/bin/../libs/jetty-util-9.2.15.v20160210.jar:/data/bkce/service/kafka/bin/../libs/jopt-simple-5.0.3.jar:/data/bkce/service/kafka/bin/../libs/kafka_2.12-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/kafka_2.12-0.10.2.0-sources.jar:/data/bkce/service/kafka/bin/../libs/kafka_2.12-0.10.2.0-test-sources.jar:/data/bkce/service/kafka/bin/../libs/kafka-clients-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/kafka-log4j-appender-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/kafka-streams-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/kafka-streams-examples-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/kafka-tools-0.10.2.0.jar:/data/bkce/service/kafka/bin/../libs/log4j-1.2.17.jar:/data/bkce/service/kafka/bin/../libs/lz4-1.3.0.jar:/data/bkce/service/kafka/bin/../libs/metrics-core-2.2.0.jar:/data/bkce/service/kafka/bin/../libs/osgi-resource-locator-1.0.1.jar:/data/bkce/service/kafka/bin/../libs/reflections-0.9.10.jar:/data/bkce/service/kafka/bin/../libs/rocksdbjni-5.0.1.jar:/data/bkce/service/kafka/bin/../libs/scala-library-2.12.1.jar:/data/bkce/service/kafka/bin/../libs/scala-parser-combinators_2.12-1.0.4.jar:/data/bkce/service/kafka/bin/../libs/slf4j-api-1.7.21.jar:/data/bkce/service/kafka/bin/../libs/slf4j-log4j12-1.7.21.jar:/data/bkce/service/kafka/bin/../libs/snappy-java-1.1.2.6.jar:/data/bkce/service/kafka/bin/../libs/validation-api-1.1.0.Final.jar:/data/bkce/service/kafka/bin/../libs/zkclient-0.10.jar:/data/bkce/service/kafka/bin/../libs/zookeeper-3.4.9.jar kafka.Kafka ../config/server.properties
```


