## Django QuerySet 性能优化

1. 【必须】尽量避免读取全部数据，优先使用 exists, count, only, defer, 切片[]等，如：

>1)使用 QuerySet.values() 或 QuerySet.values_list() 获取部分需要的表字段数据

>2)使用 QuerySet.Iterator() 迭代大数据

>3)只查询数量时用 QuerySet.count()，查询已得结果时用 len(QuerySet)

>4)只判断存在时用 QuerySet.exists()，查询已得结果时用 if QuerySet

2. 外键关联过多，可使用 select_related 提前将关联表进行 join，移除查询读取相关数据，Many-to-many 则使用 prefetch_related

3. 建立使用数据库索引

4. 【必须】使用正确的字段类型，避免 TextField 代替 CharField，IntegerField 代替 BooleanField等
