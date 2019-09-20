### 流水线 {#pipeline}

流水线页面默认显示流水线列表，可快捷启动、停止已经设计好的流水线，也可点击对应链接进入编辑、执行历史等功能页面。
![](/assets/bk-cicdkit-3.png)

流水线编辑页面包括全局参数设置、阶段设计、原子节点编排等功能，可根据团队需求自定义符合需求的流水线。
![](/assets/bk-cicdkit-4.png)

全局设置用于配置流水线的构建方式、触发机制及通知类型，构建环境支持内置容器构建或自定义构建机构建。
![](/assets/bk-cicdkit-5.png)

可自定义添加多个不同阶段，并设置阶段内原子节点之间是串行或并行。
![](/assets/bk-cicdkit-6.png)

代码原子节点，配置从代码仓库拉取源代码的相关信息，支持 git 和 svn 两种方式。
![](/assets/bk-cicdkit-7.png)

脚本原子节点，编写在目标构建环境中执行的脚本， Linux 构建环境支持 shell ， Windows 构建环境支持 bat 和 powershell 。
![](/assets/bk-cicdkit-8.png)

单元测试原子节点，用于将单元测试代码的运行结果加工成结构化数据，并在报表中的单元测试报告栏目显示。
![](/assets/bk-cicdkit-9.png)

代码扫描原子节点，用于对源代码进行静态扫描，发现其中的漏洞、潜在 Bug、重复代码等信息，并在报表中的代码检查栏目展示。
![](/assets/bk-cicdkit-10.png)

归档原子节点，用于将编译输出的程序包归档到构件仓库，供程序部署时使用。
![](/assets/bk-cicdkit-11.png)

构建镜像原子节点，用于将程序包打包生成一个 Docker 镜像，Dockerfile 需由开发或运维团队设计编写。
![](/assets/bk-cicdkit-12.png)

推送镜像原子节点，将上一步构建的镜像归档到镜像仓库中。
![](/assets/bk-cicdkit-13.png)

构建并推送镜像，即构建镜像和推送镜像两个步骤的合并。
![](/assets/bk-cicdkit-14.png)

人工审核原子节点，用于简单的审批确认，流水线运行到该节点会自动挂起，人工确认后继续执行，也可选择终止运行。
![](/assets/bk-cicdkit-15.png)

部署原子节点，调用标准运维定义的部署流程，实现程序包的批量发布部署。
![](/assets/bk-cicdkit-16.png)

流水线执行过程可视化，点击原子节点可查看各阶段日志。
![](/assets/bk-cicdkit-17.png)

![](/assets/bk-cicdkit-18.png)

工作空间里可自定义流水线执行的子集，比如跳过一些非必须的节点以加快构建速度。
![](/assets/bk-cicdkit-19.png)

执行历史可查看具体某个流水线的历史执行记录，包括执行结果、日志、相关说明等。
![](/assets/bk-cicdkit-20.png)
