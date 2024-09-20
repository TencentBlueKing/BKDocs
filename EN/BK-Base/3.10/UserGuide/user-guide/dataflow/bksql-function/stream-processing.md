
## BKSQL real-time calculation syntax


BKSQL syntax basically conforms to [SQL-92 standard](https://en.wikipedia.org/wiki/SQL-92), and the main syntax is a Select statement
```plain
SELECT, FROM, WHERE, LIKE, GROUP BY, DISTINCT
```

#### Compared with standard SQL, there are the following differences

* Currently only the Select statement and the Insert statement are supported (only the Select statement is used in actual use). Other statements such as Create, Update, Alter, Delete, etc. are currently not supported;
* The syntax currently does not support nested subqueries. Subqueries are implemented through the inheritance relationship between statements;

####  type of data
```plain
STRING, LONG, INT, FLOAT, DOUBLE
```

#### Real-time calculation function

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


| Function name | CHAR_LENGTH |
|-------| ----- |
| Description |Returns the number of characters in the string. |
| Sample |SELECT CHAR_LENGTH('dd') as result FROM T1;<br/><br/>result<br/>-------<br/>2|
| Usage |CHAR_LENGTH(STRING var1) |
| Return value |INT |
| Remarks |None|


| Function name | length|
|-------| ----- |
| Description |Returns the character length of string data or the number of bytes of binary data. The length of the string data includes trailing spaces. The length of binary data includes binary zeros. |
| Sample |SELECT length('Spark SQL ');<br/><br/>result<br/>-------<br/>10|
| Usage |length(STRING var1) |
| Return value |LONG |
| Remarks |None|


| Function name | SUBSTRING |
|-------| ----- |
| Description |Get a string substring. Intercept the substring starting from position start and having length len. <br/><br/>start starts from 1, and when it is a negative number, it means calculating the position in reverse order from the end of the string. <br/><br/> When the third parameter "select length" is not set, it will be intercepted to the end of the string |
| Sample|SELECT SUBSTRING('k1=v1;k2=v2', 2, 2) as result FROM T1;<br/><br/>result<br/>-------<br/> 1=|
| Usage |SUBSTRING(STRING var1, INT start, INT len) |
| Return value |STRING |
| Remarks |None|


| Function name | UPPER |
|-------| ----- |
| Description | Returns a string converted to uppercase characters. |
| Sample |SELECT UPPER('ss') as result FROM T1;<br/><br/>result<br/>-------<br/>SS|
| Usage |UPPER(STRING var1) |
| Return value |STRING |
| Remarks |None|


| Function name | LOWER |
|-------| ----- |
| Description | Returns a string converted to lowercase characters. |
| Sample |SELECT LOWER('Ss') as result FROM T1;<br/><br/>result<br/>-------<br/>ss|
| Usage |LOWER(STRING var1) |
| Return value |STRING |
| Remarks |None|


| Function name | TRIM |
|-------| ----- |
| Description |Remove the beginning or end of a word in a string. The most common use is to remove leading or trailing spaces. |
| Sample |SELECT TRIM(' Sample ') as result FROM T1;<br/><br/>result<br/>-------<br/>Sample|
| Usage |TRIM(STRING var1) |
| Return value |STRING |
| Remarks |None|


| Function name | LTRIM |
|-------| ----- |
| Description |Remove whitespace characters from the left end of the string. |
| Sample |SELECT LTRIM(' Sample') as result FROM T1;<br/><br/>result<br/>-------<br/>Sample|
| Usage |LTRIM(STRING var1) |
| Return value |STRING |
| Remarks |None|


| Function name | RTRIM |
|-------| ----- |
| Description |Remove whitespace characters from the right end of the string. |
| Sample |SELECT RTRIM('Sample ') as result FROM T1;<br/><br/>result<br/>-------<br/>Sample|
| Usage |RTRIM(STRING var1) |
| Return value |STRING |
| Remarks |None|


| Function name | REPLACE |
|-------| ----- |
| Description | Replaces the specified substring in a string with the new substring. |
| Sample |SELECT REPLACE('abcbcd123','bc','www') as result FROM T1;<br/><br/>result<br/>-------<br/>awwwwwwd123|
| Usage |REPLACE(STRING a, STRING b, STRING c) |
| Return value |STRING |
| Remarks |None|


| Function name | LEFT |
|-------| ----- |
| Description | Get a substring of specified length from the left side of the string. |
| Sample |SELECT LEFT('abcbcd123', 2) as result FROM T1;<br/><br/>result<br/>-------<br/>ab|
| Usage |LEFT(STRING a, STRING b) |
| Return value |STRING |
| Remarks |None|



| Function name | RIGHT |
|-------| ----- |
| Description | Get a substring of specified length from the right side of the string. |
| Sample |SELECT RIGHT('abcbcd123', 2) as result FROM T1;<br/><br/>result<br/>-------<br/>23|
| Usage |RIGHT(STRING a, STRING b) |
| Return value |STRING |
| Remarks |None|


| Function name | REGEXP_REPLACE |
|-------| ----- |
| Description | Replace the substring of the regular pattern pattern in the string str with the string replacement and return a new string. Regular match replacement, if the parameter is null or the regular pattern is illegal, null will be returned. |
| Sample|SELECT REGEXP_REPLACE('2014-03-13', '-', '') as result FROM T1;<br/><br/>result<br/>-------<br/ >20140313|
| Usage |REGEXP_REPLACE(STRING str, STRING pattern, STRING replacement) |
| Return value |STRING |
| Remarks |None|


| Function name | CONCAT |
|-------| ----- |
| Description | Concatenates two or more string values to form a new string. If any parameter is NULL, NULL is returned. |
| Sample |SELECT CONCAT('Hello', 'World') as result FROM T1;<br/><br/>result<br/>-------<br/>HelloWorld|
| Usage |CONCAT(STRING var1, STRING var2, ...) |
| Return value |STRING |
| Remarks |None|


| Function name | SUBSTRING_INDEX |
|-------| ----- |
| Description | Intercept the string according to the delimiter count. If the length exceeds the actual number of divisions, the original string is returned. |
| Sample|SELECT SUBSTRING_INDEX('abc+dbc', '\\\+', 1) as result FROM T1;<br/><br/>result<br/>-------<br/ >abc|
| Usage |SUBSTRING_INDEX(STRING str, STRING pattern, STRING len) |
| Return value |STRING |
| Remarks | If the pattern contains special characters <code>$ ( ) * + . [ ] ? \ ^ { } &#124; "</code>, you need to add backtick **\\** before the special characters. escape |


| Function name | LOCATE |
|-------| ----- |
| Description | Returns the number of times the substring appears after the specified position in the specified string (starting from 1). The third parameter is the position to start the query (optional), which defaults to starting from 1. |
| Sample |SELECT LOCATE(‘bc’,’abcbcd123’,3) as result FROM T1;<br/><br/>result<br/>-------<br/>4|
| Usage |LOCATE(STRING str1, STRING str2, INT n) |
| Return value |INT |
| Remarks |None|

| Function name | MID |
|-------| ----- |
| Description | Intercept the substring of the specified length from the specified position. |
| Sample |SELECT MID(‘abcbcd123’,2,5) as result FROM T1;<br/><br/>result<br/>-------<br/>cbcd1|
| Usage |MID(STRING str1, INT str2, INT n) |
| Return value |STRING |
| Remarks |None|


| Function name | SPLIT_INDEX |
|-------| ----- |
| Description | Get a string based on delimiter count, starting from 1. |
| Sample|SELECT SPLIT_INDEX('abc;bcd1;23a;bcb;cd123',';',2) as result FROM T1;<br/><br/>result<br/>------ <br/>bcd1|
| Usage |SPLIT_INDEX(STRING str1, String pattern, INT n) |
| Return value |STRING |
| Remarks | If the pattern contains special characters <code>$ ( ) * + . [ ] ? \ ^ { } &#124; "</code>, you need to add backtick **\\** before the special characters. escape |


| Function name | INET_ATON |
|-------| ----- |
| Description | IP to Long. |
| Sample |SELECT INET_ATON('10.0.0.1') as result FROM T1;<br/><br/>result<br/>-------<br/>169681473|
| Usage |INET_ATON(STRING str1) |
| Return value |LONG |
| Remarks |None|


| Function name | INET_NTOA |
|-------| ----- |
| Description | Long to IP. |
| Sample |SELECT INET_NTOA(169681473) as result FROM T1;<br/><br/>result<br/>-------<br/>10.0.0.1|
| Usage |INET_NTOA(LONG str1) |
| Return value |STRING |
| Remarks |None|


| Function name | CONCAT_WS |
|-------| ----- |
| Description | Concatenate each parameter value and the separator specified by the first parameter separator in sequence to form a new string. Parameters that are NULL are automatically skipped. |
| Sample|SELECT CONCAT_WS('#', 'a', 'b' ) as result FROM T1;<br/><br/>result<br/>-------<br/>a# b|
| Usage |CONCAT_WS(STRING separator, STRING var1, STRING var2, ...) |
| Return value |STRING |
| Remarks |None|


| Function name | CONTAINS_SUBSTRING |
|-------| ----- |
| Description | Determine whether the string contains the specified substring. |
| Sample |SELECT CONTAINS_SUBSTRING(‘abcbcd123’,’bcd12’) as result FROM T1;<br/><br/>result<br/>-------<br/>True|
| Usage |CONTAINS_SUBSTRING(STRING var1, STRING var2) |
| Return value |boolean |
| Remarks |None|


| Function name | INSTR |
|-------| ----- |
| Description | Returns the position of the first occurrence of the substring in the specified string (starting from 1). |
| Sample |SELECT INSTR(‘abcbcd123’,’bc’) as result FROM T1;<br/><br/>result<br/>-------<br/>2|
| Usage |INSTR(STRING var1, STRING var2) |
| Return value |INT |
| Remarks |None|


| Function name | REGEXP_EXTRACT |
|-------| ----- |
| Description | Split the string according to the rules of regex regular expression and return the characters specified by index. |
| Sample|SELECT regexp_extract('100-200', '(\d+)-(\d+)', 1) as result FROM T1;<br/><br/>result<br/>--------<br/>100|
| Usage |INSTR(STRING str, STRING regex, INT index) |
| Return value |INT |
| Remarks |None|


| Function name | LPAD|
|-------| ----- |
| Description |Returns a string with pad padding on the left and length of length. If the string is longer than length, the return value will be shortened to length characters |
| Sample |SELECT LPAD('hi', 5, '??');<br/><br/>result<br/>-------<br/>???hi|
| Usage |LPAD(STRING str, INT len, STRING pad) |
| Return value |STRING |
| Remarks |None|


| Function name | RPAD|
|-------| ----- |
| Description |Returns a string with pad padding on the right and length of length. If the string is longer than length, the return value will be shortened to length characters |
| Sample |SELECT RPAD('hi', 5, '??');<br/><br/>result<br/>-------<br/>hi???|
| Usage |RPAD(STRING str, INT len, STRING pad) |
| Return value |STRING |
| Remarks |None|


##### Math functions


| Function name | ROUND |
|-------| ----- |
| Description | Rounds a numeric x field to the specified n decimal places. |
| Sample |SELECT ROUND(0.717,2) as result FROM T1;<br/><br/>result<br/>-------<br/>0.72|
| Usage |ROUND(DOUBLE var1, INT n) |
| Return value |DOUBLE |
| Remarks |None|


| Function name | POWER |
|-------| ----- |
| Description | Returns A raised to the power B. |
| Sample |SELECT POWER(2.0, 3.0) as result FROM T1;<br/><br/>result<br/>-------<br/>8|
| Usage |POWER(DOUBLE in1, DOUBLE in2) |
| Return value |DOUBLE |
| Remarks |None|


| Function name | ABS |
|-------| ----- |
| Description | Returns the absolute value of A. |
| Sample |SELECT ABS(-16) as result FROM T1;<br/><br/>result<br/>-------<br/>16|
| Usage |ABS(DOUBLE in1) |
| Return value |DOUBLE |
| Remarks |None|


| Function name | SQRT |
|-------| ----- |
| Description | Returns the square root of A. |
| Sample |SELECT SQRT(8.0) as result FROM T1;<br/><br/>result<br/>-------<br/>2.8284271|
| Usage |SQRT(DOUBLE in1) |
| Return value |DOUBLE |
| Remarks |None|

| Function name | FLOOR |
|-------| ----- |
| Description | Round off decimal places. Returns the largest integer value less than or equal to A. The data type of output A is the same as the input type. |
| Sample |SELECT FLOOR(2.2) as result FROM T1;<br/><br/>result<br/>-------<br/>2.0|
| Usage |FLOOR(INT/LONG/FLOAT/DOUBLE in1) |
| Return value |INT/LONG/FLOAT/DOUBLE |
| Remarks |None|


| Function name | CEIL |
|-------| ----- |
| Description | Output B is the smallest integer value greater than or equal to input value A. The data type of output B is consistent with the data type of input parameter A. |
| Sample |SELECT CEIL(0.2) as result FROM T1;<br/><br/>result<br/>-------<br/>1.0|
| Usage |CEIL(INT/LONG/FLOAT/DOUBLE in1) |
| Return value |INT/LONG/FLOAT/DOUBLE |
| Remarks |None|


| Function name | TRUNCATE |
|-------| ----- |
| Description | Reserves the specified number of digits in a value. |
| Sample |SELECT TRUNCATE(1.026, 2) as result FROM T1;<br/><br/>result<br/>-------<br/>1.02|
| Usage |TRUNCATE(FLOAT/DOUBLE in1, INT n) |
| Return value |FLOAT/DOUBLE |
| Remarks |None|


| Function name | MOD |
|-------| ----- |
| Description | In integer arithmetic, find the remainder of dividing integer x by integer y. When x is negative, or both x and y are negative, the result is negative. |
| Sample |SELECT MOD(29, 3) as result FROM T1;<br/><br/>result<br/>-------<br/>2|
| Usage |MOD(INT in1, INT n) |
| Return value |INT |
| Remarks |None|


| Function name | INT_OVERFLOW |
|-------| ----- |
| Description | int type qq overflow conversion function. |
| Sample |SELECT INT_OVERFLOW(-1448817156) as result FROM T1;<br/><br/>result<br/>-------<br/>2846150140|
| Usage |INT_OVERFLOW(INT i) |
| Return value |LONG |
| Remarks |None|


##### Conditional function


| Function name | CASE WHEN |
|-------| ----- |
| Description | If a is TRUE, returns b; if c is TRUE, returns d; otherwise, returns e. |
| Sample|SELECT case when 1<>1 then 'data' else 'flow' end as result FROM TABLE;<br/><br/>result<br/>-------<br/>flow |
| Usage |CASE WHEN a THEN b [WHEN c THEN d]*[ELSE e] END |
| Return value |T |
| Remarks |None|


| Function name | IF |
|-------| ----- |
| Description | If the expression testCondition evaluates to TRUE, returns valueTrue; otherwise, returns valueFalseOrNull. |
| Sample |SELECT IF(1 < 2,'abc', 'nnn') as result FROM T1;<br/><br/>result<br/>-------<br/>abc|
| Usage |IF(BOOLEAN testCondition, T valueTrue, T valueFalseOrNull) |
| Return value |T |
| Remarks |None|

##### Type conversion function

| Function name | CAST |
|-------| ----- |
| Description | Converts an A value to the given type. |
| Sample |SELECT CAST(var1 as INT) as result FROM T1;<br/><br/>result<br/>-------<br/>1000|
| Usage |CAST(A AS type) |
| Return value |type |
| Remarks |None|

*Note: Data type correspondence*

| *sql type* | *data type* |
|-------| ----- |
| *VARCHAR* | *STRING*|
| *INT* | *INT*|
| *BIGINT* | *LONG*|
| *FLOAT* | *FLOAT*|
| *DOUBLE* | *DOUBLE*|

*Convert data type to string: cast(var as varchar)*
*Convert data type to int: cast(var as int)*
*Convert data type to long: cast(var as bigint)*
*Convert data type to float: cast(var as float)*
*Convert data type to double: cast(var as double)*

##### Aggregation function


| Function name | AVG |
|-------| ----- |
| Description |Returns the average of all input values. |
| Sample |SELECT AVG(var1) as result FROM T1;<br/><br/>result<br/>-------<br/>8|
| Usage |AVG(INT/DOUBLE/FLOAT/LONG var1) |
| Return value |DOUBLE |
| Remarks |None|


| Function name | SUM |
|-------| ----- |
| Description |Returns the numerical sum of all input values. |
| Sample |SELECT SUM(var1) as result FROM T1;<br/><br/>result<br/>-------<br/>8|
| Usage |SUM(INT/DOUBLE/FLOAT/LONG var1) |
| Return value |INT/DOUBLE/FLOAT/LONG |
| Remarks |None|


| Function name | stddev_pop|
|-------| ----- |
| Description |Calculate population standard deviation|
| Sample |SELECT stddev_pop(var1) as result FROM T1 group by var2;|
| Usage |stddev_pop(INT/DOUBLE/FLOAT/LONG var1) |
| Return value |INT/DOUBLE/FLOAT/LONG |
| Remarks |None|

| Function name | stddev_samp|
|-------| ----- |
| Description |Calculate sample standard deviation|
| Sample |SELECT stddev_samp(var1) as result FROM T1 group by var2;|
| Usage |stddev_samp(INT/DOUBLE/FLOAT/LONG var1)|
| Return value |INT/DOUBLE/FLOAT/LONG |
| Remarks |None|


| Function name | COUNT |
|-------| ----- |
| Description |Returns the number of input columns. |
| Sample |SELECT COUNT(var1) as result FROM T1;<br/><br/>result<br/>-------<br/>8|
| Usage |COUNT(INT/DOUBLE/FLOAT/LONG/STRING var1) |
| Return value |LONG |
| Remarks |None|


| Function name | LAST |
|-------| ----- |
| Description |Returns the last field value of all input values. |
| Sample |SELECT LAST(var1) as result FROM T1;<br/><br/>result<br/>-------<br/>8|
| Usage |LAST(INT/DOUBLE/FLOAT/LONG/STRING var1) |
| Return value |INT/DOUBLE/FLOAT/LONG/STRING |
| Remarks |None|


| Function name | MIN |
|-------| ----- |
| Description |Returns the minimum value of all input values. |
| Sample |SELECT MIN(var1) as result FROM T1;<br/><br/>result<br/>-------<br/>8|
| Usage |MIN(INT/DOUBLE/FLOAT/LONG var1) |
| Return value |INT/DOUBLE/FLOAT/LONG |
| Remarks |None|


| Function name | MAX |
|-------| ----- |
| Description |Returns the maximum value of all input values. |
| Sample |SELECT MAX(var1) as result FROM T1;<br/><br/>result<br/>-------<br/>8|
| Usage |MAX(INT/DOUBLE/FLOAT/LONG var1) |
| Return value |INT/DOUBLE/FLOAT/LONG |
| Remarks |None|


| Function name | COUNT_DISTINCT |
|-------| ----- |
| Description |Returns the number of unique data in the input column. |
| Sample |SELECT COUNT(DISTINCT var1) as result FROM T1;<br/><br/>result<br/>-------<br/>3|
| Usage |COUNT(INT/DOUBLE/FLOAT/LONG/STRING var1) |
| Return value |LONG |
| Remarks |None|


##### Time function


| Function name | UNIXTIME_DIFF |
|-------| ----- |
| Description | Calculate the time difference between two timestamps (in seconds). |
| Sample |SELECT UNIXTIME_DIFF(1466436000,1466434200,'minute') as result FROM T1;<br/><br/>result<br/>-------<br/>3|
| Usage |UNIXTIME_DIFF(LONG u1, LONG u2, STRING str) |
| Return value |INT |
| Remarks |None|

| Function name | NOW |
|-------| ----- |
| Description | Current date and time, specified format. |
| Sample |SELECT NOW('yyyyMMddHHmmss') as result FROM T1;<br/><br/>result<br/>-------<br/>20160621194437|
| Usage |NOW(STRING str) |
| Return value |STRING |
| Remarks |None|


| Function name | UNIX_TIMESTAMP |
|-------| ----- |
| Description | Get the timestamp of the current date and time (in seconds). |
| Sample |SELECT UNIX_TIMESTAMP() as result FROM T1;<br/><br/>result<br/>-------<br/>1466436000|
| Usage |UNIX_TIMESTAMP() |
| Return value |INT |
| Remarks |None|


| Function name | CURDATE |
|-------| ----- |
| Description | The current date, you can choose to specify the format, the default format: 'YYYY-MM-dd'. |
| Sample |SELECT CURDATE('YYYYMMdd') as result FROM T1;<br/><br/>result<br/>-------<br/>20160621|
| Usage |CURDATE(STRING str) |
| Return value |STRING |
| Remarks |None|


| Function name | FROM_UNIXTIME |
|-------| ----- |
| Description | Convert a timestamp (in seconds) to a datetime (specified format) string. |
| Sample|SELECT FROM_UNIXTIME(CAST(1466436000 AS BIGINT), 'yyyy/MM/dd/HH/mm/ss') as result FROM T1;<br/><br/>result<br/>--------<br/>2016/06/20/23/20/00|
| Usage |FROM_UNIXTIME(LONG u1, STRING str) |
| Return value |STRING |
| Remarks |None|


| Function name | UNIX_TIMESTAMP |
|-------| ----- |
| Description | Converts a datetime (specified format) string to a timestamp (in seconds). |
| Sample|SELECT UNIX_TIMESTAMP('2021-01-14 23:09:15','yyyy-MM-dd HH:mm:ss') as result FROM T1;<br/><br/>result<br/ >-------<br/>1610636955|
| Usage |UNIX_TIMESTAMP(STRING str, STRING format) |
| Return value |INT |
| Remarks |None|


##### Table-valued functions


| Function name | ZIP |
|-------| ----- |
| Description | Split multiple or one fields according to the specified delimiter, and then splice them together according to the specified splicing character to form multiple lines for output. |
| Sample|SELECT result FROM T1, LATERAL TABLE(ZIP('\*','11\_21','\\\_','12\_22','\\\_','13\_23' ,'\\\_')) AS T(result);<br/><br/>result<br/>-------<br/>11\*12\*13<br/> 21\*22\*23|
| Usage |ZIP(STRING a, STRING str1, STRING b,STRING str2,STRING c,STRING str3,STRING d) |
| Return value |STRING |
| Remarks | If the delimiter parameter contains special characters <code>$ ( ) * + . [ ] ? \ ^ { } &#124; "</code>, you need to add a backtick **\\* before the special characters * to escape |


| Function name | SPLIT_FIELD_TO_RECORDS |
|-------| ----- |
| Description | Split multiple or one fields according to the specified delimiter, and then splice them together according to the specified splicing character to form multiple lines for output. |
| Sample|SELECT result FROM T1, LATERAL TABLE(SPLIT\_FIELD\_TO\_RECORDS('11\_21','\\\_')) AS T(result);<br/><br/>result< br/>-------<br/>11<br/>21|
| Usage |SPLIT_FIELD_TO_RECORDS(STRING str, STRING a) |
| Return value |STRING |
| Remarks | If the delimiter parameter contains special characters <code>$ ( ) * + . [ ] ? \ ^ { } &#124; "</code>, you need to add a backtick **\\* before the special characters * to escape |


