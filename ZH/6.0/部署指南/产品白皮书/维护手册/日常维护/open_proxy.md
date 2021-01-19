# 开启 Proxy

蓝鲸部署默认不开启 Proxy，因为部分用户存在跨云管控需求，而实现跨云管控需要安装 proxy 。

本文描述，开启 proxy 的方法：
## 登录至节点管理机器

```bash
# $CTRL_DIR 请使用实际部署脚本路径替换。
source $CTRL_DIR/utils.fc
ssh $BK_NODEMAN_IP
```

## 获取外网 IP

获取节点管理所在机器的外网 IP 并写入到相关文件中。

```bash
echo "WAN_IP=$(curl -s icanhazip.com)" >> /etc/blueking/env/local.env
```

## 重新渲染配置

渲染配置可以选择重装或者重新渲染配置文件的方式。

```bash
# 重新渲染节点管理配置文件
./bkcli render bknodeman

# 重装节点管理 （可选），建议是重新渲染配置文件
./bkcli install bknodeman
```

## 重启节点管理进程

```bash
./bkcli restart bknodeman
```