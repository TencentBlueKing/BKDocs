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

## 3. iam-go-sdk 中 NewRequest为什么是一个slice?

```go
req := iam.NewRequest(
    "bk_paas",
    iam.NewSubject("user", "admin"),
    iam.NewAction("develop_app"),
    []iam.ResourceNode{
        iam.NewResourceNode("bk_paas", "app", "1", map[string]interface{}{}),
    },
)
```

[API 文档-概览-接口协议前置说明: 接口协议中resources字段说明](../../../Reference/API/01-Overview/02-APIBasicInfo.md)

## 4. iam-go-sdk 中生成无权限申请url GetApplyURL函数的 bkToken/bkUsername怎么传递?

代码位置: [iam.go](https://github.com/TencentBlueKing/iam-go-sdk/blob/master/iam.go#L299) 

- 如果使用 ESB 调用权限中心(`iam := NewIAM()`), bkToken/bkUsername二者必须传递一个
- 如果使用 APIGateway调用权限中心(`iam := NewAPIGatewayIAM()`), bkToken/bkUsername无实际作用, 理论上不需要传递, 但是 SDK 未来兼容 ESB调用做了不能全不为空的检查, 所以此时bkUsername填任意一个字符串即可

## 5. sdk 中的批量鉴权函数, 是否支持两个不同的操作, 操作各自对应的实例视图不一样(即操作关联的资源类型不同)?

不支持

- 批量操作单个资源接口, 所有操作关联的资源类型需一致
- 批量资源单个操作接口, 只有一个操作
- 批量操作批量资源接口, 所有操作关联的资源类型需一致

可以参考`BatchResourceMultiActionsAllowed`自行进行封装

1. PolicyQueryByActions(传两个action) 得到返回值=> 两个action对应的policy
2. 直接获取 policy1 = p['a']. policy2 = p['b'], 拼接鉴权资源 objectset1, objectset2, 分别执行eval

## 6. 使用 SDK 介入后, 配置权限回调接入系统时报 401

权限中心拿token回调接入系统, 接入系统返回 401 了

此时代表token校验失败

开启sdk的debug看下日志, 为什么没有拿到token, 或者拿到的token同回调请求header中的token为什么不匹配.
