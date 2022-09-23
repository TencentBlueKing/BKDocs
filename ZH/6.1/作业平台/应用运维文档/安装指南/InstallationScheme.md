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
        <td>单机作业平台</td>
        <td>JOB 作业平台单例 RabbitMQ,MYSQL</td>
        <td>1</td>
        <td>不搭建 NFS，只用本地硬盘作存储</td>
    </tr>
    <tr>
        <td rowspan="5">方案二</td>
        <td rowspan="5">高可用作业平台</td>
        <td rowspan="5">JOB 作业平台开启镜像双节点 RabbitMQ<br>FS 可靠存储高<br>可用 MySQL</td>
        <td>2</td>
        <td>在两台机器上启动 JOB</td>
    </tr>
    <tr>
        <td rowspan="2">2</td>
        <td>FS存储服务要冗余</td>
    </tr>
    <tr>
        <td>MQ 服务各在两台服务器上启动</td>
    </tr>
    <tr>
        <td rowspan="2">2</td>
        <td>Master/Slave MySQL</td>
    </tr>
    <tr>
        <td>或者用 MySQL 中间件产品解决</td>
    </tr>
</table>
