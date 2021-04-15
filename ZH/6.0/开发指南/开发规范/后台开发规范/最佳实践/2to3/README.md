## 1. why 2to3

Python 软件基金会宣布，到 2020 年元旦，将不再为编程语言 Python 2.x 分支提供任何支持。意味着在 2020 年以后 Python2 将不会有官方的支持和修复。 最近的几年里，Python 主流库都做了很多兼容的工作，以帮助我们从 Python2 迁移到 Python3，但是这类的兼容性代码会消耗相当大的人力和性能。 事实上，这种兼容的工作已经在不同程度上停止了，比如 Django 2.0 已宣布不再支持 Python2，可以预见的是，2020 年之后，基本上不会有库再会处理兼容问题了。

### 如何选择项目的 Python 版本

- **新项目** - 必须使用 Python 3 进行开发（推荐版本: Python 3.6）
- **老项目(仍在迭代更新)** - 需要尽快迁移至 Python 3
- **老项目(处于稳定维护状态)** - 可维持当前 Python 版本

## 2. 2to3 工具介绍

[2to3](https://docs.python.org/zh-cn/3/library/2to3.html) 是一个 Python 程序，它可以用来读取 Python 2.x 版本的代码，并使用一系列的修复器 fixer 来将其转换为合法的 Python 3.x 代码。标准库中已经包含了丰富的修复器，这足以处理绝大多数代码。不过 2to3 的支持库 [`lib2to3`](https://docs.python.org/zh-cn/3.7/library/2to3.html#module-lib2to3) 是一个很灵活通用的库， __所以你也可以为 2to3 编写你自己的修复器__ 。[`lib2to3`](https://docs.python.org/zh-cn/3.7/library/2to3.html#module-lib2to3) 也可以用在那些需要自动处理 Python 代码的应用中。

2to3 是 Python 自带的一个代码转换工具，可以将 Python2 的代码自动转换为 Python3 的代码。

**注意事项 1：转换后的代码不再对 python2 进行兼容**

**注意事项 2：转换后并不确保功能 100% 可用，需要通过完备的单元测试和集成测试去确保功能正确性**

### 2.1 基本命令

1. 使用 patch 命令生成文件差异

```python
        # 解析 test.py ，并将转换到py3后的文件差异输出到 test.patch
        2to3 test.py > test.patch

        # 应用 test.patch 中的改动到 test.py
        patch test.py test.patch
```

2. 直接把修改写回原文件

```python
# 除非传入了 `-n` 参数，否则会为原始文件创建一个副本
2to3 -w test.py
```

3. 将整个项目代码转换到 py3

```python
2to3 -w -n myproject
```

### 2.2 修复器

转换代码的每一个步骤都封装在修复器中。可以使用 `2to3 -l` 来列出可用的修复器。每个修复器都可以独立地打开或是关闭。

- 使用  `-l`  参数可以列出所有可用的修复器
- 使用  `-f`  参数可以明确指定需要使用的修复器集合
- 使用  `-x`  参数则可以明确指定不使用的修复器

## 3. 升级步骤

1. 使用 [caniusepython3](https://pypi.org/project/caniusepython3/) 检查 `requirements.txt` 中是否存在不支持 python 3 的依赖包。若存在，则需要将对应依赖包升级至支持 python 3 的版本

2. 将**开发框架**升级到 `2.5.0` 以上的版本

3. 使用 2to3 工具，将整个项目代码迁移到 py3

    > 建议 checkout 一个新分支进行迁移验证，验证通过后再合并回主分支
    ```python
    2to3 -w -n myproject
    ```
4. 对个别无法通过 2to3 自动转换的代码，根据控制台输出给的修改建议，进行手动调整

5. 进行完整的单元测试和功能测试

6. 部署到测试环境做进一步的验证

## 4. 使用 Python 3 部署蓝鲸 APP

如需更改 Python 版本，需要开发者在 **App 根目录下** 添加`runtime.txt`文件，并在其中写上自定义版本号，平台会根据这个版本号选择 Python 版本，例如：

```bash
python-3.6.6
```

然后提交到**版本仓库**，部署后即可使用 Python-3.6.6 了

## 5. 迁移过程常见问题及解决方案

### 1. logging 无法写入中文编码字符，抛出异常 `UnicodeEncodeError`

- 原因

    在 Python3 需指定文件流编码

- 解决

    直接在 logging 增加属性 `'encoding': 'utf-8'`

### 2. 在获取字符串 MD5 时，抛出异常 `TypeError: Unicode-objects must be encoded before hashing`

```python
cache_str = "url_{url}__params_{params}".format(
    url=self.build_actual_url(params), params=json.dumps(params)
)
hash_md5 = hashlib.new('md5')
hash_md5.update(cache_str)  # 此处抛出异常
cache_key = hash_md5.hexdigest()
```

- 原因

    在 Python3，此函数参数为 bytes，需要进行 encode

- 解决

```python
cache_str = "url_{url}__params_{params}".format(
    url=self.build_actual_url(params), params=json.dumps(params)
)
hash_md5 = hashlib.new('md5')
hash_md5.update(cache_str.encode('utf-8'))  # 增加encode
cache_key = hash_md5.hexdigest()
```

### 3. 执行行语句 `'a' >= 2` ，抛出异常 `TypeError: '>=' not supported between instances of 'str' and 'int'`

- 原因

    在 Python3 中，不允许直接把字符串和数字直接进行大小比较

### 4. `xrange` 函数未被 2to3 工具自动替换为 `range`，需要手动修改

### 5. 执行语句以下语句，抛出异常 `TypeError: 'cmp' is an invalid keyword argument for this function`

```python
sorted(referenced_weight.items(), cmp=lambda x, y: cmp(x[1], y[1]), reverse=True)
```

- 原因

    Python 3 把 `sort()` 方法中的`cmp`参数废弃了

- 解决

```python
from functools import cmp_to_key
nums = [1, 3, 2, 4]
nums.sort(key=cmp_to_key(lambda a, b: a - b))
print(nums)  # [1, 2, 3, 4]
```

### 6. bytes 转换字符串，抛出异常 `TypeError: string argument without an encoding`

```python
f.encrypt(bytes(node_id))
```

- 原因

    python 3 将字符串转换成 byte 需要指定编码

- 解决

```python
f.encrypt(bytes(node_id, encoding='utf8'))
```

### 7. btytes 类型 json dumps 抛出异常 `Object of type 'bytes' is not JSON serializable`

- 原因

    在 python 3 中，json 仅支持序列化 `str` 类型的字符串，而不支持 `bytes` 类型

- 解决

    使用 `ujson` 替换掉原生的 `json`

```python
import ujson as json
```

### 8. base64 编码时，抛出异常 `TypeError: a bytes-like object is required, not 'str'`

```python
file_data = base64.b64encode(json.dumps({
    'template_data': templates_data,
    'digest': digest
}, sort_keys=True))
```

- 原因

    在 python 3 中，base64 仅支持对 `bytes` 类型字符串的 encode

- 解决

    在 encode 之前，先对 `str` 类型的字符串转换为 `bytes`

```python
file_data = base64.b64encode(json.dumps({
    'template_data': templates_data,
    'digest': digest
}, sort_keys=True).encode('utf-8'))
```

### 9. 捕获异常后打印 `e.message` ，抛出异常 `AttributeError: 'Exception' object has no attribute 'message'`

```python
try:
    task.modify_cron(cron, tz)
except Exception as e:
    return JsonResponse({
        'result': False,
        'message': e.message
    })
```

- 原因

    python3 `BaseException` 中去掉了 `message` 属性

- 解决

    使用 `str(e)` 进行类型转换

```python
try:
    task.modify_cron(cron, tz)
except Exception as e:
    return JsonResponse({
        'result': False,
        'message': str(e)
    })
```
