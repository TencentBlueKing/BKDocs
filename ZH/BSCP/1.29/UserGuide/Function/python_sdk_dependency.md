# BSCP Python SDK 依赖说明
[BSCP Python SDK](https://github.com/TencentBlueKing/bscp-python-sdk) 依赖以下库：

* Python 版本 3.8 及以上
* grpcio 版本 1.60.0 及以上
* typing-extensions 版本 4.9.0 及以上
* protobuf 版本 4.25.2 及以上

为了快速体验 BSCP Python SDK 示例，我们采用了开源项目 "[uv](https://github.com/astral-sh/uv)"，它易用、跨平台且能灵活管理 Python 版本与依赖，请注意，正式业务环境Python版本及组件依赖部署需由开发和运维团队确定



## 1. 安装uv

```bash
# On macOS and Linux.
curl -LsSf https://astral.sh/uv/install.sh | sh
```

![uv_install](../Image/uv_install.png)

```bash
# 配置 uv 的环境变量路径
source $HOME/.local/bin/env
```



## 2. 部署BSCP Python SDK依赖

```bash
# 最小支持python 3.8
uv python pin 3.8

# 初始化 bscp-python-sdk-demo 项目
uv init bscp-python-sdk-demo

# 进入bscp-python-sdk-demo目录
cd bscp-python-sdk-demo

# 添加依赖以及部署BSCP Python SDK组件
uv add bk-bscp
```

![bscp_python_sdk_tools_install](../Image/bscp_python_sdk_tools_install.png)


## 3. 验证BSCP Python SDK组件

在验证BSCP Python SDK组件之前，需要首先在服务配置中心（BSCP）创建一个键值型服务，并添加相应的键值配置。接下来，生成并发布版本。有关操作指南，请参阅白皮书：[键值型配置](https://bk.tencent.com/docs/markdown/ZH/BSCP/1.29/UserGuide/QuickStart/kv.md)

把配置示例里的demo保存为demo.py文件，把{{ YOUR_KEY }}替换为业务实际的Key

```python
### Get

from bk_bscp.client import BscpClient

SERVER_ADDRS = ["feed.demo.com:9510"]
TOKEN = "AAm***ayQ"
BIZ_ID = 2
APP = "demo"
LABELS = {}

def main(key):
    with BscpClient(SERVER_ADDRS, TOKEN, BIZ_ID) as client:
        pair = client.get(APP, key, LABELS)
        print(pair.value)

if __name__ == "__main__":
    # 请将 {{ YOUR_KEY }} 替换为您的实际 Key
    key = {{ YOUR_KEY }}
    main(key)
```

```bash
# 执行demo.py获取指定Key的Value
python demo.py
```



