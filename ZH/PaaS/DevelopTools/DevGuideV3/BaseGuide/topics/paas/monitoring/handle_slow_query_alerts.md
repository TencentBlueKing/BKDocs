# 当出现数据库慢查询告警时该怎么处理

## 如何处理 MySQL 慢查询告警

GCS-MySQL 告警提供了 3 个维度的数据用户描述查询语句有多“慢”, 分别是扫描行数、返回行数以及查询耗时。当扫描行数和返回行数越大，sql 执行时间(也就是查询耗时)也会越大，因此优化的重点在于减少扫描行数和返回行数的数值。

### 优化建议: 建立合适的索引

索引就像字典一样，合适的索引可以让我们快速定位到需要的数据所在的位置，从而提高查询效率，如果没有索引，那么就有可能需要把整个数据库遍历一遍，才能找到我们需要的数据。

#### 联合索引和单独索引

如果需要对数据库表的两个列需要**单独进行搜索**时，这时候只有分别对两列建立索引时，索引才会有效。

如果需要对数据库表的两列进行**联合搜索**时，这时候可以按照业务需求，将**区分度最高(或搜索频率最高)**的列放在联合索引的最左侧，这样进行搜索时，两个搜索条件都能被索引加速。

#### 补充说明: 联合索引的最左前缀匹配原则

在 mysql 建立联合索引时会遵循最左前缀匹配的原则，即最左优先，在检索数据时从联合索引的最左边开始匹配。

例如：对 col1、 col2 和 col3 建一个联合索引

```sql
KEY test_col1_col2_col3 on test(col1,col2,col3);
```

联合索引 test_col1_col2_col3 实际建立了 (col1)、(col1, col2)、(col1, col2, col3) 三个索引。

```sql
# 以下搜索语句能被索引优化
SELECT * FROM test WHERE col1=1;
SELECT * FROM test WHERE col1=1 AND col2=2;
SELECT * FROM test WHERE col1=1 AND col2=2 and col3=3;

# 针对 col4 的搜索未被索引优化, 其余搜索条件都命中索引
SELECT * FROM test WHERE col1=1 AND col4=4;
SELECT * FROM test WHERE col1=1 AND col2=2 AND col4=4;
SELECT * FROM test WHERE col1=1 AND col2=2 and col3=3 AND col4=4;

# 以下搜索语句不能被索引优化
SELECT * FROM test WHERE col2=2;
SELECT * FROM test WHERE col2=2 AND col3=3;
SELECT * FROM test WHERE col4=4;
```

### 优化建议: 使用 explain 指令查看 sql 执行计划

MySQL 提供了一个 explain 指令，它可以对 select 语句进行分析，并输出 select 执行的详细信息，以供开发人员针对性优化。

explain 指令用法十分简单，在 select 语句前加上 explain 即可，例如:

```sql
explain select * from test where col1=1 and col2=2 and col3=3;
```

expain 返回的结果包含了 10 列信息，分别是 id、select_type、table、type、possible_keys、key、key_len、ref、rows、Extra，针对慢查询优化，最需要关注的是 type 字段，表示着该 select 语句找到所需行的扫描方式，常见的类型包括如下几类:
- ALL: Full Table Scan， MySQL 将**遍历全表**以找到匹配的行。
- index: Full Index Scan，index 与 ALL 区别为 index 类型只**遍历索引树**。
- range: 只检索给定范围的行，使用一个索引来选择行。
- ref: 表示上述表的连接匹配条件，即哪些列或常量被用于查找索引列上的值。
- eq_ref: 类似 ref ，区别就在使用的索引是唯一索引，对于每个索引键值，表中只有一条记录匹配，简单来说，就是多表连接中使用 primary key 或者  unique key 作为关联条件。
- const: 当 MySQL 对查询某部分进行优化，并转换为一个常量时，使用这些类型访问。如将主键置于 where 列表中，MySQL 就能将该查询转换为一个常量。
- system: system 是 const 类型的特例，当查询的表只有一行的情况下，使用 system。
- NULL: MySQL 在优化过程中分解语句，执行时甚至不用访问表或索引，例如从一个索引列里选取最小值可以通过单独索引查找完成。

其中 ALL、index 类型是最需要被优化的搜索类型。

在慢查询告警中，如果扫描行数非常大，一般都是触发了这类型的搜索类型，可以根据业务实际，配合 explain 指令调试出合适的索引方案。

> 如果以上的办法都不能优化慢查询，请联系蓝鲸助手，向 DBA 同学寻求更多的帮助。
