# SDK 相关

## 1. 怎么把 iam-python-sdk 的日志落地项目

需要增加项目的 logging 配置, 具体见文档 [流水日志](https://github.com/TencentBlueKing/iam-python-sdk/blob/master/docs/usage.md#%E6%B5%81%E6%B0%B4%E6%97%A5%E5%BF%97)

## 2. 怎么开启 python-sdk 的 debug

详细内容见 [5.1 开启 debug 及配置流水日志](https://github.com/TencentBlueKing/iam-python-sdk/blob/master/docs/usage.md#api-debug)

**注意** :  `debug` 仅在调试阶段开启, 生产环境请关闭( `iam_looger.setLevel(logging.ERROR)` );

```python
from iam import IAM, Request, Subject, Action, Resource

import sys
import logging
iam_logger = logging.getLogger("iam")
iam_logger.setLevel(logging.DEBUG)

debug_hanler = logging.StreamHandler(sys.stdout)
debug_hanler.setFormatter(logging.Formatter('%(levelname)s [%(asctime)s] [IAM] %(message)s'))
iam_logger.addHandler(debug_hanler)
```