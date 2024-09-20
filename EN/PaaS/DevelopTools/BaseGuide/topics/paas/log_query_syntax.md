# 日志查询语法

## 简介

蓝鲸日志用 Elasticsearch 做存储，可以通过 Elasticsearch 的语法查询日志，本文介绍常用的查询语法。

### 关键字查询

查询包含某个关键词的记录，如 `error msg`

- 精确查询：默认会对搜索的关键词进行分词，需要精确匹配，请在关键词上加上英文双引号，如`"error msg"`

### 字段名查询

根据指定的字段名进行查询

- 查询错误级别的日志：`json.levelname:ERROR`
- 查询包含 Traceback 或 error 的日志：`json.message:Traceback error`


### 通配符查询

利用通配符查询，用 ? 表示单个字符，用 * 表示 0 或者多个字符

- 查询以 get_staff 开头的函数产生的日志：`json.funcName:get_staff*`

### 布尔运算符

支持运算符 AND、OR、NOT（也写作 &&， ||， !），NOT 优先于 AND、AND 优先于 OR。
- 查询日志级别不是 ERROR 的日志：`NOT json.levelname:ERROR`
- 查询日志级别为 ERROR 或 CRITICAL 的日志：`json.levelname:(ERROR OR CRITICAL)`
- 查询日志级别为 ERROR 或 消息包含 error 的日志：`json.levelname:ERROR OR json.message:error`
- 查询日志级别为 ERROR 且 函数名为 get_staff_info 的日志：`json.levelname: ERROR AND json.funcName: get_staff_info`

**注意事项**：

- 搜索的内容中如果包含`\ + - && || ! () {} [] ^" ~ * ? : \`等字符，需要加反斜杠\转义，如`\"关键词`。
- 以上查询语法为常用查询，如使用其他查询，可参考: [Elasticsearch query string 语法说明](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html#query-string-syntax)

