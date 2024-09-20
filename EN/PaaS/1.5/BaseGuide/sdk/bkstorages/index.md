# bkstorages Documentation

The BlueKing Artifact Repository (bk-repo) provides an object storage service that can store images, files, etc. You can access the API of the BlueKing Artifact Repository (bk-repo) using the HTTP protocol in your project. For more details, please refer to the API documentation of the BlueKing Artifact Repository (bk-repo).

For Python, you can use the `bkstorages` module to help you use the object storage service in BlueKing applications.

## How to Use bkstorages

### Installation

Install the module using pip:

```bash
$ pip install bkstorages
```

### Adding Configuration

After installing the module, add the following to your Django configuration file:

```python
import os

# BKREPO related configuration information, the corresponding configuration will be automatically added to the environment variables after enabling enhanced services
# In addition to the `BKREPO_BUCKET` variable, you can also obtain repository configuration through two other environment variables
# Public repository: BKREPO_PUBLIC_BUCKET
# Private repository: BKREPO_PRIVATE_BUCKET
BKREPO_BUCKET = os.environ['BKREPO_BUCKET']
BKREPO_ENDPOINT_URL = os.environ['BKREPO_ENDPOINT_URL']
BKREPO_USERNAME = os.environ['BKREPO_USERNAME']
BKREPO_PASSWORD = os.environ['BKREPO_PASSWORD']
BKREPO_PROJECT = os.environ['BKREPO_PROJECT']
```

If you want to use the BlueKing object storage service to save all user-uploaded files, add the following to your configuration file:

```python
DEFAULT_FILE_STORAGE = 'bkstorages.backends.bkrepo.BKRepoStorage'
```

Afterward, all `FileField` and `ImageField` in your project will upload user files to the BlueKing object storage service.

By default, uploading a new file will overwrite an old file with the same name. You can disable this by modifying the `BKREPO_FILE_OVERWRITE` configuration item.

For more information about Django storage, please refer to: [Django document: File Storage](https://docs.djangoproject.com/en/3.2/topics/files/#file-storage)

## Manually Using BKRepoStorage to Upload and Modify Files

In addition to specifying BKRepoStorage as the file storage backend, you can also manually use it to manage files through the API.

Initialize the storage object:

```python
from bkstorages.backends.bkrepo import BKRepoStorage

storage = BKRepoStorage()
```

Upload a file using the storage object:

```python
# The content of the file must be a string (bytes) rather than text (text). To ensure compatibility between Python2 and Python3,
# it is recommended to use Django's utility function for conversion first.
from django.utils.encoding import force_bytes
content = force_bytes('Hello, RGW!')

# Using ContentFile
from django.core.files.base import ContentFile
f = ContentFile(content)
storage.save(u'/test/hello', f)
```

Upload a file object:

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

View the file link:

```python
# For public repositories, the file link returned by `storage.url` is permanently available
# For private repositories, the file link returned by `storage.url` is a temporary link, which will become inaccessible when the access credentials in the link expire
storage.url('/test/temp_file.txt')
```

List all files in a directory:

```python
storage.listdir('/test')
```

Delete a file:

```python
storage.delete('/test/temp_file.txt')
```

For more API details, please refer to: [File storage API - Django documentation](https://docs.djangoproject.com/en/3.2/ref/files/storage/#the-storage-class)