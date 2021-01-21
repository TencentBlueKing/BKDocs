## 1 DB 建模

### 1.1 字段设计

- 避免允许 null 值的字段，null 值难以查询优化且占用额外的索引空间

- 充分考虑每张表的数据规模，选取合适主键字段类型。比如数据创建比较频繁的表，主键建议使用 `BigIntegerField`

- 使用正确的字段类型，避免`TextField`代替`CharField`，`IntegerField`代替`BooleanField`等

- 如果字段的取值是一个有限集合，应使用 `choices` 选项声明枚举值

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

- 如果某个字段或某组字段被频繁用于过滤或排序查询，建议建立单字段索引或联合索引

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

## 2 DB 查询

### 2.1 基本要求

- 了解 Django ORM 是如何缓存数据的
- 了解 Django ORM 何时会做查询
- 不要以牺牲代码可读度为代价做过度优化

### 2.2 实际应用

- 避免全表扫描。优先使用`exists`, `count`等方法

```python
# 获取 project 的数量
projects = Project.objects.filter(enable=True)

# Bad: 会强制将 projects 实例化，导致全表扫描
project_count = len(projects)  

# Good: 直接从数据库层面统计，避免全表扫描
project_count = projects.count()
```

- 避免 N + 1 查询。可使用`select_related`提前将关联表进行 join，一次性获取相关数据，many-to-many 的外键则使用`prefetch_related`

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

```

```python
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

- 如果仅查询外键 ID，则无需进行连表操作。使用 `外键名_id` 可直接获取

```python
# 获取学生的班级ID
student = Student.objects.first()

# Bad: 会产生一次关联查询
cls_id = student.cls.id

# Good: 不产生新的查询
cls_id = student.cls_id
```

- 避免查询全部字段。可使用`values`, `values_list`,  `only`, `defer`等方法进行过滤出需要使用的字段。

```python
# 仅获取学生姓名的列表

# Bad
students = Student.objects.all()
student_names = [student.name for student in students]

# Good
students = Student.objects.all().values_list('name', flat=True)
```

- 避免在循环中进行数据库操作。尽量使用 ORM 提供的批量方法，防止在数据量变大的时候产生大量数据库连接导致请求变慢

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
```

```python
# 批量查询项目
project_names = ['ProjectA', 'ProjectB', 'ProjectC']

# Bad: 每次循环都产生一次新的查询
projects = []
for project_name in project_names:
    project = Project.objects.get(name=project_name)
    projects.append(project)

# Good：使用 in，只需一次数据库查询
projects = Project.objects.filter(name__in=project_names)
```

```python
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

- 避免隐式的子查询

```python
# 查询符合条件的组别中的人员

# Bad: 将查询集作为下一个查询的过滤条件，因此产生了子查询。IN 语句中的子查询在外层查询的每一行中都会被执行一次，复杂度为 O(n^2)
groups = Group.objects.filter(type="typeA")
members = Member.objects.filter(group__in=groups)

# Good: 以确定的数据作为过滤条件，避免子查询
group_ids = Group.objects.filter(type="typeA").values_list('id', flat=True)
members = Member.objects.filter(group__id__in=list(group_ids))
```

- `update_or_create` 与 `get_or_create` 不是线程安全的。因此查询条件的字段必须要有唯一性约束

```python
# 为了保证逻辑的正确性，Host 表中的 ip 和 bk_cloud_id 字段必须设置为 unique_together。否则在高并发情况下，可能会创建出多条相同的记录，最终导致逻辑异常
host, is_created = Host.objects.get_or_create(
    ip="127.0.0.1",
    bk_cloud_id="0"
)
```

- 如果查询集只用于单次循环，建议使用 `iterator()` 保持连接查询。当查询结果有很多对象时，QuerySet 的缓存行为会导致使用大量内存。如果你需要对查询结果进行好几次循环，这种缓存是有意义的，但是对于 QuerySet 只循环一次的情况，缓存就没什么意义了。在这种情况下，`iterator()`可能是更好的选择

```python
# Bad
for task in Task.objects.all():
    # do something

# Good
for task in Task.objects.all().iterator():
    # do something
```
