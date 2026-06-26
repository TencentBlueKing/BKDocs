# 智能体

【智能体开发】-》【智能体】tab 下可以查看 “全部智能体/当前空间/我的智能体”，可以进行插件开发、调试、源码包下载。

智能体是基于 LLM Agent Framework 二次开发的场景智能体，智能体源码可在蓝鲸 PaaS 平台进行部署，提供独立的场景智能体服务。

![Agent_No-Code_Development_20260423185538.png](../assets/Agent_No-Code_Development_20260423185538.png)

通过小鲸组件在线调试已开发的智能体。

![Agent_No-Code_Development_20260423185538.png](../assets/Agent_No-Code_Development_20260423185538.png)

下载源码后，可以继续进行二次开发并部署，详见后续章节 基于LLM Agent Framework开发。

![Agent_No-Code_Development_20260423185739.png](../assets/Agent_No-Code_Development_20260423185739.png)

## 配置智能体 - 单智能体

### 创建智能体

填写智能体所需的必要信息。

![2026-03-13-15-51-22.png](../assets/2026-03-13-15-51-22.png)

如果在蓝鲸开发者中心已有对应的应用，可以直接进行绑定。

![2026-03-13-15-51-32.png](../assets/2026-03-13-15-51-32.png)

### 配置智能体

支持自定义prompt或引用已配置的角色，或使用AI生成提示词，或从模板导入提示词。

![Agent_No-Code_Development_20260423193215.png](../assets/Agent_No-Code_Development_20260423193215.png)

如果角色定义了变量，可以进行配置，点击角标可以快速定位。

![Agent_No-Code_Development_20260423193542.png](../assets/Agent_No-Code_Development_20260423193542.png)

选择智能体所使用的大模型，用于会话和检索（检索场景建议使用非深度思考模型，速度更快）。

![Agent_No-Code_Development_20260423193358.png](../assets/Agent_No-Code_Development_20260423193358.png)

按需填写开场白和预设的常用提示词。

![Agent_No-Code_Development_20260423193913.png](../assets/Agent_No-Code_Development_20260423193913.png)

按需选择需要关联的外部智能体，并勾选需要使用的快捷指令。可以通过快捷指令的方式实现多智能体之间的切换调用。

![Agent_No-Code_Development_20260423194506.png](../assets/Agent_No-Code_Development_20260423194506.png)

可以定义当前智能体所支持的快捷指令（及其对应的输入），用于规范特定问答场景的输入。关联的外部智能体，也会以快捷指令的形式在此处展示。

![Agent_No-Code_Development_20260423194019.png](../assets/Agent_No-Code_Development_20260423194019.png)

以翻译场景为例，可定义下列输入和指令：

![Agent_No-Code_Development_20260423194246.png](../assets/Agent_No-Code_Development_20260423194246.png)

按需选择需要关联的知识库和检索方式。

检索方式：语义检索适合 文本理解 的检索场景；混合检索适合 文本理解、数值、固定文案 多种混合的检索场景。

![Agent_No-Code_Development_20260423194601.png](../assets/Agent_No-Code_Development_20260423194601.png)

修改检索参数以调整召回结果，具体参数的调试可以在 检索测试 功能中进行。

![Agent_No-Code_Development_20260423194640.png](../assets/Agent_No-Code_Development_20260423194640.png)

![Agent_No-Code_Development_20260423194736.png](../assets/Agent_No-Code_Development_20260423194736.png)

按需选择需要关联的skill。

![Agent_No-Code_Development_20260424102440.png](../assets/Agent_No-Code_Development_20260424102440.png)

如果skill中定义了环境变量，需要按需填写变量值。

![Agent_20260623170942.png](../assets/Agent_20260623170942.png)

![Agent_20260623171123.png](../assets/Agent_20260623171123.png)

按需选择需要关联的工具或MCP。

![Agent_No-Code_Development_20260423194832.png](../assets/Agent_No-Code_Development_20260423194832.png)

如需申请其他空间的资源（MCP、工具、智能体、skill等），可以点击【去申请】前往【空间管理】申请。

![Agent_No-Code_Development_20260423194958.png](../assets/Agent_No-Code_Development_20260423194958.png)

在MCP的【全部】中，可以选择 蓝鲸API网关 来源的MCP，若无使用权限，勾选后将会自动提单，可联系相应审批人进行审批。

![Agent_No-Code_Development_20260423195201.png](../assets/Agent_No-Code_Development_20260423195201.png)

调试无误之后，即可进行发布。

![Agent_No-Code_Development_20260423195243.png](../assets/Agent_No-Code_Development_20260423195243.png)

## 配置智能体 - 流程类智能体

最佳实践可参考 [流程类智能体最佳实践](../UserCase/Process_Agent_Best_Practices.md)

### 创建智能体

相较于单智能体，流程类智能体更适合 每个智能体分别仅处理小部分业务逻辑 且 顺序需要严格固定的业务逻辑 的场景。

填写智能体所需的必要信息。

![2026-03-13-16-06-27.png](../assets/2026-03-13-16-06-27.png)

### 配置智能体

通过编辑画布，配置流程类智能体的业务逻辑。

![Agent_No-Code_Development_20260423195551.png](../assets/Agent_No-Code_Development_20260423195551.png)

在画布中按需编排所需节点，目前支持 模型、智能体、知识库、插件 功能节点。

![Agent_No-Code_Development_20260423195708.png](../assets/Agent_No-Code_Development_20260423195708.png)

- 模型

![Agent_No-Code_Development_20260423195749.png](../assets/Agent_No-Code_Development_20260423195749.png)

  示例如下

  ![2026-03-13-16-07-07.png](../assets/2026-03-13-16-07-07.png)

- 智能体

![Agent_No-Code_Development_20260423195821.png](../assets/Agent_No-Code_Development_20260423195821.png)  

  示例如下

  ![2026-03-13-16-07-26.png](../assets/2026-03-13-16-07-26.png)

- 知识库

![Agent_No-Code_Development_20260423200029.png](../assets/Agent_No-Code_Development_20260423200029.png)

  示例如下

  ![Agent_No-Code_Development_20260423200149.png](../assets/Agent_No-Code_Development_20260423200149.png)

- 插件

![Agent_No-Code_Development_20260423195901.png](../assets/Agent_No-Code_Development_20260423195901.png)  

  示例如下
  
  ![2026-03-13-16-07-45.png](../assets/2026-03-13-16-07-45.png)

流程类智能体的调试，需要绑定凭证，按照提示前往蓝鲸开发者中心获取当前智能体（应用）的凭证。

![Agent_20260623171222.png](../assets/Agent_20260623171222.png)

前往蓝鲸开发者中心，获取 bk_app_secret。

![2026-03-13-16-08-55.png](../assets/2026-03-13-16-08-55.png)

### 变量管理

在变量管理中创建和编辑流程中使用的参数。

![2026-03-13-16-07-54.png](../assets/2026-03-13-16-07-54.png)

![2026-03-13-16-08-06.png](../assets/2026-03-13-16-08-06.png)

![2026-03-13-16-08-15.png](../assets/2026-03-13-16-08-15.png)

配置完成后，即可进行调试。

![2026-03-13-16-08-26.png](../assets/2026-03-13-16-08-26.png)

查看每个节点的执行状态。

![2026-03-13-16-09-13.png](../assets/2026-03-13-16-09-13.png)

调试无误之后，即可进行发布。

![Agent_20260623172236.png](../assets/Agent_20260623172236.png)

## 发布智能体

可以使用两种方式进行发布。

发布至蓝鲸开发者中心：默认的发布方式。发布后会在蓝鲸开发者中心生成对应的应用，支持以 源码包 或 代码仓库 部署。可以使用 页面聊天窗、API调用、小鲸聊天窗、企微助手 等多种使用渠道。

- 源码包部署（无码开发，智能体源码Tar包一键部署）

![2026-03-13-16-09-32.png](../assets/2026-03-13-16-09-32.png)
  
  发布后可以在右侧查看历史发布记录，或跳转至开发者中心的各个功能页。

  ![2026-03-13-16-09-39.png](../assets/2026-03-13-16-09-39.png)

- 代码仓库部署（基于智能体框架进行二次开发，需先在开发者中心切换为目标代码仓库）

![2026-03-13-16-09-49.png](../assets/2026-03-13-16-09-49.png)

![2026-03-13-16-09-57.png](../assets/2026-03-13-16-09-57.png)

已在其他渠道发布：在AIDev将已发布的智能体访问入口、API进行注册，并进行简单的版本发布管理，仅能使用 页面聊天窗、API调用 两种使用渠道。

## 使用渠道

目前提供五种使用渠道。

页面聊天窗 可以直接访问或者进行分享。

![Agent_No-Code_Development_20260423200333.png](../assets/Agent_No-Code_Development_20260423200333.png)

API调用 和 小鲸聊天窗 可以直接查看使用文档。

![Agent_No-Code_Development_20260423200400.png](../assets/Agent_No-Code_Development_20260423200400.png)

如需使用 企微智能机器人 功能，只需打开开关，并按使用文档申请权限即可。

![Agent_No-Code_Development_20260423200514.png](../assets/Agent_No-Code_Development_20260423200514.png)

如需对小鲸聊天窗提供【转人工】服务，可将客服号绑定到当前Agent，操作如下：

  - 获取客服号的 ServiceId

    在企微 内部客服助手，输入命令：/info 客服号名称，会返回客服号的 ServiceId，如下：

    ![2026-03-13-16-15-44.png](../assets/2026-03-13-16-15-44.png)

  - 在蓝鲸开发者中心，智能体对应的应用，配置拉群的环境变量，如下：

    - CHAT_GROUP_ENABLED：1

    - CHAT_GROUP_STAFF：客服人员企微id

    ![2026-03-13-16-16-22.png](../assets/2026-03-13-16-16-22.png)

  - 重新部署default模块

  ![2026-03-13-16-16-32.png](../assets/2026-03-13-16-16-32.png)

  - 待部署完成即可在小鲸组件使用转人工功能

  ![2026-03-13-16-16-42.png](../assets/2026-03-13-16-16-42.png)

## 使用文档

编辑使用文档，供用户使用时查看。

![Agent_No-Code_Development_20260423200620.png](../assets/Agent_No-Code_Development_20260423200620.png)

![Agent_No-Code_Development_20260423200703.png](../assets/Agent_No-Code_Development_20260423200703.png)

## 使用权限

控制智能体对外使用渠道（小鲸组件、页面聊天窗）的人员使用权限，默认全开放。

![Agent_No-Code_Development_20260423200733.png](../assets/Agent_No-Code_Development_20260423200733.png)

## 运营管理

可以查看智能体各个渠道的所有使用记录，并可查看、下载会话内容。

![Agent_20260622165655.png](../assets/Agent_20260622165655.png)

![Agent_20260622165739.png](../assets/Agent_20260622165739.png)