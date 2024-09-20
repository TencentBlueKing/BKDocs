## Spark Tutorial

Notebook uses the platform-specific %%spark syntax to provide Spark computing capabilities, and supports the creation of temporary result tables in Notebook, and stores the results of Spark calculations in the newly generated result table. The usage method is as follows

### Create a DataFrame based on the existing result table data of the platform

Example:

```sql
%%spark
partition = {'range':[{'start':'2020-07-01-10','end':'2020-07-01-12'}]}
df = spark_session.create_dataframe('591_demo_nginx_access_log', partition)
```

![](../../../assets/datalab/notebook/spark/create_dataframe.png)



### Process the result table created above and select two columns

Example:

```python
%%spark
df2 = df.select(df['uri'], df['body_bytes_sent'].alias('bytes'))
```

![](../../../assets/datalab/notebook/spark/create_dataframe2.png)



### Create results table

Example:

```sql
%%bksql
create table 591_spark_demo(uri string, bytes long)
```

![](../../../assets/datalab/notebook/spark/create_table.png)



### Write the data in the DataFrame to the result table

Example:

```python
%%spark
spark_session.save_dataframe(df2, '591_spark_demo', 'append')
```

![](../../../assets/datalab/notebook/spark/save_dataframe.png)



### Query the data in the newly generated result table and assign values to the result set

Example:

```python
%%bksql
SELECT
     uri, COUNT(*) AS cnt
FROM 591_spark_demo
GROUP BY uri
ORDER BY cnt DESC
LIMIT 10
```

```python
result = _
```

![](../../../assets/datalab/notebook/spark/query.png)



### The result set generates a pie chart

Example:

```python
result.pie();
```

<img src="../../../assets/datalab/notebook/spark/pie.png" style="zoom: 50%;" />

### The result set generates a histogram

Example:

```python
result.bar();
```

<img src="../../../assets/datalab/notebook/spark/bar.png" style="zoom:50%;" />