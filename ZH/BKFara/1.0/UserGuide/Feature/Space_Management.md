# 空间管理

## 标签管理

可管理当前空间内的标签，标签允许用于 流程、任务 这两类对象，用于快速检索。

![Space_Management_20260721163147.png](../assets/Space_Management_20260721163147.png)

## 成员管理

空间内的三种角色：

![Space_Management_20260721163534.png](../assets/Space_Management_20260721163534.png)

## 资源管理

故障分析处置平台 按照【业务】空间对资源进行权限管理。用户在【业务】空间内提交资源使用申请单，由来源平台审批。在【资源管理】页可进行单据管理、进度查看。

- AIDEV

  - 使用范围是“所有空间可见”状态的智能体，分析处置平台的所有空间 流程节点都可以直接选择使用，不需要申请授权。

  - 使用范围是“本空间可见”状态且已经开启“可授权”的智能体，分析处置平台的所有空间可以在【资源管理】里为当前空间申请这个智能体权限，获得授权后可以在当前空间里使用。

![Space_Management_20260723104450.png](../assets/Space_Management_20260723104450.png)

- 蓝鲸开发者中心

  - 复用现有蓝鲸插件授权方案，指定【故障分析处置平台】为使用方。

![Space_Management_20260722113623.png](../assets/Space_Management_20260722113623.png)

## 空间设置

### 故障知识库

可以绑定AIDEV的知识库，用于自动编排模式下的故障诊断。

![Space_Management_20260721164240.png](../assets/Space_Management_20260721164240.png)

### 故障通知配置

可以为不同级别的故障，指定通知方式。

![Space_Management_20260722113548.png](../assets/Space_Management_20260722113548.png)

### 降噪配置

可以自定义规则，让命中规则的告警按下列两种方式处理：

- 不经过降噪，直接进入故障分析流程（**避免遗漏重要告警**）

- 必须作为噪声被过滤掉（**避免噪声干扰故障分析结果**）

![Space_Management_20260831171253.png](../assets/Space_Management_20260831171253.png)

可选的条件来源包含 告警数据维度、监控系统维度。

![Space_Management_20260831171355.png](../assets/Space_Management_20260831171355.png)

### 数据接入状态

可以查看当前空间的数据接入状态，及其对应的故障分析能力开启情况。

![Space_Management_20260721164718.png](../assets/Space_Management_20260721164718.png)

目前提供下列故障分析能力：

#### 故障总结

通过LLM能力对当前故障关联的 告警、APM服务、K8s资源、主机、调用信息 等进行综合分析，并给出最终结论。

![Space_Management_20260831105308.png](../assets/Space_Management_20260831105308.png)

示例告警分析：

![Space_Management_20260831105318.png](../assets/Space_Management_20260831105318.png)

对应的告警如下：

![Space_Management_20260831105328.png](../assets/Space_Management_20260831105328.png)

#### 处置建议

通过LLM能力分析当前故障可能的解决方案，并打通下游处置系统。

![Space_Management_20260831105408.png](../assets/Space_Management_20260831105408.png)

#### 图谱RCA

- 故障拓扑

  故障传播图，支持查看 服务层、K8s层 的异常流量传播链路

  ![Space_Management_20260831105525.png](../assets/Space_Management_20260831105525.png)

- 节点和边概览

  每个节点均可查看节点概览，包含节点指标和关联边

  ![Space_Management_20260831105536.png](../assets/Space_Management_20260831105536.png)

  每条边均可查看边概览，包含边指标

  ![Space_Management_20260831105546.png](../assets/Space_Management_20260831105546.png)

- 资源从属

  可以查看图谱实体的静态资源拓扑（从属关系），以辅助排查故障影响范围节点的上下游

  ![Space_Management_20260831105557.png](../assets/Space_Management_20260831105557.png)

- 拓扑聚合

  可以按照特定规则，对拓扑图上的边进行聚合（从属关系、调用关系）

  ![Space_Management_20260831105607.png](../assets/Space_Management_20260831105607.png)

- 故障回放

  支持回放故障历史切片

  ![Space_Management_20260831105615.png](../assets/Space_Management_20260831105615.png)

#### 异常维度分析

通过对告警指标的异常维度分析，获取告警的影响面，辅助排查问题。

![Space_Management_20260831105726.png](../assets/Space_Management_20260831105726.png)

#### 事件分析

列出可能与故障关联的各种事件，并进行分析

- 主机系统事件

  ![Space_Management_20260831105803.png](../assets/Space_Management_20260831105803.png)

- K8s异常事件

  ![Space_Management_20260831105810.png](../assets/Space_Management_20260831105810.png)

- 发布变更事件

  ![Space_Management_20260831105915.png](../assets/Space_Management_20260831105915.png)

#### 日志分析

基于日志模式聚类的故障分析。

![Space_Management_20260831110024.png](../assets/Space_Management_20260831110024.png)

#### 调用链分析

基于服务调用拓扑的故障分析，并提供调用链路中的异常span和异常信息。

![Space_Management_20260831110101.png](../assets/Space_Management_20260831110101.png)

#### 排障知识库RAG

- 故障场景库

  主要涉及常用组件类故障（MySQL、Redis等11个常用组件）、主机&虚拟机故障、服务实例类等3个业务通用故障场景。

  如果根据故障表现召回到对应的故障场景库中的内容，在后续故障分析过程中，会参考故障场景库的【故障处理指引】进行排查。

  ![Space_Management_20260831110524.png](../assets/Space_Management_20260831110524.png)

  - 示例

    query: Redis连接超时

    检索结果：

    ![Space_Management_20260831110535.png](../assets/Space_Management_20260831110535.png)

- 业务错误码知识库

  - 错误码知识库应用

    当故障对应的告警详情/错误日志（需接入日志平台）中包含对应的错误码，可以在告警分析中找回错误码对应的含义，进行相关分析。

    ![Space_Management_20260831110755.png](../assets/Space_Management_20260831110755.png)

  - 业务支持范围 & 新增业务支持方式

    目前已支持业务：

    100231[和平精英]

    100391[Gcloud]

    100674[金铲铲之战]

    100147[蓝鲸监控]

    其他业务，错误码支持方式：将业务错误码对应的bkaidev结构化知识按照如下格式要求（需授权）同步给【蓝鲸故障分析（bk-incident）】，具体支持细节可联系sueliang。

    ![Space_Management_20260831110805.png](../assets/Space_Management_20260831110805.png)

    ![Space_Management_20260831110832.png](../assets/Space_Management_20260831110832.png)

  - 示例

    query：DevopsNotDeployedError

    检索结果：

    {
      "bk_biz_id": xxxxx,
      "error_code": 3301002,
      "error_name": "DevopsNotDeployedError",
      "error_message": "蓝盾环境未部署",
      "error_influence": null,
      "status_code": "500",
      "module": "api.py"
    }