## 术语解释

了解蓝鲸容器服务，会涉及到以下基本概念：

<table><tbody>
<tr><td width="10%">容器编排引擎</td><td width="90%">用于容器化应用的自动化部署、扩展和管理的工具或平台，目前行业主流的引擎有 K8S 、Mesos。</td></tr>
<tr><td width="10%">集群</td><td width="90%">是指容器运行所需要的物理机或虚拟机资源的集合，可以选择集群-的模式是 Kubernetes（简称 K8S） 或者 Mesos。</td></tr>
<tr><td width="10%">节点</td><td width="90%">一台已经注册到集群中的服务器，为集群提供计算资源。</td></tr>
<tr><td width="10%">应用</td><td width="90%">由一组容器及服务构成集合，这个集合可以代表一个业务，或者业务的某个大区，在 K8S 中应用由 K8S 的工作负载（Workload）、服务（Service、Ingress）构成一个整体对外提供服务。</td></tr>
<tr><td width="10%">模板集</td><td width="90%">配置文件模板的集合，简化服务管理的复杂度，可以实现部署、升级应用。</td></tr>
<tr><td width="10%">网络</td><td width="90%">主要包含 服务 和 负载均衡器 的定义和管理，服务是由多个相同配置的容器和访问这些容器的规则组成的微服务，负载均衡器定义了访问规则的具体实现。</td></tr>
<tr><td width="10%">资源</td><td width="90%">资源中可以定义业务配置项，通过配置模板中关联这些业务配置项，可以实现对容器中业务进程使用配置的个性化管理。</td></tr>
<tr><td width="10%">仓库</td><td width="90%">用户存放 Docker 镜像、Helm Charts。</td></tr>
</tbody></table>

## 帮助文档

[容器管理平台文档](../../../../../BCS/6.0/产品白皮书/Introduction/README.md)
