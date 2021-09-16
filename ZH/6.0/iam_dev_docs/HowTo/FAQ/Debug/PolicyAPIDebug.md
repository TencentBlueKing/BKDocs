# 鉴权接口 debug

# 1. 背景

目前策略查询及鉴权接口, 调用支持 debug, 用于接入系统在接入调试期间对接口进行`debug`

debug 接口将返回本次请求的上下文/执行详情/报错等信息

可以根据 debug 信息, 查看每条策略的执行结果, 确认接口执行正确性

**注意**, `debug`仅在接入联调时使用, 以及单一问题排查时使用, 不能用在生产; 会导致对应接口性能急剧下降.

# 2. 注意

**仅供调试用, 不要用在正式环境, 禁止用在生产逻辑**

# 3. 协议

在接口 url 中加入参数`?debug`或者`?debug=true`

```bash
http://{IAM_HOST}/api/v1/policy/query?debug

http://{IAM_HOST}/api/v1/policy/auth?debug
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

# 4. 示例

```json
# http://{IAM_HOST}/api/v1/policy/query?debug
{
    "code": 0,
    "data": {
        "content": [
            {
                "field": "host.system",
                "op": "eq",
                "value": "linux"
            }
        ],
        "op": "OR"
    },
    "debug": {
        "time": "2020-04-20T19:53:58.548923+08:00",
        "context": {
            "action": {
                "ID": "edit_host",
                "Attribute": {
                    "Attribute": {
                        "pk": 1,
                        "resource_type": [
                            {
                                "System": "bk_cmdb",
                                "Type": "host",
                                "ScopeExpression": ""
                            }
                        ]
                    }
                }
            },
            "policies": [
                {
                    "Version": "1",
                    "ID": 4,
                    "System": "bk_cmdb",
                    "Subject": {
                        "Type": "",
                        "ID": "",
                        "Attribute": {
                            "Attribute": {
                                "pk": 0
                            }
                        }
                    },
                    "Action": {
                        "ID": "",
                        "Attribute": null
                    },
                    "ResourceExpression": "[{\"system\": \"bk_cmdb\", \"type\": \"host\", \"expression\": {\"OR\": {\"content\": [{\"StringEquals\": {\"system\": [\"linux\"]}}]}}}]",
                    "Environment": "",
                    "ExpiredAt": 0,
                    "TemplateID": 0
                }
            ],
            "resources": [],
            "subject": {
                "Type": "user",
                "ID": "test1",
                "Attribute": {
                    "Attribute": {
                        "department": [],
                        "group": [
                            {
                                "pk": 5,
                                "type": "group",
                                "id": "1",
                                "policy_expired_at": 4102444800
                            }
                        ],
                        "pk": 3
                    }
                }
            },
            "system": "bk_cmdb"
        },
        "steps": [
            {
                "index": 1,
                "name": "Fetch action details"
            },
            {
                "index": 2,
                "name": "Validate action remote resource"
            },
            {
                "index": 3,
                "name": "Fetch subject details"
            },
            {
                "index": 4,
                "name": "Query Policies"
            },
            {
                "index": 5,
                "name": "Filter policies by eval resources"
            }
        ],
        "evals": {
            "4": "pass"
        },
        "error": ""
    },
    "message": "ok"
}
```


```json
# http://{IAM_HOST}/api/v1/policy/auth?debug
{
    "code": 0,
    "data": {
        "allowed": true
    },
    "debug": {
        "time": "2020-04-20T20:02:42.35988+08:00",
        "context": {
            "action": {
                "ID": "edit_host",
                "Attribute": {
                    "Attribute": {
                        "pk": 1,
                        "resource_type": [
                            {
                                "System": "bk_cmdb",
                                "Type": "host",
                                "ScopeExpression": ""
                            }
                        ]
                    }
                }
            },
            "policies": [
                {
                    "Version": "1",
                    "ID": 1,
                    "System": "bk_cmdb",
                    "Subject": {
                        "Type": "",
                        "ID": "",
                        "Attribute": {
                            "Attribute": {
                                "pk": 0
                            }
                        }
                    },
                    "Action": {
                        "ID": "",
                        "Attribute": null
                    },
                    "ResourceExpression": "[{\"system\": \"bk_cmdb\", \"type\": \"host\", \"expression\": {\"OR\": {\"content\": [{\"Any\": {\"id\": []}}]}}}]",
                    "Environment": "",
                    "ExpiredAt": 0,
                    "TemplateID": 0
                }
            ],
            "resources": [
                {
                    "System": "bk_cmdb",
                    "Type": "host",
                    "ID": "1",
                    "Attribute": {
                        "system": [
                            "linux",
                            "windows"
                        ]
                    }
                }
            ],
            "subject": {
                "Type": "user",
                "ID": "admin",
                "Attribute": {
                    "Attribute": {
                        "department": [],
                        "group": [
                            {
                                "pk": 5,
                                "type": "group",
                                "id": "1",
                                "policy_expired_at": 4102444800
                            }
                        ],
                        "pk": 1
                    }
                }
            },
            "system": "bk_cmdb"
        },
        "steps": [
            {
                "index": 1,
                "name": "Fetch action details"
            },
            {
                "index": 2,
                "name": "Validate action resource"
            },
            {
                "index": 3,
                "name": "Fetch subject details"
            },
            {
                "index": 4,
                "name": "Query Policies"
            },
            {
                "index": 5,
                "name": "Eval"
            },
            {
                "index": 6,
                "name": "Single local resource eval"
            }
        ],
        "evals": {
            "1": "pass"
        },
        "error": ""
    },
    "message": "ok"
}
```