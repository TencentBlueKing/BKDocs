# 检索语法指南

在日志检索当中，使用了标准的 Elasticsearch Query String，基本支持所有语法。下面是基础的语法介绍。

## Query String 简介

查询语句，使用的是ES Query String语法，查询时候，可以按照一定的规则进行查询，如查询log字段包含2189988 of user的日志关键字，则可以使用查询语句为 log: "2189988 of user"，其中log表示日志中存在一个字段叫log，冒号是查询的语法，双引号里面的字符是待查询的关键词。

![](media/16619446106736.jpg)

对于简单的检索，直接使用上述查询即可，但对于复杂的查询，里面包含特殊符号的查询，则直接输入关键字是无法正常查询的，为了更好的理解查询语句，请参考后文的介绍。

```
日志检索使用的是elasticsearch默认分词器(Standard Analyzer)，按空格对词切分，小写处理，对于特殊符号，如+ - = && || >< ! ( ) { } [ ] ^ " ~ * ? : \ / 等特殊符号（见后文详说），将不能被匹配搜索
```

### Query String 语法 


```
注：由于大多数日志字段名称是log，此处举例使用log字段
```

在搜索的时候，如果没有指定搜索的字段，就默认搜索 _all field, 其中包含了所有 field 的值，此时ES扫描的范围将会很大，查询效率将不高，故建议按照特定字段进行检索，以提高检索速度。

### 区分 分词 和 字符串

* 分词：是ES的一个特性，也是需要学习的一个门槛
* 字符串：能支持正则，但是严格的一种正则语法，所以也是需要注意。

注意：不同的字段类型，其支持查询语法不一样

## 分词

分词是将日志文本分成词汇方式，便于更快的检索。分词器 接受一个字符串作为输入，将这个字符串拆分成独立的词或 语汇单元（token） （可能会丢弃一些标点符号等字符），然后输出一个 语汇单元流（token stream） 

原始日志

`blueking@foo-bar.com|[abc] &`

分词后的字段

```
blueking
foo
bar.com
abc
```

其中`@ |  ]   [ &`这几个特殊符号被忽略处理，也就是搜索的时候会不被匹配

例如原始日志如下所示

```
"ERROR [2022-01-05 15:04:43] /data/bkee/bknodeman/nodeman/apps/backend/subscription/tasks.py 430 wrapper 18302 140333498185536 [3800009] 订阅任务实例为空，不再创建订阅任务 Traceback (most recent call last): File \"/data/bkee/bknodeman/nodeman/apps/backend/subscription/tasks.py\", line 428, in wrapper func_result = func(subscription, subscription_task, *args, **kwargs) File \"/data/bkee/bknodeman/nodeman/apps/backend/subscription/tasks.py\", line 555, in run_subscription_task_and_create_instance subscription, subscription_task, instances, instance_actions, preview_only=preview_only File \"/data/bkee/.envs/bknodeman-nodeman/lib/python3.6/site-packages/celery/local.py\", line 191, in __call__ return self._get_current_object()(*a, **kw) File \"/data/bkee/.envs/bknodeman-nodeman/lib/python3.6/site-packages/celery/app/trace.py\", line 705, in __protected_call__ return orig(self, *args, **kwargs) File \"/data/bkee/.envs/bknodeman-nodeman/lib/python3.6/site-packages/celery/app/task.py\", line 393, in __call__ return self.run(*args, **kwargs) File \"/data/bkee/bknodeman/nodeman/apps/backend/subscription/tasks.py\", line 213, in wrapper raise err File \"/data/bkee/bknodeman/nodeman/apps/backend/subscription/tasks.py\", line 206, in wrapper func_return = create_task_func(subscription, subscription_task, *args, **kwargs) File \"/data/bkee/bknodeman/nodeman/apps/backend/subscription/tasks.py\", line 375, in create_task raise SubscriptionInstanceEmpty() apps.backend.subscription.errors.SubscriptionInstanceEmpty: [3800009] 订阅任务实例为空，不再创建订阅任务"
```

经过standard分词后的词如下，这些词都是可以检索的关键字，不在此处的词，是不能被检索的

```
error, 2022, 01, 05, 15, 04, 43, data, bkee, bknodeman, nodeman, apps, backend, subscription, tasks.py, 430, wrapper, 18302, 140333498185536, 3800009, 订, 阅, 任, 务, 实, 例, 为, 空, 不, 再, 创, 建, 订, 阅, 任, 务, traceback, most, recent, call, last, file, data, bkee, bknodeman, nodeman, apps, backend, subscription, tasks.py, line, 428, in, wrapper, func_result, func, subscription, subscription_task, args, kwargs, file, data, bkee, bknodeman, nodeman, apps, backend, subscription, tasks.py, line, 555, in, run_subscription_task_and_create_instance, subscription, subscription_task, instances, instance_actions, preview_only, preview_only, file, data, bkee, envs, bknodeman, nodeman, lib, python3.6, site, packages, celery, local.py, line, 191, in, __call__, return, self, _get_current_object, a, kw, file, data, bkee, envs, bknodeman, nodeman, lib, python3.6, site, packages, celery, app, trace.py, line, 705, in, __protected_call__, return, orig, self, args, kwargs, file, data, bkee, envs, bknodeman, nodeman, lib, python3.6, site, packages, celery, app, task.py, line, 393, in, __call__, return, self.run, args, kwargs, file, data, bkee, bknodeman, nodeman, apps, backend, subscription, tasks.py, line, 213, in, wrapper, raise, err, file, data, bkee, bknodeman, nodeman, apps, backend, subscription, tasks.py, line, 206, in, wrapper, func_return, create_task_func, subscription, subscription_task, args, kwargs, file, data, bkee, bknodeman, nodeman, apps, backend, subscription, tasks.py, line, 375, in, create_task, raise, subscriptioninstanceempty, apps.backend.subscription.errors.subscriptioninstanceempty, 3800009, 订, 阅, 任, 务, 实, 例, 为, 空, 不, 再, 创, 建, 订, 阅, 任, 务
```

可以看到`+ - = && || >< ! ( ) { } [ ] ^ " ~ * ? : \ /` 特殊字符，是不会进行分词的，直接被standard分词器无视了，而不属于特殊字符的点`(.)`下划线`( _ )`,则会当做词的一部分进行处理

搜索词

```
log: "/data/bkee/bknodeman/nodeman/apps/backend/subscription/tasks.py"
```

搜索结果
![](media/16619452860147.jpg)



分词特殊情况，如

```
原日志
I'm blueking 'log'.
standard分词之后
i'm
blueking
log

#如果有ES环境，可以通过ES接口查询分析，最后一个点被去掉了，这是standard的默认行为

GET _analyze
{
"analyzer": "standard",
"text":"I'm blueking 'log'."
}
```


### 如何判断是否被分词

当类型为**文本**时，表示该字段经过了分词，需要按**分词规则**进行检索

 **文本**，说明该字段是被分词过的，可以支持按词进行搜索，如遇到特殊符号，则无法匹配
![](media/16619453368450.jpg)

点击鼠标到词上，如果该词可以高亮，则说明该词是可以用于关键词的搜索

![](media/16619453738647.jpg)


### 规则1：关键字查询

**字段名：被分词的关键字**

`log：ERROR `    #搜索log字段包含ERROR的日志

### 规则2：精确查询-带双引号

**字段名："精确匹配的完整字符串"**

`log: "ERROR MSG"` #搜索log字段包含“ERROR MSG”的日志

### 规则3：布尔查询 AND、OR

```
 字段名：(关键字1 OR 关键字2)    #默认是OR，（）可以省略
 字段名：(关键字1  关键字2)      #默认是OR
 字段名：(关键字1  AND 关键字2)  #同时存在关键字1和关键字2 
 字段名：(关键字1  AND 关键字2 AND NOT 关键字3)   #同时存在关键字1和关键字2，但不包含关键3
```

`log: (ERROR OR INFO)`     #等同于  log: ERROR OR    log: INFO
`log: (ERROR INFO)`        #等同于  log: ERROR OR    log: INFO
`log: (ERROR AND INFO)`    #等同于 log: ERROR AND  log: INFO
`log: (ERROR AND INFO  AND NOT panic)`  #等同于 `log: ERROR AND  log: INFO NOT log: panic`

> 注意：AND可以写为 &&，OR也可以写为 ||，NOT可以写为 ! , `log: (ERROR && INFO && !panic)`

### 规则4：布尔查询 关键字存在+，不存在-

`字段名：关键字1 关键字2 +关键字3 -关键字4`    #搜索 `关键字1` OR `关键字2` 其中一个存在，并且`关键字3`也同时存在，但`关键字4`不存在

等同于：`((关键字1 AND 关键字3) OR (关键字2 AND 关键字3)  OR 关键字3 ) AND NOT 关键字4`

### 规则5：字段有空格

遇到字段有空格的，需要转义

`first\ name: Alice`

### 规则6：嵌套字段

嵌套字段的搜索，可以使用*匹配，如msg.title，msg.content 或 msg.date中包含ERROR或者INFO，则可以如下写

`msg.\*: (ERROR OR INFO)`

### 规则7：字段存在

 查询存在某个字段的日志

`_exists_: cloudId`

### 规则8：通配符

通配符有?和* 

```
？匹配一个字符
* 匹配0个或多个字符
```

> 注意：通配符将会消耗ES的大量内存，执行效率不高，如将*放在开头，查询效率严重降低，请谨慎使用。

### 规则9：fuzzy模糊查询

fuzzy查询是一种模糊查询，会根据检索词和检索字段的编辑距离（Levenshtein Distance）来判断是否匹配。一个编辑距离就是对单词进行一个字符的修改，这种修改可能是

* 修改一个字符，比如box到fox
* 删除一个字符，比如black到lack
* 插入一个字符，比如sic到sick
* 交换两个相邻的字符的位置，比如act到cat

在进行fuzzy搜索的时候，ES会生成一系列的在特定编辑距离内的变形，然后返回这些变形的准确匹配。默认情况下，当检索词的长度在0..2中间时，必须准确匹配；长度在3..5之间的时候，编辑距离最大为1；长度大于5的时候，最多允许编辑距离为2。

如果是模糊搜索，则可以使用~符号进行匹配，使用Damerau-Levenshtein距离找到所有最多只有两个变化的术语，其中一个变化是单个字符的插入，删除或替换，或两个相邻字符的变换。

如下所示

```
log: bl* AND log

bl log search
blu log search
blue log search
bluek log search
blueki log search
bluekin log search
blueking log search

blue~2 匹配bl,blu,blue,bluek,blueki之间的词字符，从~开始算起(不包含~所在位置），向前减去2个字符，即bl，blu,blue匹配，先后加2个字符(从~所在位置算起)，即bluek,blueki匹配
log: blue~2 AND log

匹配的结果是

bl log search
blu log search
blue log search
bluek log search
blueki log search

log: blue~4 AND log 因为最多匹配2个字符，所以和log: blue~2 AND log效果相同

同理blue~，匹配blu,blue,bluek，从~开始算起，前后各1个字符的词匹配,和log: blue~1 AND log等同，长度在3..5之间的时候，编辑距离最大为1

log: blue~ AND log
blu log search
blue log search
bluek log search

长度大于5的时候，最多允许编辑距离为2，log: bluekin~ AND log 和log: bluekin~2 AND log 等同

log: bluekin~ AND log 
bluek log search
blueki log search
bluekin log search
blueking log search


长度大于5的时候，最多允许编辑距离为2

log: bluekin~3 AND log
bluek log search
blueki log search
bluekin log search
blueking log search
```

### 规则10: 邻近搜索

邻近查询允许搜索词与日志具有不同的出现顺序和位置。

例如原始日志为blueking log search

如果我们的搜索语句为log: "log blueking" ，则此时将无法搜索出日志，但使用临近搜索方法，虽然次序不同，但通过匹配是可以搜索出的。

可以搜索出日志查询语法

`log: "log blueking"~2`
`log: "search blueking"~3`

不能搜索出日志的查询语法

`log: "log blueking"~1`
`log: "search blueking"~2`

### 规则11：正则匹配

正则表达式模式嵌套可以再 Query String 中使用，使用时需要将查询内容包裹在两个正斜杠中（“/”）。

例如匹配log字段中的字符串Mozilla，则可以这么写

`log: /[L-N].*z*l{2}a/ `

关于正则匹配的更多语法，参考本文后部分

### 规则12：范围查询

范围查询是针对**时间**、**数字**和**字符串**类型的字段使用的。范围查询的操作符主要是 [] 和 {}，其中 [] 是闭合查询，{} 非闭合查询。

查询code在200到600之间的数据

`code: [ 200 TO 600 ]`     

查询code大于等于200的数据

`code: [ 200 TO * ] `   

查询code小于等于600的数据

`code: [ * TO 600 ] `  

查询时间范围

`timestamp: [2021-08-01T19:56:00 TO 2021-08-01T22:00:00]`

查询 Bytes 字段从 8023 到 9057 区间内的数据，不包含 9057

`bytes: [8823 TO 9057}`

一侧无界的范围，可以使用如下语法

```
code: > 200
code: >=  200
code: < 500
code: <= 500
```

### 规则13：条件分组

使用`()`对查询语句进行分组，最外层括号的优先匹配

`((关键字1 AND 关键字3)  OR (关键字2 AND 关键字3) OR 关键字3 ) AND NOT 关键字4`

### 规则14：特殊符号

特殊符号，如`+ - = && || >< ! ( ) { } [ ] ^ " ~ * ? : \ / `，其用途举例如下，不可以当做查询语句，因为默认的分词器不会将他们分词，具体请参考分词

```
+ 表示AND操作
| 表示OR操作
-  表示否定
" 用于圈定一个短语
* 放在token的后面表示前缀匹配
() 表示优先级
~N 放在token后面表示模糊查询的最大编辑距离fuzziness
~N 放在phrase后面表示模糊匹配短语的slop值
[ ] 范围查询，包含开始和结束
{} 范围查询，不包含开始和结束
// 正则匹配
```



## 字符串搜索 【字符串】

![](media/16619453863893.jpg)

字符串，表示该字段是未经过分词的，可以查询特殊符号，如

使用双引号搜索

`path: "/data/bkee/logs/nginx/paas_api_access.log"`

转义特殊符号

`path: \/data\/bkee\/logs\/nginx\/paas_api_access.log`

转义，并加上*匹配

`path: \/data\/bkee\/logs\/nginx\/paas_api_access*`

使用正则搜索，匹配[l-n]

`path: /\/data\/bkee\/logs\/nginx\/paas_api_access.[a-z]og/`

#### 无法搜索出日志

双引号里面加*，则无法匹配，因为双引号表示精确匹配的文本

`path: "/data/bkee/logs/nginx/paas_api_access*"`

不使用双引号，也不进行转义，则不符合搜索语法，而无法进行搜索

`path: /data/bkee/logs/nginx/paas_api_access.log`


### 正则表达式语法

正则表达式查询由 `regexp` 和 `query_string` 查询支持。 Lucene 正则表达式引擎不兼容 Perl ，但支持较小范围的运算符。

#### 锚定

大多数正则表达式引擎允许您匹配字符串的任何部分。如果你希望正则表达式模式从字符串的开头开始或者在字符串的结尾处结束，那么你必须具体地锚定它，使用 `^` 表示开头或使用 `$` 表示结束。

`Lucene` 的模式总是锚定的。提供的模式必须匹配整个字符串。对于字符串 “abcde” ：

```
ab.*     # 匹配
abcd     # 不匹配
```

#### 允许的字符

任何 Unicode 字符都可以在模式中使用，但某些字符是保留的，必须进行转义。标准保留字符为：

`. ? + * | { } [ ] ( ) " \`

如果启用可选功能（见下文），则还可以保留这些字符：

`# @ & < >  ~`

任何保留字符都可以使用反斜杠 `\ *` 转义，其中包括一个字面反斜杠字符：`\`

此外，任何字符（双引号除外）在用双引号括起时，将被逐字解释：

`john"@smith.com"`

#### 匹配任意字符

字符 `.` 可以用来表示任何字符。对于字符串 “abcde” ：

```
ab...   # 匹配
a.c.e   # 匹配
```

#### 匹配一个或多个

加号 `+` 可以用于重复小先前模型一次或多次。对于字符串 “aaabbb” ：

```
a+b+        # 匹配
aa+bb+      # 匹配
a+.+        # 匹配
aa+bbb+     # 匹配
```

#### 匹配零个或多个

星号 `*` 可以用于匹配小先前模型零次或多次。对于字符串 “aaabbb” ：

```
a*b*        # 匹配
a*b*c*      # 匹配
.*bbb.*     # 匹配
aaa*bbb*    # 匹配
```

#### 匹配零个或一个

问号 `?` 使得先前模型是可选的。它匹配零或一次。对于字符串 “aaabbb” ：

```
aaa?bbb?    # 匹配
aaaa?bbbb?  # 匹配
.....?.?    # 匹配
aa?bb?      # 不匹配
```

#### 最小最大匹配次数

大括号 `{}` 可以用于指定前一先前模型可以重复的最小和最大（可选）次数。允许的形式是：

```
{5}     # 重复匹配5次。
{2,5}   # 重复匹配最小2次，最多5次。
{2,}    # 重复匹配最小2次。
```

例如字符串 "aaabbb" ：

```
a{3}b{3}        # 匹配
a{2,4}b{2,4}    # 匹配
a{2,}b{2,}      # 匹配
.{3}.{3}        # 匹配
a{4}b{4}        # 不匹配
a{4,6}b{4,6}    # 不匹配
a{4,}b{4,}      # 不匹配
```

#### 分组

括号 `()` 可以用于形成子模型。上面列出的数量运算符以最短的先前模型操作，它可以是一个组。对于字符串 “ababab” ：

```
(ab)+       # 匹配
ab(ab)+     # 匹配
(..)+       # 匹配
(...)+      # 不匹配
(ab)*       # 匹配
abab(ab)?   # 匹配
ab(ab)?     # 不匹配
(ab){3}     # 匹配
(ab){1,2}   # 不匹配
```

#### 交替

管道符号 `|` 作为 `OR` 运算符。如果左侧或右侧的模式匹配，匹配将成功。交替适用于 longest pattern （最长的模型），而不是最短的。对于字符串 “aabb” ：

```
aabb|bbaa   # 匹配
aacc|bb     # 不匹配
aa(cc|bb)   # 匹配
a+|b+       # 不匹配
a+b+|b+a+   # 匹配
a+(b|c)+    # 匹配
```

#### 字符类

潜在字符的范围可以通过将它们包围在方括号 `[]` 中来表示为字符类。前导 `^` 排除字符类。允许的形式是：

```
[abc]   # 'a' or 'b' or 'c'
[a-c]   # 'a' or 'b' or 'c'
[-abc]  # '-' or 'a' or 'b' or 'c'
[abc\-] # '-' or 'a' or 'b' or 'c'
[^abc]  # any character except 'a' or 'b' or 'c'
[^a-c]  # any character except 'a' or 'b' or 'c'
[^-abc]  # any character except '-' or 'a' or 'b' or 'c'
[^abc\-] # any character except '-' or 'a' or 'b' or 'c'
```

请注意，破折号“ - ”表示一个字符范围，除非它是第一个字符或者使用反斜杠转义。

例如字符串 "abcd"：

```
ab[cd]+ # 匹配

[a-d]+   # 匹配

[^a-d]+ # 不匹配
```

更多内容请参考[2]


查询语法：https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html#_field_names

正则语法：https://www.elastic.co/guide/en/elasticsearch/reference/current/regexp-syntax.html


