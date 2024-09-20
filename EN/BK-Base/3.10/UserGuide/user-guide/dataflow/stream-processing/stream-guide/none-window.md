# No window

Real-time computing supports windowless operations, and can perform processing operations such as conversion and filtering on real-time data one by one. Aggregation operations are not supported.
Common windowless operations include using `SELECT` to select data from a live data stream, vertically split relationships, and eliminate certain columns.
A statement using `SELECT` is as follows:
```sql
SELECT ColA, ColC FROM table
```
Common windowless operations include using `WHERE` to filter data from real-time data streams, and using `SELECT` to horizontally split relationships based on certain conditions, that is, to select records that meet the conditions.
A statement using `WHERE` is as follows:
```sql
SELECT ColA, ColB, ColC FROM table WHERE ColA <> 'a2'
```