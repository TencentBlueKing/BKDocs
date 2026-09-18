# DQL(数据查询)语句

## BKSQL 查询语法

查询 SQL 语法符合 SQL-92 标准，主体语法为一个 Select 语句，如下所示

```mysql
SELECT ... FROM ... WHERE ... GROUP BY ...
```

通用语法包含：DISTINCT、COUNT DISTINCT、COUNT IF、SUM IF、UNION、UNION ALL、LEFT JOIN、RIGHT JOIN、JOIN、FULL JOIN

* ### 支持的运算符

  BKSQL 查询语法支持标准 SQL 四类运算符，如下所示

  * 算数运算符：+（加）、 -（减）、 \*（乘）、 /（除）、 %（求余或者模）

  * 比较运算符：=、&lt;=&gt;、&lt;&gt; \(!=\)、&lt;=、&gt;=、&gt;、IS NULL、IS NOT NULL、IN、NOT IN、BETWEEN . . . AND. . .、LIKE、NOT LIKE

  * 逻辑运算符：NOT\(逻辑非\)、AND\(逻辑与\)、OR\(逻辑或\)、XOR\(异或\)

  * 位运算符：位或（\|）、位与（&）、位异或（^ ）

* ### 支持的表达式

  BKSQL 查询语法支持标准 SQL 表达式，如下所示

  * 算数表达式：支持\(+ - \* / % \)算数运算符组成表达式，表达式的结果是数值。

    语法：

    ```sql
    SELECT numerical_expression as OPERATION_NAME[FROM table_name WHERE CONDITION];
    ```

    例子：

    ```sql
    SELECT (1+2) from tableA where tableA.c1=1000;
    ```

  * 条件表达式：支持\(=  =  &gt;  &gt;=  &lt;  &lt;=  !=  is  is not  in  not in  like  not  like\) 等比较运算符，和逻辑运算符\(AND、OR\)或者括号组成的条件表达式，表达式的结果是 true or false。

    语法：

    ```sql
    SELECT column1, column2, columnN FROM table_name WHERE [CONDITION|EXPRESSION];
    ```

    例子：

    ```sql
    SELECT c1 from tableA where tableA.c1=1000;
    ```

  * 分支表达式：Case ... When ... Then ... \[Else\] ... End

    语法 1：

    ```mysql
    CASE input_expression
    WHEN when_expression THEN
      result_expression [...n ] [
    ELSE
        else_result_expression
    END
    ```

    语法 2：

    ```mysql
    CASE
    WHEN Boolean_expression THEN
      result_expression [...n ] [
    ELSE
        else_result_expression
    END
    ```

    例子：

    ```mysql
    select case worldid when 1001 then 100100 when 1002 then 100200 else 100000 end as new_worldid from tableA;
    ```

  * 正则表达式：不同的存储引擎正则表达式写法会有区别，具体请参考各自的官方文档

* ### 支持的常用函数

  字符串函数

| 函数名 | 用法 | 说明 | 返回值 | TSpider/MySQL | HDFS |
| --- | :--- | --- | --- | --- | --- |
| lower | lower\(string a\) | 转小写，将字符串 a 转换    成小写 | string | 支持 | 支持 |
| upper | upper\(string a\) | 转大写，将字符串 a 转换成大写 | string | 支持 | 支持 |
| length | length\(string a\) | 返回字符串 a 的长度 | int | 支持 | 支持 |
| char\_length | char\_length\(string a\) | 返回字符串 a 的字符数 | int | 支持 | 不支持 |
| trim | trim\(string a\) | 删除字符串 a 左右两边的空格 | string | 支持 | 支持 |
| rtrim | rtrim\(string a\) | 删除字符串 a 右边的空格 | string | 支持 | 支持 |
| ltrim | ltrim\(string a\) | 删除字符串 a 左边的空格 | string | 支持 | 支持 |
| concat | concat\(string a,string b,...\) | 拼接字符串，将字段 a，b……拼接为新的字符串 | string | 支持 | 支持 |
| concat\_ws | concat\_ws\(string s,string a,string b\) | 根据分隔符拼接字符串，对字段 a,b……拼接新的字符串，每个字段中间拼接分隔符 s | string | 支持 | 不支持 |
| substr | substr\(string a, int start, int length\) | 从字符串 a 的 start 位置截取长度为 length 的子字符串 | string | 支持 | 支持 |
| split | split\(string a, char delimiter\) | 将字符串 a 按分隔符进行分割 | array\(string\) | 不支持 | 支持 |

数学函数

| 函数名 | 用法 | 说明 | 返回值 | TSpider/MySQL | HDFS |
| --- | --- | --- | --- | --- | --- |
| abs | abs\(a\) | 取绝对值，输入为数值型 | 数值型 | 支持 | 支持 |
| ceil | ceil\(a\) | 返回大于或等于 a 的最小整数 | long | 支持 | 支持 |
| floor | floor\(a\) | 返回小于或等于 a 的最小整数 | long | 支持 | 支持 |
| pow | pow\(a,n\) | 求乘法，对字段 a 求 n 次方 | double | 支持 | 支持 |
| sqrt | sqrt\(a\) | 返回 a 的平方根 | double | 支持 | 支持 |
| round | round\(a,n\) | 四舍五入取值，对字段 a 四舍五入取值并保留 n 位小数点 | double | 支持 | 支持 |
| mod | mod\(a,b\) | 返回 a 除以 b 以后的余数 | int | 支持 | 支持 |
| truncate | truncate\(a,n\) | 返回数值 a 保留到小数点后 n 位的值（与 round 最大的区别是不会进行四舍五入） | double | 支持 | 支持 |

聚合函数

| 函数名 | 用法 | 说明 | 返回值 | TSpider/MySQL | HDFS |
| --- | --- | --- | --- | --- | --- |
| min | min\(a\) | 返回字段 a 中的最小值 | 数值型 | 支持 | 支持 |
| max | max\(a\) | 返回字段 a 中的最大值 | 数值型 | 支持 | 支持 |
| sum | sum\(a\) | 返回指定字段 a 的总和 | 数值型 | 支持 | 支持 |
| avg | avg\(a\) | 返回指定字段 a 的平均值 | 数值型 | 支持 | 支持 |
| count | count\(\*\) | 返回满足条件的行数 | long | 支持 | 支持 |
| distinct | distinct\(a\) | 返回去重后的字段 |  | 支持 | 支持 |

控制流函数

| 函数名 | 用法 | 说明 | TSpider/MySQL | HDFS |
| --- | --- | --- | --- | --- |
| if | if\(expr1,expr2,expr3\) | 如果 expr1 成立，则返回 expr2，否者返回 expr3 | 支持 | 支持 |
| Case ... When ... Then ... \[Else\] ... End | case when expr1then expr2 \[when \[expr3\] then expr4 ...\]\[else expr5\] end | 如果 expr1 成立，则返回 expr2，可以有多个判断表达式，返回对应的结果 | 支持 | 支持 |
| nullif | nullif\(a,b\) | 比较两个值，如果 a 和 b 相等返回 null，否则返回 a | 支持 | 支持 |
| coalesce | coalesce\(expr1, expr2, ……, expr\_n\) | 返回参数中的第一个非空表达式（从左向右） | 支持 | 支持 |

## 各存储 SQL 差异

| 功能 | TSpider/MySQL | HDFS |
| :---: | :---: | :---: |
| minuteX | 支持 | 不支持 |
| join | 支持 | 支持 |
| where | 需包含 dteventtimestamp、dteventtime、thedate 其中一个 | 需包含 dteventtime、thedate 其中一个 |
| order by | 支持 | 支持 |
| time | 不支持 | 不支持 |
| limit | 默认 limit 100 | 必须加 |
| 时间字段 d h m | 不支持 | 不支持 |
| distinct | 支持 | 支持 |

注：关于各个存储引擎其他函数相关用法可以参考相应的官方文档或者网上资料

- [HDFS 函数列表](https://trino.io/docs/current/functions.html)

- [MySQL 函数列表](https://dev.mysql.com/doc/refman/5.7/en/functions.html)

