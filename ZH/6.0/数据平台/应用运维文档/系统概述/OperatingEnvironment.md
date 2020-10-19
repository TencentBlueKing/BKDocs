# 运营环境

## 软件环境

| **软件名称**    | **版本**               | **备注**                                                                       |
|-----------------|------------------------|--------------------------------------------------------------------------------|
| Linux OS        | 2.6+                   | 操作系统,指明**内核版本**不低于2.6，发行版(Ubuntu or Centos or suse)并不重要。 |
| JDK             | 1.8                    | 数据总线Java部分使用1.8环境                                                    |
| Kafka           | 0.10.0.1               | Apache开源消息队列服务，数据总线使用Kafka生态设施实现                          |
| Redis           | 2.8.19                 | 监控模块使用Redis缓存逻辑中间数据                                              |
| MySQL           | 5.5                    | 数据服务模块整体使用MySQL作为配置库以及存放用户数据                            |
| ElasticSearch   | 5.4                    | 日志服务使用ElasticSearch作为主存储                                            |
| Azkaban         | 3.0.0                  | DataFlow离线计算任务调度系统                                                   |
| Spark           | 1.6.1                  | DataFlow使用的内存计算框架                                                     |
| Hadoop          | CDH-5.4.1-Hadoop 2.6.0 | DataFlow使用的资源调度及分布式存储                                             |
| Spark-jobserver | v0.7.0                 | DataFlow离线计算作业提交集群                                                   |
| Storm           | 0.9.5                  | DataFlow实时计算框架                                                           |
| CrateDB         | 2.1.7                  | DataFlow用户存放调试数据                                                       |
| Influxdb        | 1.3.5                  | 数据质量模块用来存放时序信息                                                   |
| Fabio           | 1.3.3                  | 负载均衡中间件，用来均衡Spark-jobserver                                        |

## 硬件环境

<table>
    <tr>
        <th rowspan="2">服务/模块</th>
        <th colspan="7">机型</th>
    </tr>
    <tr>
        <th>CPU</th>
        <th>内存</th>
        <th>存储</th>
        <th>网卡</th>
        <th>操作系统</th>
        <th>数量</th>
        <th>备注</th>
    </tr>
    <tr>
        <td>DataAPI模块</td>
        <td>8C</td>
        <td>16G</td>
        <td>500M</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>2</td>
        <td></td>
    </tr>
    <tr>
        <td>ProcessorAPI模块</td>
        <td>8C</td>
        <td>16G</td>
        <td>500M</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>2</td>
        <td></td>
    </tr>
    <tr>
        <td>Databus模块</td>
        <td>8C</td>
        <td>16G</td>
        <td>100M</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>2</td>
        <td></td>
    </tr>
    <tr>
        <td>Monitor模块</td>
        <td>8C</td>
        <td>16G</td>
        <td>100G</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>2</td>
        <td></td>
    </tr>
    <tr>
        <td>Kafka服务</td>
        <td>8C</td>
        <td>16G</td>
        <td>1T</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>2</td>
        <td></td>
    </tr>
    <tr>
        <td>ElasticSearch服务</td>
        <td>24C</td>
        <td>64G</td>
        <td>1T</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>3</td>
        <td></td>
    </tr>
    <tr>
        <td>Azkaban服务</td>
        <td>4C</td>
        <td>8G</td>
        <td>100M</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>3</td>
        <td>1台WebServer<br>2台Executor</td>
    </tr>
    <tr>
        <td>Yarn服务</td>
        <td>24C</td>
        <td>64G</td>
        <td>100G</td>
        <td>万兆</td>
        <td>centos 7/X86_64</td>
        <td>5</td>
        <td>要求NodeManager节点与Jobserver节点打包部署</td>
    </tr>
    <tr>
        <td>Spark-Jobserver</td>
        <td>24C</td>
        <td>64G</td>
        <td>100G</td>
        <td>万兆</td>
        <td>centos 7/X86_64</td>
        <td>5</td>
        <td>要求NodeManager节点与Jobserver节点打包部署</td>
    </tr>
    <tr>
        <td>HDFS服务</td>
        <td>12C</td>
        <td>32G</td>
        <td>40T</td>
        <td>万兆</td>
        <td>centos 7/X86_64</td>
        <td>5</td>
        <td></td>
    </tr>
    <tr>
        <td>Storm 服务</td>
        <td>24C</td>
        <td>64G</td>
        <td>100G</td>
        <td>万兆</td>
        <td>centos 7/X86_64</td>
        <td>5</td>
        <td></td>
    </tr>
    <tr>
        <td>CrateDB服务</td>
        <td>24C</td>
        <td>64G</td>
        <td>1T</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>3</td>
        <td></td>
    </tr>
    <tr>
        <td>InfluxDB服务</td>
        <td>24C</td>
        <td>64G</td>
        <td>1T</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>2</td>
        <td>SSD</td>
    </tr>
</table>
