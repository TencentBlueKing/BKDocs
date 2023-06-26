## 数据清洗 FAQ

### 是否可以修改已经使用的字段类型？能否删除和新增字段 

目前平台支持对旧的清洗规则进行修改操作，可以在平台中点击编辑，进行导出字段的新增和删除操作，但是不支持修改字段类型操作。（删掉一个旧的导出字段，并重新创建一个新的同名不同类型字段视作修改操作，不提供支持。）

由于下游可能会有几种已经入库的数据，为了避免数据类型异常，股不支持数据类型修改。有几种替代操作可以考虑：

* 对统一字段导出两次，重新赋值一个不同类型的字段。例如： 【 raw_use_age 导出字符串类型 output_age 】, 可修改为【 raw_use_age 导出字符串类型 output_age ，raw_use_age 导出`整数`类型 int_output_age】
* 在后续的计算流程中使用 `caseas` 操作算子方式进行转换

### 清洗前的数据量和清洗后的数据量不一样，如何查看丢弃的数据，如何做到是什么原因导致丢弃

在配置完清洗规则后，将严格按照清洗规则对数据清洗，如果出现字段对不上，字段类型解析不了等情况，会将原数据数据丢弃。

在清洗详情中提供了查看最近清洗无效数据的接口，如下图所示。

![](./media/clean_drop.png)

### 清洗中的时间字段的作用是什么？如何使用时间字段 

清洗时间字段用做：作为后续存储的分区字段（如 HDFS 这类支持分区的存储），例如 `2020-05-01` 时有一条指定时间字段为 `2020-01-01` 的数据，
如这条数据有对应的入库，在查询时需要在后续 SQL 中指定日期 thedate 为 `2020-01-01` 才可以查询。

平台提供了几种默认清洗格式，如下所示。若上报的字段与下列格式不匹配，请使用正则匹配等方式转换为下列格式：

* yyyy-MM-dd HH:mm:ss
* yyyy-MM-dd HH:mm:ss.SSSSSS
* yyyy-MM-dd'T'HH:mm:ssXXX
* yyyy-MM-dd+HH:mm:ss
* yyyy-MM-dd
* yy-MM-dd HH:mm:ss
* yyyyMMdd HH:mm:ss
* yyyyMMdd HH:mm:ss.SSSSSS
* yyyyMMddHHmm
* yyyyMMddHHmmss
* yyyyMMdd
* dd/MMM/yyyy:HH:mm:ss
* MM/dd/yyyy HH:mm:ss
* Unix Time Stamp(seconds)
* Unix Time Stamp(milliseconds)
* Unix Time Stamp(mins)
* yyyy-MM-dd'T'HH:mm:ss
* yyyyMMddHH
* yyyy-MM-ddTHH:mm:ss.SSSZZZ
* yyyy-MM-ddTHH:mm:ss.SSSSSXXX
* yyyy-MM-ddTHH:mm:ss.SSSSSSXXX
* yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXX

### 清洗之后的大整数为何变成负数了

将一个超过整数范围的数字类型（ java Integer -2147483648 ~ 2147483648 ）设定为整数时，会导致该问题

应将该类型设置为 Long 类型

![](./media/clean-error.png)

### 清洗中的有哪些不可以使用的保留字段 

有着平台预留的关键字，例如：'__time', 'dteventtimestamp', 'dteventtime', 'localtime', 'thedate', 'now', 'offset'

还有各种后续存储中的关键字，例如：

* MySQL 关键字： ADD	ALL	ALTER ANALYZE WHERE AND	AS int8 int16 等，
* Elasticsearch 关键字：abstract	enum int short boolean export interface	static byte	extends	long super char	final native synchronized
* HDFS Druid 等关键字

为避免后续使用中出现问题，请避免使用各种预留关键字。
