# ActiveMQ部署（ActiveMQ版才需要）

## 安装activeMQ包

```bash
cd ${BK_HOME}/service
unzip activemq.zip  # 根据实际情况看 run.sh 里面的环境变量是否需要修改
vim run.sh
export ACTIVEMQ_DATA= ${BK_HOME}/logs
export ACTIVEMQ_CONF= ${BK_HOME}/service/activemq/activemq/conf
```

## ActiveMQ数据库初始化

解压后的路径下有一个 `activemq_init.sql` 文件，负责创建数据库并初始化，执行他：

```bash
source ${BK_HOME}/service/activemq/activemq_init.sql
```

## 修改配置

配置文件在 `${BK_HOME}/service/activemq/activemq/conf` 目录下

### activemq.xml

- 删除以下配置（如果有的话, 5.14.0版本）：
```bash
<bean id="logQuery" class="org.fusesource.insight.log.log4j.Log4jLogQuery"
    lazy-init="false" scope="singleton"
    init-method="start" destroy-method="stop">
</bean>
```

- 找到 brokerName 修改为唯一标识，部署多个 MQ 时每个都要保证唯一

- 找到 transportConnectors

    - 增加如下 `<transportConnector name="JOB" uri="tcp://本机内网IP**:61616**"/>`

        - 修改为**内网ip和端口**

          > **注意:** 在搭建另外一套环境时，克隆这些安装好的程序过去后这个地方也要改成另一套环境的内网ip和端口，如果是在一台机器上安装两个MQ，注意其中一个要修改端口。

- **在\<broker\>下面增加如下配置信息**

```bash
<plugins>
<simpleAuthenticationPlugin>
<users>
<authenticationUser username="${activemq.username}"
password="${activemq.password}" groups="users,admins"/>
</users>
</simpleAuthenticationPlugin>
</plugins>
<persistenceAdapter>
<jdbcPersistenceAdapter dataSource="#mysql-ds" transactionIsolation="4"
createTablesOnStartup="false" lockKeepAlivePeriod="5000">
<locker>
<lease-database-locker lockAcquireSleepInterval="10000"/>
</locker>
</jdbcPersistenceAdapter>
</persistenceAdapter>
```

- **为了安全可以关闭 web 控制台，直接删除掉 `<import resource="jetty.xml"/>`** 并在此处增加以下配置，数据库连接账号密码都要修改下面 `value`

```bash
<bean id="mysql-ds" class="org.apache.commons.<font color=#FF0000>dbcp2</font>.BasicDataSource" destroy-method="close">
<property name="driverClassName" value="com.mysql.jdbc.Driver" /\> \<property name="url" value="jdbc:mysql://<font color=#FF0000>主机:端口/activemq</font>?relaxAutoCommit=true"/>
 <property name="username" value="账户请修改"/>
 <property name="password" value="密码请修改"/>
 <property name="maxTotal" value="50"/>
 <property name="initialSize" value="3"/>
 <property name="maxIdle" value="8"/>
 <property name="minIdle" value="5"/>
 <property name="validationQuery" value="SELECT 1 FROM DUAL"/>
 <property name="poolPreparedStatements" value="false"/>
 </bean>
 ```
### MQ安全认证

MQ 消息队列使用鉴权文件：`activemq/conf/credentials.properties`

```bash
activemq.username=ijobs
activemq.password=amq@bk123
```

**注意密码要保证安全，强密码，建议由数字+字母大小写组成。**

### MQ Web安全认证

此为 ActiveMQ 的管理控制台界面认证文件在 `activemq/conf/jetty-realm.properties`

```bash
# Defines users that can access the web (console, demo, etc.)
# username: password [,rolename ...] mqmgr: cosl@rMgr823, admin mquser: usr_82671, user
```

**注意密码要保证安全，强密码，建议由数字+字母大小写组成。**

## 启停ActiveMQ

**启动：`${BK_HOME}/service/activemq/bin/activemq start`**

**停止：`${BK_HOME}/service/activemq/bin/activemq stop`**
