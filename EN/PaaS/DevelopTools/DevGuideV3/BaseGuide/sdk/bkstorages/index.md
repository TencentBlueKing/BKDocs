# bkstorages 文档

蓝鲸制品库（bk-repo）提供的对象存储服务，可存储图片、文件等，你可以在项目中使用 HTTP 协议访问蓝鲸制品库（bk-repo)的 API，详情请查看蓝鲸制品库（bk-repo）的 API 文档。

对于 Python 语言, 可以使用 bkstorages 模块来帮助你在蓝鲸应用中使用对象存储服务。

## 如何使用 bkstorages

### 安装
使用 pip 来安装模块：

```
$ pip install bkstorages
```

### 添加配置
安装好模块后，在你的 Django 配置文件中添加：

```
import os

# BKREPO 相关配置信息, 启用增强服务后会自动往环境变量中添加对应的配置
BKREPO_ENDPOINT_URL = os.environ['BKREPO_ENDPOINT_URL']
BKREPO_USERNAME = os.environ['BKREPO_USERNAME']
BKREPO_PASSWORD = os.environ['BKREPO_PASSWORD']
BKREPO_PROJECT = os.environ['BKREPO_PROJECT']
BKREPO_BUCKET = os.environ['BKREPO_BUCKET']
```

如果要用蓝鲸对象存储服务来保存所有的用户上传文件，请在配置文件中添加：

```
DEFAULT_FILE_STORAGE = 'bkstorages.backends.bkrepo.BKRepoStorage'
```

之后项目中所有的 FileField 与 ImageField 都会将用户文件上传至蓝鲸对象存储服务。

默认情况下，上传新文件会覆盖同名旧文件，你可以通过修改 BKREPO_FILE_OVERWRITE 配置项来关闭。

关于 Django storage 的更多说明请参考： [Django document: File Storage](https://docs.djangoproject.com/en/3.2/topics/files/#file-storage)

## 手动使用 BKRepoStorage 上传和修改文件
除了将 BKRepoStorage 指定为文件存储后端外，你还可以通过 API 来手动使用它来管理文件。

初始化 storage 对象：

```
from bkstorages.backends.bkrepo import BKRepoStorage


storage = BKRepoStorage()
```

使用 storage 对象上传文件：

```
# 文件内容必须是字符串（bytes）而非文本（text）。为了兼容 Python2 与 Python3 版本，
# 建议使用 django 提供的工具函数先进行一次转换。
from django.utils.encoding import force_bytes
content = force_bytes('Hello, RGW!')

# 使用 ContentFile
f = ContentFile(content)
storage.save(u'/test/hello', f)
```

上传文件对象：
```
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
```
storage.url('/test/temp_file.txt')
列出目录下所有文件：

storage.listdir('/test')
```

删除文件：
```
storage.delete('/test/temp_file.txt')
```

更多 API 说明请参考：[File storage API - Django documentation](https://docs.djangoproject.com/en/3.2/ref/files/storage/#the-storage-class)