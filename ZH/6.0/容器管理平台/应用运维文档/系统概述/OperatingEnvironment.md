# 运营环境
## 软件环境

| **软件名称** | **版本** | **备注**           |
|--------------|----------|--------------------|
| Centos       | 7.x      | 操作系统版本       |
| Nginx        | 1.11.9   | 接入层版本         |
| Python       | 3.6.7    | 解释器             |
| Redis        | 4.0.12   | 平台提供的统一版本 |
| Prometheus   | 2.4.3    | 监控中心使用的版本 |
| Grafana      | 4.6      | 监控中心使用的版本 |
| Mysql        | 5.7      | 数据库版本         |

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
        <td>容器服务+监控中心 SaaS</td>
        <td>8C</td>
        <td>24G</td>
        <td>128G</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>1</td>
        <td>两个 SaaS 运行在集成平台的 App 服务器上</td>
    </tr>
    <tr>
        <td>监控中心后台</td>
        <td>8C</td>
        <td>16G</td>
        <td>128G</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>1</td>
        <td>可混合部署</td>
    </tr>
    <tr>
        <td>配置中心</td>
        <td>4C</td>
        <td>8G</td>
        <td>128G</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>1</td>
        <td>可混合部署</td>
    </tr>
    <tr>
        <td>Grafana</td>
        <td>4C</td>
        <td>8G</td>
        <td>128G</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>1</td>
        <td>可混合部署</td>
    </tr>
    <tr>
        <td>WebConsole</td>
        <td>4C</td>
        <td>8G</td>
        <td>128G</td>
        <td>千/万兆</td>
        <td>centos 7/X86_64</td>
        <td>1</td>
        <td>可混合部署</td>
    </tr>
</table>
