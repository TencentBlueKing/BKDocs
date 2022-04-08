# 使用蓝鲸对象存储（Django 1.3 版本）

## 添加配置

安装好模块后，在你的 Django 配置文件中添加：

```python
# RGW 相关配置，请修改为蓝鲸为你分配的相关信息
RGW_ACCESS_KEY_ID = ''
RGW_SECRET_ACCESS_KEY = ''
RGW_STORAGE_BUCKET_NAME = ''

# RGW 服务地址
RGW_ENDPOINT_HOST = ''
```

如果要用蓝鲸对象存储服务来保存所有的用户上传文件，请在配置文件中添加：

```python
DEFAULT_FILE_STORAGE = 'bkstorages.legacy.backends.rgw.RGWStorage'
```

之后项目中所有的 FileField 与 ImageField 都会将用户文件上传至蓝鲸对象存储服务。

除了修改项目的全局默认 backend 外，你也可以手动为 FieldField 指定 Storage：

```python
from bkstorages.legacy.backends.rgw import RGWStorage

storage = RGWStorage()


class ModelWithFile(models.Model):
    some_file = models.FileField(storage=storage)
```

默认情况下，上传新文件会覆盖同名旧文件，你可以通过修改 [RGW_FILE_OVERWRITE](./ref_rgw_legacy.md#RGW_FILE_OVERWRITE) 配置项来关闭。

## 将静态文件托管到蓝鲸对象存储服务

如果要使用蓝鲸对象存储服务托管静态文件，请在配置文件中添加：

```bash
STATICFILES_STORAGE = 'bkstorages.legacy.backends.rgw.StaticRGWStorage'
```

之后每次执行 `python manage.py collectstatic` 时，django 会自动将所有文件上传到你配置的 bucket 中。

与 RGWStorage 不同，StaticRGWStorage 默认修改了以下几个配置：

- 所有文件会被默认上传至 `/static/` 目录下，可通过 `RGW_STATIC_BUCKET_PREFIX` 参数修改

### 自定静态文件 storage

如果通过修改配置文件满足不了你的需求，你随时可以通过继承 `RGWStorage` 的方式来自定义你自己的 storage：

```python
from bkstorages.legacy.backends.rgw import RGWStorage

class MyStaticRGWStorage(RGWStorage):
    """My Storage class for storing static files
    """
    BUCKET_PREFIX = 'mystatic'
    HEADERS = {
        'Cache-Control': 'max-age=86400' 
    }


# 修改 settings
STATICFILES_STORAGE = 'custom_backend.MyStaticRGWStorage'
```

### 修改模板中的静态文件地址

你需要同时修改模板文件中的静态文件地址，才能指向到蓝鲸对象存储服务上的文件。

## 手动使用 RGWStorage 上传和修改文件

除了将 `RGWStorage` 指定为文件存储后端外，你还可以通过 API 来手动使用它来管理文件。

- 上传内容文件：

```python
from bkstorages.legacy.backends.rgw import RGWStorage


storage = RGWStorage()

# 文件内容必须是字符串（bytes）而非文本（text）。为了兼容 Python2 与 Python3 版本，
# 建议使用 django 提供的工具函数先进行一次转换。
from django.utils.encoding import smart_str
content = smart_str('Hello, RGW!')

# 使用 ContentFile
f = ContentFile(content)
storage.save(u'/test/hello', f)
```

- 上传文件对象：

```python
from tempfile import NamedTemporaryFile

from django.core.files import File
from django.utils.encoding import smart_str


with NamedTemporaryFile() as fp:
    fp.write(smart_str('Temp file'))
    fp.flush()

    f = File(fp)
    storage.save(u'/test/temp_file.txt', f)
```

- 查看文件链接：

```python
storage.url('/test/temp_file.txt')
```

- 列出目录下所有文件：

```python
storage.listdir('/test')
```

- 删除文件：

```python
storage.delete('/test/temp_file.txt')
```

