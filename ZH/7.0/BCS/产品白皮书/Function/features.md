# 产品特性

BCS 的核心功能包含集群管理、资源模板管理、应用管理、镜像管理以及网络管理。

<table border="1" width="100%">  
<tr bgcolor="#D3D3D3">  
<td width="10%">产品功能</td>  
<td width="40%">概述</td>  
<td width="50%">功能简介</td>  
</tr>  
<tr>  
<td>集群管理</td>  
<td>通过蓝鲸容器服务可以简单高效地管理容器集群</td>  
<td><b>K8S原生集群创建</b><ul>  
<li>支持自定义设置Master和Node节点，一键自动安装集群组件</li>  
<li>用户独占集群，保证安全隔离性</li>
</ul>
<b>集群导入</b>
<ul>
<li>支持通过集群kubeconfig文件导入外部集群，使用BCS管理已存在K8S集群</li>  
<li>支持通过云凭证导入云上K8S集群，目前支持腾讯云TKE集群导入，支持Worker节点自动扩缩容</li>  
</ul>
<b>集群管理</b>
<ul>
<li>支持节点添加、删除，集群删除</li>
<li>支持节点标签、污点与资源调度等节点管理功能</li>
<li>支持集群和节点级别的监控告警及主要数据的视图展示</li>  
</ul>
</td>
</tr>  
<tr>  
<td>模板管理</td>  
<td>模板管理为用户提供了在集群中部署资源的管理方案。支持用户设置容器编排的Helm Chart。用户可以将同一套Helm Chart，实例化到不同的命名空间，通过不同的values，完成差异化的资源编排</td>
<td>
<b>管理容器资源模板</b>
<ul>  
<li>支持模板集或Helm Chart的多版本管理</li>  
<li>支持通过命名空间管理不同的环境</li>  
</ul></td>  
</tr>
<tr>  
<td>应用管理</td>  
<td>应用管理为用户提供了对模板集实例化后得到的容器集合的管理方案，通过应用管理，可以看到容器各个编排维度的信息和状态。并且可以针对单个维度进行操作，重启容器，重新调度容器等等</td>  
<td>
<b>容器视图</b>
<ul>  
<li>通过应用视图或者命名空间视图管理容器</li>  
<li>查看应用、POD、容器等的在线状态</li>  
</ul>
<b>容器操作</b><ul>
<li>启停容器，重新调度容器
<li>对应用做更新，例如扩缩容、滚动升级等
</ul></td>  
</tr>
<tr>
<td>镜像管理</td>
<td>镜像仓库包含公共镜像库、项目私有镜像库。项目私有镜像库只有项目中有指定权限的人才能访问</td>
<td><ul>
<li>公共镜像，包含了一些实用程度比较高，且开源共有的镜像资源。公共镜像对所有用户可见<li>项目镜像，是项目成员主动添加的镜像，或者是通过CI流程归档的私有镜像。项目镜像只有项目中指定的权限所有者才能访问。
</ul></td>
</tr>
<tr>
<td>网络管理</td>
<td>网络管理提供了用户管理服务和负载均衡器的方案。用户通过网络管理可以查看线上服务的状态和负载均衡器的状态</td>
<td>
<b>服务管理</b>
<ul>
<li>查看服务的列表，以及每个服务的详细信息
<li>对服务进行操作，例如更新服务或者停止服务
</ul>
<b>负载均衡器管理</b><ul>
<li>查看线上负载均衡器列表，及每个负载均衡器的详细信息
<li>启动、删除或者更新负载均衡器
<li>使用bcs ingress controller可实现多云负载均衡器管理与功能增强</li>
</ul>
</td>
<tr>
<td>GameWorkload</td>
<td>GameDeployment 是针对游戏场景定制的面向无状态服务的增强版 Deployment，GameStatefulSet 是针对游戏场景定制的面向有状态服务的增强版 StatefulSet</td>
<td>
<b>GameDeployment</b>
<ul>
<li>支持Operator高可用部署
<li>支持滚动更新 / 原地更新
<li>优雅删除和更新
<li>支持设置 partition 灰度发布
<li>支持分步骤自动化灰度发布
<li>支持 HPA
<li>指定 pod 删除
<li>支持 pod 注入唯一序号
<li>支持防误删功能
<li>支持 readinessgate 可选功能
</ul>
<b>GameStatefulSet</b><ul>
<li>支持 Operator 高可用部署
<li>支持 Node 失联时，Pod 的自动漂移
<li>支持优雅删除和更新
<li>支持滚动更新/原地更新
<li>支持分步骤自动化灰度发布
<li>支持并行更新
<li>支持 maxSurge / maxUnavailable 字段
<li>支持 HPA
<li>支持防误删功能
</ul>
</td>
</tr>
<tr>
<td>容器监控与日志</td>
<td>BCS打通蓝鲸容器监控与容器日志平台，为BCS集群提供监控告警与日志采集查询能力</td>
<td>
<b>蓝鲸容器监控</b>
<ul>
<li>分布式采集k8s集群的监控数据
<li>支持控制平面，servicemonitor，podmonitor指标数据采集
<li>完整兼容Prometheus协议的采集方式
<li>支持集群事件采集
</ul>
<b>蓝鲸容器日志</b><ul>
<li>分布式采集k8s集群的日志
<li>支持标准输出日志，容器内程序日志
</ul>
</td>
</tr>

<tr>
<td>API密钥</td>
<td>BCS打通蓝鲸容器监控与容器日志平台，为BCS集群提供监控告警与日志采集查询能力</td>
<td>
<b>蓝鲸容器监控</b>
<ul>
<li>分布式采集k8s集群的监控数据
<li>支持控制平面，servicemonitor，podmonitor指标数据采集
<li>完整兼容Prometheus协议的采集方式
<li>支持集群事件采集
</ul>
<b>蓝鲸容器日志</b><ul>
<li>分布式采集k8s集群的日志
<li>支持标准输出日志，容器内程序日志
</ul>
</td>
</tr>

</table>
