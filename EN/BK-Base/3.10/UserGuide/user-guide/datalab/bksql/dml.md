# DML (data manipulation) statement
- [INSERT INTO](#insert-into)
- [INSERT OVERWRITE](#insert-overwrite)
- [DELETE](#delete)
- [UPDATE](#update)
- [MERGE INTO](#merge-into)

## `INSERT INTO`
- ### Grammar description
   To insert data into the result table, you can use `values` or `select` subquery to specify the data set to be inserted.

- ### Syntax format
   ```mysql
   INSERT INTO table_name [ ( column_list ) ]
     { VALUES ( { value | NULL } [ , ... ] ) [ , ( ... ) ] | query }
   ```
  
- ### Parameter Description
   - `table_name`: the name of the result table to be inserted into
   - `column_list`: field list
   - `query`: subquery statement

- ### Example
   - Use `values` to specify the data set
   ```mysql
   INSERT INTO 591_datalab_ctas_demo2 VALUES ('2022-06-07')
   ```

   ![](../../../assets/datalab/bksql/dml/insert_into_values.png)

   - Use `select` subquery to specify the data set
   ```mysql
   INSERT INTO 591_datalab_ctas_demo2 (dteventtime)
   SELECT dteventtime
   FROM 591_presto_marketing_clusterinfo.hdfs
   WHERE thedate >= 20220605
         AND thedate <= 20220607;
   ```

   ![](../../../assets/datalab/bksql/dml/insert_into_select.png)
  
- ### Usage restrictions
   - Operate on the [Notebook](../notebook/bksql.md) page or call through the asynchronous query interface (`v3_queryengine_query_async`)
   - Both the target table and the data source table are in `iceberg` format
   - Have insert permissions to the target table and query permissions to the data source table

## `INSERT OVERWRITE`
- ### Grammar description
   Clean the existing data in the result table, and then insert the result set specified by the `values` or `select` subquery.

- ### Syntax format
   ```mysql
   INSERT OVERWRITE table_name [ ( column_list ) ]
     { VALUES ( { value | NULL } [ , ... ] ) [ , ( ... ) ] | query }
   ```
  
- ### Parameter Description
   - `table_name`: the name of the result table to be inserted into
   - `column_list`: field list
   - `query`: subquery statement

- ### Example
   - Use `values` to specify the data set
   ```mysql
   INSERT OVERWRITE INTO 591_datalab_ctas_demo2 (dteventtime) VALUES ('2022-06-05')
   ```

   ![](../../../assets/datalab/bksql/dml/insert_overwrite_values.png)

   - Use `select` subquery to specify the data set
   ```mysql
   INSERT OVERWRITE INTO 591_datalab_ctas_demo2 (dteventtime)
   SELECT dteventtime
   FROM 591_presto_marketing_clusterinfo.hdfs
   WHERE thedate >= 20220605
         AND thedate <= 20220607;
   ```

   ![](../../../assets/datalab/bksql/dml/insert_overwrite_select.png)

- ### Usage restrictions
   - Operate on the [Notebook](../notebook/bksql.md) page or call through the asynchronous query interface (`v3_queryengine_query_async`)
   - Both the target table and the data source table are in `iceberg` format
   - Have insert permissions to the target table and query permissions to the data source table

## `DELETE`
- ### Grammar description
   Delete data from the results table. If no where condition is specified, all data in the result table will be cleared.

- ### Grammatical structures
   ```mysql
   DELETE FROM table_name [ WHERE condition ]
   ```
  
- ### Parameter Description
   - `table_name`: the result table name of the data to be deleted
   - `WHERE condition`: where condition

- ### Example
   - where expression
   ```mysql
   DELETE FROM 591_datalab_ctas_demo2
   WHERE dteventtime = '2022-06-07 09:40:01'
   ```

   ![](../../../assets/datalab/bksql/dml/delete_where.png)
  
   - where subquery
   ```mysql
   DELETE FROM 591_datalab_ctas_demo2
   WHERE dteventtime IN (
       SELECT dteventtime
       FROM 591_presto_marketing_clusterinfo.hdfs
       WHERE thedate >= 20220605
           AND thedate <= 20220607
     )
   ```

   ![](../../../assets/datalab/bksql/dml/delete_where_select.png)

- ### Usage restrictions
   - Operate on the [Notebook](../notebook/bksql.md) page or call through the asynchronous query interface (`v3_queryengine_query_async`)
   - The target table is in `iceberg` format
   - Have delete permission on the target table

## `UPDATE`
- ### Grammar description
   Update the data in the results table. If no where condition is specified, all data in the result table will be updated

- ### Grammatical structures
   ```mysql
   UPDATE table_name SET col1_name = value1 [, col2_name = value2 ...]
   [WHERE condition];
   ```
  
- ### Parameter Description
   - `table_name`: the result table name of the data to be updated
   - `col1_name, col2_name`: column names corresponding to the rows to be updated
   - `value1, value2`: updated column values
   - `WHERE condition`: where condition

- ### Example
   - where expression
   ```mysql
   UPDATE 591_datalab_ctas_demo2
   SET dteventtime = '2022-06-01'
   WHERE dteventtime = '2022-06-05'
   ```

   ![](../../../assets/datalab/bksql/dml/update_where.png)
  
   - where subquery
   ```mysql
   UPDATE 591_datalab_ctas_demo2
   SET dteventtime = '2022-06-01'
   WHERE dteventtime IN (
           SELECT dteventtime
           FROM 591_presto_marketing_clusterinfo.hdfs
           WHERE thedate >= 20220605
               AND thedate <= 20220607
     )
   ```

   ![](../../../assets/datalab/bksql/dml/update_where_select.png)
- ### Usage restrictions
   - Operate on the [Notebook](../notebook/bksql.md) page or call through the asynchronous query interface (`v3_queryengine_query_async`)
   - The target table is in `iceberg` format
   - Have update permissions on the target table

## `MERGE INTO`
- ### Grammar description
   Perform insert, update, or delete operations on the target table based on results associated with the source table

- ### Grammatical structures
   ```mysql
   MERGE INTO target_table AS <target_alias_name> USING <select|source_table> AS <source_alias_name>
   ON <boolean expression>
   WHEN MATCHED THEN { UPDATE SET <set_clause_list> | DELETE }
   WHEN NOT MATCHED THEN { INSERT VALUES <value_list> | INSERT *}
   ```
  
- ### Parameter Description
   - `target_table`: target table name
   - `target_alias_name`: target table alias
   - `select, source_table`: associated source table or subquery
   - `boolean expression`: associated conditions
   - `set_clause_list`: update list
   - `value_list`: Insert value list

- ### Example
   -Update if it matches, insert if it doesn't match
   ```mysql
   merge into 591_datalab_ctas_demo2 as a
   using(SELECT dteventtime FROM 591_presto_marketing_clusterinfo.hdfs WHERE thedate >= 20220605 AND thedate <= 20220607) b
   on (a.dteventtime=b.dteventtime)
   when matched then update set dteventtime='2022-01-01'
   when not matched then insert *
   ```

   ![](../../../assets/datalab/bksql/dml/merge_update_insert.png)
  
   - If it matches, delete it; if it doesn’t match, insert it.
   ```mysql
   merge into 591_datalab_ctas_demo2 as a
   using(SELECT dteventtime FROM 591_presto_marketing_clusterinfo.hdfs WHERE thedate >= 20220605 AND thedate <= 20220607) b
   on (a.dteventtime=b.dteventtime)
   when matched then delete
   when not matched then insert *
   ```
  
   ![](../../../assets/datalab/bksql/dml/merge_delete_insert.png)

- ### Usage restrictions
   - Operate on the [Notebook](../notebook/bksql.md) page or call through the asynchronous query interface (`v3_queryengine_query_async`)
   - The target table and source table are in `iceberg` format
   - Have update/delete permissions on the target table and query permissions on the source table