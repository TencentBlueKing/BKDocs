# 使用蓝鲸对象存储服务

> <font color=red>注意：该指南仅适用于新版本蓝鲸应用 **（Django 版本 >= 1.7）**，对于使用了旧版本 Django 的应用，请参考：[Django 1.3 版本使用指南](./blueking_rgw_legacy.md)</font>

## 添加配置

安装好模块后，在你的 Django 配置文件中添加：

```python
# RGW 相关配置，请修改为蓝鲸为你分配的相关信息
RGW_ACCESS_KEY_ID = ''
RGW_SECRET_ACCESS_KEY = ''
RGW_STORAGE_BUCKET_NAME = ''

# RGW 服务地址
RGW_ENDPOINT_URL = ''
```

如果要用蓝鲸对象存储服务来保存所有的用户上传文件，请在配置文件中添加：

```python
DEFAULT_FILE_STORAGE = 'bkstorages.backends.rgw.RGWBoto3Storage'
```

之后项目中所有的 `FileField` 与 `ImageField` 都会将用户文件上传至蓝鲸对象存储服务。

默认情况下，上传新文件会覆盖同名旧文件，你可以通过修改 [RGW_FILE_OVERWRITE](./ref_rgw.md#RGW_FILE_OVERWRITE) 配置项来关闭。

关于 Django storage 的更多说明请参考： [Django document: File Storage](https://docs.djangoproject.com/en/3.2/topics/files/#file-storage)

## 将静态文件托管到蓝鲸对象存储服务

如果要使用蓝鲸对象存储服务托管静态文件，请在配置文件中添加：

```bash
STATICFILES_STORAGE = 'bkstorages.backends.rgw.StaticRGWBoto3Storage'
```

之后每次执行 `python manage.py collectstatic` 时，django 会自动将所有文件上传到你配置的 bucket 中。

与 RGWBoto3Storage 不同，StaticRGWBoto3Storage 默认修改了以下几个配置：

- 所有文件会被默认上传至 `/static/` 目录下，可通过 `RGW_STATIC_LOCATION` 参数修改
- 默认为文件添加以下头信息，可通过 `RGW_STATIC_OBJECT_PARAMETERS` 参数修改：
    - **Cache-Control**: max-age=86400

### 自定静态文件 storage

如果通过修改配置文件满足不了你的需求，你随时可以通过继承 `RGWBoto3Storage` 的方式来自定义你自己的 storage：

```python
class MyStaticRGWBoto3Storage(RGWBoto3Storage):
    """My Storage class for storing static files
    """
    bucket_name = 'another_bucket'
    location = '/my_static_path'
    object_parameters = {
        # 配置：文件在这个时间后不再被缓存
        'Expires': 'Wed, 30 Nov 2016 04:12:29 GMT',
        # 配置：文件默认缓存时间为一天
        'CacheControl': 'max-age=86400'
    }

# 修改 settings
STATICFILES_STORAGE = 'custom_backend.MyStaticRGWBoto3Storage'
```

### 修改模板中的静态文件地址

你需要同时修改模板文件中的静态文件地址，才能指向到蓝鲸对象存储服务上的文件。

**Django 模板**：

```html
{% load staticfiles %}
<script type="text/javascript" src="{{ static 'js/settings.js' }}"></script>
```

**Mako 模板**：

```html
<%!
    from django.contrib.staticfiles.templatetags.staticfiles import static
%>
<script type="text/javascript" src="${static('js/settings.js')}"></script>
```

## 手动使用 RGWBoto3Storage 上传和修改文件

除了将 `RGWBoto3Storage` 指定为文件存储后端外，你还可以通过 API 来手动使用它来管理文件。

初始化 storage 对象：

```python
from bkstorages.backends.rgw import RGWBoto3Storage


storage = RGWBoto3Storage()
```

使用 storage 对象上传文件：

```python
# 文件内容必须是字符串（bytes）而非文本（text）。为了兼容 Python2 与 Python3 版本，
# 建议使用 django 提供的工具函数先进行一次转换。
from django.utils.encoding import force_bytes
content = force_bytes('Hello, RGW!')

# 使用 ContentFile
f = ContentFile(content)
storage.save(u'/test/hello', f)
```

上传文件对象：

```python
from tempfile import NamedTemporaryFile

from django.core.files import File
from django.utils.encoding import force_bytes


with NamedTemporaryFile() as fp:
    fp.write(force_bytes('Temp file'))
    fp.flush()

    f = File(fp)
    storage.save(u'/test/temp_file.txt', f)
```

查看文件链接：

```python
storage.url('/test/temp_file.txt')
```

列出目录下所有文件：

```python
storage.listdir('/test')
```

删除文件：

```python
storage.delete('/test/temp_file.txt')
```

更多 API 说明请参考：[File storage API - Django documentation](https://docs.djangoproject.com/en/3.2/ref/files/storage/#the-storage-class)
