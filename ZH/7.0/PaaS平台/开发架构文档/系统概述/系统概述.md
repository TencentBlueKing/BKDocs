# 运营环境
## 软件环境

| 软件名称       | 版本     | 备注                           |
|---------------|----------|--------------------------------|
| Centos        | 6.x/7.x  | 服务器操作系统                  |
| Nginx         | 0.77     | Web Server                     |
| Redis         | 3.x      | 缓存及消息队列                  |
| Mysql         | 5.0      | 数据库(Logserver 使用 mysql5.1) |
| ElasticSearch | 5.x      | 日志存储引擎                    |
| Python        | 2.7      | 解释器                         |

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
        <td>PaaS 服务器</td>
        <td>8C</td>
        <td>8G</td>
        <td>20G</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>1</td>
        <td></td>
    </tr>
    <tr>
        <td>PaaS Agent 服务器</td>
        <td>8C</td>
        <td>24G</td>
        <td>128G</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>2</td>
        <td></td>
    </tr>
</table>

# 系统功能

| 进程名称           | 部署服务器           |    功能                 |
|-------------------|---------------------|------------------------|
| **Login**         | PaaS 服务器          | 统一登录服务             |
| **Console**       | PaaS 服务器          | 桌面                    |
| **ESB**           | PaaS 服务器          | 组件系统                |
| **AppEngine**     | PaaS 服务器          | 应用引擎                |
| **APIGW**         | PaaS 服务器          | API 网关                |
| **PaaS**          | PaaS 服务器          | 开发者中心              |
| **Nginx**         | PaaS 服务器          | 一级反向代理             |
| **PaaSAgent**     | PaaSAgent 服务器     | 集成平台 Agent           |
| **Nginx**         | PaaSAgent 服务器     | 二级反向代理             |
| **Mysql**         | 数据库服务器          | 数据库，公共服务         |
| **ElasticSearch** | ElasticSearch 服务器 | 存储引擎，公共服务        |
| **Redis**         | Redis 服务器         | 缓存及消息队列，公共服务  |
