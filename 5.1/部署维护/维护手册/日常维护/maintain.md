# 蓝鲸日常维护

## 统一术语

- **INSTALL_PATH：** 安装路径，默认为 `/data/bkce`

- **CTRL_PATH：** 安装维护脚本所在目录，默认为 `/data/install`

- **PKG_SRC_PATH：** 组件原始包解压目录，默认为 `/data/src`
s
- **中控机：** 安装蓝鲸后台服务器中，选一台作为中控机，安装蓝鲸和运维蓝鲸，一般均从这台机器开始

- **source utils.fc：** 一些操作需要加载蓝鲸环境变量和函数后才能调用，此为 `cd $CTRL_PATH/ && source utils.fc` 的简写

- **bkcec <command> <module>：** 若无特殊说明，含义是：`cd $CTRL_PATH && ./bkcec <command> <module>`

下面提到路径时，均以默认路径为例，请根据实际安装路径修改相关命令
