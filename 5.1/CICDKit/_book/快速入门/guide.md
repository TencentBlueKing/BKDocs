## 入门指南

新建流水线并修改流水线名称：
![](/assets/bk-cicdkit-32.png)

点击全局设置，选择容器构建，并选择 Java 构建镜像：
![](/assets/bk-cicdkit-33.png)

新增一个阶段，选择串行：
![](/assets/bk-cicdkit-34.png)

新增一个任务，选择源代码，并添加一个代码仓库：
![](/assets/bk-cicdkit-35.png)

填写代码仓库的配置信息（这里请填写一个 Java Maven 项目的真实信息）：
![](/assets/bk-cicdkit-36.png)

添加一个脚本节点，选择 shell 类型，并输入编译 Java Maven 项目的指令： mvn clean package
![](/assets/bk-cicdkit-37.png)

添加一个归档节点，填写归档路径（即构件仓库中的相对路径）、版本号、归档项目（项目名称）、归档文件类型（保持跟编译后的程序包类型一致）、归档分类（可自定义，比如 snapshot 、 release 等）、源文件路径（即编译产出的程序包路径，可用相对路径）：
![](/assets/bk-cicdkit-38.png)

保存并执行流水线，先检查测试一下是否正常。
![](/assets/bk-cicdkit-39.png)

![](/assets/bk-cicdkit-40.png)

若执行没有报错，到构件管理栏目中找一下刚才归档的文件，复制链接可以获取到该程序包的下载地址：
![](/assets/bk-cicdkit-41.png)

到部署栏目新增一个单节点快速执行脚本的简单的流程，脚本内容包括下载程序包（即 wget 代码仓库中的程序包下载地址）、启动程序（如果是 SpringBoot 项目可直接 java -jar 启动，如果是传统项目则需准备 Tomcat 之类的服务器）等步骤，并填写部署的目标服务器 IP、用户等信息：（该步骤更多细节请参考标准运维相关产品介绍）
![](/assets/bk-cicdkit-42.png)

回到流水线编辑界面，增加一个部署节点，并选择刚刚创建的部署流程：
![](/assets/bk-cicdkit-43.png)

保存后再次执行流水线，即可完成一个项目的简单 CI、CD 过程，更多功能节点可按需进行配置和使用：
![](/assets/bk-cicdkit-44.png)
