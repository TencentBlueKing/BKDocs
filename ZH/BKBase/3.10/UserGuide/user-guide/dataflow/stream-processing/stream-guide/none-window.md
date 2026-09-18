# 无窗口

实时计算支持无窗口操作，可对实时数据逐条进行转换、过滤等处理操作，不支持聚合操作。
常见的无窗口操作有使用 `SELECT` 用于从实时数据流中选择数据，对关系进行垂直分割，消去某些列。
一个使用 `SELECT` 的语句如下：
```sql
SELECT ColA, ColC FROME table
```
常见的无窗口操作有使用 `WHERE` 用于从实时数据流中过滤数据，与 `SELECT` 一起使用，根据某些条件对关系做水平分割，即选择符合条件的记录。
一个使用 `WHERE` 的语句如下：
```sql
SELECT ColA, ColB, ColC FROM table WHERE ColA <> 'a2'
```
