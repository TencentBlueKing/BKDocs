# SDK 测试用例

## 背景

新版权限中心只进行`策略管理`, 资源本身还在各个接入系统;

此时从权限中心获取策略之后, 需要拿本地资源进行计算求值(eval)

例如权限中心返回表达式

```json
{
        "op": "OR",
        "content": [
            {
                "op": "eq",
                "field": "host.id",
                "value": "a1"
            },
            {
                "op": "eq",
                "field": "host.name",
                "value": "b1"
            },
        ]
}
```

会拿本地的资源带入表达式计算结果, 此时资源的`id`及`attr`可以表示为一个`json`

```json
{
    "id": "a1",
    "name": "xxxx"
}
```

计算逻辑:
- `attr` op `value`
- `("a1" eq "a1") OR ("xxxx" eq "b1")`
- 最终结果: `True`


为了确保各个语言实现的 sdk 逻辑一致性, 这里提供了几个关键细节的测试用例, 需要各个 SDK 实现对应单元测试, 确保逻辑正确性

## 关键

- 根据 [条件表达式协议](../../Reference/Expression/01-Schema.md), 计算表达式中存在两种操作符, postive (`eq/in/contains/starts_with/ends_with`)和 negative(`not_eq/not_in/not_contains/not_starts_with/not_ends_with`)
- 条件表达式中的`value`可能是单一值, 也可能是个列表
- 用户资源的属性`attr`可能是单一值, 也可能是个列表
- 计算逻辑, 会比较 `value` 和 `attr`中的每一个值 (相当于逐一比较)
- 具体: 
    - postive 则 `value`和`attr`中, 一个求值`True`则`pass`, 全部求值`False`则`no pass`
    - 举例: `op=eq, value=[1, 2]` 及 `resource.attr=[2, 3]`, 求值结果`pass`
    - negative 则 `value`和`attr`中, 全部求值 True 则 pass, 一个求值 False 则`no pass`
    - 举例: `op=not_eq, value=[1, 2]`及`resource.attr=[2, 3]`, 求值结果`no pass`

- ANY 操作符, 不需要计算, `op=any`则`pass`

- 特殊集合操作: IN 操作符, `op=in` / `op=not_in` 
    - `attr` in `value`: 如果`attr=[1,2]`, 需要逐一判定`1`/`2` 是否在 `value`中 => `1`/`2`只要一个在`value`中则`True`; 否则`False`
    - `attr` not_in `value`: 如果`attr=[1,2]`, 需要逐一判定`1`/`2` 不在 `value`中 => `1`/`2`两个都不在`value`中则`True`; 否则`False`
- 特殊集合操作: Contains 操作符, `op=contains` / `op=not_contains`
    - `attr` contains `value`: 如果`value=[3, 4]`, 需要逐一判定`attr`包含`3`/`4` => `attr`包含`3`/`4`中的一个则`True`; 全部不包含`False`
    - `attr` not_contains `value`: 如果`value=[3, 4]`, 需要逐一判定`attr`不包含`3`/`4` => `attr`全部不包含`3`/`4`则`True`; 否则`False`


## 测试用例

### 1. 常规表达式

#### OP=AND

policy

```json
{
        "op": "OR",
        "content": [
            {
                "op": "eq",
                "field": "host.id",
                "value": "a1"
            },
            {
                "op": "eq",
                "field": "host.name",
                "value": "b1"
            },
        ]
}
```

resource

```json
# host
{
        "id": "a1",
        "name": "b1"
}
```

is_allowed: `True`


#### OP=OR


policy

```json
{
        "op": "OR",
        "content": [
            {
                "op": "eq",
                "field": "host.id",
                "value": "a1"
            },
            {
                "op": "eq",
                "field": "host.name",
                "value": "b1"
            },
        ]
}
```

resource

```json
# host
{
        "id": "a1",
        "name": "b1"
}
```

is_allowed: `True`

#### OP=EQ

policy

```json
{
        "op": "eq",
        "field": "host.id",
        "value": "a1"
}
```

resource

```json
{
        "id": "a1",
        "name": "b1"
}
```

is_allowed: `True`

### 2. positive(eq 为例)

policy

```json
{
        "op": "eq",
        "field": "host.id",
        "value": VALUE
}
```

resource

```json
{
        "id": ATTR,
        "name": "b1"
}
```


| VALUE  | ATTR   | is_allowed |
|:---|:---|:---|
| 1      | 1      | True       |
| 2      | [1, 2] | True       |
| 3      | [1, 2] | False       |

- [python sdk 实现](https://github.com/TencentBlueKing/iam-python-sdk/blob/master/iam/eval/operators.py#L114)

### 3. negative(not_eq 为例)

policy

```json
{
        "op": "not_eq",
        "field": "host.id",
        "value": VALUE
}
```

resource

```json
{
        "id": ATTR,
        "name": "b1"
}
```


| VALUE  | ATTR   | is_allowed |
|:---|:---|:---|
| 1      | 2      | True       |
| 2    | 1      | True       |
| 3      | [1, 2] | True       |
| 2      | [1, 2] | False      |


- [python sdk 实现](https://github.com/TencentBlueKing/iam-python-sdk/blob/master/iam/eval/operators.py#L182)

### 4. in and not_in

```json
{
        "op": "in",
        "field": "host.id",
        "value": ["a1", "a3"]    
}

# Resource 1, True
{
    "id": ["a4", "a3"],
}
```

```json
{
        "op": "not_in",
        "field": "host.id",
        "value": ["a1", "a3"]    
}

# Resource 1, False
{
    "id": ["a4", "a3"],
}
```

### 5. contains and not_contains


```json
{
        "op": "contains",
        "field": "host.id",
        "value": ["a1", "a3"]    
}

# Resource 1, True
{
    "id": ["a4", "a3"],
}
```

```json
{
        "op": "not_contains",
        "field": "host.id",
        "value": ["a1", "a3"]    
}

# Resource 1, False
{
    "id": ["a4", "a3"],
}
```


### 6. 更多的测试用例

可以参考 python-sdk 实现的各类操作符的用例

https://github.com/TencentBlueKing/iam-python-sdk/blob/master/tests/eval/test_operators.py

## Reference

- [iam-python-sdk 实现](https://github.com/TencentBlueKing/iam-python-sdk)
- [条件表达式协议](../../Reference/Expression/01-Schema.md)