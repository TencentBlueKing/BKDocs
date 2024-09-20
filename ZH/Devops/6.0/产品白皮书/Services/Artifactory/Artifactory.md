# 制品的归档与拉取

持续集成平台提供制品库，可以让你将 ipa、apk、maven、docker image、二进制包等产物归档并分享，结合流水线，会让持续交付变得更加简单。

编译产出构件后，添加`Upload artifacts`插件将构件归档至制品库

![添加插件](../../assets/artifactory_1.png)

配置产物的所在路径

![配置插件](../../assets/artifactory_2.png)

添加新的构建环境`Job 3-1`

![添加构建环境](../../assets/artifactory_3.png)

添加并配置`Downlad artifacts`插件，用以拉取已上传至制品库的构件

![配置插件](../../assets/artifactory_4.png)

执行流水线，通过插件日志检查构件是否拉取成功

进入制品库服务，查看构件是否成功归档至流水线仓库
