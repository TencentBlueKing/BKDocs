# 手动安装 Agent 使用脚本
## 云区域 Proxy 安装

要求：Linux 64位机器。
安装流程与直连 Agent 安装一致，但 -m 指定的节点类型为 Proxy 即可。

### 获取云区域ID

在手动安装前，需要在节点管理上创建好云区域。获得云区域 ID。详情参考 [新增云区域](../../快速入门/create_cloud.md) 。

### 执行安装

登陆 Proxy 机器，下载 agent_setup_pro.sh 脚本，后执行如下命令即可：

```bash
root@rbtnode1 download#
root@rbtnode1 download# bash agent_setup_pro.sh -m proxy -i CLOUD_ID
```

> **[info] Note:**
>
> 1. 注意替换上述命令中的 CLOUD_ID 为实际的云区域 ID。
> 2. 若使用了错误的云区域 ID，平台将无法识别或查找到上报的数据。
> 3. 多台 Proxy 机器，每台机器都需要执行。
