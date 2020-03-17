# 社区版V4.1.16/5.0.x 升级V5.1 常见问题指引

- [蓝鲸域名错误恢复指引](https://bk.tencent.com/docs/document/5.1/20/666)
- [蓝鲸开源组件密码错误恢复指引](https://bk.tencent.com/docs/document/5.1/10/250)
- [升级 BKDATA MySQL-Python安装失败问题修复指引](https://bk.tencent.com/docs/document/5.1/10/248)
- 升级 bkdata_update_reserved_dataid 报错
  ```bash
  # 中控机器执行
   /data/src/bkdata/dataapi/databus/tests.py  注释第50行。即`self.update_bizid(blueking_bizid)`
  # 修改后重新执行 bkdata 更新
  ./bkcec upgrade  bkdata  
  ```
![-w2020](../../assets/bkdata_update_reserved_dataid.png)
- 导入 MySQL 备份库失败
  ```bash
  # 如果在升级过程中因为磁盘空间不足导致导入 MySQL 备份库失败，可删除 MySQL 数据目录重新导入
  ./bkcec stop mysql # 停止进程
  ssh $MYSQL_IP
  rm /data/bkce/public/mysql -rf
  # 中控机器重新安装 MySQL并导入
  ./bkcec install mysql
  ./bkcec start mysql
  # 重新导入 MySQL 备份数据，待完成后按照原升级指引继续执行
  ```
- 部署 SaaS 失败
  ```bash
  # 确保蓝鲸官方旧 SaaS 应用都已下架
  # 如果通过后台部署 SaaS 失败由于无法输出具体报错信息，请登陆 web 页面-【开发者中心】-【S-mart】部署新SaaS以便查看具体失败原因
  # setuptools 问题
  ssh $APPO_IP
  vim /data/bkce/paas_agent/paas_agent/etc/build/virtualenv/saas/buildsaas  +134 行
  在`--system-site-packages`  参数后面空格追加 `--no-setuptools` 保存并退出
  # 删除部署失败 SaaS virtualenv
  # APP_CODE等于各蓝鲸官方 SaaS 英文标识符，即（bk_nodemn,bk_monitor）等，根据自己实际情况替换 $APP_CODE
  rm /data/bkce/paas_agent/apps/Envs/$APP_CODE -rf
  rm /data/bkce/paas_agent/apps/projects/$APP_CODE -rf
  ```
