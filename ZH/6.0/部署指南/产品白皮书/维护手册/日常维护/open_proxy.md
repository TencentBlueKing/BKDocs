# 开启 Proxy

蓝鲸部署默认不开启 Proxy，因为部分用户存在跨云管控需求，而实现跨云管控需要安装 proxy 。

本文描述，开启 proxy 的方法：

## 部署前

- 登陆节点管理机器，将 nodeman 模块所在机器的外网 IP 写入指定文件。

```bash
# $CTRL_DIR 请使用实际部署脚本路径替换。
source $CTRL_DIR/utils.fc
ssh $BK_NODEMAN_IP

# 将节点管理机器外网 IP 写入指定文件
echo "WAN_IP=$(curl -s icanhazip.com)" >> /etc/blueking/env/local.env
```

- 将 gse 模块所在机器的外网 IP 写入至中控机指定的文件

    需要将 gse 外网写入至中控机指定文件，主要是为了解决 proxy 机器与 gse 机器的网络不通，导致无法与 gse 建立相关连接，因为未指定 gse 外网 IP 时，默认为 gse 的内网 IP。

```bash
# 中控机执行
# $CTRL_DIR 请使用实际部署脚本路径替换。

echo "BK_GSE_WAN_IP_LIST=$($CTRL_DIR/pcmd.sh -m gse "curl -s icanhazip.com" | tail -n 1)" >> /etc/blueking/env/local.env 
```

## 部署后

- 登陆节点管理机器，将 nodeman 模块所在机器的外网 IP 写入指定文件。

```bash
# $CTRL_DIR 请使用实际部署脚本路径替换。
source $CTRL_DIR/utils.fc
ssh $BK_NODEMAN_IP

# 将节点管理机器外网 IP 写入指定文件
echo "WAN_IP=$(curl -s icanhazip.com)" >> /etc/blueking/env/local.env
```

- 进入节点管理SaaS，修改 gse 的全局配置

  - 打开节点管理
  
  - 进入 【全局配置】，编辑【默认接入点】

  - 修改 `Btfileserver`、`Dataserver`、`Taskserver` 的 `外网IP列` 为实际的 GSE 外网 IP [gse 模块分布的机器]，可参考 `$CTRL_DIR/pcmd.sh -m gse "curl -s icanhazip.com" | tail -n 1`。

  - 修改 `Agent包URL` 第二个输入框的域名，替换为节点管理的外网 IP [nodeman 模块分布的机器]，可参考 `$CTRL_DIR/pcmd.sh -m nodeman "curl -s icanhazip.com" | tail -n 1`
  
    ![image](https://user-images.githubusercontent.com/4710858/116407651-8f576f00-a864-11eb-8ab4-0461d7b9b6cb.png)


- 重新渲染配置

渲染配置可以选择重装或者重新渲染配置文件的方式。

```bash
./bkcli render bknodeman
```

- 重启节点管理进程

```bash
./bkcli restart bknodeman
```
