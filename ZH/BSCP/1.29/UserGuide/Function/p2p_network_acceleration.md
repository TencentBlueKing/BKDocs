# P2P网络加速
## 概述
P2P（Peer-to-Peer）是一种网络通信模式，它允许计算机之间直接相互连接和交换数据，而无需通过中央服务器。在P2P网络中，每个计算机（称为节点或对等体）既可以作为客户端，也可以作为服务器，这意味着它们可以直接发送和接收数据，而不必依赖于中心化的服务器

BSCP利用蓝鲸GSE组件实现P2P网络加速，特别适用于处理较大配置文件，如游戏资源文件等场景



## 优势

P2P（Peer-to-Peer）下载相对于传统的客户端-服务器模式下载具有一些显著优势：

* 带宽利用率：在P2P下载中，文件被分割成多个部分并在多个节点之间进行传输，这种方式可以充分利用所有可用的带宽资源，从而显著提高下载速度

* 可扩展性：P2P网络可以轻松扩展以容纳更多的节点。随着节点数量的增加，网络的资源分配和传输能力会相应提高。这使得P2P下载在面对大量客户端请求时仍能保持良好的性能

* 负载分散：在P2P网络中，文件传输的负载分散在多个节点之间，而不是集中在文件服务器上（bkrepo/cos等），这有助于降低文件服务器的压力，减轻网络瓶颈，并提高整体传输速度

* 成本效益：相较于传统的客户端-服务器模式，P2P下载可以降低服务器带宽和硬件成本，因为文件传输的负载分散在多个节点上，P2P网络可以更好地应对流量激增等情况，无需为配置发布时的突发流量与请求次数额外付费



## 前置要求

* bscp-sidecar镜像（容器环境）、节点管理BSCP插件版本需 ≥ v1.3.0

* 服务器必须安装GSE Agent 2.0，如果在容器环境中，只需在集群节点上进行部署即可

* 如果是容器环境，必须接入蓝鲸容器管理平台（BCS），否则无法启用P2P

* 在集群Node上确保添加标签：bkcmdb.tencent.com/bk-agent-id=<bk-agent-id>，通过BCS创建的集群和添加的节点会自动附带此标签，使用以下脚本检查K8S集群中是否存在未带此标签的节点

```bash
# 如果以下命令的输出为空，则表示集群中的所有Node都带有标签bkcmdb.tencent.com/bk-agent-id
# 如果输出不为空，则显示的节点名称表示没有包含bkcmdb.tencent.com/bk-agent-id标签的Node
kubectl get nodes -o json | jq '.items[] | select(.metadata.labels | has("bkcmdb.tencent.com/bk-agent-id") | not) | .metadata.name'

# 如果以上命令输出为空，可以忽略以下操作

# 从节点上获取 bkcmdb.tencent.com/bk-agent-id 值的方法
bk_agent_etc_path=$(ps -ef | awk '/gse_agent/ {sub(/\/gse_agent.conf$/, "", $NF); print $NF}'|tail -1)
bk_agent_id=$(cat ${bk_agent_etc_path}/.agent)
echo ${bk_agent_id}

# 上述命令用于获取bkcmdb.tencent.com/bk-agent-id的值，如果返回的值为空或出现错误，都表示获取失败，此情况建议与 alkaidchen 联系帮助解决问题

# 为没有`bkcmdb.tencent.com/bk-agent-id`标签的节点添加标签，请将`<node_name>`替换为实际的节点名称
kubectl label node <node_name> bkcmdb.tencent.com/bk-agent-id=${bk_agent_id}

# 查看刚刚为节点添加的标签
kubectl get node <node_name> --show-labels|grep 'bkcmdb.tencent.com/bk-agent-id='
```



## 开启条件

启用 P2P 网络加速主要适用于业务单配置文件较大与大量节点拉取配置的场景，以实现更优的文件传输速度，以下是启用 P2P 网络加速的基本条件，以确保实现有效的网络加速：

* 单个配置文件的大小应超过 50 MB
* 客户端实例数量应超过 50 个

【注意】如果不满足上述条件，启用 P2P 后的配置文件下载性能可能不如传统的客户端-服务器模式



## 容器接入方式

【必须】给 BSCP 容器（bscp-init/bscp-sidecar）设置  P2P 相关环境变量

```yaml
# 是否启用 P2P 文件下载加速
- name: enable_p2p_download
  value: 'true'
# 以下几个环境变量在启用 P2P 文件加速时为必填项
# BCS集群ID
- name: cluster_id
  value: BCS-K8S-xxxxx
# BSCP容器名称
- name: container_name
  value: bscp-init/bscp-sidecar
- name: pod_id
  valueFrom:
    fieldRef:
      apiVersion: v1
      fieldPath: metadata.uid
```



【建议】设置节点亲和性，使pod尽量调度到支持 p2p 文件加速的节点

```yaml
affinity:
  # 设置节点亲和性，让 Pod 尽量调度到支持 P2P 网络加速的节点
  nodeAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
    - weight: 1
      preference:
        matchExpressions:
        - key: bkcmdb.tencent.com/bk-agent-id
          operator: Exists
```



下面是一个manifest配置示例，查看更详细的配置示例请参阅产品功能中的“客户端管理 -> 配置示例 -> Sidecar容器”部分

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test-listener
  namespace: default
spec:
  selector:
    matchLabels:
      app: test-listener
  template:
    metadata:
      labels:
        app: test-listener
    spec:
      affinity:
        # 设置节点亲和性，让 pod 尽量调度到支持 p2p 文件加速的节点
        nodeAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 1
            preference:
              matchExpressions:
              - key: bkcmdb.tencent.com/bk-agent-id
                operator: Exists
      initContainers:
        # BSCP init 容器，负责第一次拉取配置文件到指定目录下
        - name: bscp-init
          image: ccr.ccs.tencentyun.com/blueking/bscp-init:v1.3.0
          env:
            # BSCP 业务 ID
            - name: biz
              value: "2"
            # BSCP 服务名称
            - name: app
              value: demo-service
            # BSCP 服务订阅地址
            - name: feed_addrs
              value: "xxx.com:9510"
            # 服务秘钥
            - name: token
              value: "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234"
            # 实例标签
            - name: labels
              value: '{"app":"demo"}'
            # 配置文件临时目录，文件将下发到 {temp_dir}/files 目录下
            - name: temp_dir
              value: '/data/bscp'
            # 是否启用 p2p 文件下载加速
            - name: enable_p2p_download
              value: 'true'
            # 以下几个环境变量在启用 p2p 文件加速时为必填项
            # BCS 集群 ID
            - name: cluster_id
              value: BCS-K8S-xxxxx
            # bscp 容器名称
            - name: container_name
              value: bscp-init
            - name: pod_id
              valueFrom:
                fieldRef:
                  apiVersion: v1
                  fieldPath: metadata.uid
          # 需要同时挂载文件临时目录到 init 容器，sidecar 容器，业务容器
          volumeMounts:
            - mountPath: /data/bscp
              name: bscp-temp-dir
      containers:
        # 业务容器
        - name: test-listener
          image: alpine
          command:
          - "/bin/sh"
          - "-c"
          - |
            apk add --no-cache inotify-tools
            echo "start watch ..."
            while true; do
            # 监听 /data/bscp/metadata.json 的写入事件
            inotifywait -m /data/bscp/metadata.json -e modify |
                while read path action file; do
                    # 递归遍历 /data/bscp/files 目录下的所有文件，输出其绝对路径
                    find /data/bscp/files
                done
            done
          resources:
            limits:
              memory: "128Mi"
              cpu: "500m"
          # 需要同时挂载文件临时目录到 init 容器，sidecar 容器，业务容器
          volumeMounts:
            - mountPath: /data/bscp
              name: bscp-temp-dir
        # BSCP sidecar 容器，负责监听版本变更时间，并更新临时目录下的配置文件，更新完成后向 metadata.json 写入事件
        - name: bscp-sidecar
          image: ccr.ccs.tencentyun.com/blueking/bscp-sidecar:v1.3.0
          env:
            # bscp-sidecar 容器的环境变量配置和 bscp-init 容器完全一致
            - name: biz
              value: "2"
            - name: app
              value: demo-service
            - name: feed_addrs
              value: "xxx.com:9510"
            - name: token
              value: "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234"
            - name: labels
              value: '{"app":"demo"}'
            - name: temp_dir
              value: '/data/bscp'
            # 是否启用 p2p 文件下载加速
            - name: enable_p2p_download
              value: 'true'
            # 以下几个环境变量在启用 p2p 文件加速时为必填项
            # BCS 集群 ID
            - name: cluster_id
              value: BCS-K8S-xxxxx
            # bscp 容器名称
            - name: container_name
              value: bscp-sidecar
            - name: pod_id
              valueFrom:
                fieldRef:
                  apiVersion: v1
                  fieldPath: metadata.uid
          resources:
            limits:
              memory: "128Mi"
              cpu: "500m"
          volumeMounts:
            - mountPath: /data/bscp
              name: bscp-temp-dir
      volumes:
        - name: bscp-temp-dir
          emptyDir: {}
```



