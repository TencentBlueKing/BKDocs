## 开发第一个 Hello World 应用

- 在 config/default.py 的 INSTALLED_APPS 中加入 home_application (默认已添加)
- 在 urls.py 的 urlpatterns 加入 url(r'^', include('home_application.urls')) (默认已添加)
- 在 home_application/views.py 加入

```python
from django.http import HttpResponse


def hello(request):
    return HttpResponse('Hello World!')
```
- 修改 home_application/urls.py


```python
from django.conf.urls import url
from home_application import views

urlpatterns = [
    url(r'^$', views.hello),
]
```

再次运行项目吧，“世界就在你眼前”！
