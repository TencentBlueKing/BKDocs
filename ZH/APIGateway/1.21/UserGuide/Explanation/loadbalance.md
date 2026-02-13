## 支持的负责均衡算法

目前网关在配置后端服务时支持的负载均衡轮询算法：

- `roundrobin`: 轮询
- `weight-roundrobin`: 带权重的轮询
- `chash`: 一致性哈希。
- `ewma`: 选择延迟最小的节点，参考 [EWMA_chart](https://en.wikipedia.org/wiki/EWMA_chart)
- `least_conn`: 选择 `(active_conn + 1) / weight` 最小的节点。此处的 `active connection` 概念跟 NGINX 的相同，它是当前正在被请求使用的连接。

## 一致性 hash 配置

### hash_on = vars

设为 `vars` 时，`key` 为必传参数，

目前支持的 NGINX 内置变量有：

- uri
- server_name
- server_addr
- request_uri
- remote_port
- remote_addr
- query_string
- host
- hostname
- `arg_***`，其中 `arg_***` 是来自 URL 的请求参数。详细信息请参考 NGINX 变量列表。

### hash_on = header

设为 `header` 时，`key` 为必传参数

其值为自定义的 Header name。如  `content-type`

### hash_on = cookie

设为 cookie 时，key 为必传参数

其值为自定义的 cookie name。如 `bk_token`

请注意 cookie name 是区分大小写字母的。例如 x_foo 与 X_Foo 表示不同的 cookie。

## reference

- [apisix upstream](https://apisix.apache.org/zh/docs/apisix/admin-api/#upstream-body-request-methods)
