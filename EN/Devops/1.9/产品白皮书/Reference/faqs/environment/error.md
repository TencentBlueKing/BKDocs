1. + ## Q1 构建机节点导入报错 

     报错：cannot execute binary file

     ​	解决方案：开发环境与命令不相符，不同环境会对应不同的命令。不能在 windows 机器上执行 macOS 或 Linux的命令。

     ![](../../../assets/import_error.png)

     ---

     ## Q2 环境管理节点agent 异常

     第三方机器agent异常

     1. 登录机器查看是否存在devops进程：

        + Windows下打开进程管理查看devopsDaemon和devopsAgent进程；

        + MAC或者Linux直接在机器上执行命令ps -ef | grep devops 查看是否有两个devops进程

          

     2. 

        + 如果devops进程不存在，cd到agent目录(agent目录就是当初执行安装的目录)执行start脚本；
        + 如果devops 进程存在，手动杀掉进程以后，确保没有devops进程了，再执行start脚本

     ---

     ## Q3 windows构建机上安装BKCIagent失败，子目录或文件已经存在，拒绝访问

     ![](../../../assets/企业微信截图_16393825053890-3096967.png)

     这种情况一般是由于用户重复安装BKCIagent导致，可以先执行uninstall脚本，卸载当前agent，然后删除该agent的安装目录，然后重新下载agent包，再次安装

     ## Q4 安装agent后，BKCI读取不到节点

     如果执行agent安装命令后，点击刷新仍无法刷出节点，请按以下步骤排查：

     ![](../../../assets/get-node-error.png)

     1. 检查agent是否安装成功，如果失败：

     - 1.1 确保目标机器是devnet机器，或者可以测试网络连通性，看下是否能连通。

     - 1.2确保去掉机器代理

      

     2. 检查复制的命令是否与目标机器的系统一致

     ![](../../../assets/image-20220831184628259.png)

     3. 确保安装命令是通过点击下图红框按钮复制的

     ![](../../../assets/image-20220831184641257.png)

     **如果目标机器已导入过agent，并且安装命令是从已导入的agent节点页面内复制的，也会导致无法刷出节点的问题。**

     ---

     ## Q5 机器访问第三方内网报错

     问题详情：机器访问第三方内网报错 Failed to connect to 内网.com port XX: Connection refused

     示例：

     1. Failed to connect to xx.xx.com port XX: Connection refused

     2. 机器无法访问内网

     解决方案：若机器配置了外网代理，则访问第三方内网服务需要设置noproxy的值，试打印出no_proxy的值，将需要访问的内网添加到值中

     ![](../../../assets/fail_to_connect.png)

     ---

     ## Q6 Windows机器启动agent提示“由于登录失败而无法启动服务”

     ![](../../../assets/image-20220831154909517.png)

     解决方案：

     请更新一下登录服务的密码

     更新方法如下：

     执行命令services.msc打开windows服务管理界面，找到服务landun_devops_agent

     ![](../../../assets/image-20220831175010006.png)

     ---

     ## Q7 环境节点属性不断在变化

     用户将相同agent安装命令安装在多台不同的机器上了，导致环境管理页面会不断上报两个不同的机器信息。

     安装agent注意需要使用新的唯一安装命令。

     ---

     ## Q8 无法正确获取构建机内网IP

     BKCI获取不到构建机的内网IP，显示为 127.0.0.1

     ![](../../../assets/image-20220831182403811.png)

     在BKCI流水线下拉构建机也显示127.0.0.1

     ![](../../../assets/image-20220831182430720.png)

     原因：这个IP是agent从本机IP里面随机选择的一个IP、可能是有使用其他代理然后获取到了这个IP，可以检查下机器代理问题，关闭掉一些代理软件
     **内网地址的显示12.7.0.0.1本质对构建机使用没有影响， 用户可正常使用**

     