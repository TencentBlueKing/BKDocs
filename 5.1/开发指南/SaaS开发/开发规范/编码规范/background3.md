# 第三章 性能优化

## 1. Python 性能优化

1. 尽量使用 generator（生成器），如 `xrange`, `yield`, `dict.iteritems()`, `itertools`

2. 【必须】正则表达式预编译, `re.compile(…)`

3. 排序尽量使用 `.sort()`， 其中使用 key 比 cmp 效率更高

4. 适当使用 list 迭代表达式，如 `[i for i in xrane(10)]`

5. 使用set来判断元素的存在

6. 使用 dequeue 来做双端队列

## 2. Django QuerySet 性能优化

1. 【必须】尽量避免读取全部数据，优先使用 `exists`, `count`, `only`, `defer`,
切片 `[]` 等。如：

    - 使用 `QuerySet.values()` 或 `QuerySet.values_list()` 获取部分需要的表字段数据

    - 使用 `QuerySet.Iterator()` 迭代大数据

    - 只查询数量时用 `QuerySet.count()`，查询已得结果时用 `len(QuerySet)`

    - 只判断存在时用 `QuerySet.exists()`，查询已得结果时用 `if QuerySet`

2. 外键关联过多，可使用 `select_related` 提前将关联表进行 join，移除查询读取相关数据，many-to-many 则使用 `prefetch_related`

3. 建议使用数据库索引

4. 【必须】使用正确的字段类型，避免 `TextField` 代替 `CharField`，`IntegerField` 代替 `BooleanField` 等

5. 强烈不建议在迭代循环中执行`查询`或者`更新`等会触发DB动作的函数任务，防止在数据量变大的时候产生大量重复链接导致请求变慢
	- 对于查询动作，可以考虑使用 `Model.objects.filter(field__in=condition_list)` 的方法批量获得查询结果
	- 对于更新动作，可以考虑使用 `bulk_create`或者`QuerySet.update(filed=new_value)` 批量更新
