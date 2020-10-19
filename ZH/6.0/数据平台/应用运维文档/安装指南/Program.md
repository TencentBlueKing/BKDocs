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
        <td>单机数据服务模块（仅测试）</td>
        <td>所有模块</td>
        <td>1</td>
        <td>仅测试试用</td>
    </tr>
    <tr>
        <td rowspan="5">方案二</td>
        <td rowspan="5">高可数据服务模块</td>
        <td>DataAPI</td>
        <td>2</td>
        <td>两台机器上启动API</td>
    </tr>
    <tr>
        <td>ProcessorAPI</td>
        <td>2</td>
        <td>两台机器上启动ProcessorAPI</td>
    </tr>
    <tr>
        <td>DataBus</td>
        <td>2</td>
        <td>两台启动总线服务，此高可用方案利用Kafka coordination机制实现</td>
    </tr>
    <tr>
        <td>Monitor</td>
        <td>2</td>
        <td></td>
    </tr>
    <tr>
        <td>DataFlow</td>
        <td>18</td>
        <td>两台主节点，启动HDFS NameNode服务和Yarn ResourceManager服务，并混布 JournalNode。<br>三台DataNode。<br>三台NodeManager。<br>一台 Azkaban WebServer，混布JournalNode<br>两台Azkaban Executor，同时Excutor上混布Fabio。<br>二台混布BKSQL和DataManager。<br>三台Crate DB。<br>两台 Influx DB。<br></td>
    </tr>
</table>
