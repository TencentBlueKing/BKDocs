
## 安装 agent 及插件时的报错

### 执行日志里显示 curl 下载 setup_agent.sh 报错 could not resolv host
#### 表现

执行日志显示：
``` plain
[时间略 INFO] [script] curl http://bkrepo.bkce7.bktencent.com/generic/blueking/bknodeman/data/bkee/public/bknodeman/download/setup_agent.sh -o /tmp/setup_agent.sh --connect-timeout 5 -sSfg
[时间略 ERROR] [3803009] 命令返回非零值: exit_status -> 6, stdout -> , stderr -> curl: (6) Could not resolve host: bkrepo.bkce7.bktencent.com; Unknown error
```

#### 排查处理

目的主机无法解析 bkrepo 域名。请任选一种方案处理：
* 配置目的主机的 hosts（操作文档见 [配置中控机的 DNS](../install-bkce.md#hosts-in-bk-ctrl)），然后**重试出错的任务**。
* 让节点管理今后使用 IP 下载文件（操作文档见 [配置 GSE 环境管理](../manual-install-saas.md#post-install-bk-nodeman-gse-env) ），然后**创建新任务**。


#### 总结

环境问题。

如果你使用了 DNS 提供 bkrepo 域名的解析，可以自行逐级排查 DNS 配置问题。


### 执行日志里显示 curl 下载 setup_agent.sh 报错 Connection timed out
#### 表现

执行日志显示：
``` plain
[时间略 INFO] [script] curl http://服务端地址略/generic/blueking/bknodeman/data/bkee/public/bknodeman/download/setup_agent.sh -o /tmp/setup_agent.sh --connect-timeout 5 -sSfg
[时间略 ERROR] [3803009] 命令返回非零值: exit_status -> 28, stdout -> , stderr -> curl: (28) Connection timed out after 5000 milliseconds
```

#### 排查处理

从节点管理能 SSH 访问到目的主机，但是目的主机无法访问 bkrepo 下载脚本。

前往目的主机测试访问服务端地址。

>**提示**
>
>可以参考上述日志中提示的 curl 命令添加 `-v` 参数： `curl -v 其他参数保持不变`。

如果测试结果依旧为连接超时，可参考如下步骤排查：
1. 检查服务端是否正常：
   1. 当服务端地址填写域名时，需要检查 ingress-nginx：
      1. 核对目的主机上解析域名得到的 IP 是否为当前 ingress-nginx pod 所在 node 的 IP。
      2. 如果是云服务，检查安全组是否放行了 `80` 端口，以及是否限制了入站 IP。
      3. 检查 `ingress-nginx` pod 所在 node 的软件防火墙是否有限制 `80` 端口的入站流量。
      4. 在集群内的其他 node 测试访问 `ingress-nginx` service（`80` 端口），如果超时，可能是 k8s 虚拟网络故障。
   2. 当服务端地址填写 IP 时，需要检查 bkrepo-gateway：
      1. 核对该 IP 是否为 k8s 集群中某个 node 的 IP。
      2. 如果是云服务，检查安全组是否放行了 `30025` 端口，以及是否限制了入站 IP。
      3. 检查 服务端 IP 对应主机上的软件防火墙是否有限制 `30025` 端口的入站流量。
      4. 在集群内的其他 node 测试访问 `bk-repo-bkrepo-gateway` service （`30025` 端口），如果超时，可能是 k8s 虚拟网络故障。
2. 检查目的主机的出站限制：
   1. 检查路由表，可能因网段冲突或路由策略导致出口网卡及源 IP 地址不正确。
   2. 如果是云服务，检查安全组是否有出站限制。
   3. 检查软件防火墙是否有出站限制。
3. 当以上检查均未发现问题，需要检查网络：
   1. 网络路由是否互通。
   2. 中途路由器是否存在 访问控制规则。
   3. 硬件防火墙 是否有拦截策略。

#### 总结

无。


### 执行日志里显示 curl 下载 setup_agent.sh 报错 404 not found
#### 表现

执行日志显示：
``` plain
[时间略 INFO] [script] curl http://服务端地址略/generic/blueking/bknodeman/data/bkee/public/bknodeman/download/setup_agent.sh -o /tmp/setup_agent.sh --connect-timeout 5 -sSfg
[时间略 ERROR] [3803009] 命令返回非零值: exit_status -> 22, stdout -> , stderr -> curl: (22) The requested URL returned error: 404 not found
```

#### 排查处理

在节点管理报错 404 后，登录制品库管理界面，发现文件存在，点击文件详情，取得 sha256。

然后找到了 `bk-repo-bkrepo-storage` pvc 所对应的 pv，检查发现此 pv 中确实没有 `pv目录前缀/store/sha256的2层前缀目录/文件sha256`这个文件。

询问用户得知有卸载 bkrepo，故断定为卸载导致了历史文件丢失。

经 bkrepo 开发确认暂无此场景的修复工具，且重装 `nodeman` 时因为存在数据库记录无法自动重新上传，推测 PaaS 相关文件上传也会如此，故推荐用户卸载整个蓝鲸。

#### 总结

操作不当。

用户 bkrepo 曾卸载，因此导致历史文件丢失。因为暂无工具检查数据不一致的情况，故推荐完整卸载蓝鲸重新部署。


### 执行日志里显示 agent is not connect to gse server
#### 表现

执行日志显示：
``` plain
[时间略 INFO] [script] setup agent. (extract, render config)
[script] request agent config file(s)
[script] gse agent is setup successfully.
[时间略 ERROR] agent(PID: 略) is not connect to gse server
```

#### 排查处理

此问题需进一步排查。

请选择其中一台安装失败的机器。登录到此机器，检查 agent 日志文件： `/var/log/gse/agent-err.log`。

发现日志中大量提示：
   ``` plain
   时间略 (略):ZOO_ERROR@getaddrs@599: getaddrinfo: No such file or directory
   ```
   此报错为无法解析 zk 服务器地址所致，需检查配置文件：`/usr/local/gse/agent/etc/agent.conf`。
   * 如果配置文件中 `.zkhost` 的值是 `"bk-zookeeper:2181"`，说明你遗漏了部署步骤，请在 “节点管理”——“全局配置” 中 [配置 GSE 环境管理](../manual-install-saas.md#post-install-bk-nodeman-gse-env) 。
   * 如果为其他域名，则请自行解决 DNS 解析问题，建议使用 IP。

如有其他情况，请联系助手排查。

#### 总结

操作不当。

用户遗漏了 “节点管理”——“全局配置” 中 [配置 GSE 环境管理](../manual-install-saas.md#post-install-bk-nodeman-gse-env) 步骤。


### 安装插件时下发安装包失败，执行日志显示作业平台 API 请求异常 HTTP 状态码 401
#### 表现

安装插件时在“下发安装包”步骤失败，执行日志显示：
``` plain
时间略 [ERROR] [1306201] [作业平台]API请求异常:(Component request third-party system [JOBV3] interface [fast_transfer_file] error: Status Code: 401, Error Message: third-party system interface response status code is not 200, please try again later or contact component developer to handle this) path => /api/c/compapi/v2/jobv3/fast_transfer_file/
```

#### 排查处理

检查发现 `bk-job-gateway-` 开头的 pod 日志中出现异常：
``` plain
时间略 ERROR [,,] 14 --- [           main] c.t.b.j.g.s.impl.EsbJwtServiceImpl       : Build esb jwt public key caught error!
org.springframework.web.client.ResourceAccessException: I/O error on GET request for "http://bkapi.域名略/api/c/compapi/v2/esb/get_api_public_key": Connect to bkapi.域名略:80 [bkapi.域名略/IP略] failed: connect timed out; nested exception is org.apache.http.conn.ConnectTimeoutException: Connect to bkapi.域名略:80 [bkapi.域名略/IP略] failed: connect timed out
```


#### 总结

待开发排查原因。可能是用户虚拟网络不稳定导致 job 误判或缓存了错误结果。

正式解决办法，请升级到 job-3.6.2 版本。参考 [更新 bk-job](../update.md#更新%20bk-job) 操作。

临时解决办法：重启一次 `bk-job-gateway` pod 即可。在中控机执行如下命令：
``` bash
kubectl rollout restart deployment -n blueking bk-job-gateway
```
