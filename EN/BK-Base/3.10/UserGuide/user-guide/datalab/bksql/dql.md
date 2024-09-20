# DQL (data query) statement

## BKSQL query syntax

The query SQL syntax complies with the SQL-92 standard, and the main syntax is a Select statement, as shown below

```mysql
SELECT ... FROM ... WHERE ... GROUP BY ...
```

Common syntax includes: DISTINCT, COUNT DISTINCT, COUNT IF, SUM IF, UNION, UNION ALL, LEFT JOIN, RIGHT JOIN, JOIN, FULL JOIN

* ### Supported operators

   BKSQL query syntax supports standard SQL four types of operators, as shown below

   * Arithmetic operators: + (addition), - (subtraction), \* (multiplication), / (division), % (remainder or modulo)

   * Comparison operators: =, &lt;=&gt;, &lt;&gt; \(!=\), &lt;=, &gt;=, &gt;, IS NULL, IS NOT NULL, IN, NOT IN, BETWEEN . . . AND. . ., LIKE, NOT LIKE

   * Logical operators: NOT\(logical NOT\), AND\(logical AND\), OR\(logical OR\), XOR\(XOR\)

   * Bit operators: bitwise OR (\|), bitwise AND (&), bitwise XOR (^)

* ### Supported expressions

   BKSQL query syntax supports standard SQL expressions as shown below

   * Arithmetic expression: Supports \(+ - \* / % \) arithmetic operators to form expressions, and the result of the expression is a numerical value.

     grammar:

     ```sql
     SELECT numerical_expression as OPERATION_NAME[FROM table_name WHERE CONDITION];
     ```

     example:

     ```sql
     SELECT (1+2) from tableA where tableA.c1=1000;
     ```

   * Conditional expression: supports comparison operators such as \(= = &gt; &gt;= &lt; &lt;= != is is not in not in like not like\), and logical operators \(AND, OR\) or A conditional expression composed of parentheses, the result of the expression is true or false.

     grammar:

     ```sql
     SELECT column1, column2, columnN FROM table_name WHERE [CONDITION|EXPRESSION];
     ```

     example:

     ```sql
     SELECT c1 from tableA where tableA.c1=1000;
     ```

   * Branch expression: Case ... When ... Then ... \[Else\] ... End

     Syntax 1:

     ```mysql
     CASE input_expression
     WHEN when_expression THEN
       result_expression [...n ] [
     ELSE
         else_result_expression
     END
     ```

     Syntax 2:

     ```mysql
     CASE
     WHEN Boolean_expression THEN
       result_expression [...n ] [
     ELSE
         else_result_expression
     END
     ```

     example:

     ```mysql
     select case worldid when 1001 then 100100 when 1002 then 100200 else 100000 end as new_worldid from tableA;
     ```

   * Regular expressions: Different storage engines have different writing methods for regular expressions. Please refer to their respective official documents for details.

* ### Common functions supported

   String functions

| Function name | Usage | Description | Return value | TSpider/MySQL | HDFS |
| --- | :--- | --- | --- | --- | --- |
| lower | lower\(string a\) | Convert to lowercase, convert string a to lowercase | string | Support | Support |
| upper | upper\(string a\) | Convert to uppercase, convert string a to uppercase | string | Support | Support |
| length | length\(string a\) | Returns the length of string a | int | supported | supported |
| char\_length | char\_length\(string a\) | Returns the number of characters in string a | int | Supported | Not supported |
| trim | trim\(string a\) | Remove the spaces on the left and right sides of string a | string | Support | Support |
| rtrim | rtrim\(string a\) | Remove the spaces to the right of string a | string | Support | Support |
| ltrim | ltrim\(string a\) | Delete the spaces to the left of string a | string | Support | Support |
| concat | concat\(string a,string b,...\) | Concatenate strings, concatenate fields a, b... into a new string | string | Support | Support |
| concat\_ws | concat\_ws\(string s,string a,string b\) | Splice strings according to delimiters, splice new strings for fields a, b..., and splice delimiter s in the middle of each field | string | supported | not supported |
| substr | substr\(string a, int start, int length\) | Intercept the substring of length length from the start position of string a | string | Support | Support |
| split | split\(string a, char delimiter\) | Split string a according to the delimiter | array\(string\) | Not supported | Supported |

mathematical functions

| Function name | Usage | Description | Return value | TSpider/MySQL | HDFS |
| --- | --- | --- | --- | --- | --- |
| abs | abs\(a\) | Get the absolute value, the input is numeric type | Numerical type | Support | Support |
| ceil | ceil\(a\) | Returns the smallest integer greater than or equal to a | long | supported | supported |
| floor | floor\(a\) | Returns the smallest integer less than or equal to a | long | supported | supported |
| pow | pow\(a,n\) | To perform multiplication, raise nth power of field a | double | Support | Support |
| sqrt | sqrt\(a\) | Returns the square root of a | double | Supported | Supported |
| round | round\(a,n\) | Round the value, round the value of field a and retain n decimal points | double | Support | Support |
| mod | mod\(a,b\) | Returns the remainder after dividing a by b | int | Support | Support |
| truncate | truncate\(a,n\) | Returns the value a retained to n digits after the decimal point (the biggest difference from round is that it will not be rounded) | double | Support | Support |

aggregate function

| Function name | Usage | Description | Return value | TSpider/MySQL | HDFS |
| --- | --- | --- | --- | --- | --- |
| min | min\(a\) | Returns the minimum value in field a | Numeric type | Support | Support |
| max | max\(a\) | Returns the maximum value in field a | Numeric type | Supported | Supported |
| sum | sum\(a\) | Returns the sum of the specified field a | Numeric type | Supported | Supported |
| avg | avg\(a\) | Returns the average value of the specified field a | Numeric type | Supported | Supported |
| count | count\(\*\) | Returns the number of rows that meet the condition | long | Support | Support |
| distinct | distinct\(a\) | Return the field after deduplication | | Support | Support |

control flow function

| Function name | Usage | Description | TSpider/MySQL | HDFS |
| --- | --- | --- | --- | --- |
| if | if\(expr1,expr2,expr3\) | If expr1 is true, return expr2, otherwise return expr3 | Support | Support |
| Case ... When ... Then ... \[Else\] ... End | case when expr1then expr2 \[when \[expr3\] then expr4 ...\]\[else expr5\] end | If expr1 is established, expr2 is returned. There can be multiple judgment expressions and the corresponding results are returned | Support | Support |
| nullif | nullif\(a,b\) | Compares two values, returns null if a and b are equal, otherwise returns a | Support | Support |
| coalesce | coalesce\(expr1, expr2, …, expr\_n\) | Returns the first non-empty expression in the parameter (from left to right) | Support | Support |

## SQL differences for each storage

| Features | TSpider/MySQL | HDFS |
| :---: | :---: | :---: |
| minuteX | supported | not supported |
| join | support | support |
| where | needs to contain one of dteventtimestamp, dteventtime, and thedate | needs to contain one of dteventtime, thedate |
| order by | support | support |
| time | not supported | not supported |
| limit | default limit 100 | must be added |
| Time field d h m | Not supported | Not supported |
| distinct | support | support |

Note: For related usage of other functions of each storage engine, please refer to the corresponding official documents or online information.

- [HDFS function list](https://trino.io/docs/current/functions.html)

- [MySQL function list](https://dev.mysql.com/doc/refman/5.7/en/functions.html)