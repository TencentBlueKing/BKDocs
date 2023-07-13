# 统一术语

- **BK_HOME：** 安装路径，默认为 `/data/bkce`

- **CTRL_PATH：** 安装维护脚本所在目录，默认为 `/data/install`

- **BK_PKG_SRC_PATH：** 组件原始包解压目录，默认为 `/data/src`

- **中控机：** 安装蓝鲸后台服务器中，选一台作为中控机，安装蓝鲸和运维蓝鲸，一般均从这台机器开始

- **source load_env.sh：** 一些操作需要加载蓝鲸环境变量和函数后才能调用。此为 `cd $CTRL_PATH/ && source load_env.sh` 的简写

- **bkcli \<command\> \<module\>：** 若无特殊说明，含义是在**中控机**上执行命令：`cd $CTRL_PATH && ./bkcli <command> <module>`。如重启 cmdb：`./bkcli restart cmdb`

后文提到路径时，均以默认路径为例，请根据实际安装路径修改相关命令
