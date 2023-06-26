# 云环境异常定位


## 关键词：云环境、corefile

## 业务挑战

服务上云后，游戏进程发生core，由于pod节点漂移等原因，找到corefile并断点调试比较困难。

## BKCI优势

通过BKCI自动拉起调试节点，并邮件输出coredump内容给后台开发，如果有断点需求，可以在集群master节点登录调试pod，进行调试定位。

## 解决方案

1、整体流程如下：

● node机监控是否产生corefile

思路：编写corefile文件监控脚本，利用蓝鲸“作业平台”-定时任务功能，当有corefile新增时，远程触发BKCI流水线。

脚本核心部分样例，仅供参考

file_list=`find /data/corefile  -mmin -3 -name  "core_*"`

● 远程触发BKCI流水线后，根据node ip和镜像版本号等信息，部署调试pod

● 调试pod启动后，通过kubectl命令，获取coredump内容

● 发送邮件or机器人等方式，通知开发人员

● 开发人员自助登录调试pod，排查问题

![&#x56FE;1](../../../assets/scene-Cloud-anomaly-location-a.png)

2、BKCI流水线配置

● 解析文件名

通过解析corefile文件名，获取命名空间、文件名、镜像版本号等信息。

● 启动调试pod

根据node节点、镜像版本等参数，启动调试pod

● 获取coredump内容

通过kubectl命令，获取coredump内容

kubectl -n NAMESPACE logs POD_NAME -c corefile-debug

![&#x56FE;1](../../../assets/scene-Cloud-anomaly-location-b.png)


