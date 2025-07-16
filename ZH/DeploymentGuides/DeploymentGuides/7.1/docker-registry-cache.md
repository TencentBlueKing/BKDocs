在部署过程中，需要联网拉取镜像。如果我们能提前将所需的镜像拉取到本地，可以节约部署时间及公网带宽开销。

我们提供了 2 种方法：
1. 推荐：使用具备缓存能力的代理服务器。本文使用 docker 官方的 `registry:2` 作为示例。
2. 提前将镜像下载并导入到内网 registry。本文会提供脚本方便你下载及推送镜像。

请查阅下面对应的章节。

# 使用具备缓存能力的代理服务器
## 部署 docker-registry-v2
我们建议你在 node 所在的网络选择一台独立的机器部署镜像服务，主要是带宽充足，至少准备 1Gbps 以上的带宽。

如下脚本在中控机部署 registry，若需在 其他主机 （如 k8s master）部署，请自行修改脚本。

``` bash
# 一些变量，基于变量设置文件名及目录等
upstream_name=bkhub
upstream_url=https://hub.bktencent.com

proxy_port=5500
proxy_instance_name=proxy-$upstream_name
proxy_config_dir=/etc/docker/registry
proxy_config_file=$proxy_config_dir/$upstream_name.yaml
proxy_data_dir=/var/lib/registry-$upstream_name

# 创建目录，生成配置文件
mkdir -p "$proxy_config_dir" "$proxy_data_dir"
cat > "$proxy_config_file" <<EOF
version: 0.1
http:
  addr: :5000
  net: tcp
  secret: $upstream_name-$proxy_port
  headers:
    X-Content-Type-Options: [nosniff]
storage:
  filesystem:
    rootdirectory: /var/lib/registry
cache:
  blobdescriptor: inmemory
redirect:
  disable: true
delete:
  enabled: true
proxy:
  remoteurl: $upstream_url
EOF
# 检查创建或重启容器
if docker inspect "$proxy_instance_name" &>/dev/null; then
  echo "$proxy_instance_name exist, restart."
  docker restart "$proxy_instance_name"
else
  docker run -d -p $proxy_port:5000 --restart=always \
    --name "$proxy_instance_name" \
    -v "$proxy_config_file":/etc/docker/registry/config.yml \
    -v "$proxy_data_dir":/var/lib/registry \
    hub.bktencent.com/library/registry:2
fi
```


# 验证 registry 里的镜像
假设你在中控机已经安装好了 docker 命令，且 registry 也是中控机，端口为 5500。

则可以在中控机拉取如下镜像测试：
``` bash
time docker pull 127.0.0.1:5500/blueking/slug-app:v1.1.0-beta.27
```
当拉取成功，说明代理工作正常。

此时可以删除 dockerd 的镜像缓存，然后重新拉取：
``` bash
docker rmi 127.0.0.1:5500/blueking/slug-app:v1.1.0-beta.27
time docker pull 127.0.0.1:5500/blueking/slug-app:v1.1.0-beta.27
```
可以观察到，第二次拉取耗时比第一次低，因为此时镜像已经缓存到了 registry 的本地磁盘。

当你的 k8s 集群存在多个 node 时，可以节约公网传输耗时。

# 导入镜像到 registry
如果你使用了已有的内网镜像，可以提前下载镜像并推送到 registry 上。后续即可在内网部署了。

TODO 镜像导入脚本，参考部署次序串行下载镜像。
