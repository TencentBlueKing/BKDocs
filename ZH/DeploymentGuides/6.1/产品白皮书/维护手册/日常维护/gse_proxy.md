# 手动安装 proxy

- 此文档实现方案有别于节点管理 - 手动安装 agent 方案
- 提供网络环境复杂、需要了解安装逻辑的用户使用

## 安装流程

### 1. 安装前准备

**确认接入点配置、访问策略** > **创建云区域** > **导入主机至 cmdb** > **启用 proxy**

### 2. 安装 proxy 简要流程

**同步 proxy 安装包** > **更改配置** > **启动 proxy** > **配置 pagent 安装环境** > **测试验证**

## 安装前准备

1. 确认接入点配置、访问策略
    - 接入点请在节点管理页面配置: http://paas.bktencent.com/o/bk_nodeman/#/global-config/gse-config
    - 访问策略参考: [开通端口](../../../../../NodeMan/2.0/产品白皮书/FAQ/Proxy问题/安装Proxy需要开通哪些端口.md) 
2. 创建云区域
    - 云区域请在节点管理页面创建：http://paas.bktencent.com/o/bk_nodeman/#/cloud-manager
3. 导入主机至 cmdb
    - 限制 1：由于 cmdb 限制，不能直接通过 web 页面的方式导入非直连区域的机器
    - 限制 2：目前版本不能导入手动安装的 proxy 至 节点管理
    - 导入方案：从节点管理中使用安装 proxy，导入 cmdb 后终止任务的方式达到导入的效果
    - 不导入的影响：无法安装 pagent、管理插件
4. 获取对应的业务 ID、云区域 ID
5. 启用 proxy
    - 可参考: [开启Proxy](../日常维护/open_proxy.md) 
## 安装

1. 准备主机
    - 云区域对外通信的代理节点。在非直连的云区域，需要安装 proxy 让蓝鲸可以连接到这个区域下的主机进行管控。为了负载均衡和容灾的考虑，您可以在一个云区域中安装多个 proxy
    - proxy 仅可安装在 liunx 操作系统下
    - 此处准备了一台 centos7.6 机器
1. 同步 proxy 安装包
    - 登录节点管理后台
        ```bash
        source /data/install/utils.fc
        ssh $BK_NODEMAN_IP
        获取： /data/bkce/public/bknodeman/download/gse_proxy-linux-x86_64.tgz
        ```
    - 上传 gse_proxy-linux-x86_64.tgz 至 proxy 机器 /tmp 目录
2. 停止原有 proxy/agent 进程（如未在此机器上安装过 proxy/agent ，则可跳过此步骤）
    - 停止原有 proxy/agent 进程
        ```bash
        # 曾安装 proxy 
        /usr/local/gse/proxy/bin/gsectl stop
        # 曾安装 agent
        /usr/local/gse/agent/bin/gsectl stop
        ```
    - 停止采集器插件进程
        ```bash
        cd /usr/local/gse/plugins/bin
        # 停止该机器上的采集器插件进程
        ls * | grep -v '.sh' | xargs -n 1 -I {} ./stop.sh {}
        # 
        ls * | grep -v '.sh' | xargs -n 1 -I {} pidof {} | xargs kill -9
        ```
    - 移除安装目录
        ```bash
        rm -rf /usr/local/gse
        ```
3. 解压安装包
    ```bash
    mkdir -p /usr/local/gse
    tar xf gse_proxy-linux-x86_64.tgz -C /usr/local/gse
    ```
4. 获取配置文件
    - 默认 gse_proxy-linux-x86_64.tgz 中是不包含任何配置文件。通过节点管理安装时，配置文件是通过节点管理接口生成（http://节点管理后台/get_gse_config）
    - 此次安装将从中控机上 nodeman 后台模块中获取 proxy 配置
        ```bash
        cd /data/src/bknodeman/nodeman/apps/backend/agent/templates
        ls proxy*conf | xargs tar czf proxy_conf.tgz
        ```
5. 更改配置文件
    - 上传 proxy_conf.tgz 至 proxy 机器
    - 解压，重命名配置文件
        ```bash
        tar xf proxy_conf.tgz /proxy/etc/
        rename 'proxy#etc#' '' /usr/local/gse/proxy/etc/*.conf
        mv proxy.conf agent.conf
        ```
    - 修改配置
        将配置中占位符变量（占位有：__、@@）替换为对应的值
        ```bash
        # 路径
        GSE_AGENT_HOME=/usr/local/gse    # gse proxy/agent 安装路径，默认即可
        # ip
        PROXY_LAN_IP=10.0.0.1            # proxy 机器的内网 ip，即可以与 pagent 通讯的 ip
        PROXY_IP0=                       # proxy 机器的内网 ip，即可以与 pagent 通讯的 ip
        PROXY_IP1=                       # 替换为对应第二台 proxy 机器的外网 ip，如果只有单台 proxy ，请把相关行配置删除
        PROXY_WAN_IP=                    # proxy 机器的外网 ip，即可以与 gse server 通讯的 ip
        GSE_WAN_IP0=                     # gse 外网IP，即可以与 proxy 通讯的 ip
        GSE_WAN_IP1=                     # 第二台 gse 外网IP（可选），如果只有单台 gse ，请把相关行配置删除
        EXTERNAL_IP=$PROXY_LAN_IP        # 标识 IP，替换为对应 proxy 机器的内网 ip
        # id                            
        BIZ_ID=                          # 业务 ID，替换为“安装前准备”中获取的业务 ID
        CLOUD_ID=                        # 云区域 ID，替换为“安装前准备”中获取的云区域 ID
        # port
        gse_task 端口                    # 默认版本为企业版端口，社区版请改为对应端口
        gse_btsvr 端口                   # 默认版本为企业版端口，社区版请改为对应端口

        ```
    - 配置修改后，请确认配置内容符合 json 语法
        ```bash
        cat xxx.conf | jq
        ```
5. 同步 gsecmdline
    ```bash
    cp -fp /usr/local/gse/plugins/bin/gsecmdline /bin/
    chmod 775 /bin/gsecmdline
    ```
6. 启动 proxy 进程，启动后可简单测试执行命令、文件分发是否正常
    - 启动
        ```bash
        cd /usr/local/gse/proxy/bin && ./gsectl start
        ```
    - 确认进程已启动：gse_agent、gse_transit、gse_btsvr
    - 启动异常排查：
        1. 日志：/var/log/gse
        2. 进程是否启动
        3. 端口是否监听
        4. 网络策略是否正常
7. 利用作业平台 - 全业务分发 agent 安装包、安装工具、辅助工具（windows）
    - proxy 中将缓存一份 agent 安装包、辅助工具（windows），实际安装时 pagent 将通过 proxy 上的代理服务从 节点管理后台获取对应的安装包、辅助工具（windows）
    - 文件来源
        1. 蓝鲸 bknodeman 机器
        2. 文件列表(默认路径:/data/bkce/public/bknodeman/download/，请按实际更改)
            ```bash
            /data/bkce/public/bknodeman/download/gse_client-windows-x86.tgz
            /data/bkce/public/bknodeman/download/gse_client-windows-x86_64.tgz
            /data/bkce/public/bknodeman/download/gse_client-linux-x86.tgz
            /data/bkce/public/bknodeman/download/gse_client-linux-x86_64.tgz
            /data/bkce/public/bknodeman/download/py36.tgz
            /data/bkce/public/bknodeman/download/nginx-portable.tgz
            /data/bkce/public/bknodeman/download/curl-ca-bundle.crt
            /data/bkce/public/bknodeman/download/curl.exe
            /data/bkce/public/bknodeman/download/libcurl-x64.dll
            /data/bkce/public/bknodeman/download/7z.dll
            /data/bkce/public/bknodeman/download/7z.exe
            /data/bkce/public/bknodeman/download/handle.exe
            /data/bkce/public/bknodeman/download/unixdate.exe
            /data/bkce/public/bknodeman/download/tcping.exe
            ```
    - 传输目标
        1. proxy 机器的 /data/bkce/public/bknodeman/download/ 目录
8. 配置 pagent 安装环境、proxy 上启动正向代理服务
    - pagent 安装时将通过 proxy 的代理通道下载相关安装包
    ```bash
    # 此处逻辑不作赘述，直接复用节点管理脚本
    # proxy 上执行
    /opt/nginx-portable/nginx-portable stop || :;
    rm -rf /opt/nginx-portable/;
    rm -rf /opt/py36/;
    tar xvf /data/bkce/public/bknodeman/download/py36.tgz -C /opt;
    tar xvf /data/bkce/public/bknodeman/download/nginx-portable.tgz -C /opt;
    user=nobody
    group=nobody
    #create group if not exists
    egrep "^$group" /etc/group >& /dev/null
    if [ $? -ne 0 ]; then
        groupadd $group
    fi

    #create user if not exists
    egrep "^$user" /etc/passwd >& /dev/null
    if [ $? -ne 0 ]; then
        useradd -g $group $user
    fi
    echo -e "
    events {
        worker_connections  65535;
    }
    http {
        include       mime.types;
        default_type  application/octet-stream;
        sendfile        on;
        server {
            listen 17980;
            server_name localhost;
            root /data/bkce/public/bknodeman/download;

            location / {
                index index.html;
            }
            error_page   500 502 503 504  /50x.html;
            location = /50x.html {
                root   html;
            }
        }
        server {
            listen 17981;
            server_name localhost;
            resolver `echo $(awk 'BEGIN{ORS=" "} $1=="nameserver" {print $2}' /etc/resolv.conf)`;
            proxy_connect;
            proxy_connect_allow 443 563;
            location / {
                proxy_pass http://\$http_host\$request_uri;
            }
        }
    }" > 
    /opt/nginx-portable/nginx-portable start
    sleep 5
    is_port_listen_by_pid () {
        local pid regex ret
        pid=$1
        shift 1
        ret=0

        for i in {0..10}; do
            sleep 1
            for port in "$@"; do
                stat -L -c %i /proc/"$pid"/fd/* 2>/dev/null \
                | grep -qwFf - <( awk -v p="$port" 'BEGIN{ check=sprintf(":%04X0A$", p)} $2$4 ~ check {print $10}' /proc/net/tcp) \
                || ((ret+=1))
            done
        done
        return "$ret"
    }
    pid=$(cat /opt/nginx-portable/logs/nginx.pid)
    is_port_listen_by_pid "$pid" 17980 17981
    exit $?
    ```
9. 启用插件
    - 通过节点管理 - 插件管理 - 托管