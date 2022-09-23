# 运营环境
## 软件环境

| 软件名称|版本|备注|
|--|--|--|
| Linux OS      | 2.6+     | 操作系统，指明内核版本不低于 2.6，发行版(Ubuntu or Centos or suse)并不重要。|
| Kafka         | 0.10.0.1 | Apache 开源消息队列服务，数据总线使用 Kafka 生态设施实现 |
| MySQL         | 5.5      | 后台整体使用 MySQL 作为配置库以及存放用户数据 |
| ElasticSearch | 5.4      | 日志服务使用 ElasticSearch 作为主存储 |

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
        <td>Bklog-api 模块</td>
        <td>8C</td>
        <td>16G</td>
        <td>100G</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>2</td>
        <td></td>
    </tr>
    <tr>
        <td>Kafka 服务</td>
        <td>8C</td>
        <td>16G</td>
        <td>1T</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>2</td>
        <td></td>
    </tr>
    <tr>
        <td>ElasticSearch 服务</td>
        <td>12C</td>
        <td>32G</td>
        <td>4*2TB</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>3</td>
        <td></td>
    </tr>
</table>
