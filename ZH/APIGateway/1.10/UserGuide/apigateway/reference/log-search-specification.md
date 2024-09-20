# 网关 API 请求日志查询规则

## 高级查询

除了使用关键字进行模糊搜索外，日志检索还支持更复杂的高级查询。
你可以使用 `client_ip:xx.xx.xx.xx` 这样的语法来查询具体字段，同时组合 `AND`、`OR` 等关键字来完成更复杂的查询。 比如：

- 查询结果码不是 200 的请求: **NOT status:200**
- 查询特定 IP 的所有 POST 请求: **client_ip:xx.xx.xx.xx AND method:POST**

更多查询语法说明请参考 [elasticsearch query string 语法说明](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html#query-string-syntax)。

### 日志查询所有字段名称

<style tyle="text/css">
table {width: 50%}
</style>

字段含义 | 字段名称
--- | ---
请求ID | request_id
环境 | stage
资源ID | resource_id
蓝鲸应用 | app_code
客户端IP | client_ip
请求方法 | method
请求域名 | http_host
请求路径 | http_path
后端请求方法 | backend_method 
后端Scheme | backend_scheme
后端域名 | backend_host
后端路径 | backend_path
状态码 | status
请求后端耗时 | backend_duration
