# 构建镜像

## 构建镜像
### 1. 编写简单的 helloworld 程序
首先我们创建 `app.py` 文件, 使用 fastapi 编写一个简单的 HelloWorld 程序。

```python
import random
import string
from django.conf import settings
from django.urls import path
from django.http import HttpResponse
from django.core.asgi import get_asgi_application


def index(request):
    return HttpResponse(f'Hello {request.GET.get("who", "World")}')


urlpatterns = [path("", index)]


settings.configure(
    **{
        "DEBUG": True,
        "SECRET_KEY": "".join(random.choices(string.ascii_letters, k=20)),
        "ROOT_URLCONF": __name__,
    }
)

application = get_asgi_application()


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(application)

```

### 2. 编写 Dockerfile
我们已经编写了一个简单的 helloworld 程序, 但还需要编写 `Dockerfile` 描述容器的运行环境。

> 详细的 Dockerfile 语法说明请阅读[文档](https://docs.docker.com/engine/reference/builder/)

```dockerfile
FROM python:3.8-slim
USER root

WORKDIR /app

RUN pip install "django<4,>=3.2" uvicorn
COPY ./app.py /app/app.py

ENTRYPOINT ["env"]
CMD ["bash", "-c", "python -m uvicorn app:application --host 0.0.0.0 --port ${PORT:-5000}"]
```

### 3. 构建镜像
执行 `docker build` 命令即可从 `Dockerfile` 和 上下文构建镜像。

```bash
docker build . -f Dockerfile -t bk-helloworld
```

构建成功后, 可以通过 `docker images bk-helloworld` 命令验证镜像是否存在。

```bash
REPOSITORY      TAG       IMAGE ID       CREATED         SIZE
bk-helloworld   latest    31893e2d2755   2 seconds ago   240MB
```

## 运行镜像
通过以下命令可启动镜像, 并监听本地的 5000 端口

```bash
docker run --rm -p 8888:5000 bk-helloworld 
```

容器启动成功后, 接着在浏览器访问 http://127.0.0.1:8888 就可以验证服务是否可用啦
