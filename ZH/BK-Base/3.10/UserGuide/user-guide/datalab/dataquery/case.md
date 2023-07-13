# 常见用法



## 动态过滤 昨日0点到现在的数据

MySQL类语法

```sql
WHERE thedate>=DATE_SUB(CURDATE(), INTERVAL '1' DAY) 
```