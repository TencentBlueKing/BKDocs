# 云区域下的 P-Agent 安装

由于以下两个原因：

1. P-Agent 节点无法连接到 Nginx 进行文件的下载。
2. 节点管理所在机器 (APPO) 也无法连接到 P-Agent。

在安装 Proxy 时，提前把 P-Agent 的安装包下载到 Proxy 节点上。因此 P-Agent 的安装在 Proxy 上操作即可完成。

安装云区域下的 P-Agent 使用的脚本仍然是：`agent_setup_pro.sh`，使用 -o 参数将要安装机器列表填写在配置文件中。
脚本将自动识别并完成 Agent 的安装。

在 **任意一台** Proxy 机器上执行安装即可。

## P-Agent 主机列表配置文件

配置文件格式如下

```bash
IP  操作系统名称  密码/密钥文件路径  SSH 端口   登陆账号  是否有 Cygwin
```

- SSH 端口：Windows 无 Cygwin 时，SSH 端口任意填写即可。但不是空。
- 登陆账号：root，Administrato，注意区分大小写。
- 操作系统可以是: `linux`，`windows`， `aix`, 全部小写。
- 密码密钥文件：填写密码，或者密钥文件的绝对路径，登陆需要。
- 是否有 Cygwin，有填写 1，无填写 0，( windows 机器有效)。

配置文件示例：

```bash
10.0.0.1    linux       mypassword01         22      root             0
10.0.0.2    linux       /root/.ssh/id_rsa    22      root             0
10.0.0.3    windows    mypassword02          22      Administrator    1
10.0.0.4    windows    mypassword02          22      Administrator    0
10.0.0.5    aix        mypassword02          22      root             0
```

将要准备安装 P-Agent 的机器按照如上格式，填写到一个配置文件中，假设文件名为： /tmp/pagent.list

## 登陆及下载脚本
略

## 执行安装

在 **任意一台** Proxy 机器上执行一下命令即可。

```bash

root@rbtnode1 ~# ./agent_setup_pro.sh -b -m client -o /tmp/pagent.list -i 云区域ID -l proxy内网IP -w proxy外网IP -g http://$NGINX_IP:$NGINX_PORT/download
```

> **Note:**
>
> 1. 注意替换上述命令中的 CLOUD_ID，PROXY_LAN_IP 为实际值。
> 2. 若有两台 Proxy，-l 选项参数中把两个 Proxy 的内网 IP 用逗号分隔即可。
> 3. 若在脚本执行阶段超时，可以用 -t 参数调整超时时间。
