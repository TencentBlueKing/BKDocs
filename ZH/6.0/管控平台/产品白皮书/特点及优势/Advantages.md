## BK Agent，强大的执行代理

蓝鲸智能Agent程序，可以安装在业务需要管控的实体机、虚拟机或者容器里面，蓝鲸Agent是蓝鲸管控平台提供三大服务能力（命令执行、文件传输、数据上报）的实际执行者，蓝鲸Agent所在机器的通讯策略、网络状况需要在安装前调整好才能发挥其所有能力。

## BK TaskServer，提供海量管控能力

蓝鲸管控平台任务及控制服务端程序，该程序提供对集群内Agent的管理能力，并支持对Agent批量下发执行发命令或脚本，最快任务流转时间小于2s。

## BK FileServer，基于BT协议，传输更高效

管控平台文件传输控制服务端程序，该程序对指定范围内Agent节点提供BT种子服务，保证对传输的安全性、不同区域及业务模块间的隔离性，并控制BT传输在有限的贪婪特性范围内。单独部署BK FileServer并不能提供文件传输服务，受限于安全性考虑，BK FileServer必须和BK TaskServer配合才能完成完整的文件分发流程。

## BK DataServer，海量数据处理不再是瓶颈

蓝鲸管控平台数据传输服务端程序。该服务端主要提供对Agent采集的数据进行汇聚、分类、流转能力。对于普通的千兆网卡机器，BK DataServer能够最大提供100MB/s的数据处理能力。BK DataServer可以单独为用户提供数据服务，而不需要其他服务端程序配合。

## 支持 OS 类型

<table><tbody>
<tr><th>OS 类型 </th><th> 主要 OS 版本 </th></tr>
<tr><td rowspan="5">CentOS</td></tr>
<tr><td>5.8 32/64 位 </td></tr>
<tr><td>5.11 32/64 位 </td></tr>
<tr><td>6.x 32/64 位 </td></tr>
<tr><td>7.x 32/64 位 </td></tr>
<tr><td rowspan="2">Redhat</td><td>6.x 32/64 位 </td></tr>
<tr><td>7.x 32/64 位 </td></tr>
<tr><td>Debian</td><td>7.4  64 位 </td></tr>
<tr><td>SUSE</td><td>10  64 位 </td></tr>
<tr><td rowspan="3">Ubuntu</td><td>14.04  32/64 位 </td></tr>
<tr><td>10.04  32/64 位 </td></tr>
<tr><td>12.04  64 位 </td></tr>
<tr><td rowspan="4">Windows Server</td><td>2012</td></tr>
<tr><td>2008</td></tr>
<tr><td>2003</td></tr>
<tr><td>Win 7</td></tr>
<tr><td rowspan="2">AIX (企业版)</td><td>AIX 6</td></tr>
<tr><td>AIX 7</td></tr>
</tbody></table>
