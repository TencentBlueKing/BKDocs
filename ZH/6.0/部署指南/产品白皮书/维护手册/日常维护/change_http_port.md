# 修改蓝鲸入口的 HTTP 访问端口

蓝鲸默认部署的是 http 协议 + 80 端口的访问，比如 http://paas.bktencent.com 。有些用户因为网络原因，需要修改 80 端口为指定的端口，比如 8089。如果与实际环境产生端口冲突，请自行替换。

本文描述修改默认 http 访问端口的方法。

1. 修改和端口变更相关的变量

    ```bash
    source /data/install/utils.fc

    # 从default/global.env 中复制相关变量到 userdef.env 中然后重定义端口
    cat <<EOF >> $CTRL_DIR/bin/03-userdef/global.env 
    # 访问PaaS平台的域名
    BK_PAAS_PUBLIC_URL="http://paas.bktencent.com:8089"
    BK_PAAS_PUBLIC_ADDR="paas.bktencent.com:8089"

    # 访问CMDB的域名
    BK_CMDB_PUBLIC_ADDR="cmdb.bktencent.com:8089"
    BK_CMDB_PUBLIC_URL="http://cmdb.bktencent.com:8089"

    # 访问Job平台的域名
    BK_JOB_PUBLIC_ADDR="job.bktencent.com:8089"
    BK_JOB_PUBLIC_URL="http://job.bktencent.com:8089"
    BK_JOB_API_PUBLIC_ADDR="jobapi.bktencent.com:8089"
    BK_JOB_API_PUBLIC_URL="http://jobapi.bktencent.com:8089"
    EOF

    ./bkcli install bkenv
    ./bkcli sync common

    # 刷新 consul 中存储的值
    consul kv put bkcfg/ports/paas_http 8089
    ```

2. 渲染 PaaS 和 CMDB 配置并重启

    ```bash
    ./bkcli render paas
    ./bkcli restart paas

    ./bkcli render cmdb
    ./bkcli restart cmdb
    ```

3. 渲染 JOB 的配置，并重启

    ```bash
    # 刷新前端index.html调用的api地址
    ./pcmd.sh -m nginx '$CTRL_DIR/bin/release_job_frontend.sh -p $BK_HOME -s $BK_PKG_SRC_PATH -B $BK_PKG_SRC_PATH/backup -i $BK_JOB_API_PUBLIC_URL'

    # 刷新job后台的web.url配置，并重启进程
    ./bkcli render job
    ./bkcli restart job
    ```

4. 重新部署 SaaS，从 PaaS 中获取新的 PUBLIC_URL

    ```bash
    ./bkcli install saas-o 
    ```
