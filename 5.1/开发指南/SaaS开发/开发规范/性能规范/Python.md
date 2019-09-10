## Python性能优化

1. 尽量使用 generator（生成器），如 xrange / yield/ dict.iteritems() / itertools

2. 【必须】正则表达式预编译,  re.compile(…)

3. 排序尽量使用  .sort()， 其中使用 key 比 cmp 效率更高

4. 适当使用 list 迭代表达式，如 [i for i in xrane(10)]

5. 使用 set 来判断元素的存在

6. 使用 dequeue 来做双端队列
