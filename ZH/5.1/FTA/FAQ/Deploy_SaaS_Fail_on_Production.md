# APP 部署失败

## 测试环境 APP 部署失败

后台只有正式环境，所以 APP 不支持测试环境部署

![-w960](../assets/15675011122718.jpg)
<center>图 1. 测试环境部署故障自愈 APP 失败</center>

## 正式环境 APP 部署失败

部署后台的时候没有执行初始化数据的步骤：

`./bkcec initdata fta   //社区版`

![-w958](../assets/15675011237028.jpg)
<center>图 2. 正式环境部署故障自愈 APP 失败</center>
