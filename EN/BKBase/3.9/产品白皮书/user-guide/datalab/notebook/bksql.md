## BKSQL 语法

Notebook 中使用平台特有的 bksql 语法提供查询服务，使用方式如下

### 多行 SQL

示例：

```sql
%%bksql
select 
	col, col2, col3
from table1
where thedate = '20200101'
limit 10
```

![](../../../assets/datalab/notebook/bksql/datalab_bksql_query.png)

![](../../../assets/datalab/notebook/bksql/datalab_result_chart.png)

### 单行 SQL

示例：

```python
%bksql select col, col2, col3 from table1 where thedate = '20200101' limit 10
```

## 查询结果引用

执行查询语句后，查询结果集支持赋值给自定义变量，方式如下

```sql
%%bksql
select 
	col, col2, col3
from table1
where thedate = '20200101'
limit 10
```

```python
result = _
```

自定义变量 result 包含 dicts、DataFrame 等方法，方便对结果集进行二次处理

```python
for line in result.dicts():
  print(line)
```

![](../../../assets/datalab/notebook/bksql/datalab_result_dicts.png)

```python
df = result.DataFrame()
```

![](../../../assets/datalab/notebook/bksql/datalab_result_dataframe.png)



## 复用查询任务结果集

Notebook 中支持复用查询任务的结果集，方式如下

```python
result = datasets('query_1')
```

![](../../../assets/datalab/notebook/bksql/datalab_query_result.png)

## Tips

#### 1、Notebook 中设置全局变量，SQL 引用变量组织查询语句

```python
today = '20200101'
```

```sql
%bksql select col, col2, col3 from table1 where thedate = {today} limit 10
```

```sql
%%bksql
select 
	col, col2, col3
from table1
where thedate = {today}
limit 10
```
