# 更新证书

> 有时候 GSE 和 License 所在服务器的 MAC 地址发生了变化，此时证书需要重新下载，然后操作更新证书的步骤

## 中控机上解压新的证书

```bash
cd /data/src/cert && rm -f *
tar -xvf /data/ssl_certificates.tar.gz -C /data/src/cert/
```

## 中控机执行更新证书动作

> 该动作将会重启 license、gse、job，请酌情操作

```bash
cd /data/install
./bkcli upgrade cert
```

`Proxy` 和 `Agent` 已实现免证书更新，不需执行任何操作。
