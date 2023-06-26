# 流水线执行常见错误

## Q1: 流水线在执行中，unity的构建日志不会实时显示

其原因是「脚本中先执行unity编译构建操作，同时将日志写入文件，但在该操作结束前，不会执行后续的cat命令，导致日志无法实时在web页面上显示」。 针对此场景，可尝试以下解决方式：

```
 nohup $UNITY_PATH -quit -batchmode -projectPath $UNITY_PROJECT_PATH -logFile $UNITY_LOG_PATH -executeMethod CNC.Editor.PackageBuilderMenu.BuildPC "${isMono} ${isDevelop} $UNITY_OUT_PATH" & echo $! > /tmp/unity_${BK_CI_BUILD_ID}.pid unity_main_pid=$(cat /tmp/unity_${BK_CI_BUILD_ID}.pid) tail -f --pid ${unity_main_pid} $UNITY_LOG_PATH
```

---

## Q2:ci不显示日志

![](../../../assets/image-20220301101202-xwkmo.png)

查看对应微服务日志 /data/bkce/logs/ci/log/

![](../../../assets/image-20220301101202-bduGg.png)

一个index占了12个shards，超过了es7 设置的shards最大值，这是es7的限制

解决方法：清理一些无用的索引

```
查看目前所有的索引
source /data/install/utils.fc
curl -s -u elastic:$BK_ES7_ADMIN_PASSWORD -X GET http://$BK_ES7_IP:9200/_cat/indices?v
删除索引 # index 是索引名称
curl -s -u elastic:$BK_ES7_ADMIN_PASSWORD -X DELETE http://$BK_ES7_IP:9200/index
# 注意：不能删除 .security-7
```

![](./../../../assets/image-20220301101202-RWPNo.png)

**另一种可能是用户未安装es7**



## Q3：构建任务中插件长时间卡住

插件默认的超时时间为 900min，若超过超时时间仍未终止，通常是 process 或 project 服务出现了异常。

需进入BKCI机器，重启服务 

```systemctl status BKCI-project.service ```

```systemctl status BKCI-process.service``` 

---

## Q4：手动取消构建后，构建未取消或响应时间过长

常见的原因有：

1. BKCI版本更新后，如客户端 Agent 版本未进行相应更新。可能会导致此问题。
2. 确认机器中是否添加了变量 DEVOPS_DONT_KILL_PROCESS_TREE。
3. 如是偶现问题，可能是资源占用过高等原因导致BKCI的 process 进程偶现故障。可以尝试重启 process 进程。
4. 构建机因网络、资源等问题，导致接收进程终止信号缓慢。可检查构建机资源及网络。



## Q5：remote API 远程触发流水线，显示无权限 2101008

![](./../../../assets/remote_error.png)

远程触发是以最后保存流水线的用户来执行流水线的。

最后保存流水线的用户在权限中心被取消权限，则该流水线无法使用remote执行。需要其他有权限的用户来重新保存一下该流水线。



## Q6：执行报错 pipeline start failed 并行上限

![](./../../../assets/max_parallel_view.png)

单条流水线同时并发在跑任务超过50条，会影响性能，还有可能失败。所以限制。



可以修改数据库限制
update devops_process.T_PIPELINE_SETTING set MAX_CON_RUNNING_QUEUE_SIZE=100 where PIPELINE_ID='${pipeline_id}'; 
建议最大不超过100
