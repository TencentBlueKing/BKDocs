## Q1：bkiam v3 failed

![](../../assets/bkiam_failed.png)

此错误一般是由于机器重启后，权限中心SaaS 未启动导致的。需要手动拉起 SaaS

中控机执行 ``` /data/install/bkcli start saas-o```

其他机器重启的需要的操作，请查看  [机器重启](../../../../../DeploymentGuides/6.1/产品白皮书/维护手册/日常维护/host_reboot.md) 



## Q2：点击插件时报错：服务正在部署中，请稍候

![](../../assets/touch_plugin.png)

常见于 mongodb 异常导致。

中控机执行 ``` /data/install/bkcli restart mongod```

随后检查 mongodb 状态是否正常  ``` /data/install/bkcli status mongod```



## Q3: 插件包上传失败（研发商店）

![](../../assets/image-20220301101202-iJWQt.png)

可以先检查下blueking用户能否正常读写 artifactory数据目录: /data/bkce/public/ci/artifactory/

然后检查artifactory日志文件, 看看报错.



## Q4: BKCI添加节点的时候报错 bkiam v3 failed（环境管理）（构建机）

![](../../assets/image-20220301101202-MyIAk.png)

然后根据给出的文档排查了日志

/data/bkce/ci/environment/logs/environment-devops.log

/data/bkce/ci/environment/logs/auth-devops.log

![](../../assets/image-20220301101202-GyIic.png)

排查发现ci auth库下的 T\_AUTH\_IAM\_CALLBACK表 为空

原因是集群初始配置失败，但脚本并没有终止

```
ci初始化
reg ci-auth callback.
[1] 19:29:00 [SUCCESS] 172.16.1.49
{
  "timestamp" : 1626291190535,
  "status" : 500,
  "error" : "Internal Server Error",
  "message" : "",
  "path" : "/api/op/auth/iam/callback/"
}Stderr: * About to connect() to localhost port 21936 (#0)
解决方法：可尝试手动 注册ci-auth的回调.
source /data/install/load_env.sh
iam_callback="support-files/ms-init/auth/iam-callback-resource-registere.conf"
./pcmd.sh -H "$BK_CI_AUTH_IP0" curl -vsX POST "http://localhost:$BK_CI_AUTH_API_PORT/api/op/auth/iam/callback/" -H "Content-Type:application/json" -d @${BK_PKG_SRC_PATH:-/data/src}/ci/support-files/ms-init/auth/iam-callback-resource-registere.conf
```



## Q5: JOOQ;uncategorized SQLException for SQL（研发商店）（插件）

![](../../assets/image-20220301101202-rtxbB.png)

旧sql没有清理的缘故

```
# 清理flag文件, 重新导入全部sql文件
for sql_flag in $HOME/.migrate/*_ci_*.sql; do
chattr -i "$sql_flag" && rm "$sql_flag"
done
# 导入数据库 SQL 仅在中控机执行
cd ${CTRL_DIR:-/data/install}
./bin/sql_migrate.sh -n mysql-ci /data/src/ci/support-files/sql/*.sql
```



## Q6：pipeline start failed 并行上限

![](../../assets/max_parallel_view.png)

单条流水线同时并发在跑任务超过50条，会影响性能，还有可能失败。所以限制。



可以修改数据库限制
update devops_process.T_PIPELINE_SETTING set MAX_CON_RUNNING_QUEUE_SIZE=100 where PIPELINE_ID='${pipeline_id}'; 
建议最大不超过100

---

## Q7:使用流水线文件变量，报错2102004

![](../../assets/var_error_2102004.png)

上传时需要给变量填写包含文件名的完整的路径。该功能依赖于BKCI制品库。