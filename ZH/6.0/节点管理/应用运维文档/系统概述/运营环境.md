## 软件环境
| **软件名称**     | **版本**  | **备注**                                                                   |
|-----------------|----------|---------------------------------------------------------------------------|
| Linux OS        | 2.6+     | 操作系统,指明内核版本不低于 2.6，发行版(Ubuntu or Centos or suse)并不重要。|
| Python          | 3.6.10   | Python3                  |
| RabbitMQ Server | 3.7.0    | 启动后台任务(celery 任务)的消息队列 |
| Redis           | 4.0.12   | 启动后台任务(celery beat)的消息队列，保证分布式部署的情况下不会重复执行 |
| MySQL           | 5.7      | 后台整体使用 MySQL 作为配置库以及存放用户数据 |
| Supervisor      | 3.3.3    | 进程托管 | 
| OpenResty       | 1.15.8.3 | 提供 Nginx 服务 |


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
        <td>节点管理后台</td>
        <td>8C</td>
        <td>16G</td>
        <td>100G</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>2</td>
        <td></td>
    </tr>
</table>
