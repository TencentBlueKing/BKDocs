# 蓝鲸日常维护

## 更新证书

有时候 GSE 和 License 所在服务器的 MAC 地址发生了变化，此时证书需要重新从官网生成下载，然后操作更新证书的步骤

中控机上解压新的证书

```bash
cd /data/src/cert && rm -f *
tar -xvf /data/ssl_certificates.tar.gz -C /data/src/cert/
```

操作更新相关组件

```bash
source /data/install/utils.fc
for ip in ${ALL_IP[@]}; do
    _rsync -a $PKG_SRC_PATH/cert/ root@$ip:$PKG_SRC_PATH/cert/
    _rsync -a $PKG_SRC_PATH/cert/ root@$ip:$INSTALL_PATH/cert/
done

 for ip in ${JOB_IP[@]}; do
     rcmd root@$ip "gen_job_cert"
 done

./bkcec stop license
./bkcec start license
./bkcec stop job
./bkcec start job
./bkcec install gse 1
./bkcec stop gse
./bkcec start gse
./bkcec stop bkdata
./bkcec start bkdata
./bkcec stop fta
./bkcec start fta
```

Proxy 和 Agent 的更新，需要把新的 cert 目录传到对应机器的路径：

- agent: `/usr/local/gse/agent/cert/`
- proxy: `/usr/local/gse/proxy/cert/`

然后重启进程：

- Proxy 和 Agent 均为：`/usr/local/gse/agent/bin/gsectl restart`
