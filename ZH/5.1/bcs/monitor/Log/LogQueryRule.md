# 日志查询规则

*由于字段可能不支持分词，因此，推荐指定字段进行查询，比如 bcs_cluster: BCS-K8S-10000。*

Elasticsearch 日志支持自定义查询，可用选项如下所述。

### 字段名

根据指定字段名进行查询

- 查询 bcs_cluster 为 BCS-K8S-10000 的请求: **bcs_cluster: BCS-K8S-10000**

- 查询嵌套字段 pin.status 为 complete 的请求: **pin.status: complete**

### 通配符

利用通配符查询，用 `?` 表示单个字符，用 `*` 表示 0 或者多个字符

- 查询 bcs_cluster 以 BCS-K8S- 开头的请求: **bcs_cluster: BCS-K8S-\***

### 范围

可以为日期，数字，或字符串字段指定范围。包含范围用方括号 `[min TO max]` 指定，独有范围用大括号 `{min TO max}`指定。

- 查询 gseindex 在 3 到 5 之间的请求 : **gseindex: [3 TO 5]**
- 查询 gseindex 大于 10 的请求: **gseindex: [10 TO \*]**

一边无范围的范围可以使用以下语法：

- **gseindex: >300**
- **gseindex: >=300**
- **gseindex: <300**
- **gseindex: <=300**
- **gseindex: (>=300 AND <600)**

### 布尔运算符

首选运算符为 `+`（必须存在）和 `-`（不得出现），`+`、`-`只影响它右边的字段。

- 查询 bcs_namespace 不包含 bcs-test 的请求: **-bcs_namespace: bcs-test**

支持运算符 `AND`、`OR`、`NOT`（也写作 &&， ||， !），`NOT` 优先于 `AND`、`AND` 优先于 `OR`。

- 查询 bcs_namespace 不是 bcs-test 的请求：**NOT bcs_namespace: bcs-test**
- 查询 bcs_cluster 为 BCS-K8S-10000 并且 stream 为 stderr 的请求: **bcs_cluster: BCS-K8S-10000 AND stream: stderr**
- 查询 bcs_namespace 为 bcs-test 或者 bcs_cluster 为 BCS-K8S-10000 的请求: **bcs_namespace: bcs-test OR bcs_cluster: BCS-K8S-10000**
- 查询 bcs_cluster 为 BCS-K8S-10000 或 BCS-K8S-20000 的请求: **bcs_cluster: (BCS-K8S-10000 OR BCS-K8S-20000)**


更多查询语法说明请参考 [elasticsearch query string 语法说明](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html#query-string-syntax)。
