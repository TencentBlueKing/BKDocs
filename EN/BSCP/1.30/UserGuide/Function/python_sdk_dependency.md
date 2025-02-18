# BSCP Python SDK Dependency Description
[BSCP Python SDK](https://github.com/TencentBlueKing/bscp-python-sdk) depends on the following libraries:

* Python version 3.8 and above
* grpcio version 1.60.0 and above
* typing-extensions version 4.9.0 and above
* protobuf version 4.25.2 and above

In order to quickly experience the BSCP Python SDK example, we use the open source project "[uv](https://github.com/astral-sh/uv)", which is easy to use, cross-platform and can flexibly manage Python versions and dependencies. Please note that the Python version and component dependency deployment in the formal business environment must be determined by the development and operation and maintenance team

## 1. Install uv

```bash
# Execute the following command line on the Linux server to install the uv component
curl -LsSf https://astral.sh/uv/install.sh | sh
```

![get_biz](../Image/uv_install.png)

```bash
# Configure the environment variable path of uv
source $HOME/.local/bin/env
```

## 2. Deploy BSCP Python SDK dependencies

```bash
# Minimum supported Python 3.8
uv python pin 3.8

# Initialize bscp-python-sdk-demo project
uv init bscp-python-sdk-demo

# Enter bscp-python-sdk-demo directory
cd bscp-python-sdk-demo

# Add dependencies and deploy BSCP Python SDK components
uv add bk-bscp
```

![get_biz](../Image/bscp_python_sdk_tools_install.png)

## 3. Verify the BSCP Python SDK component

Before verifying the BSCP Python SDK component, you need to first create a key-value service in the service configuration center (BSCP) and add the corresponding key-value configuration. Next, generate and publish the version. For operation guide, please refer to the white paper: [Key-value configuration](https://bk.tencent.com/docs/markdown/ZH/BSCP/1.29/UserGuide/QuickStart/kv.md)

Save the demo in the configuration example as a demo.py file and replace {{ YOUR_KEY }} with the actual business key
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
    # Please replace {{ YOUR_KEY }} with your actual Key
    key = {{ YOUR_KEY }}
    main(key)
```

```bash
# Execute demo.py to get the value of the specified key
python demo.py
```



