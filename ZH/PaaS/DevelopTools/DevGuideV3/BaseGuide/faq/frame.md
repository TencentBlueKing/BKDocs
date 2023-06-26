# SaaS 开发框架相关

### 如何判断开发框架当前加载的是那个配置文件？能否自己指定

1. 三种配置文件分别对应：本地开发时，加载 dev；预发布环境下，加载 stag；正式环境下，加载 prod。
2. 不能指定，因为框架写死通过运行环境加载。

### 如何确认当前框架所在的运行环境

可以使用 `RUN_MODE` 变量，它被定义在 `dev.py / stag.py / prod.py`文件的开头位置。
```python
from django.conf import settings
settings.RUN_MODE
```

### 蓝鲸框架在哪里添加全局配置？

可以在`conf`目录下的`default.py`文件里添加自定义全局配置。


### 本地开发时，报错 "Environment variable x not found" 怎么办？

出现这类报错，主要是因为开发环境没有配置必要的环境变量，详见 [相关文档](../topics/company_tencent/python_framework_usage.md#2.8配置环境变量)。


### 平台无法到查询到 celery 日志怎么办？

有两个解决方案：

- 在代码 settings.py 配置中添加 CELERYD_HIJACK_ROOT_LOGGER = False 即可修复
