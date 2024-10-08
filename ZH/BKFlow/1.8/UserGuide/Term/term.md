# 术语解释

- **接入系统**：BKFlow 是面向平台设计的流程引擎平台，对于通过 API 调用来创建流程和任务的系统，均称为接入系统。

- **接入系统开发者**：BKFlow 接入系统的开发者，BKFlow 的用户，需要了解 BKFlow 的相关概念并进行接入和配置，拥有对应空间的所有资源管理权限。
  
- **接入系统用户**：BKFlow 接入系统的用户，可以不感知 BKFlow 的存在，直接基于接入系统提供的功能或者嵌入的画布进行操作，无需了解 BKFlow 的概念。
  
- **空间**：BKFlow 进行业务隔离的概念，不同空间的数据不互通。由接入系统的开发者进行创建和管理，需要绑定接入系统的 APP_CODE，推荐每个接入系统只对应于一个空间。
  
- **空间管理员**：BKFlow 空间的管理员，拥有对应空间的所有资源管理权限，空间创建者默认会成为空间管理员。
  
- **空间配置**：BKFlow 空间的配置，包括网关表达式、画布模式、空间管理员等一系列配置。
  
- **流程/流程模板**：在 BKFlow 里，每一个基础场景的预定义操作过程就是一个流程，流程是创建任务的模板。
  
- **任务/任务实例**：在 BKFlow 里，我们可以根据一个流程创建出一个任务，每个任务都是一次真正的业务场景作业，任务可以被暂停、被强制终止。
  
- **顺序流**：顺序流是 BKFlow 中用来连接两个节点的有向线段，标识任务流程的执行方向。
  
- **节点**：BKFlow 中的一个流程执行单元，包括流程控制节点和任务节点。在执行任务时，每一个节点都会有未执行、正在执行、执行成功、执行失败的状态。
  
- **流程控制节点**：BKFlow中的一类节点，本身不包含具体执行逻辑，只是用来控制任务流程的执行过程。如开始节点标识任务流程的开始，网关节点控制并行流程和分支流程的开始、结束。
  
- **网关节点**：包括并行网关、分支网关和汇聚网关，用来控制并行和分支流程的开始、结束。
  
- **并行网关**：用来标识并行流程的开始，通过和汇聚网关配对使用，可以控制多个节点并行执行。
  
- **分支网关**：用来标识分支流程的开始，通过和汇聚网关配对使用，可以根据分支表达式的计算结果，动态的控制多个分支中某一个分支执行。
  
- **汇聚网关**：用来标识并行流程或者分支流程的结束，推荐每一个分支网关和并行网关都配置一个与之对应的汇聚网关。请注意，BKFlow 中并行流程中可以嵌入分支流程，分支流程中也可以再嵌入并行流程，请务必保证汇聚网关和并行网关或分支网关一一对应，而不能出现交叉嵌入或者不配对的情况。
  
- **任务节点**：任务节点是 BKFlow 任务执行的具体逻辑单元，每个任务节点包括基础信息、输入参数和输出参数，输出参数可以用来勾选生成全局变量，输入参数还可以引用全局变量来简化用户输入。
  
- **插件**：BKFlow 中任务节点执行的业务逻辑封装，我们称之为插件，包含内置插件、 API 插件和蓝鲸插件。
  
- **内置插件**：BKFlow 默认提供的公共业务逻辑封装，包括暂停、定时、消息展示、审批、决策等插件。
  
- **API 插件**：BKFlow 中提供接入系统开发者自定义业务逻辑能力的插件，接入系统开发者可以通过暴露特定协议的接口，实现自定义业务逻辑，并在 BKFlow 生成对应的插件，供给接入系统用户使用。
  
- **蓝鲸插件**：BKFlow 对接蓝鲸插件服务，接入系统开发者或用户可以基于蓝鲸开发者中心自定义实现插件，并在 BKFlow 进行使用。
  
- **全局变量**：全局变量是一个流程模板的公共参数，通过 KEY 来做唯一性约束。用户可以在任务节点的输入参数和分支网关表达式中引用，BKFlow 会在执行任务时自动替换全局变量的引用为全局变量的值。
