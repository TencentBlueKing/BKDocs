
# Django

Django最佳实践、优化思路。

# 目录 <!-- omit in toc -->
- [Django](#django)
  - [DB 建模](#db-建模)
    - [BBP-2001 如果字段的取值是一个有限集合，应使用 `choices` 选项声明枚举值](#bbp-2001-如果字段的取值是一个有限集合应使用-choices-选项声明枚举值)
    - [BBP-2002 如果某个字段或某组字段被频繁用于过滤或排序查询，建议建立单字段索引或联合索引](#bbp-2002-如果某个字段或某组字段被频繁用于过滤或排序查询建议建立单字段索引或联合索引)
    - [BBP-2003 变更数据表时，新增字段尽量使用 `null=True` 而不是 `default`](#bbp-2003-变更数据表时新增字段尽量使用-nulltrue-而不是-default)
  - [DB 查询](#db-查询)
    - [BBP-2004 使用 .exists() 判断数据是否存在](#bbp-2004-使用-exists-判断数据是否存在)
    - [BBP-2005 使用 .count() 查询数据条目数](#bbp-2005-使用-count-查询数据条目数)
    - [BBP-2006 避免 N + 1 查询](#bbp-2006-避免-n--1-查询)
    - [BBP-2007 如果仅查询外键 ID，则无需进行连表操作。使用 `外键名_id` 可直接获取](#bbp-2007-如果仅查询外键-id则无需进行连表操作使用-外键名_id-可直接获取)
    - [BBP-2008 避免查询全部字段](#bbp-2008-避免查询全部字段)
    - [BBP-2009 避免在循环中进行数据库操作](#bbp-2009-避免在循环中进行数据库操作)
    - [BBP-2010 避免隐式的子查询](#bbp-2010-避免隐式的子查询)
    - [BBP-2011 `update_or_create` 与 `get_or_create` 通过 defaults 参数避免全表查询](#bbp-2011-update_or_create-与-get_or_create-通过-defaults-参数避免全表查询)
    - [BBP-2012 `update_or_create` 与 `get_or_create` 查询条件的字段必须要有唯一性约束](#bbp-2012-update_or_create-与-get_or_create-查询条件的字段必须要有唯一性约束)
    - [BBP-2013 如果查询集只用于单次循环，建议使用 `iterator()` 保持连接查询](#bbp-2013-如果查询集只用于单次循环建议使用-iterator-保持连接查询)
    - [BBP-2014 针对数据库字段更新尽量使用 `update_fields`](#bbp-2014-针对数据库字段更新尽量使用-update_fields)
    - [BBP-2015 使用 Django Extra 查询时，需要使用内置的字符串表达](#bbp-2015-使用-django-extra-查询时需要使用内置的字符串表达)
    - [BBP-2016 善用 bulk\_create/bulk\_update 减少批量数据库操作耗时](#bbp-2016-善用-bulk_createbulk_update-减少批量数据库操作耗时)
    - [BBP-2017 当 MySQL 版本较低时（\<5.7)，谨慎使用 DateTimeField 进行排序](#bbp-2017-当-mysql-版本较低时57谨慎使用-datetimefield-进行排序)
- [DRF](#drf)
    - [BBP-4001 在数据量较大的场景下，避免使用 Model Serializer](#bbp-4001-在数据量较大的场景下避免使用-model-serializer)

## DB 建模

### BBP-2001 如果字段的取值是一个有限集合，应使用 `choices` 选项声明枚举值

```python
class Students(models.Model):
    class Gender(object):
        MALE = 'MALE'
        FEMALE = 'FEMALE'

    GENDER_CHOICES = (
        (Gender.MALE, "男"),
        (Gender.FEMALE, "女"),
    )

    gender = models.IntegerField("性别", choices=GENDER_CHOICES)
```

### BBP-2002 如果某个字段或某组字段被频繁用于过滤或排序查询，建议建立单字段索引或联合索引

```python
# 字段索引：使用 db_index=True 添加索引
title = models.CharField(max_length=255, db_index=True)

# 联合索引：将多个字段组合在一起建立索引
class Meta:
    index_together = ['field_name_1', 'field_name_2']

# 联合唯一索引：将多个组合在一起的索引，并且字段的组合值唯一
class Meta:
    unique_together = ('field_name_1', 'field_name_2')
```

### BBP-2003 变更数据表时，新增字段尽量使用 `null=True` 而不是 `default`

```python
# BAD
new_field = models.CharField(default="foo")

# GOOD
new_field = models.CharField(null=True)
```

前者将会在 `migrate` 操作时对已存在的数据批量刷新，对现有数据库带来不必要的影响。

参考：https://pankrat.github.io/2015/django-migrations-without-downtimes/


## DB 查询

### BBP-2004 使用 .exists() 判断数据是否存在

如果要查询记录是否存在，建议使用 `.exists()` 方法。该方法将会往数据库发起一条设置了 `LIMIT 1` 的查询语句，效率最佳。

```python
# BAD
# 将会查询表中所有结果，效率低
if Foo.objects.filter(name='test'):
    # Do something

# GOOD
if Foo.objects.filter(name='test').exists():
    # Do something
```

### BBP-2005 使用 .count() 查询数据条目数

如果要统计数据条目数，建议使用使用 `.count()` 方法。该方法将会往数据库发起一条 `SELECT count(*)` 查询语句。

```python
# BAD
# 将查询表中所有内容，耗费大量内存和 CPU
count = len(Foo.objects.all())

# GOOD
count = Foo.objects.count()
```

### BBP-2006 避免 N + 1 查询

可使用`select_related`提前将关联表进行 join，一次性获取相关数据，many-to-many 的外键则使用`prefetch_related`

```python
# select_related

# Bad
# 由于 ORM 的懒加载特性，在执行 filter 操作时，并不会将外键关联表的字段取出，而是在使用时，实时查询。这样会产生大量的数据库查询操作
students = Student.objects.all()
student_in_class = {student.name: student.cls.name for student in students}

# Good
# 使用 select_related 可以避免 N + 1 查询，一次性将外键字段取出
students = Student.objects.select_related('cls').all()
student_in_class = {student.name: student.cls.name for student in students}
# prefetch_related

# Bad
articles = Article.objects.filter(id__in=(1,2))
for item in articles:
    # 会产生新的数据库查询操作
    item.tags.all()

# Good
articles = Article.objects.prefetch_related("tags").filter(id__in=(1,2))
for item in articles:
    # 不会产生新的数据库查询操作
    item.tags.all()
```

### BBP-2007 如果仅查询外键 ID，则无需进行连表操作。使用 `外键名_id` 可直接获取

```python
# 获取学生的班级ID
student = Student.objects.first()

# Bad: 会产生一次关联查询
cls_id = student.cls.id

# Good: 不产生新的查询
cls_id = student.cls_id
```

### BBP-2008 避免查询全部字段
可使用`values`, `values_list`, `only`, `defer`等方法进行过滤出需要使用的字段。

```python
# 仅获取学生姓名的列表

# Bad
students = Student.objects.all()
student_names = [student.name for student in students]

# Good
students = Student.objects.all().values_list('name', flat=True)
```

### BBP-2009 避免在循环中进行数据库操作

尽量使用 ORM 提供的批量方法，防止在数据量变大的时候产生大量数据库连接导致请求变慢

```python
# 批量创建项目
project_names = ['ProjectA', 'ProjectB', 'ProjectC']

# Bad
for project_name in project_names:
    Project.objects.create(name=project_name)

# Good
projects = []
for project_name in project_names:
    project = Project(name=project_name)
    projects.append(project)
Project.objects.bulk_create(projects)
# 批量查询项目
project_names = ['ProjectA', 'ProjectB', 'ProjectC']

# Bad: 每次循环都产生一次新的查询
projects = []
for project_name in project_names:
    project = Project.objects.get(name=project_name)
    projects.append(project)

# Good：使用 in，只需一次数据库查询
projects = Project.objects.filter(name__in=project_names)
# 批量更新项目
project_names = ['ProjectA', 'ProjectB', 'ProjectC']
projects = Project.objects.filter(name__in=project_names)

# Bad: 每次循环都产生一次新的查询
for project in projects:
    project.enable = True
    project.save()

# Good：批量更新，只需一次数据库查询
projects.update(enable=True)
```

### BBP-2010 避免隐式的子查询

```python
# 查询符合条件的组别中的人员

# Bad: 将查询集作为下一个查询的过滤条件，因此产生了子查询。IN 语句中的子查询在外层查询的每一行中都会被执行一次，复杂度为 O(n^2)
groups = Group.objects.filter(type="typeA")
members = Member.objects.filter(group__in=groups)

# Good: 以确定的数据作为过滤条件，避免子查询
group_ids = Group.objects.filter(type="typeA").values_list('id', flat=True)
members = Member.objects.filter(group__id__in=list(group_ids))
```

### BBP-2011 `update_or_create` 与 `get_or_create` 通过 defaults 参数避免全表查询

使用 `update_or_create` 与 `get_or_create` 时，需要将 **查询字段** 和 **更新字段** 做区分：

- 前者放在方法参数中，会被 Django 当作查询条件判断是否已有记录
- 后者应该被放入 `defaults` 参数中，否则将会被当作查询条件，容易触发全表查询


```python
# BAD
ModelA.objects.update_or_create(
    field_1="field_1",
    field_2="field_2",
    field_3="field_3",
)

# GOOD
ModelA.objects.update_or_create(
    field_1="field_1",
    defaults={
        "field_2": "field_2",
        "field_3": "field_3",
    }
```

### BBP-2012 `update_or_create` 与 `get_or_create` 查询条件的字段必须要有唯一性约束

在并发请求的情况下，`get_or_create` 并不能保证记录的唯一性，会存在重复创建的情况。因此使用此方法前，需要确定用于存在性查询的字段是否设置了DB级别的唯一性约束。

```python
# BAD
# models.py
class Topic(models.Model):
    """
    模型定义
    """
    username = models.CharField(max_length=32)
    title = models.CharField(max_length=128)


# views.py
def view_func(request):
    # 并发请求场景下可能会出现重复记录
    Topic.objects.get_or_create(username="foo", title="bar")


# GOOD
# models.py
class Topic(models.Model):
    """
    模型定义
    """
    username = models.CharField(max_length=32)
    title = models.CharField(max_length=128)

    class Meta:
        # 增加 username 和 title 字段联合唯一性约束
        unique_together = ("username", "title")


# views.py
def view_func(request):
    # 存在DB级别的唯一性约束，能够保证不会创建重复记录
    Topic.objects.get_or_create(username="foo", title="bar")

```

### BBP-2013 如果查询集只用于单次循环，建议使用 `iterator()` 保持连接查询

当查询结果有很多对象时，QuerySet 的缓存行为会导致使用大量内存。如果你需要对查询结果进行好几次循环，这种缓存是有意义的，但是对于 QuerySet 只循环一次的情况，缓存就没什么意义了。在这种情况下，`iterator()`可能是更好的选择。

```python
# Bad
for task in Task.objects.all():
    # do something

# Good
for task in Task.objects.all().iterator():
    # do something
```

### BBP-2014 针对数据库字段更新尽量使用 `update_fields`  

如果要对数据库字段进行更新，使用 `update_fields` 避免并行 `save()` 产生数据冲突

```python
# BAD
foo_instance.bar_field = other_value
foo_instance.save()

# GOOD
foo_instance.bar_field = other_value
foo_instance.save(update_fields=["bar_field"])
```

同时需要注意的是，如果 `Model` 中包含 `auto_now` 字段时，需要在 `update_fields` 的列表中添加该字段，保证同时更新。

### BBP-2015 使用 Django Extra 查询时，需要使用内置的字符串表达

```python
# BAD
# 有注入风险, username 不会被转义，可以直接注入
Entry.objects.extra(where=[f"headline='{username}'"])

# GOOD
# 安全，Django 会将 username 内容转义
Entry.objects.extra(where=['headline=%s'], params=[username])
```

### BBP-2016 善用 bulk_create/bulk_update 减少批量数据库操作耗时

```python
# BAD
## 每次都执行commit，整体耗时较长(大约25s左右)
for num in range(10000):
    Record.objects.create(num=num)

# GOOD
## 统一提交数据库，耗时很短(1s以内)
inserted_list = []
for num in range(10000):
    inserted_list.append(Demo(num=num))

Record.objects.bulk_create(inserted_list)
```

同理，当 Django 版本 > 2.x 时，`bulk_update` 也可以加快批量修改。

```python
tasks = [
    Task.objects.create(name='task1', status='start', cost=1),
    Task.objects.create(name='task2', status='start', cost=1),
    ...
]

# BAD
for task in tasks:
    task.name = f'{task.pk}-{task.name}'
    task.save()

# GOOD
for task in tasks:
    task.name = f'{task.pk}-{task.name}'
Task.objects.bulk_update(tasks, ['name'])
```

同时还有一些需要额外注意: 
- bulk_create 方法只执行一次数据库交互，这样相当于创建时间一样，并且自定字段不会在返回数据中
- 当单次提交的对象可能过多时，可通过 `batch_size` 控制

### BBP-2017 当 MySQL 版本较低时（<5.7)，谨慎使用 DateTimeField 进行排序

当 MySQL 版本较低时，DATETIME 类型默认是不支持 milliseconds 的，当批量创建对象时，会导致大量记录的 `auto_now_add` 字段都在同一秒，此时根据该字段是无法获得稳定的排序结果的。

```python
# BAD
class Foo(models.Model):
    ...
    foo = models.DateTimeField(auto_now_add=True)
    ...

    class Meta:
        ordering = ["foo"]



# GOOD
class Foo(models.Model):
    ...
    foo = models.DateTimeField(auto_now_add=True)
    ...

    class Meta:
        # 使用自增 ID 或者其他能准确表明顺序的字段
        ordering = ["id"]
```

参考：
- https://stackoverflow.com/questions/13344994/mysql-5-6-datetime-doesnt-accept-milliseconds-microseconds


# Golang 

蓝鲸监控团队的Golang实践，持续补充中...

### BBP-3001 channel空间设定为1或者阻塞

如果改为其他长度的channel，都需要很详细的评估设计，因此建议默认考虑长度为1或阻塞的channel

```go
// BAD
c := make(chan int, 100)

// GOOD
c := make(chan int)
```

### BBP-3002 除for循环以外，不要在代码块初始化中使用:=

如果在代码块中使用了新建变量，容易导致覆盖上层的变量而不会发现，容易引发bug

```go
// BAD 
if _, err := openFile("/path") {
   // do something
}

// GOOD 
var err error
if _, err = openFile("/path") {
   // do something
}
```

### BBP-3003 channel接受使用两段式

由于读取已关闭的channel会导致panic，因此要求在读取channel的代码都使用二段式，可以避免channel已关闭的导致panic

```go
// BAD
value := <- ch

// GOOD
var (
	ok bool
)
if _, ok = <- ch; !ok {
	// do something when channel is closed.
}
```

### BBP-3004 不能通过取出来的值来判断 key 是不是在 map 中

go 会返回元素对应数据类型的零值，取值操作总有值返回，不能通过取出来的值来判断 key 是不是在 map 中

```go
// BAD
x := map[string]string{"demo1": "1", "demo2": "2"}
if v := x["demo3"]; v == "" {
  fmt.Println("demo3 is not exist")
}


// GOOD
x := map[string]string{"demo1": "1", "demo2": "2"}
if _, ok := x["demo3"]; !ok {
    fmt.Println("demo3 is not exist")
}
```

### BBP-3005 接口类型转换应使用两段式

由于当接口(interface)类型转换为实际类型时，如果类型不正确或接口为nil，会导致panic。因此应该使用二段式或switch的方式来避免panic

```go
var (
  a  interface{}
  b  int
  ok bool
)

// BAD
b = a.(int)

// GOOD
b, ok = a.(int)
// or
switch a.(type) {
case int:
    // do something when type is int
case float64:
    // do something when type is float64
default:
    // Ooops, trans failed.
}
```

### BBP-3006 定义常量时，使用自增的方式定义

定义常量时，应使用`itoa`的方式由编译器协助为各个常量赋值，降低后续维护的成本

```go
// BAD
const (
   Red = 0
   Gray  = 1
)

// GOOD
const (
   Red = iota
   Gray 
)
```

# DRF

### BBP-4001 在数据量较大的场景下，避免使用 Model Serializer

DRF 在 3.10 版本以前，`ModelSerializer` 有较大的性能问题，用作渲染大量的数据返回可能会耗时非常久，可以考虑使用 `Serializer` 或者原生数据结构返回。
```python
# 当有大量 user 对象需要渲染时

# BAD
class UserModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = "__all__"

# GOOD
# 性能有所提升，同时又不会破坏 Serializer 结构
class UserSerializer(serializers.Serializer):
    # 将需要的字段平铺出来
    username = serializers.CharField()
    ...

# GOOD
# 最快！直接返回原始结构体，但是可能需要处理多种对象
def serialize_user(user: User) -> Dict[str, Any]:
    ...
    return {
        "username": "foo",
        ...
    }
```

在 DRF 3.10 版本以后，`ModelSerializer` 性能有一定程度的提升，但依旧会比后两种处理慢，可以根据场景和具体测试数据选择适合的写法。

参考：
- https://hakibenita.com/django-rest-framework-slow