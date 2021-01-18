# HTTP 切换 HTTPS

1. 中控机生成 $BK_DOMAIN 的自签名通配符证书（可选），如果有外部签发的合法证书，可拷贝改名到 $BK_PKG_SRC_PATH/cert/bk_domain.{crt,key} 两个文件。文件名的修改是为了匹配 nginx 模板默认名。

    ```bash
    source /data/install/utils.fc

    # 注意：openssl 这是一行命令
    openssl req -x509 -days 365 -out $BK_PKG_SRC_PATH/cert/bk_domain.crt -keyout   $BK_PKG_SRC_PATH/cert/bk_domain.key \
    -newkey rsa:2048 -nodes -sha256 \
    -subj "/CN=*.$BK_DOMAIN" -extensions EXT -config <( \
    printf "[dn]\nCN=*.$BK_DOMAIN\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:*.$BK_DOMAIN\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
    ```

2. 同步并安装证书

    ```bash
    ./bkcli sync cert
    ./bkcli install cert 
    ```

3. 将 BK_HTTP_SCHEMA 修改为 https，同时修改 JOB 的前端 API 地址。然后刷新 consul 中存储的键值，以及重新渲染 JOB 的前端页面。

    ```bash
    source /data/install/utils.fc
    cd $CTRL_DIR

    # 自定义 global.env 配置相关URL和ADDR变量的变更，因为涉及到https切换，80端口也需要改为443

    cat <<EOF >> $CTRL_DIR/bin/03-userdef/global.env 
    BK_HTTP_SCHEMA=https
    # 访问PaaS平台的域名
    BK_PAAS_PUBLIC_URL="https://paas.bktencent.com"
    BK_PAAS_PUBLIC_ADDR="paas.bktencent.com:443"
    BK_PAAS_PRIVATE_ADDR="paas.service.consul:80"
    BK_PAAS_PRIVATE_URL="http://paas.service.consul"
    # 访问CMDB的域名
    BK_CMDB_PUBLIC_ADDR="cmdb.bktencent.com:443"
    BK_CMDB_PUBLIC_URL="https://cmdb.bktencent.com"
    # 访问Job平台的域名
    BK_JOB_PUBLIC_ADDR="job.bktencent.com:443"
    BK_JOB_PUBLIC_URL="https://job.bktencent.com"
    BK_JOB_API_PUBLIC_ADDR="jobapi.bktencent.com:443"
    BK_JOB_API_PUBLIC_URL="https://jobapi.bktencent.com"
    EOF

    ./bkcli install bkenv
    ./bkcli sync common

    # 刷新 consul 中存储的值
    consul kv put bkcfg/global/bk_http_schema https
    ```

4. 渲染PaaS和CMDB配置并重启

    ```bash
    ./bkcli render paas
    ./bkcli restart paas

    ./bkcli render cmdb
    ./bkcli restart cmdb
    ```

5. 渲染job的配置，并重启

    ```bash
    # 刷新前端index.html调用的api地址
    ./pcmd.sh -m nginx '$CTRL_DIR/bin/release_job_frontend.sh -p $BK_HOME -s $BK_PKG_SRC_PATH -B $BK_PKG_SRC_PATH/backup -i $BK_JOB_API_PUBLIC_URL'

    # 刷新job后台的web.url配置，并重启进程
    ./bkcli render job
    ./bkcli restart job
    ```

6. 重新部署SaaS，从PaaS中获取新的BK_HTTP_SCHEMA(https)

    ```bash
    ./bkcli install saas-o 
    ```