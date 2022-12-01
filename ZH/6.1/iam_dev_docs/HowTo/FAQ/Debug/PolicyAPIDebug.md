# 排查: 为什么有权限/无权限

## 背景

接入系统在接入权限中心过程中, 可能有时候会对鉴权结果有疑问
1. 为什么这个人鉴权结果是**有权限**?
2. 为什么这个人鉴权结果是**没有权限**?

权限中心相应的鉴权接口, 提供了`api debug`功能

步骤:
1. 开启`api debug`
2. 获取对应的返回值
3. 分析确定为什么**有权限/无权限**

## 1. 开启`api debug`

### 1.1 SDK

SDK 是支持通过配置或环境变量开启`api debug`的.

- [iam-python-sdk debug](https://github.com/TencentBlueKing/iam-python-sdk/blob/master/docs/usage.md#112-api-debug)
- [iam-go-sdk debug](https://github.com/TencentBlueKing/iam-go-sdk/blob/master/docs/usage.md#13-%E5%BC%80%E5%90%AFapi-debug)
- [iam-php-sdk debug](https://github.com/TencentBlueKing/iam-php-sdk/blob/master/docs/usage.md#13-%E5%BC%80%E5%90%AFapi-debug)

### 1.2 非 SDK

直接在对应请求接口后面加入`?debug=true&force=true`, 并发送请求, 获取响应结果

```bash
http://{IAM_HOST}/api/v1/policy/query?debug=true&force=true

http://{IAM_HOST}/api/v1/policy/auth?debug=true&force=true
```

## 2. 获取对应的返回值

使用 curl 或者对应语言库, 发送`URL?debug=true&force=true`请求后, 拿到的响应结果中多了一个字段`debug`

```bash
{
    "code": 0,
    "data": {},
    "debug": {},
    "message": ""
}
```

debug 中包含请求上下文, 获取的策略, 执行结果等详细信息

最终以接口返回的debug信息进行`是否有权限`排查

## 3. 分析确定

debug 信息中

`expression`字段是最终鉴权计算的表达式

```json
"expression": {
				"content": [{
					"content": [{
						"field": "host._bk_iam_path_",
						"op": "starts_with",
						"value": "/biz,2005000002/set,2000000004/module,2000000008/"
					}, {
						"field": "host._bk_iam_path_",
						"op": "starts_with",
						"value": "/biz,2005000002/set,2000000005/module,*/"
					}],
					"op": "OR"
				}, {
					"field": "biz_account.id",
					"op": "any",
					"value": []
				}],
				"op": "AND"
			}
```

是一个`AND/OR`与操作符组成的逻辑表达式

可以将`debug`中`"resources"`字段(鉴权传递的资源)带进去, 确认下整个表达式执行结果`true`or`false`

有可能:
1. 鉴权传递的参数有问题, 例如 id 错误/id 格式错误/未传递`_bk_iam_path_`导致拓扑类权限执行失败/少传递了资源某些属性
2. 用户的确没有该权限, 用户权限过期/退出组织/其所在部门退出组织等这类, 对应权限将被回收.

如果自己无法确定, 可以提单, 请将`debug`详情附到单据中.(注意 debug 中的敏感信息, 例如 app_code/app_secret 等提单是需要去掉)

## 附: 鉴权接口 debug 说明

目前策略查询及鉴权接口, 调用支持 `debug`, 用于接入系统在接入调试期间对接口进行`debug`

debug 接口将返回本次请求的上下文/执行详情/报错等信息

可以根据 debug 信息, 查看每条策略的执行结果, 确认接口执行正确性

注意: **仅供调试用, 不要用在正式环境, 禁止用在生产逻辑** (不能用在生产; 会导致对应接口性能急剧下降)

### 协议

在接口 url 中加入参数`?debug=true&force=true`

```bash
http://{IAM_HOST}/api/v1/policy/query?debug=true&force=true

http://{IAM_HOST}/api/v1/policy/auth?debug=true&force=true
```

返回内容:

```json
{
    "code": 0,
    "data": {},
    "debug": {
        "time": "2020-04-20T19:53:58.548923+08:00",
        "context": {        # 上下文
            "action": {},    #     Action信息
            "policies": [    #     使用到的所有策略列表
                {
				"ID": 4,    # Policy的ID
                }
            ],
            "resources": [],  #   Resource资源信息
            "subject": {},     #   Subject用户信息
            "system": "bk_cmdb"   # 系统
        },
        "steps": [             # 执行的步骤信息
            {
                "index": 1,
                "name": "Fetch action details"
            },
        ],
        "evals": {            # 每条策略执行结果, key为PolicyID, 状态 paas/nopaas/unknown
            "4": "pass"
        },
        "error": ""           # 具体报错信息
    },
    "message": "ok"
}
```

- 相对于正常接口, debug 接口多返回一个 debug 字段
- time: 时间
- context: 上下文
    - system: 系统
    - subject: 用户
    - action: 操作
    - resources: 资源
    - policies: 计算用到的所有策略
- steps: 执行步骤
- evals: 策略执行结果
    - pass,  成功
    - nopass, 失败
    - unknown, 未知, 提前返回没有计算到这条策略
- error: 报错






