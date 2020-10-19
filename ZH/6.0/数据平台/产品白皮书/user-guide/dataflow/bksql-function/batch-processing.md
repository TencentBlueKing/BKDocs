## BKSQL 离线计算语法 

由于离线计算是基于 sparkSQL，所以 BKSQL 语法基本符合[SQL-92 标准](https://en.wikipedia.org/wiki/SQL-92)，主体语法为一个 Select 语句

```plain
SELECT ... FROM ... WHERE ... GROUP BY ...
```

支持常用计算表达式、条件表达式、分支表达式、聚合函数、转化函数

#### BKSQL 示例 

* 离线 Join 示例

```plain
select count(*) as count_all, a.DeviceID as adevice, b.DeviceID as bdevice
from PlayerRegisterParseJ145 as a
left join 591_PlayerRegister_parse3 as b on
a.DeviceID = b.DeviceID
group by a.DeviceID
```

* 离线综合示例

```plain
select min(dtEventTimeStamp) as thedate,
min(dtEventTimeStamp) as dtEventTimeStamp,
min(dtEventTime) as dtEventTime, '3v3' as module,
case substring(iZoneAreaID,1,1)
when '1' then 'aqq' when '3' then 'awx' when '2' then 'iqq' when '4' then 'iwx' else 'other' end as platform, sum(TotalDisconnNumOnEnd)/6 as lost
from 591_logdt_3v3_pvp_settle where IsPKAI=1 group by substring(iZoneAreaID,1,1)
```

#### 对比标准 SQL，还存在以下区别 

目前只支持 Select 语句以及 Insert 语句（实际使用中只用到了 Select 语句），其他如 Create、Update、Alter、Delete 等语句目前不支持。

#### 离线计算函数

##### 比较运算符
```plain
=, <>, >=, >, <=, <, IS NOT NULL, IS NULL

```

##### 算术表达式
```plain
+, -, *, /
```

##### 逻辑运算符
```plain
AND, OR, NOT, IN
```

##### 字符串函数

| 函数名 | substring|
|-------| -----  |
| 说明   |获取字符串子串。截取从位置 start 开始，长度为 len 的子串。<br/><br/>start 从 1 开始，为负数时表示从字符串末尾倒序计算位置。<br/><br/> 当不设置第三个参数“选取长度”时，则截取到字符串结尾|
| 样例   |SELECT  SUBSTRING('k1=v1;k2=v2', 2, 2);<br/><br/>result<br/>-------<br/>1=|
| 用法   |SUBSTRING(STRING var1, INT start, INT len)    |
| 返回值 |STRING    |
|   备注       |无|

| 函数名 | substring_index|
|-------| -----  |
| 说明   | 根据分隔符计数截取字符串，如果长度超过实际分割数，则返回原字符串。|
| 样例   |SELECT SUBSTRING_INDEX('abc+dbc', '\\+', 1);<br/><br/>result<br/>-------<br/>abc|
| 用法   |SUBSTRING_INDEX(STRING str, STRING pattern, STRING len)    |
| 返回值 |STRING    |
| 备注   |若 pattern 中包含特殊字符 <code>$ ( ) * + . [ ] ? \ ^ { } &#124; "</code>，需在特殊字符前增加反引号 **\\** 进行转义    |

| 函数名 | base64|
|-------| -----  |
| 说明   | 将字符串进行 base64 编码。|
| 样例   |SELECT base64('Spark SQL');<br/><br/>result<br/>-------<br/>U3BhcmsgU1FM|
| 用法   |base64(STRING var1)    |
| 返回值 |STRING    |
| 备注   |无|

| 函数名 | concat_ws|
|-------| -----  |
| 说明   | 将每个参数值和第一个参数 separator 指定的分隔符依次连接到一起组成新的字符串。|
| 样例   |SELECT CONCAT_WS('#', 'a', 'b' );<br/><br/>result<br/>-------<br/>a#b|
| 用法   |CONCAT_WS(STRING separator, STRING var1, STRING var2, ...)    |
| 返回值 |STRING    |
| 备注   |无|

| 函数名 | concat|
|-------| -----  |
| 说明   | 连接两个或多个字符串值从而组成一个新的字符串。任一参数为 NULL，跳过该参数。|
| 样例   |SELECT CONCAT('Hello', 'World') as result FROM T1;<br/><br/>result<br/>-------<br/>HelloWorld|
| 用法   |CONCAT(STRING var1, STRING var2, ...)    |
| 返回值 |STRING    |
| 备注   |无|

| 函数名 | decode|
|-------| ----- |
| 说明 |使用第二个参数字符集解码第一个参数。|
| 样例 |SELECT decode(encode('abc', 'utf-8'), 'utf-8');<br/><br/>result<br/>-------<br/>abc|
| 用法 |decode(STRING var1, STRING charset) |
| 返回值 |STRING |
| 备注 |无|

| 函数名 | encode|
|-------| -----  |
| 说明   |使用第二个参数字符集对第一个参数进行编码。|
| 样例   |SELECT encode('abc', 'utf-8');<br/><br/>result<br/>-------<br/>abc|
| 用法   |SUBSTRING(STRING var1, INT start, INT len)    |
| 返回值 |STRING    |
| 备注   |无|

| 函数名 | format_string|
|-------| -----  |
| 说明   |从 printf 样式的格式字符串返回格式化的字符串|
| 样例   |SELECT format_string("Hello World %d %s", 100, "days");<br/><br/>result<br/>-------<br/>Hello World 100 days|
| 用法   |format_string(STRING strfmt, STRING obj...)    |
| 返回值 |STRING    |
| 备注   |无|

| 函数名 | from_unixtime|
|-------| -----  |
| 说明   |以指定格式返回 unix_time。|
| 样例   |SELECT from_unixtime(0, 'yyyy-MM-dd HH:mm:ss');<br/><br/>result<br/>-------<br/>1970-01-01 00:00:00|
| 用法   |SUBSTRING(LONG unix_time, STRING format)    |
| 返回值 |STRING    |
| 备注   |无|

| 函数名 | lower|
|-------| -----  |
| 说明   |将所有字符都更改为小写|
| 样例   |SELECT lower('SparkSql');<br/><br/>result<br/>-------<br/>sparksql|
| 用法   |SUBSTRING(STRING var1, INT start, INT len)    |
| 返回值 |STRING    |
| 备注   |无|

| 函数名 | trim|
|-------| -----  |
| 说明   |从字符串中删除开头和结尾空格字符|
| 样例   |SELECT trim('    SparkSQL   ');<br/><br/>result<br/>-------<br/>SparkSQL|
| 用法   |trim(STRING str)    |
| 返回值 |STRING    |
| 备注   |无|

| 函数名 | ltrim|
|-------| ----- |
| 说明 |从字符串中删除开头空格字符|
| 样例 |SELECT ltrim('    SparkSQL   ');<br/><br/>result<br/>-------<br/>sparkSQL   |
| 用法 |ltrim(STRING str) |
| 返回值 |STRING |
| 备注   |无|

| 函数名 | rtrim|
|-------| ----- |
| 说明 |从字符串中删除结尾空格字符|
| 样例 |SELECT rtrim('    SparkSQL   ');<br/><br/>result<br/>-------<br/>    SparkSQL|
| 用法 |rtrim(STRING str) |
| 返回值 |STRING |
| 备注   |无|

| 函数名 | upper|
|-------| ----- |
| 说明 |将所有字符都更改为大写|
| 样例 |SELECT upper('SparkSql');<br/><br/>result<br/>-------<br/>SPARKSQL|
| 用法 |upper(STRING str) |
| 返回值 |STRING |
| 备注   |无|

| 函数名 | lpad|
|-------| -----  |
| 说明   |返回字符串，左边填充 pad，长度为 length。如果字符串长于 length，则返回值将缩短为 length 个字符|
| 样例   |SELECT lpad('hi', 5, '??');<br/><br/>result<br/>-------<br/>???hi|
| 用法   |lpad(STRING str, INT len, STRING pad)    |
| 返回值 |STRING    |
| 备注   |无|

| 函数名 | rpad|
|-------| -----  |
| 说明   |返回字符串，右边填充 pad，长度为 length。如果字符串长于 length，则返回值将缩短为 length 个字符|
| 样例   |SELECT rpad('hi', 5, '??');<br/><br/>result<br/>-------<br/>hi???|
| 用法   |rpad(STRING str, INT len, STRING pad)   |
| 返回值 |STRING    |
| 备注   |无|

| 函数名 | groupconcat|
|-------| ----- |
| 说明 |对数据列进行字符串拼接，可以支持设置拼接分隔符，按指定列升序降序排序(默认降序)，以及去重功能|
| 样例 |SELECT GroupConcat(s1) as new_field;<br/><br/>result<br/>-------<br/>('1') ('2') ('3') ==> '1,2,3'<br/><br/>SELECT GroupConcat(s1, '&#124;') as new_field;<br/><br/>result<br/>-------<br/>('1', '&#124;') ('2', '&#124;') ('3', '&#124;') ==> '1&#124;2&#124;3'<br/><br/>SELECT GroupConcat(s1, '&#124;', s2) as new_field;<br/><br/>result<br/>-------<br/> ('11', '&#124;', '12') ('21', '&#124;', '22') ('31', '&#124;', '32') ==> '31&#124;21&#124;11'<br/><br/>SELECT GroupConcat(s1, '&#124;', s2, 'asc') as new_field;<br/><br/>result<br/>-------<br/> ('11', '&#124;', '12', 'asc') ('21', '&#124;', '22', 'asc') ('31', '&#124;', '32', 'asc') ==> '11&#124;21&#124;31'<br/><br/>SELECT GroupConcat(s1, '&#124;', s2, 'desc', 'distinct') as new_field;<br/><br/>result<br/>-------<br/> ('11', '&#124;', '12', 'asc', 'distinct') ('21', '&#124;', '22', 'asc', 'distinct') ('21', '&#124;', '22', 'asc', 'distinct') ('31', '&#124;', '32', 'asc', 'distinct') ==> '31&#124;21&#124;11'|
| 用法 |groupconcat(STRING var, STRING split, STRING order_var, STRING order_rule, STRING distinct) |
| 返回值 |STRING |
| 备注   |无|

| 函数名 | regexp_replace|
|-------| ----- |
| 说明 |将与正则匹配的字符串的所有子字符串替换为新值|
| 样例 |SELECT regexp_replace('100-200', '(\d+)', 'num');<br/><br/>result<br/>-------<br/>num-num|
| 用法 |regexp_replace(STRING str, STRING reg, STRING replace) |
| 返回值 |STRING |
| 备注   |无|

| 函数名 | regexp_extract|
|-------| ----- |
| 说明 |提取与正则匹配的组|
| 样例 |SELECT regexp_extract('100-200', '(\d+)-(\d+)', 1);<br/><br/>result<br/>-------<br/>100|
| 用法 |regexp_extract(STRING str, STRING reg, INT idx) |
| 返回值 |STRING |
| 备注   |无|

| 函数名 | replace|
|-------| ----- |
| 说明 |用新字符串替换所有搜索出现的字符串|
| 样例 |SELECT replace('ABCabc', 'abc', 'DEF');<br/><br/>result<br/>-------<br/>ABCDEF|
| 用法 |replace(STRING str, STRING search, String replace) |
| 返回值 |STRING |
| 备注   |无|

| 函数名 | split|
|-------| ----- |
| 说明 |根据正则表达式对匹配的字符进行分割|
| 样例 |SELECT split('oneAtwoBthreeC', '[ABC]');<br/><br/>result<br/>-------<br/>["one","two","three",""]|
| 用法 |split(STRING str, STRING regexp) |
| 返回值 |STRING |
| 备注   | 无   |

| 函数名 | SPLIT_INDEX   |
|-------| -----  |
| 说明   | 根据分隔符计数取字符串，从 1 开始。|
| 样例   |SELECT SPLIT_INDEX(‘abc;bcd1;23a;bcb;cd123’，’;’,2) as result FROM T1;<br/><br/>result<br/>-------<br/>bcd1|
| 用法   |SPLIT_INDEX(STRING str1, String pattern, INT n)    |
| 返回值 |STRING    |
| 备注   |若 pattern 中包含特殊字符 <code>$ ( ) * + . [ ] ? \ ^ { } &#124; "</code>，需在特殊字符前增加反引号 **\\** 进行转义    |

| 函数名 | ZIP   |
|-------| -----  |
| 说明   |将多个或一个字段根据指定分隔符拆分后，再根据指定拼接符拼接在一起，变成多行进行输出。|
| 样例   |SELECT result FROM T1, LATERAL TABLE(ZIP('\*','11\_21','\\\_','12\_22','\\\_','13\_23','\\\_')) AS T(result);<br/><br/>result<br/>-------<br/>11\*12\*13<br/>21\*22\*23|
| 用法   |ZIP(STRING a, STRING str1, STRING b,STRING str2,STRING c,STRING str3,STRING d)    |
| 返回值 |STRING    |
| 备注   |若分隔符参数中包含特殊字符 <code>$ ( ) * + . [ ] ? \ ^ { } &#124; "</code>，需在特殊字符前增加反引号 **\\** 进行转义    |

| 函数名 | char_length|
|-------| ----- |
| 说明 |返回字符串数据的字符长度或二进制数据的字节数。字符串数据的长度包括尾随空格。|
| 样例 |SELECT char_length('BKSQL ')|
| 用法 |char_length(expr) |
| 返回值 |INT |
| 备注   | N/A   |

| 函数名 | left|
|-------| ----- |
| 说明 |返回最左边长度为 len 的字符串，如果 len 小于等于 0 返回空字符串|
| 样例 |SELECT left('BKSQL SQL', 3);|
| 用法 |left(str, len) |
| 返回值 |STRING |
| 备注   | N/A   |

| 函数名 | right|
|-------| ----- |
| 说明 |返回最右边长度为 len 的字符串，如果 len 小于等于 0 返回空字符串|
| 样例 |SELECT left('BKSQL SQL', 3);|
| 用法 |left(str, len) |
| 返回值 |INT |
| 备注   | STRING/A   |

| 函数名 | locate|
|-------| ----- |
| 说明 |返回在 pos 后第一次出现 substr 的位置，位置从 1 开始|
| 样例 |locate(substr, str[, pos]);|
| 用法 |SELECT locate('bar', 'foobarbar'); |
| 返回值 |INT |
| 备注   | N/A   |

| 函数名 | instr|
|-------| ----- |
| 说明 |返回从 1 开始的 str 中第一次出现 substr 的索引|
| 样例 |instr(str, substr)|
| 用法 |SELECT instr('BKSQL', 'SQL') |
| 返回值 |INT |
| 备注   | N/A   |

##### 数学函数

| 函数名 | sqrt|
|-------| -----  |
| 说明   |开方|
| 样例   |SELECT sqrt(4);<br/><br/>result<br/>-------<br/>2.0|
| 用法   |sqrt(DOUBLE num) |
| 返回值 |DOUBLE    |
| 备注   |无|

| 函数名 | round|
|-------| ----- |
| 说明 |使用四舍五入的模式将表达式舍入指定位数的小数位|
| 样例 |SELECT round(2.5, 0);<br/><br/>result<br/>-------<br/>3.0|
| 用法 |ROUND(DOUBLE expr, INT number) |
| 返回值 |DOUBLE |
| 备注   |无|

| 函数名 | ceil|
|-------| ----- |
| 说明 |返回不小于当前数值的最小整数|
| 样例 |SELECT ceil(-0.1);<br/><br/>result<br/>-------<br/>0|
| 用法 |ceil(DOUBLE number) |
| 返回值 |LONG |
| 备注   |无|

| 函数名 | floor|
|-------| ----- |
| 说明 |返回不大于当前数值的最大整数|
| 样例 |SELECT floor(-0.1);<br/><br/>result<br/>-------<br/>-1|
| 用法 |floor(DOUBLE number) |
| 返回值 |LONG |
| 备注   |无|

| 函数名 | mod|
|-------| ----- |
| 说明 |取余数|
| 样例 |SELECT MOD(2, 1.8);<br/><br/>result<br/>-------<br/>0.2|
| 用法 |MOD(DOUBLE expr1, DOUBLE expr2) |
| 返回值 |DOUBLE |
| 备注   |无|

| 函数名 | pmod|
|-------| ----- |
| 说明 |返回余数的正值|
| 样例 |SELECT pmod(-10, 3);<br/><br/>result<br/>-------<br/>2|
| 用法 |pmod(DOUBLE expr1, DOUBLE expr2) |
| 返回值 |DOUBLE |
| 备注   |无|

| 函数名 | length|
|-------| ----- |
| 说明 |返回字符串数据的字符长度或二进制数据的字节数。字符串数据的长度包括尾随空格。二进制数据的长度包括二进制零。|
| 样例 |SELECT length('Spark SQL ');<br/><br/>result<br/>-------<br/>10|
| 用法 |length(STRING var1) |
| 返回值 |LONG |
| 备注   |无|

| 函数名 | abs|
|-------| ----- |
| 说明 |获取绝对值|
| 样例 |SELECT abs(-1);<br/><br/>result<br/>-------<br/>1|
| 用法 |abs(LONG var1) |
| 返回值 |LONG |
| 备注   |无|

| 函数名 | pow|
|-------| ----- |
| 说明 |求幂值|
| 样例 |SELECT pow(2, 3);<br/><br/>result<br/>-------<br/>8|
| 用法 |pow(double expr1, INT expr2) |
| 返回值 |DOUBLE |
| 备注   |无|

##### 聚合函数

| 函数名 | sum|
|-------| ----- |
| 说明 |求和|
| 样例 |SELECT sum(column) as result FROM T1;|
| 用法 |sum(column) |
| 返回值 |LONG |
| 备注   |无|

| 函数名 | last|
|-------| -----  |
| 说明   |返回最后一个值|
| 样例   |SELECT last(column) as result FROM T1;|
| 用法   |last(column)    |
| 返回值 |column 的类型    |
| 备注   |无|

| 函数名 | first|
|-------| -----  |
| 说明   |返回第一个值|
| 样例   |SELECT last(column) as result FROM T1;|
| 用法   |first(column) |
| 返回值 |column 的类型  |
| 备注   |无|

| 函数名 | min|
|-------| ----- |
| 说明 |最小值|
| 样例 |SELECT min(column) as result FROM T1;|
| 用法 |min(column) |
| 返回值 |column 的类型 |
| 备注   |无|

| 函数名 | max|
|-------| ----- |
| 说明 |最大值|
| 样例 |SELECT max(column) as result FROM T1;|
| 用法 |max(column) |
| 返回值 |column 的类型 |
| 备注   |无|

| 函数名 | count|
|-------| ----- |
| 说明 |求和|
| 样例 |SELECT count(column) as result FROM T1;|
| 用法 |count(column) |
| 返回值 |LONG |
|   备注  |无|

| 函数名 | avg|
|-------| ----- |
| 说明 | 计算平均值|
| 样例 |SELECT avg(column) as result FROM T1;|
| 用法 |avg(column) |
| 返回值 |LONG |
| 备注   |无|

| 函数名 | variance|
|-------| -----  |
| 说明   |计算样本方差|
| 样例   |SELECT variance(column) as result FROM T1;|
| 用法   |variance(column)    |
| 返回值 |DOUBLE    |
| 备注   |无|

| 函数名 | std|
|-------| ----- |
| 说明 |计算样本标准差|
| 样例 |SELECT std(column) as result FROM T1;|
| 用法 |std(column) |
| 返回值 |DOUBLE |
| 备注   |无|

| 函数名 | stddev_pop|
|-------| ----- |
| 说明 |计算总体标准差|
| 样例 |SELECT stddev_pop(column) as result FROM T1;|
| 用法 |stddev_pop(column) |
| 返回值 |DOUBLE |
| 备注   |无|

| 函数名 | stddev_samp|
|-------| ----- |
| 说明 |计算样本标准差|
| 样例 |SELECT std(column) as result FROM T1;|
| 用法 |stddev_samp(column)|
| 返回值 |DOUBLE |
| 备注   |无|

| 函数名 | percentile|
|-------| ----- |
| 说明 |返回给定百分比的数字列 col 的确切百分位数值。百分比值必须介于 0.0 和 1.0 之间。频率值应为正整数|
| 样例 |SELECT percentile(column,0.8) as result FROM T1;|
| 用法 |percentile(col, percentage [, frequency]) |
| 返回值 |DOUBLE |
| 备注   |无|

##### 条件函数

| 函数名 | if|
|-------| ----- |
| 说明 |如果 expr1 的计算结果为 true，则返回 expr2;否则返回 expr3|
| 样例 |SELECT if(1 < 2, 'a', 'b');<br/><br/>result<br/>-------<br/>a|
| 用法 |if(expr1, expr2, expr3)  |
| 备注   |无|

| 函数名 | case when|
|-------| ----- |
| 说明 |CASE WHEN expr1 THEN expr2 [WHEN expr3 THEN expr4]* [ELSE expr5] END - 当 expr1 = true 时, 返回 expr2; 当 expr3 = true, 返回 expr4; 否则 returns expr5.|
| 样例 |SELECT CASE WHEN 1 > 0 THEN 1 WHEN 2 > 0 THEN 2.0 ELSE 1.2 END;|
| 用法 |CASE WHEN expr1 THEN expr2 [WHEN expr3 THEN expr4]* [ELSE expr5] END  |
| 备注   |N/A|


##### 表值函数

| 函数名 | zip|
|-------| ----- |
| 说明 |将多个特定字段根据特定分隔符分割后合并，再分多行输出|
| 样例 |select explode(zip('\*','11\_21','\\\_','12\_22','\\\_','13\_23','\\\_')) as rt <br/><br/>result<br/>-------<br/>11\*12\*13<br/>21\*22\*23 |
| 用法 |zip(STRING split, [,STRING column, STRING split2]...) |
| 返回值 |STRING |
| 备注   |若分隔符中包含特殊字符 <code>$ ( ) * + . [ ] ? \ ^ { } &#124; "</code>，需在特殊字符前增加反引号 **\\** 进行转义    |

##### 时间函数

| 函数名 | datediff|
|-------| ----- |
| 说明 | 返回从 startDate 到 endDate 的天数|
| 样例 |SELECT datediff('2009-07-31', '2009-07-30');<br/><br/>result<br/>-------<br/>1|
| 用法 |datediff(endDate, startDate) |
| 返回值 |LONG |
| 备注   |无|

| 函数名 | date_format|
|-------| ----- |
| 说明 |将时间戳转换为日期格式 fmt 指定格式的字符串值。|
| 样例 | SELECT date_format('2016-04-08', 'y');<br/><br/>result<br/>-------<br/>2016|
| 用法 |date_format(STRING timestamp, STRING fmt) |
| 返回值 |STRING |
| 备注   |无|

| 函数名 | unix_timestamp|
|-------| ----- |
| 说明 |返回当前 unix 时间戳或者指定的时间戳|
| 样例 | SELECT unix_timestamp();|
| 用法 |unix_timestamp([expr[, pattern]]) |
| 返回值 |LONG |
| 备注   |N/A|

| 函数名 | now|
|-------| ----- |
| 说明 | 返回 SQL 执行的时间|
| 样例 | select CAST(now() AS STRING) as c;|
| 用法 |now() |
| 返回值 |TIMESTAMP |
| 备注   |N/A|

##### 窗口函数

| 函数名 | rank|
|-------| ----- |
| 说明 | 计算一组值中的值的排名。结果是一个加上分区排序中当前行的行数|
| 样例 |select rank() over(partition by column1 order by column2 desc ) as rank from table;|
| 用法 |rank() |
| 返回值 |LONG |
| 备注   |无|
