## 安装 BKDATA

BKDATA（蓝鲸数据平台基础服务）包含三个子工程

- dataapi
- databus
- monitor

![Bkdata依赖简图](/assets/bkdata_depends.png)

新增的依赖有 `Kafka` 、 `ES` 、 `Beanstalk` 、 `InfluxDB` 。其中 Kafka 用来做数据流处理； ES(Elasticsearch) 用来存储日志文本数据； Beanstalk 是监控后台依赖的队列服务， InfluxDB 是存储信息的时序数据库。

### 安装依赖

#### 安装 Elasticasearch

```bash
./bkcec install es
./bkcec start es
```

详解：

1. 安装 ES (install_es)
    1. 安装 Java
    2. 同步 ES 目录到 `$INSTALL_PATH/service/` 下
    3. 渲染配置模板
    4. 添加 ES 系统用户来运行 Elasticsearch
    5. 修改内核参数和 `open files` 值
    6. 设置目录权限，让 ES 用户可以读写。
2. 启动 ES

#### 安装 Kafka

```bash
./bkcec install kafka
./bkcec start kafka
```

详解：

1. 安装 Kafka (install_kafka)
    1. 安装 Java
    2. 同步 Kafka 目录到 `$INSTALL_PATH/service/` 下
    3. 渲染配置模板
    4. 修改 `/etc/hosts` 配置上主机名
2. 启动 Kafka

#### 安装 Beanstalk

```bash
./bkcec install beanstalk
./bkcec start beanstalk
```

详解：

1. 安装 Beanstalkd(install_beanstalk) ，使用 Yum 安装
2. 启动 Beanstalk

#### 安装 InfluxDB

```bash
./bkcec install influxdb
./bkcec start influxdb
```

详解：

1. 安装 InfluxDB (install_influxdb)
    1. 从 ``$PKG_SRC_PATH/service/influxdb-*.rpm` 安装
    2. 渲染配置模板, 并做软链接。
    3. 修改目录权限让 InfluxDB 用户可以读写。
2. 启动 InfluxDB

### 安装 BKDATA

```bash
./bkcec install bkdata
./bkcec initdata bkdata
./bkcec start bkdata
```

详解：

1. 安装 BKDATA (install_bkdata)
    1. 安装 `dependents.env` 里定义依赖的 Yum 包
    2. 尝试修复可能引起安装 MySQL-python pip 包的 lib 库问题 (fixlocation_libmysqlclient_r函数)
    3. 同步代码工程目录，同步 cert 目录
    4. 因为 databus 是 Java工程，安装 Java
    5. 安装 Python 虚拟环境（init_virtualenv函数）
    6. 安装 Python 工程的 requirments.txt 定义的 pip 包
    7. 渲染配置模板
2. 初始化 BKDATA (initdata_bkdata)
    1. 初始化 MySQL 数据库表结构
    2. dataapi 工程 migrate trt 初始化
    3. 初始化 Kafka 的 topic 数据
3. 启动 BKDATA
    1. 启动 BKDATA
    2. 如果是第一次启动 BKDATA ，那么运行 init_bkdata_snapshot 函数，因为这个初始化需要 dataapi 启动后才能运行。运行成功后，设置一个标记文件，$INSTALL_PATH/.init_bkdata_snapshot。防止重复执行。

### 安装 FTA

FTA 是蓝鲸故障自愈的后台进程

```bash
./bkcec install fta
./bkcec initdata fta
./bkcec start fta
```

详解：

1. 安装 FTA  (install_fta)
    1. 安装 dependents.env 里定义依赖的 Yum 包
    2. 同步代码工程目录，同步 cert 目录
    3. 安装 Python 虚拟环境（init_virtualenv函数）
    4. 安装 Python 工程的 requirments.txt 定义的 pip 包
    5. 渲染配置模板
2. 初始化 FTA (initdata fta)
    1. 初始化 MySQL 的库表结构
3. 启动 FTA
