# 变更域名

安装部署后，网络管理默认跟蓝鲸基础环境使用的顶级域名保持一致 (bktencent.com)，如果需要修改成其他的域名。例如换成 bktencent.org，可以按以下步骤进行：

下述操作以蓝鲸默认目录为准，操作过程中请以实际目录路径为准。

1. 变更 bknetwork 域名配置项

    ```bash
    echo "BK_NETWORK_PUBLIC_URL=http://bknetwork.bktencent.org:80" >> /data/install/bin/03-userdef/bknetwork.env
    ```

    渲染至 04-final/bknetwork.env

    ```bash
    cd /data/install
    ./bin/merge_env.sh bknetwork
    ```

2. 同步脚本目录至所有机器

    ```bash
    ./bkcli sync common
    ```

3. 更新 bknetwork 的 kv

    ```bash
    source /data/install/utils.fc

    #确认是否已加载正确的值
    echo  $BK_NETWORK_PUBLIC_URL

    # 更新 kv
    consul kv put bkcfg/fqdn/bknetwork $(awk -F'[:/]' '{ print $4}' <<<"${BK_NETWORK_PUBLIC_URL}")

    # 确认是否更新成功
    consul kv get bkcfg/fqdn/bknetwork  
    ```

4. 修改 bknetwork 配置文件

    ```bash
    # 登陆至网络管理机器
    ssh $BK_NETWORK_IP

    # 文件末尾处蓝鲸配置处进行修改 bknetwork 的域名，包括 paas、cmdb 的 host
    vim /data/bkce/bknetwork/nop/conf/application.yml
    ```

5. 更新 /etc/hosts 中原 paas 域名为新的域名

    ```bash
    vim /etc/hosts
    ```

6. 重启网络管理

    ```bash
    # 网络管理机器上执行
    systemctl restart bk-network.target
    ```

7. 修改 SaaS 链接

    ```bash
    # 中控机执行，请使用实际过程中的域名替换指引的案例域名
    mysql --login-path=mysql-default -e "use open_paas; update paas_usefullinks set link='http://bknetwork.bktencent.org' where name='网络管理';"
    ```
