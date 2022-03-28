# 部署问题排查
## 常用排查命令（必知必会）
1. 切换当前 context 的 namespace 到 blueking。切换后，后面排查需要指定 `-n blueking` 的命令就可以省略了。
 `kubectl config set-context --current --namespace=blueking` 
2. 部署过程中，查看 pod 的变化情况： `kubectl get pods -w` 
3. 查看 pod 日志： `kubectl logs  -f --tail=xxx`  ，如果 pod 日志较多，加上--tail 防止刷屏
4. 查看 pod 状态不等于 Running 的： `kubectl get pods --field-selector 'status.phase!=Running'。注意job任务生成的pod，没有自动删除的且执行完毕的pod，处于Completed状态。` 
5. pod 状态不是 Running，需要了解原因： `kubectl describe pod <pod_name>` 
6. 有些 pod 的日志没有打印到 STDOUT，需要进入容器查看： `kubectl exec -it  -- bash xxxx` 
7. 访问公共 mysql： `kubectl exec bk-mysql-mysql-master-0 -- mysql -uroot -pblueking`
