# 安装方案

<table>
    <tr>
        <th>序号</th>
        <th>用户需求</th>
        <th>部署模块</th>
        <th>机器数量</th>
        <th>推荐部署方案</th>
    </tr>
    <tr>
        <td>方案一</td>
        <td>单机配置平台</td>
        <td>配置平台<br>MongoDB<br>Zookeeper<br>Redis</td>
        <td>1</td>
        <td>所有服务搭建在一台机器上</td>
    </tr>
    <tr>
        <td rowspan="4">方案二</td>
        <td rowspan="4">高可用配置平台</td>
        <td>CMDB 配置平台</td>
        <td>2</td>
        <td>在两台机器上启动 CMDB</td>
    </tr>
    <tr>
        <td>高可用 redis</td>
        <td>3</td>
        <td>Redis 集群服务</td>
    </tr>
    <tr>
        <td>高可用 zookeeper</td>
        <td>3</td>
        <td>Zookeeper 集群</td>
    </tr>
    <tr>
        <td>高可用 MongoDB</td>
        <td>2</td>
        <td>MongoDB 集群</td>
    </tr>
</table>
