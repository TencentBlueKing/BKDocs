# 软件环境

| 软件名称         | 版本   | 备注                              |
| --------------- | ------ | --------------------------------- |
| Mysql           | 5.0    | 数据库(Logserver 使用 mysql5.1)    |
| Python          | 2.7.9  | Stackless Python                  |
| RabbitMQ Server | 3.1.10 | 启动后台任务(celery 任务)的消息队列 |

# 硬件环境

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
        <td>PaaS 服务器</td>
        <td>24C</td>
        <td>64G</td>
        <td>1T</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>2</td>
        <td></td>
    </tr>
</table>
