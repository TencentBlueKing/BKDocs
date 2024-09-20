## BKSQL offline calculation syntax

Since offline computing is based on sparkSQL, the BKSQL syntax basically conforms to the [SQL-92 standard](https://en.wikipedia.org/wiki/SQL-92), and the main syntax is a Select statement

```plain
SELECT ... FROM ... WHERE ... GROUP BY ...
```

Supports commonly used calculation expressions, conditional expressions, branch expressions, aggregate functions, and conversion functions

#### BKSQL Example

* Offline Join example

```plain
select count(*) as count_all, a.DeviceID as adevice, b.DeviceID as bdevice
from PlayerRegisterParseJ145 as a
left join 591_PlayerRegister_parse3 as b on
a.DeviceID = b.DeviceID
group by a.DeviceID
```

* Offline comprehensive example

```plain
select min(dtEventTimeStamp) as thedate,
min(dtEventTimeStamp) as dtEventTimeStamp,
min(dtEventTime) as dtEventTime, '3v3' as module,
case substring(iZoneAreaID,1,1)
when '1' then 'aqq' when '3' then 'awx' when '2' then 'iqq' when '4' then 'iwx' else 'other' end as platform, sum(TotalDisconnNumOnEnd)/6 as lost
from 591_logdt_3v3_pvp_settle where IsPKAI=1 group by substring(iZoneAreaID,1,1)
```

#### Compared with standard SQL, there are the following differences

Currently, only the Select statement and the Insert statement are supported (only the Select statement is used in actual use). Other statements such as Create, Update, Alter, and Delete are not currently supported.

#### Offline calculation function

##### Comparison operators
```plain
=, <>, >=, >, <=, <, IS NOT NULL, IS NULL

```

##### Arithmetic expression
```plain
+, -, *, /
```

##### Logical Operators
```plain
AND, OR, NOT, IN
```

##### String function

| Function name | substring|
|-------| ----- |
| Description |Get a string substring. Intercept the substring starting from position start and having length len. <br/><br/>start starts from 1, and when it is a negative number, it means calculating the position in reverse order from the end of the string. <br/><br/> When the third parameter "select length" is not set, it will be intercepted to the end of the string |
| Sample |SELECT SUBSTRING('k1=v1;k2=v2', 2, 2);<br/><br/>result<br/>-------<br/>1=|
| Usage |SUBSTRING(STRING var1, INT start, INT len) |
| Return value |STRING |
| Remarks |None|

| Function name | substring_index|
|-------| ----- |
| Description | Intercept the string according to the delimiter count. If the length exceeds the actual number of divisions, the original string is returned. |
| Sample |SELECT SUBSTRING_INDEX('abc+dbc', '\\+', 1);<br/><br/>result<br/>-------<br/>abc|
| Usage |SUBSTRING_INDEX(STRING str, STRING pattern, STRING len) |
| Return value |STRING |
| Remarks | If the pattern contains special characters <code>$ ( ) * + . [ ] ? \ ^ { } &#124; "</code>, you need to add backtick **\\** before the special characters. escape |

| Function name | base64|
|-------| ----- |
| Description | Base64 encode the string. |
| Sample |SELECT base64('Spark SQL');<br/><br/>result<br/>-------<br/>U3BhcmsgU1FM|
| Usage |base64(STRING var1) |
| Return value |STRING |
| Remarks |None|

| Function name | concat_ws|
|-------| ----- |
| Description | Concatenate each parameter value and the separator specified by the first parameter separator in sequence to form a new string. |
| Sample |SELECT CONCAT_WS('#', 'a', 'b' );<br/><br/>result<br/>-------<br/>a#b|
| Usage |CONCAT_WS(STRING separator, STRING var1, STRING var2, ...) |
| Return value |STRING |
| Remarks |None|

| Function name | concat|
|-------| ----- |
| Description | Concatenates two or more string values to form a new string. If any parameter is NULL, the parameter is skipped. |
| Sample |SELECT CONCAT('Hello', 'World') as result FROM T1;<br/><br/>result<br/>-------<br/>HelloWorld|
| Usage |CONCAT(STRING var1, STRING var2, ...) |
| Return value |STRING |
| Remarks |None|

| Function name | decode|
|-------| ----- |
| Description | Decodes the first argument using the second argument character set. |
| Sample|SELECT decode(encode('abc', 'utf-8'), 'utf-8');<br/><br/>result<br/>-------<br/ >abc|
| Usage |decode(STRING var1, STRING charset) |
| Return value |STRING |
| Remarks |None|

| Function name | encode|
|-------| ----- |
| Description | Encodes the first argument using the second argument character set. |
| Sample |SELECT encode('abc', 'utf-8');<br/><br/>result<br/>-------<br/>abc|
| Usage |SUBSTRING(STRING var1, INT start, INT len) |
| Return value |STRING |
| Remarks |None|

| Function name | format_string|
|-------| ----- |
| Description |Returns a formatted string from a printf-style format string|
| Sample|SELECT format_string("Hello World %d %s", 100, "days");<br/><br/>result<br/>-------<br/>Hello World 100 days|
| Usage |format_string(STRING strfmt, STRING obj...) |
| Return value |STRING |
| Remarks |None|

| Function name | from_unixtime|
|-------| ----- |
| Description |Returns unix_time in the specified format. |
| Sample|SELECT from_unixtime(0, 'yyyy-MM-dd HH:mm:ss');<br/><br/>result<br/>-------<br/>1970-01 -01 00:00:00|
| Usage |SUBSTRING(LONG unix_time, STRING format) |
| Return value |STRING |
| Remarks |None|

| Function name | lower|
|-------| ----- |
| Description |Change all characters to lowercase|
| Sample |SELECT lower('SparkSql');<br/><br/>result<br/>-------<br/>sparksql|
| Usage |SUBSTRING(STRING var1, INT start, INT len) |
| Return value |STRING |
| Remarks |None|

| Function name | trim|
|-------| ----- |
| Description |Remove leading and trailing space characters from a string|
| Sample |SELECT trim(' SparkSQL ');<br/><br/>result<br/>-------<br/>SparkSQL|
| Usage |trim(STRING str) |
| Return value |STRING |
| Remarks |None|

| Function name | ltrim|
|-------| ----- |
| Description |Remove leading space characters from a string|
| Sample |SELECT ltrim(' SparkSQL ');<br/><br/>result<br/>-------<br/>sparkSQL |
| Usage |ltrim(STRING str) |
| Return value |STRING |
| Remarks |None|

| Function name | rtrim|
|-------| ----- |
| Description |Removes trailing space characters from a string|
| Sample |SELECT rtrim(' SparkSQL ');<br/><br/>result<br/>-------<br/> SparkSQL|
| Usage |rtrim(STRING str) |
| Return value |STRING |
| Remarks |None|

| Function name | upper|
|-------| ----- |
| Description |Change all characters to uppercase|
| Sample |SELECT upper('SparkSql');<br/><br/>result<br/>-------<br/>SPARKSQL|
| Usage |upper(STRING str) |
| Return value |STRING |
| Remarks |None|
| Function name | lpad|
|-------| ----- |
| Description |Returns a string with pad padding on the left and length of length. If the string is longer than length, the return value will be shortened to length characters |
| Sample |SELECT lpad('hi', 5, '??');<br/><br/>result<br/>-------<br/>???hi|
| Usage |lpad(STRING str, INT len, STRING pad) |
| Return value |STRING |
| Remarks |None|

| Function name | rpad|
|-------| ----- |
| Description |Returns a string with pad padding on the right and length of length. If the string is longer than length, the return value will be shortened to length characters |
| Sample |SELECT rpad('hi', 5, '??');<br/><br/>result<br/>-------<br/>hi???|
| Usage |rpad(STRING str, INT len, STRING pad) |
| Return value |STRING |
| Remarks |None|

| Function name | groupconcat|
|-------| ----- |
| Description | String splicing of data columns can support setting the splicing separator, sorting by specified columns in ascending and descending order (default descending order), and deduplication function |
| Sample|SELECT GroupConcat(s1) as new_field;<br/><br/>result<br/>-------<br/>('1') ('2') ('3' ) ==> '1,2,3'<br/><br/>SELECT GroupConcat(s1, '&#124;') as new_field;<br/><br/>result<br/>--------<br/>('1', '&#124;') ('2', '&#124;') ('3', '&#124;') ==> '1&# 124;2&#124;3'<br/><br/>SELECT GroupConcat(s1, '&#124;', s2) as new_field;<br/><br/>result<br/>--------<br/> ('11', '&#124;', '12') ('21', '&#124;', '22') ('31', '&#124;' , '32') ==> '31&#124;21&#124;11'<br/><br/>SELECT GroupConcat(s1, '&#124;', s2, 'asc') as new_field;<br/ /><br/>result<br/>-------<br/> ('11', '&#124;', '12', 'asc') ('21', '&# 124;', '22', 'asc') ('31', '&#124;', '32', 'asc') ==> '11&#124;21&#124;31'<br/> <br/>SELECT GroupConcat(s1, '&#124;', s2, 'desc', 'distinct') as new_field;<br/><br/>result<br/>-------< br/> ('11', '&#124;', '12', 'asc', 'distinct') ('21', '&#124;', '22', 'asc', 'distinct' ) ('21', '&#124;', '22', 'asc', 'distinct') ('31', '&#124;', '32', 'asc', 'distinct') = => '31&#124;21&#124;11'|
| Usage |groupconcat(STRING var, STRING split, STRING order_var, STRING order_rule, STRING distinct) |
| Return value |STRING |
| Remarks |None|

| Function name | regexp_replace|
|-------| ----- |
| Description |Replace all substrings of the string matching the regular expression with new values|
| Sample|SELECT regexp_replace('100-200', '(\d+)', 'num');<br/><br/>result<br/>-------<br/>num -num|
| Usage |regexp_replace(STRING str, STRING reg, STRING replace) |
| Return value |STRING |
| Remarks |None|

| Function name | regexp_extract|
|-------| ----- |
| Description |Extract groups matching the regular expression|
| Sample|SELECT regexp_extract('100-200', '(\d+)-(\d+)', 1);<br/><br/>result<br/>-------<br />100|
| Usage |regexp_extract(STRING str, STRING reg, INT idx) |
| Return value |STRING |
| Remarks |None|

| Function name | replace|
|-------| ----- |
| Description |Replace all occurrences of the search string with the new string|
| Sample |SELECT replace('ABCabc', 'abc', 'DEF');<br/><br/>result<br/>-------<br/>ABCDEF|
| Usage |replace(STRING str, STRING search, String replace) |
| Return value |STRING |
| Remarks |None|

| Function name | split|
|-------| ----- |
| Description | Split matching characters according to regular expressions |
| Sample|SELECT split('oneAtwoBthreeC', '[ABC]');<br/><br/>result<br/>-------<br/>["one","two" ,"three",""]|
| Usage |split(STRING str, STRING regexp) |
| Return value |STRING |
| Remarks | None |

| Function name | SPLIT_INDEX |
|-------| ----- |
| Description | Get a string based on delimiter count, starting from 1. |
| Sample|SELECT SPLIT_INDEX('abc;bcd1;23a;bcb;cd123',';',2) as result FROM T1;<br/><br/>result<br/>------ <br/>bcd1|
| Usage |SPLIT_INDEX(STRING str1, String pattern, INT n) |
| Return value |STRING |
| Remarks | If the pattern contains special characters <code>$ ( ) * + . [ ] ? \ ^ { } &#124; "</code>, you need to add backtick **\\** before the special characters. escape |

| Function name | ZIP |
|-------| ----- |
| Description | Split multiple or one fields according to the specified delimiter, and then splice them together according to the specified splicing character to form multiple lines for output. |
| Sample|SELECT result FROM T1, LATERAL TABLE(ZIP('\*','11\_21','\\\_','12\_22','\\\_','13\_23' ,'\\\_')) AS T(result);<br/><br/>result<br/>-------<br/>11\*12\*13<br/> 21\*22\*23|
| Usage |ZIP(STRING a, STRING str1, STRING b,STRING str2,STRING c,STRING str3,STRING d) |
| Return value |STRING |
| Remarks | If the delimiter parameter contains special characters <code>$ ( ) * + . [ ] ? \ ^ { } &#124; "</code>, you need to add a backtick **\\* before the special characters * to escape |

| Function name | char_length|
|-------| ----- |
| Description |Returns the character length of string data or the number of bytes of binary data. The length of the string data includes trailing spaces. |
| Sample |SELECT char_length('BKSQL ')|
| Usage |char_length(expr) |
| Return value |INT |
| Remarks | N/A |

| Function name | left|
|-------| ----- |
| Description | Returns the leftmost string with length len. If len is less than or equal to 0, returns an empty string |
| Example |SELECT left('BKSQL SQL', 3);|
| Usage |left(str, len) |
| Return value |STRING |
| Remarks | N/A |

| Function name | right|
|-------| ----- |
| Description | Returns the rightmost string with length len. If len is less than or equal to 0, returns an empty string |
| Example |SELECT left('BKSQL SQL', 3);|
| Usage |left(str, len) |
| Return value |INT |
| Remarks | STRING/A |

| Function name | locate|
|-------| ----- |
| Description | Returns the position where substr appears for the first time after pos, starting from 1 |
| Example |locate(substr, str[, pos]);|
| Usage |SELECT locate('bar', 'foobarbar'); |
| Return value |INT |
| Remarks | N/A |

| Function name | instr|
|-------| ----- |
| Description | Returns the index of the first occurrence of substr in str starting from 1 |
| Example |instr(str, substr)|
| Usage |SELECT instr('BKSQL', 'SQL') |
| Return value |INT |
| Remarks | N/A |

##### Math functions

| Function name | sqrt|
|-------| ----- |
| Description |Prescription|
| Sample |SELECT sqrt(4);<br/><br/>result<br/>-------<br/>2.0|
| Usage |sqrt(DOUBLE num) |
| Return value |DOUBLE |
| Remarks |None|

| Function name | round|
|-------| ----- |
| Description |Rounds an expression to the specified number of decimal places using rounding mode|
| Sample |SELECT round(2.5, 0);<br/><br/>result<br/>-------<br/>3.0|
| Usage |ROUND(DOUBLE expr, INT number) |
| Return value |DOUBLE |
| Remarks |None|
| Function name | ceil|
|-------| ----- |
| Description |Returns the smallest integer that is not less than the current value|
| Sample |SELECT ceil(-0.1);<br/><br/>result<br/>-------<br/>0|
| Usage |ceil(DOUBLE number) |
| Return value |LONG |
| Remarks |None|

| Function name | floor|
|-------| ----- |
| Description |Returns the largest integer not greater than the current value|
| Sample |SELECT floor(-0.1);<br/><br/>result<br/>-------<br/>-1|
| Usage |floor(DOUBLE number) |
| Return value |LONG |
| Remarks |None|

| Function name | mod|
|-------| ----- |
| Description |Get the remainder|
| Sample |SELECT MOD(2, 1.8);<br/><br/>result<br/>-------<br/>0.2|
| Usage |MOD(DOUBLE expr1, DOUBLE expr2) |
| Return value |DOUBLE |
| Remarks |None|

| Function name | pmod|
|-------| ----- |
| Description |Returns the positive value of the remainder|
| Sample |SELECT pmod(-10, 3);<br/><br/>result<br/>-------<br/>2|
| Usage |pmod(DOUBLE expr1, DOUBLE expr2) |
| Return value |DOUBLE |
| Remarks |None|

| Function name | length|
|-------| ----- |
| Description |Returns the character length of string data or the number of bytes of binary data. The length of the string data includes trailing spaces. The length of binary data includes binary zeros. |
| Sample |SELECT length('Spark SQL ');<br/><br/>result<br/>-------<br/>10|
| Usage |length(STRING var1) |
| Return value |LONG |
| Remarks |None|

| Function name | abs|
|-------| ----- |
| Description |Get absolute value|
| Sample |SELECT abs(-1);<br/><br/>result<br/>------<br/>1|
| Usage |abs(LONG var1) |
| Return value |LONG |
| Remarks |None|

| Function name | pow|
|-------| ----- |
| Description |Exponentiation|
| Sample |SELECT pow(2, 3);<br/><br/>result<br/>-------<br/>8|
| Usage |pow(double expr1, INT expr2) |
| Return value |DOUBLE |
| Remarks |None|

##### Aggregation function

| Function name | sum|
|-------| ----- |
| Description |Sum |
| Example |SELECT sum(column) as result FROM T1;|
| Usage |sum(column) |
| Return value |LONG |
| Remarks |None|

| Function name | last|
|-------| ----- |
| Description |Return the last value|
| Example |SELECT last(column) as result FROM T1;|
| Usage |last(column) |
| Return value |Type of column |
| Remarks |None|

| Function name | first|
|-------| ----- |
| Description |Return the first value|
| Example |SELECT last(column) as result FROM T1;|
| Usage |first(column) |
| Return value |Type of column |
| Remarks |None|

| Function name | min|
|-------| ----- |
| Description |Minimum value|
| Example |SELECT min(column) as result FROM T1;|
| Usage |min(column) |
| Return value |Type of column |
| Remarks |None|

| Function name | max|
|-------| ----- |
| Description |Maximum value|
| Example |SELECT max(column) as result FROM T1;|
| Usage |max(column) |
| Return value |Type of column |
| Remarks |None|

| Function name | count|
|-------| ----- |
| Description |Sum |
| Sample |SELECT count(column) as result FROM T1;|
| Usage |count(column) |
| Return value |LONG |
| Remarks |None|

| Function name | avg|
|-------| ----- |
| Description | Calculate average |
| Sample |SELECT avg(column) as result FROM T1;|
| Usage |avg(column) |
| Return value |LONG |
| Remarks |None|

| Function name | variance|
|-------| ----- |
| Description |Calculate sample variance|
| Sample |SELECT variance(column) as result FROM T1;|
| Usage |variance(column) |
| Return value |DOUBLE |
| Remarks |None|

| Function name | std|
|-------| ----- |
| Description |Calculate sample standard deviation|
| Sample |SELECT std(column) as result FROM T1;|
| Usage |std(column) |
| Return value |DOUBLE |
| Remarks |None|

| Function name | stddev_pop|
|-------| ----- |
| Description |Calculate population standard deviation|
| Sample |SELECT stddev_pop(column) as result FROM T1;|
| Usage |stddev_pop(column) |
| Return value |DOUBLE |
| Remarks |None|

| Function name | stddev_samp|
|-------| ----- |
| Description |Calculate sample standard deviation|
| Sample |SELECT std(column) as result FROM T1;|
| Usage |stddev_samp(column)|
| Return value |DOUBLE |
| Remarks |None|

| Function name | percentile|
|-------| ----- |
| Description |Returns the exact percentile value of a numeric column col for a given percentage. Percent value must be between 0.0 and 1.0. Frequency value should be a positive integer |
| Example |SELECT percentile(column,0.8) as result FROM T1;|
| Usage |percentile(col, percentage [, frequency]) |
| Return value |DOUBLE |
| Remarks |None|

##### Conditional function

| Function name | if|
|-------| ----- |
| Description |If expr1 evaluates to true, return expr2; otherwise, return expr3|
| Sample |SELECT if(1 < 2, 'a', 'b');<br/><br/>result<br/>-------<br/>a|
| Usage |if(expr1, expr2, expr3) |
| Remarks |None|

| Function name | case when|
|-------| ----- |
| Description |CASE WHEN expr1 THEN expr2 [WHEN expr3 THEN expr4]* [ELSE expr5] END - when expr1 = true, returns expr2; when expr3 = true, returns expr4; otherwise returns expr5.|
| Example |SELECT CASE WHEN 1 > 0 THEN 1 WHEN 2 > 0 THEN 2.0 ELSE 1.2 END;|
| Usage |CASE WHEN expr1 THEN expr2 [WHEN expr3 THEN expr4]* [ELSE expr5] END |
| Remarks |N/A|


##### Table-valued functions

| Function name | zip|
|-------| ----- |
| Description | Split multiple specific fields according to specific separators, merge them, and then output them in multiple lines |
| Sample|select explode(zip('\*','11\_21','\\\_','12\_22','\\\_','13\_23','\\\ _')) as rt <br/><br/>result<br/>-------<br/>11\*12\*13<br/>21\*22\*23 |
| Usage |zip(STRING split, [,STRING column, STRING split2]...) |
| Return value |STRING |
| Remarks | If the delimiter contains special characters <code>$ ( ) * + . [ ] ? \ ^ { } &#124; "</code>, you need to add a backtick **\\** before the special characters Escape |

##### Time function

| Function name | datediff|
|-------| ----- |
| Description | Returns the number of days from startDate to endDate |
| Sample |SELECT datediff('2009-07-31', '2009-07-30');<br/><br/>result<br/>-------<br/>1|
| Usage |datediff(endDate, startDate) |
| Return value |LONG |
| Remarks |None|

| Function name | date_format|
|-------| ----- |
| Description | Convert timestamp to date format fmt A string value in the specified format. |
| Sample | SELECT date_format('2016-04-08', 'y');<br/><br/>result<br/>-------<br/>2016|
| Usage |date_format(STRING timestamp, STRING fmt) |
| Return value |STRING |
| Remarks |None|

| Function name | unix_timestamp|
|-------| ----- |
| Description |Returns the current unix timestamp or the specified timestamp|
| Sample | SELECT unix_timestamp();|
| Usage |unix_timestamp([expr[, pattern]]) |
| Return value |LONG |
| Remarks |N/A|

| Function name | now|
|-------| ----- |
| Description | Returns the SQL execution time |
| Example | select CAST(now() AS STRING) as c;|
| Usage |now() |
| Return value |TIMESTAMP |
| Remarks |N/A|

##### Window function

| Function name | rank|
|-------| ----- |
| Description | Calculates the ranking of a value within a set of values. The result is one plus the number of rows of the current row in the partitioned sort |
| Example |select rank() over(partition by column1 order by column2 desc) as rank from table;|
| Usage |rank() |
| Return value |LONG |
| Remarks |None|