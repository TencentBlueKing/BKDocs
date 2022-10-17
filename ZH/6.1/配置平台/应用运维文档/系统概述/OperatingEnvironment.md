# 运营环境
## 软件环境

| 软件名称    | 版本   | 备注 |
|------------|--------|---------------|
| Linux      | 2.6+   | 操作系统,指明内核版本不低于 2.6，发行版(Ubuntu or Centos or suse)并不重要。 |
| Zookeeper  | 3.4.11 | 服务发现、配置发现 |
| Redis      | 3.2.11 | 配置平台缓存、session 保存 |
| MongoDB    | 2.8.0  | 配置平台数据库 |
| Redis      | 1.4.4  | 配置平台数据、会话存储 |
| Supervisor | 3.3.1  | 进程托管 |

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
        <td>蓝鲸配置平台服务器</td>
        <td>8C</td>
        <td>16G</td>
        <td>500G</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>2</td>
        <td>部署配置平台 web、api、cli 服务</td>
    </tr>
    <tr>
        <td>Redis</td>
        <td>8C</td>
        <td>64G</td>
        <td>500G</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>3</td>
        <td>三台搭建一个 redis 集群</td>
    </tr>
    <tr>
        <td>MongoDB</td>
        <td>4C</td>
        <td>8G</td>
        <td>1T</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>2</td>
        <td>MongoDB 主、从服务搭建</td>
    </tr>
    <tr>
        <td>Zookeeper</td>
        <td>4C</td>
        <td>8G</td>
        <td>500G</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>3</td>
        <td>Zookeeper 集群</td>
    </tr>
</table>
