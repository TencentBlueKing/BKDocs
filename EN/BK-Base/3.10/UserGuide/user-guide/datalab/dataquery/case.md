# Common usage



## Dynamic filtering data from 0:00 yesterday to now

MySQL class syntax

```sql
WHERE thedate>=DATE_SUB(CURDATE(), INTERVAL '1' DAY)
```