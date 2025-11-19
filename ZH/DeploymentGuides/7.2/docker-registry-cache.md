# 缓存容器镜像

在部署过程中，需要联网拉取镜像。如果公网带宽过低，则拉取镜像会消耗更多时间，甚至导致部署超时。

蓝鲸现已全面支持内网缓存镜像。在接下来的部署操作中，都会提示如何使用缓存镜像。

本文提供提前拉取镜像

我们提供 2 种方法：
1. 推荐：部署具备缓存能力的代理服务器。本文使用 docker 官方的 `registry:2` 作为示例。
2. 提前下载镜像并导入到内网 registry。本文会提供脚本方便你下载及推送镜像。

请查阅下面对应的章节。

## 方案 1：使用具备缓存能力的代理服务器
### 部署 docker-registry-v2
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


### 验证 registry 里的镜像
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

## 方案 2：提前下载镜像并导入

### 获取镜像列表

您可以根据需要获取不同范围的镜像列表：

获取当前部署所需的镜像列表（依赖现有 values 配置）
```bash
bkdl-7.2-stable.sh -ur latest bkhelmfile -i $HOME # 获取部署脚本
cd $INSTALL_DIR/blueking
scripts/list_all_image.sh helmfile # 获取部署所需镜像文件
```

获取全量镜像列表（可选）
```bash
awk '{for(i=3;i<=NF;++i) printf $i" "; print ""}' $(bkdl-7.2-stable.sh -r latest chart-images |& awk '/chart-images.txt/{path=$NF; sub(/\.$/, "", path); print path}')
```

### 导入镜像到内网 registry
如果你的内网已经存在 docker registry，可以提前下载镜像并推送到 registry 上。后续即可在内网部署了。

>**注意**
>
>不建议导入镜像到 k8s node，因为 pod 可能迁移，因此无法预测 node 上的镜像。如果全量镜像都导入，会占用大量磁盘空间。内网传输已经足够大了，所以使用内网 registry 是一个方便维护的选择。
