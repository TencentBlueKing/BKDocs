
## BKSQL 实时计算语法


BKSQL 语法基本符合 [SQL-92 标准](https://en.wikipedia.org/wiki/SQL-92)，主体语法为一个 Select 语句
```plain
SELECT、FROM、WHERE、LIKE、GROUP BY、DISTINCT
```

####  对比标准 SQL，还存在以下区别

* 目前只支持 Select 语句以及 Insert 语句（实际使用中只用到了 Select 语句），其他如 Create、Update、Alter、Delete 等语句目前不支持；
* 语法上目前还不支持嵌套子查询，子查询通过语句之间的继承关系来实现；

####  数据类型
```plain
STRING, LONG, INT, FLOAT, DOUBLE
```

#### 实时计算函数

##### 比较运算符
```plain
=, <>, >=, >, <=, <, IS NOT NULL, IS NULL

```

#####  算术表达式
```plain
+, -, *, /
```

##### 逻辑运算符
```plain
AND, OR, NOT, IN
```

##### 字符串函数


| 函数名 | CHAR_LENGTH   |
|-------| -----  |
| 说明   |返回字符串中的字符的数量。 |
| 样例   |SELECT  CHAR_LENGTH('dd') as result FROM T1;<br/><br/>result<br/>-------<br/>2|
| 用法   |CHAR_LENGTH(STRING var1)    |
| 返回值 |INT    |
| 备注   |无|


| 函数名 | length|
|-------| ----- |
| 说明 |返回字符串数据的字符长度或二进制数据的字节数。字符串数据的长度包括尾随空格。二进制数据的长度包括二进制零。|
| 样例 |SELECT length('Spark SQL ');<br/><br/>result<br/>-------<br/>10|
| 用法 |length(STRING var1) |
| 返回值 |LONG |
| 备注   |无|


| 函数名 | SUBSTRING   |
|-------| -----  |
| 说明   |获取字符串子串。截取从位置 start 开始，长度为 len 的子串。<br/><br/>start 从 1 开始，为负数时表示从字符串末尾倒序计算位置。<br/><br/> 当不设置第三个参数“选取长度”时，则截取到字符串结尾|
| 样例   |SELECT  SUBSTRING('k1=v1;k2=v2', 2, 2) as result FROM T1;<br/><br/>result<br/>-------<br/>1=|
| 用法   |SUBSTRING(STRING var1, INT start, INT len)    |
| 返回值 |STRING    |
| 备注   |无|


| 函数名 | UPPER   |
|-------| -----  |
| 说明   |返回转换为大写字符的字符串。 |
| 样例   |SELECT  UPPER('ss') as result FROM T1;<br/><br/>result<br/>-------<br/>SS|
| 用法   |UPPER(STRING var1)    |
| 返回值 |STRING    |
| 备注   |无|


| 函数名 | LOWER   |
|-------| -----  |
| 说明   |返回转换为小写字符的字符串。 |
| 样例   |SELECT  LOWER('Ss') as result FROM T1;<br/><br/>result<br/>-------<br/>ss|
| 用法   |LOWER(STRING var1)    |
| 返回值 |STRING    |
| 备注   |无|


| 函数名 | TRIM   |
|-------| -----  |
| 说明   |除掉一个字串中的字头或字尾。最常见的用途是移除字首或字尾的空格。 |
| 样例   |SELECT  TRIM('   Sample   ') as result FROM T1;<br/><br/>result<br/>-------<br/>Sample|
| 用法   |TRIM(STRING var1)    |
| 返回值 |STRING    |
| 备注   |无|


| 函数名 | LTRIM   |
|-------| -----  |
| 说明   |移除字符串左端的空白字符。 |
| 样例   |SELECT  LTRIM('   Sample') as result FROM T1;<br/><br/>result<br/>-------<br/>Sample|
| 用法   |LTRIM(STRING var1)    |
| 返回值 |STRING    |
| 备注   |无|


| 函数名 | RTRIM   |
|-------| -----  |
| 说明   |移除字符串右端的空白字符。 |
| 样例   |SELECT  RTRIM('Sample      ') as result FROM T1;<br/><br/>result<br/>-------<br/>Sample|
| 用法   |RTRIM(STRING var1)    |
| 返回值 |STRING    |
| 备注   |无|


| 函数名 | REPLACE   |
|-------| -----  |
| 说明   | 使用新的子串替换字符串中指定的子串。|
| 样例   |SELECT REPLACE('abcbcd123','bc','www') as result FROM T1;<br/><br/>result<br/>-------<br/>awwwwwwd123|
| 用法   |REPLACE(STRING a, STRING b, STRING c)    |
| 返回值 |STRING    |
| 备注   |无|


| 函数名 | LEFT   |
|-------| -----  |
| 说明   | 从字符串左侧取指定长度的子串。|
| 样例   |SELECT LEFT('abcbcd123', 2) as result FROM T1;<br/><br/>result<br/>-------<br/>ab|
| 用法   |LEFT(STRING a, STRING b)    |
| 返回值 |STRING    |
| 备注   |无|



| 函数名 | RIGHT   |
|-------| -----  |
| 说明   | 从字符串右侧取指定长度的子串。|
| 样例   |SELECT RIGHT('abcbcd123', 2) as result FROM T1;<br/><br/>result<br/>-------<br/>23|
| 用法   |RIGHT(STRING a, STRING b)    |
| 返回值 |STRING    |
| 备注   |无|


| 函数名 | REGEXP_REPLACE   |
|-------| -----  |
| 说明   | 用字符串 replacement 替换字符串 str 中正则模式为 pattern 的子串，返回新的字符串。正则匹配替换, 参数为 null 或者正则不合法返回 null。|
| 样例   |SELECT REGEXP_REPLACE('2014-03-13', '-', '') as result FROM T1;<br/><br/>result<br/>-------<br/>20140313|
| 用法   |REGEXP_REPLACE(STRING str, STRING pattern, STRING replacement)    |
| 返回值 |STRING    |
| 备注   |无|


| 函数名 | CONCAT   |
|-------| -----  |
| 说明   | 连接两个或多个字符串值从而组成一个新的字符串。任一参数为 NULL，则返回 NULL。|
| 样例   |SELECT CONCAT('Hello', 'World') as result FROM T1;<br/><br/>result<br/>-------<br/>HelloWorld|
| 用法   |CONCAT(STRING var1, STRING var2, ...)    |
| 返回值 |STRING    |
| 备注   |无|


| 函数名 | SUBSTRING_INDEX   |
|-------| -----  |
| 说明   | 根据分隔符计数截取字符串，如果长度超过实际分割数，则返回原字符串。|
| 样例   |SELECT SUBSTRING_INDEX('abc+dbc', '\\\+', 1) as result FROM T1;<br/><br/>result<br/>-------<br/>abc|
| 用法   |SUBSTRING_INDEX(STRING str, STRING pattern, STRING len)    |
| 返回值 |STRING    |
| 备注   |若 pattern 中包含特殊字符 <code>$ ( ) * + . [ ] ? \ ^ { } &#124; "</code>，需在特殊字符前增加反引号 **\\** 进行转义    |


| 函数名 | LOCATE   |
|-------| -----  |
| 说明   | 返回子字符串在指定字符串指定位置之后第几次出现的位置(从 1 开始)。第三个参数为开始查询的位置（可选），默认为从 1 开始。|
| 样例   |SELECT LOCATE(‘bc’,’abcbcd123’,3) as result FROM T1;<br/><br/>result<br/>-------<br/>4|
| 用法   |LOCATE(STRING str1, STRING str2, INT n)    |
| 返回值 |INT    |
| 备注   |无|


| 函数名 | MID   |
|-------| -----  |
| 说明   | 从指定位置截取字符串指定长度的子串。|
| 样例   |SELECT MID(‘abcbcd123’,2,5) as result FROM T1;<br/><br/>result<br/>-------<br/>cbcd1|
| 用法   |MID(STRING str1, INT str2, INT n)    |
| 返回值 |STRING    |
| 备注   |无|


| 函数名 | SPLIT_INDEX   |
|-------| -----  |
| 说明   | 根据分隔符计数取字符串，从 1 开始。|
| 样例   |SELECT SPLIT_INDEX(‘abc;bcd1;23a;bcb;cd123’，’;’,2) as result FROM T1;<br/><br/>result<br/>-------<br/>bcd1|
| 用法   |SPLIT_INDEX(STRING str1, String pattern, INT n)    |
| 返回值 |STRING    |
| 备注   |若 pattern 中包含特殊字符 <code>$ ( ) * + . [ ] ? \ ^ { } &#124; "</code>，需在特殊字符前增加反引号 **\\** 进行转义    |


| 函数名 | INET_ATON   |
|-------| -----  |
| 说明   | IP 转 Long。|
| 样例   |SELECT INET_ATON('127.0.0.1') as result FROM T1;<br/><br/>result<br/>-------<br/>169681473|
| 用法   |INET_ATON(STRING str1)    |
| 返回值 |LONG    |
| 备注   |无|


| 函数名 | INET_NTOA   |
|-------| -----  |
| 说明   | Long 转 IP。|
| 样例   |SELECT INET_NTOA(169681473) as result FROM T1;<br/><br/>result<br/>-------<br/>127.0.0.1|
| 用法   |INET_NTOA(LONG str1)    |
| 返回值 |STRING    |
| 备注   |无|


| 函数名 | CONCAT_WS   |
|-------| -----  |
| 说明   | 将每个参数值和第一个参数 separator 指定的分隔符依次连接到一起组成新的字符串。自动跳过为 NULL 的参数。|
| 样例   |SELECT CONCAT_WS('#', 'a', 'b' ) as result FROM T1;<br/><br/>result<br/>-------<br/>a#b|
| 用法   |CONCAT_WS(STRING separator, STRING var1, STRING var2, ...)    |
| 返回值 |STRING    |
| 备注   |无|


| 函数名 | CONTAINS_SUBSTRING   |
|-------| -----  |
| 说明   | 判断字符串中是否包含指定子串。|
| 样例   |SELECT CONTAINS_SUBSTRING(‘abcbcd123’,’bcd12’) as result FROM T1;<br/><br/>result<br/>-------<br/>True|
| 用法   |CONTAINS_SUBSTRING(STRING var1, STRING var2)    |
| 返回值 |boolean    |
| 备注   |无|


| 函数名 | INSTR   |
|-------| -----  |
| 说明   | 返回子字符串在指定字符串第一次出现的位置(从 1 开始)。|
| 样例   |SELECT INSTR(‘abcbcd123’,’bc’) as result FROM T1;<br/><br/>result<br/>-------<br/>2|
| 用法   |INSTR(STRING var1, STRING var2)    |
| 返回值 |INT    |
| 备注   |无|


| 函数名 | REGEXP_EXTRACT   |
|-------| -----  |
| 说明   | 将字符串按照 regex 正则表达式的规则拆分，返回 index 指定的字符。 |
| 样例   |SELECT regexp_extract('100-200', '(\d+)-(\d+)', 1) as result FROM T1;<br/><br/>result<br/>-------<br/>100|
| 用法   |INSTR(STRING str, STRING regex, INT index)    |
| 返回值 |INT    |
| 备注   |无|


| 函数名 | LPAD|
|-------| -----  |
| 说明   |返回字符串，左边填充 pad，长度为 length。如果字符串长于 length，则返回值将缩短为 length 个字符|
| 样例   |SELECT LPAD('hi', 5, '??');<br/><br/>result<br/>-------<br/>???hi|
| 用法   |LPAD(STRING str, INT len, STRING pad)    |
| 返回值 |STRING    |
| 备注   |无|


| 函数名 | RPAD|
|-------| -----  |
| 说明   |返回字符串，右边填充 pad，长度为 length。如果字符串长于 length，则返回值将缩短为 length 个字符|
| 样例   |SELECT RPAD('hi', 5, '??');<br/><br/>result<br/>-------<br/>hi???|
| 用法   |RPAD(STRING str, INT len, STRING pad)   |
| 返回值 |STRING    |
| 备注   |无|


#####  数学函数


| 函数名 | ROUND   |
|-------| -----  |
| 说明   | 把数值 x 字段舍入为指定的小数 n 位数。|
| 样例   |SELECT ROUND(0.717,2) as result FROM T1;<br/><br/>result<br/>-------<br/>0.72|
| 用法   |ROUND(DOUBLE var1, INT n)    |
| 返回值 |DOUBLE    |
| 备注   |无|


| 函数名 | POWER   |
|-------| -----  |
| 说明   | 返回 A 的 B 次幂。|
| 样例   |SELECT POWER(2.0, 3.0) as result FROM T1;<br/><br/>result<br/>-------<br/>8|
| 用法   |POWER(DOUBLE in1, DOUBLE in2)    |
| 返回值 |DOUBLE    |
| 备注   |无|


| 函数名 | ABS   |
|-------| -----  |
| 说明   | 返回 A 的绝对值。|
| 样例   |SELECT ABS(-16) as result FROM T1;<br/><br/>result<br/>-------<br/>16|
| 用法   |ABS(DOUBLE in1)    |
| 返回值 |DOUBLE    |
| 备注   |无|


| 函数名 | SQRT   |
|-------| -----  |
| 说明   | 返回 A 的平方根。|
| 样例   |SELECT SQRT(8.0) as result FROM T1;<br/><br/>result<br/>-------<br/>2.8284271|
| 用法   |SQRT(DOUBLE in1)    |
| 返回值 |DOUBLE    |
| 备注   |无|


| 函数名 | FLOOR   |
|-------| -----  |
| 说明   | 舍去小数位数值。返回小于或等于 A 的最大整数数值。输出 A 的数据类型与输入类型一致。|
| 样例   |SELECT FLOOR(2.2) as result FROM T1;<br/><br/>result<br/>-------<br/>2.0|
| 用法   |FLOOR(INT/LONG/FLOAT/DOUBLE in1)    |
| 返回值 |INT/LONG/FLOAT/DOUBLE    |
| 备注   |无|


| 函数名 | CEIL   |
|-------| -----  |
| 说明   | 输出 B 为大于或等于输入值 A 的最小整数数值。输出 B 的数据类型与输入参数 A 的数据类型一致。|
| 样例   |SELECT CEIL(0.2) as result FROM T1;<br/><br/>result<br/>-------<br/>1.0|
| 用法   |CEIL(INT/LONG/FLOAT/DOUBLE in1)    |
| 返回值 |INT/LONG/FLOAT/DOUBLE    |
| 备注   |无|


| 函数名 | TRUNCATE   |
|-------| -----  |
| 说明   | 保留数值的指定位数。|
| 样例   |SELECT TRUNCATE(1.026, 2) as result FROM T1;<br/><br/>result<br/>-------<br/>1.02|
| 用法   |TRUNCATE(FLOAT/DOUBLE in1, INT n)    |
| 返回值 |FLOAT/DOUBLE    |
| 备注   |无|


| 函数名 | MOD   |
|-------| -----  |
| 说明   | 整数运算中，求整数 x 除以整数 y 的余数。当 x 为负值时，或者 x、y 均为负值时，结果为负值。|
| 样例   |SELECT MOD(29, 3) as result FROM T1;<br/><br/>result<br/>-------<br/>2|
| 用法   |MOD(INT in1, INT n)    |
| 返回值 |INT    |
| 备注   |无|


| 函数名 | INT_OVERFLOW   |
|-------| -----  |
| 说明   | int 类型 qq 溢出转换函数。|
| 样例   |SELECT INT_OVERFLOW(-1448817156) as result FROM T1;<br/><br/>result<br/>-------<br/>2846150140|
| 用法   |INT_OVERFLOW(INT i)    |
| 返回值 |LONG    |
| 备注   |无|


##### 条件函数


| 函数名 | CASE WHEN   |
|-------| -----  |
| 说明   | 如果 a 为 TRUE，则返回 b；如果 c 为 TRUE，则返回 d；否则返回 e 。|
| 样例   |SELECT case when 1<>1 then 'data' else 'flow' end as result FROM TABLE;<br/><br/>result<br/>-------<br/>flow|
| 用法   |CASE WHEN a THEN b [WHEN c THEN d]*[ELSE e] END    |
| 返回值 |T    |
| 备注   |无|


| 函数名 | IF   |
|-------| -----  |
| 说明   | 如果表达式 testCondition 的值为 TRUE，则返回 valueTrue；否则返回 valueFalseOrNull 。|
| 样例   |SELECT IF(1 < 2,'abc', 'nnn') as result FROM T1;<br/><br/>result<br/>-------<br/>abc|
| 用法   |IF(BOOLEAN testCondition, T valueTrue, T valueFalseOrNull)    |
| 返回值 |T    |
| 备注   |无|

##### 类型转换函数

| 函数名 | CAST   |
|-------| -----  |
| 说明   | 将 A 值转换为给定类型。|
| 样例   |SELECT CAST(var1 as INT) as result FROM T1;<br/><br/>result<br/>-------<br/>1000|
| 用法   |CAST(A AS type)    |
| 返回值 |type   |
| 备注   |无|

*注：数据类型对应关系*

| *sql 类型* | *数据类型*   |
|-------| -----  |
| *VARCHAR* | *STRING*|
| *INT* | *INT*|
| *BIGINT* | *LONG*|
| *FLOAT* | *FLOAT*|
| *DOUBLE* | *DOUBLE*|

*将数据类型转换为 string: cast(var as varchar)*
*将数据类型转换为 int: cast(var as int)*
*将数据类型转换为 long: cast(var as bigint)*
*将数据类型转换为 float: cast(var as float)*
*将数据类型转换为 double: cast(var as double)*

##### 聚合函数


| 函数名 | AVG   |
|-------| -----  |
| 说明   |返回所有输入值的平均值。|
| 样例   |SELECT AVG(var1) as result FROM T1;<br/><br/>result<br/>-------<br/>8|
| 用法   |AVG(INT/DOUBLE/FLOAT/LONG var1)    |
| 返回值 |DOUBLE    |
| 备注   |无|


| 函数名 | SUM   |
|-------| -----  |
| 说明   |返回所有输入值的数值之和。|
| 样例   |SELECT SUM(var1) as result FROM T1;<br/><br/>result<br/>-------<br/>8|
| 用法   |SUM(INT/DOUBLE/FLOAT/LONG var1)    |
| 返回值 |INT/DOUBLE/FLOAT/LONG    |
| 备注   |无|


| 函数名 | stddev_pop|
|-------| ----- |
| 说明 |计算总体标准差|
| 样例 |SELECT stddev_pop(var1) as result FROM T1 group by var2;|
| 用法 |stddev_pop(INT/DOUBLE/FLOAT/LONG var1) |
| 返回值 |INT/DOUBLE/FLOAT/LONG |
| 备注   |无|

| 函数名 | stddev_samp|
|-------| ----- |
| 说明 |计算样本标准差|
| 样例 |SELECT stddev_samp(var1) as result FROM T1 group by var2;|
| 用法 |stddev_samp(INT/DOUBLE/FLOAT/LONG var1)|
| 返回值 |INT/DOUBLE/FLOAT/LONG |
| 备注   |无|


| 函数名 | COUNT   |
|-------| -----  |
| 说明   |返回输入列的个数。|
| 样例   |SELECT COUNT(var1) as result FROM T1;<br/><br/>result<br/>-------<br/>8|
| 用法   |COUNT(INT/DOUBLE/FLOAT/LONG/STRING var1)    |
| 返回值 |LONG    |
| 备注   |无|


| 函数名 | LAST   |
|-------| -----  |
| 说明   |返回所有输入值的最后字段值。|
| 样例   |SELECT LAST(var1) as result FROM T1;<br/><br/>result<br/>-------<br/>8|
| 用法   |LAST(INT/DOUBLE/FLOAT/LONG/STRING var1)    |
| 返回值 |INT/DOUBLE/FLOAT/LONG/STRING    |
| 备注   |无|


| 函数名 | MIN   |
|-------| -----  |
| 说明   |返回所有输入值的最小值。|
| 样例   |SELECT MIN(var1) as result FROM T1;<br/><br/>result<br/>-------<br/>8|
| 用法   |MIN(INT/DOUBLE/FLOAT/LONG var1)    |
| 返回值 |INT/DOUBLE/FLOAT/LONG    |
| 备注   |无|


| 函数名 | MAX   |
|-------| -----  |
| 说明   |返回所有输入值的最大值。|
| 样例   |SELECT MAX(var1) as result FROM T1;<br/><br/>result<br/>-------<br/>8|
| 用法   |MAX(INT/DOUBLE/FLOAT/LONG var1)    |
| 返回值 |INT/DOUBLE/FLOAT/LONG    |
| 备注   |无|


| 函数名 | COUNT_DISTINCT   |
|-------| -----  |
| 说明   |返回输入列不重复数据的个数。|
| 样例   |SELECT COUNT(DISTINCT var1) as result FROM T1;<br/><br/>result<br/>-------<br/>3|
| 用法   |COUNT(INT/DOUBLE/FLOAT/LONG/STRING var1)    |
| 返回值 |LONG    |
| 备注   |无|


##### 时间函数


| 函数名 | UNIXTIME_DIFF   |
|-------| -----  |
| 说明   |  计算两个时间戳(以秒计)的时间差。|
| 样例   |SELECT UNIXTIME_DIFF(1466436000,1466434200,'minute') as result FROM T1;<br/><br/>result<br/>-------<br/>3|
| 用法   |UNIXTIME_DIFF(LONG u1, LONG u2, STRING str)    |
| 返回值 |INT    |
| 备注   |无|


| 函数名 | NOW   |
|-------| -----  |
| 说明   |  当前日期时间,指定格式。|
| 样例   |SELECT NOW('yyyyMMddHHmmss') as result FROM T1;<br/><br/>result<br/>-------<br/>20160621194437|
| 用法   |NOW(STRING str)    |
| 返回值 |STRING    |
| 备注   |无|


| 函数名 | UNIX_TIMESTAMP   |
|-------| -----  |
| 说明   |  获取当前日期时间的时间戳(以秒计)。|
| 样例   |SELECT UNIX_TIMESTAMP() as result FROM T1;<br/><br/>result<br/>-------<br/>1466436000|
| 用法   |UNIX_TIMESTAMP()    |
| 返回值 |INT    |
| 备注   |无|


| 函数名 | CURDATE   |
|-------| -----  |
| 说明   |  当前日期，可选择指定格式，默认格式：’YYYY-MM-dd’。|
| 样例   |SELECT CURDATE('YYYYMMdd') as result FROM T1;<br/><br/>result<br/>-------<br/>20160621|
| 用法   |CURDATE(STRING str)    |
| 返回值 |STRING    |
| 备注   |无|


| 函数名 | FROM_UNIXTIME   |
|-------| -----  |
| 说明   |  将时间戳(以秒计)转换为日期时间(指定格式)字符串。|
| 样例   |SELECT FROM_UNIXTIME(CAST(1466436000 AS BIGINT), ’yyyy/MM/dd/HH/mm/ss’) as result FROM T1;<br/><br/>result<br/>-------<br/>2016/06/20/23/20/00|
| 用法   |FROM_UNIXTIME(LONG u1, STRING str)    |
| 返回值 |STRING    |
| 备注   |无|


| 函数名 | UNIX_TIMESTAMP   |
|-------| -----  |
| 说明   |  将日期时间(指定格式)字符串转换为时间戳(以秒计)。|
| 样例   |SELECT UNIX_TIMESTAMP('2021-01-14 23:09:15','yyyy-MM-dd HH:mm:ss') as result FROM T1;<br/><br/>result<br/>-------<br/>1610636955|
| 用法   |UNIX_TIMESTAMP(STRING str, STRING format)    |
| 返回值 |INT    |
| 备注   |无|


##### 表值函数


| 函数名 | ZIP   |
|-------| -----  |
| 说明   |将多个或一个字段根据指定分隔符拆分后，再根据指定拼接符拼接在一起，变成多行进行输出。|
| 样例   |SELECT result FROM T1, LATERAL TABLE(ZIP('\*','11\_21','\\\_','12\_22','\\\_','13\_23','\\\_')) AS T(result);<br/><br/>result<br/>-------<br/>11\*12\*13<br/>21\*22\*23|
| 用法   |ZIP(STRING a, STRING str1, STRING b,STRING str2,STRING c,STRING str3,STRING d)    |
| 返回值 |STRING    |
| 备注   |若分隔符参数中包含特殊字符 <code>$ ( ) * + . [ ] ? \ ^ { } &#124; "</code>，需在特殊字符前增加反引号 **\\** 进行转义    |


| 函数名 | SPLIT_FIELD_TO_RECORDS   |
|-------| -----  |
| 说明   |将多个或一个字段根据指定分隔符拆分后，再根据指定拼接符拼接在一起，变成多行进行输出。|
| 样例   |SELECT result FROM T1, LATERAL TABLE(SPLIT\_FIELD\_TO\_RECORDS('11\_21','\\\_')) AS T(result);<br/><br/>result<br/>-------<br/>11<br/>21|
| 用法   |SPLIT_FIELD_TO_RECORDS(STRING str, STRING a)    |
| 返回值 |STRING    |
| 备注   |若分隔符参数中包含特殊字符 <code>$ ( ) * + . [ ] ? \ ^ { } &#124; "</code>，需在特殊字符前增加反引号 **\\** 进行转义    |


