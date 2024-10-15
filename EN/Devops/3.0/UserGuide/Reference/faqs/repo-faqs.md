 ## Q1 Space is not released after delete Artifact on the page 

 delete file from the BK-Repo does not Immediately clean up the actual Storage files, and there are Cron that are Delay One period of time free Disk space.  By default, Disk space is cleared 14 days after file are delete. 

 To Revise the release time, edit the file/data/bkce/etc/repo/repository.yaml and write 

```server:
server:
  port: 25901
repository:
  deletedNodeReserveDays: 2
```

 Restart the repository service. 

 Check whether the setting has been Revise Success on the consume page. If not, please modify it 

![](../../assets/repo_consul.png)