## 检查微服务域名

蓝盾的微服务在启动后，会自动注册 Consul 。域名格式如下： `微服务名-标签.service.consul`。标签即 env 文件里的 `BK_CI_CONSUL_DISCOVERY_TAG`，默认 `devops`。

例如：查询 dispatch 的 DNS 解析结果：
```bash
getent hosts dispatch-devops.service.consul  # 会输出DNS解析结果, 格式为: IP  域名. 如果无输出, 则说明无解析, 需要检查对应服务是否正常.
```
>**提示**
>`getent` 命令来自 `glic-common` 包，一般无需安装。
