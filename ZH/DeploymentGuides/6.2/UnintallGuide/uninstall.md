# 蓝鲸卸载指引

为了防止误操作，卸载蓝鲸不支持批量，请自行批量操作，下面介绍一台机器卸载的方法：

建议先卸载其他节点的机器，最后卸载中控机节点。

- 拷贝 uninstall.sh 到上一层

```bash
cd /data/install
cp uninstall/uninstall.sh . 
```

- 根据提示，确认后开始清理操作。

```bash
bash uninstall.sh
```
