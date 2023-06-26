## Q1 在页面删除制品后，空间没有得到释放

制品库删除了文件不会立即清理真实的存储文件，会有定时任务延迟一段时间释放磁盘空间。默认删除文件后14天会清理磁盘空间。

如要修改释放时间，编辑文件  /data/bkce/etc/repo/repository.yaml ，写入

```server:
server:
  port: 25901
repository:
  deletedNodeReserveDays: 2
```

随后重启 repository 服务。

并且在 consul 页面进行检查，是否成功修改了配置，如未成功修改，请进行修改

![](../../assets/repo_consul.png)