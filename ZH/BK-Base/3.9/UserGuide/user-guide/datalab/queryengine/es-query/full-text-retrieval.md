# 全文检索

## 检索规则

* 关键词检索

  检索包含某个关键词的记录
> 示例：例如检索关键词是 “error”
> 结果：返回某段时间范围的包含 “error” 的记录，时间范围可以选择


* 模糊检索

  检索符合模糊匹配的记录。‘?’ 代替一个字符，‘*’ 代替 0 或多个字符
> 示例：例如模糊检索关键词 “logi?err*”
> 结果：返回 logi 和 err 之间有一个字符，err 后面有 0 个或多个字符的记录


* 字段检索

  检索样式如，“字段名称:检索关键词”，检索字段内容中包含关键词的记录（字段类型要求是字符串类型） 
> 示例：例如检索语句是 “log:error”
> 结果：返回字段名称为 log，log 中包含 error 的记录


* 组合检索

  检索样式如，“检索关键词 1 检索关键词 2”，两个关键词作为整体进行搜索，不做切分
> 示例：例如检索语句是 “login error”
> 果：返回包含 "login error" 的记录


* AND 检索

  检索样式如，“检索关键词 1 AND 检索关键词 2”，返回符合关键词 1 和关键词 2 的记录
> 示例：例如检索语句是 ip:"1.1.1.1" AND log:"error"
> 结果：返回 ip 为 1.1.1.1 并且 log 中包含 error 的记录


* OR 检索

  检索样式如，“检索关键词 1 OR 检索关键词 2”，返回符合关键词 1 或关键词 2 的记录
> 示例：例如检索语句是 ip:"1.1.1.1" OR log:"error"
> 结果：返回 ip 为 1.1.1.1 或 log 中包含 error 的记录


* NOT 检索

  检索样式如，“检索关键词 1 NOT 检索关键词 2”，返回符合关键词 1，但不符合关键词 2 的记录
> 示例：例如检索语句是 ip:"1.1.1.1" NOT log:"error"
> 结果：返回 ip 为 1.1.1.1，但 log 中不包含 error 的记录



 *注意事项*：

 * 搜索的内容中如果包含\ + - && || ! () {} [] ^" ~ * ? : \等字符，需要加反斜杠\转义，如\\"关键词。

 * 以上查询语法为常用查询，如使用其他查询，可参考:
    https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html#query-string-syntax
