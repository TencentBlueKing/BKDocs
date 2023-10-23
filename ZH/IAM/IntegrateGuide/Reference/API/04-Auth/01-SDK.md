# SDK 鉴权 API

## 说明
重要:

1. 不存在跨系统资源依赖
        - 那么请求中可以不带 resources，此时会返回 用户 在 这个系统 的这个操作 的所有策略，然后在本地进行计算;
    - 所以不存在跨系统资源依赖，可以做批量接口，一次策略查询，然后遍历本地的多个资源，逐一计算结果 (此时少了 N-1 次 IO 查询)
2. 如果存在跨系统资源依赖
    - 请求策略查询，一定要带上跨系统依赖资源，上面的示例，一定要带上 bk_cmdb; 因为权限中心需要到被依赖系统拉取相关的内容进行计算
    - 所以存在跨系统资源依赖，不能做批量接口; 除非本地的多个资源依赖的是同一个其他系统资源，例如 10 个 job 作业依赖的同一个 cmdb 主机，要鉴权
3. 如果传了 resources
    - 会走两阶段计算
    - 权限中心会拿 requests 中传递的资源，先行进行计算，得到中间结果(也是策略)，返回给接入系统，接入系统继续计算


## 1. policy query 拉取权限策略

sdk 接入, 需要实现

1. 鉴权: 拉取权限策略
2. 获取有权限的资源列表

两个将使用同一个接口, 从服务端拉取策略列表

返回结果中包含条件表达式. 具体见[条件表达式协议](../../../Reference/Expression/01-Schema.md)


### 1.1 URL

> POST /api/v1/policy/query

### 1.2 Request

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system |string | 是 | 系统唯一标识  |
| subject | subject | 是 | 鉴权实体 |
| action | action | 是 | 操作 |
| resources | Array(resource_node) | 是 | 资源实例, 资源类型的顺序必须操作注册时的顺序一致;可以为空列表 |

action

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id    |  字符串  | 是   | 操作 ID |

subject

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type    |  字符串  | 是   | 授权对象类型, 当前只支持 user |
| id    |  字符串  | 是   | 授权对象 ID |

resource_node

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system |  字符串  | 是   | 资源系统 ID |
| type |  字符串  | 是   | 资源类型 ID |
| id | 字符串 | 是 | 资源实例 ID |
| attribute | 对象 | 是 | 资源属性 |



#### 无 cmdb 依赖

```json
# 1. 
{
    "system": "bk_job",
    "subject":
    {
        "type": "user",
        "id": "admin"
    },
    "action": {
        "id": "edit"
    },
    "resources": []
}
```

#### 有 cmdb 依赖

```json
{
    "system": "bk_job",
    "subject":
    {
        "type": "user",
        "id": "admin"
    },
    "action": {
        "id": "execute"
    },
    "resources": [
    {
        "system": "bk_cmdb",
        "type": "host",
        "id": "192.168.1.1"
    }]
}
```


### 1.3 Response

> Status: 200 OK

```json
{
    "code": 0,
    "message": "ok",
    "data": {  // 条件表达式
        "field": "host.id",
        "op": "any",
        "value": []
    }
}
```

## 2. policy query by actions 批量拉取一批操作的权限策略

场景: 接入系统需要对同一资源类型的一批资源实例的多个操作鉴权, 比如资源实例列表页显示多个操作是否有权限

约束:

1. 一批资源的资源类型必须是一样的
2. action 如果对 cmdb 资源有依赖, 依赖的 cmdb 资源实例必须是同一个

SDK 实现:

1. 批量拉取一批操作的权限策略
2. 本地遍历计算资源实例是否有权限

### 2.1 URL

> POST /api/v1/policy/query_by_actions

### 2.2 Request

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system |string | 是 | 系统唯一标识  |
| subject | string | 是 | subject |
| actions | Array(action) | 是 | 操作列表 |
| resources | Array(resource_node) | 是 | 资源实例, 资源类型的顺序必须操作注册时的顺序一致 |

action

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id    |  字符串  | 是   | 操作 ID |

subject

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type    |  字符串  | 是   | 授权对象类型, 当前只支持 user |
| id    |  字符串  | 是   | 授权对象 ID |

resource_node

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| system |  字符串  | 是   | 资源系统 ID |
| type |  字符串  | 是   | 资源类型 ID |
| id | 字符串 | 是 | 资源实例 ID |
| attribute | 对象 | 是 | 资源属性 |

#### 无 cmdb 依赖

```json
{
    "system": "bk_job",
    "subject":
    {
        "type": "user",
        "id": "admin"
    },
    "actions": [
        {
            "id": "edit"
        },
        {
            "id": "view"
        }
    ],
    "resources": []
}
```

#### 有 cmdb 依赖

```json
{
    "system": "bk_job",
    "subject":
    {
        "type": "user",
        "id": "admin"
    },
    "actions": [
        {
            "id": "execute"
        },
        {
            "id": "quick_execute"
        }
    ],
    "resources": [
    {
        "system": "bk_cmdb",
        "type": "host",
        "id": "192.168.1.1"
    }]
}
```

### 2.3 Response

> Status: 200 OK

``` json
{
    "code": 0,
    "message": "ok",
    "data": [ // action的顺序与请求中的acitons顺序一致
        {
            "action":{
                "id":"edit"
            },
            "condition": {  // 条件表达式
                "field": "host.id",
                "op": "any",
                "value": []
            }
        },
        {
            "action":{
                "id":"view"
            },
            "condition": {  // 条件表达式
                "field": "host.id",
                "op": "any",
                "value": []
            }
        }
    ]
}
```

## 3. query_by_ext_resources 批量第三方依赖鉴权策略查询

### 3.1 背景

本系统的操作依赖外部系统资源类型, 需要大批量使用外部资源实例鉴权

例如: 用户在作业平台需要触发上千台主机上批量执行某个作业, 比如 需要在 host1, host2 上执行 job1

这个接口, 支持拉取策略的同时, 帮助接入系统到`依赖系统`拉取策略计算需要的资源信息; 

接入系统同时拿到`策略`和`资源信息`, 就可以完成计算, 确认是否有权限;

注: 由于大批量遍历计算 expression 属于 cpu 密集计算, 如果计算放在 IAM, 在并发批量计算时, 会导致 IAM 服务 CPU 资源不足, 进而服务不可用, 所以需要把计算分散到接入系统分布计算, 减轻 IAM 服务的压力

#### 场景 1: 外部依赖资源实例的数量**不**超过 1000 个

使用建议:

直接使用`query_by_ext_resources`接口查询策略表达式与资源实例相关信息到本地后遍历计算是否有权限

#### 场景 2: 外部依赖资源实例的数量**超过**了 1000 个

------

使用建议:

1. 使用`policy/query`接口查询策略表达式
2. 本地计算表达式中是否有`any`, 是否有实例`id in ["id1", "id2"]`初步计算部分外部依赖资源实例是否权限
3. 对于在第二步中计算无权限的资源实例, 再分批次(每次不超过 1000 个)调用`query_by_ext_resources`接口查询策略表达式与资源实例相关信息到本地后遍历计算是否有权限

### 3.2 使用方式

1. 在 request body 中 resources 传 job1 相关的资源信息, 在 ext_resources 中传第三方依赖的 host1, host2
2. 返回的结果中 expression 是过滤了 request 中 resource 相关条件后的条件表达式, 结果的 ext_resources 返回填充属性的资源信息
3. **鉴权计算**: 接入系统拿到 ext_resource 后遍历每个 host 实例带入 expression 中计算得到鉴权结果

注意:

- request 中 resources 与 ext_resources 的关系, 当前 ext_resources 只能有一种第三方依赖类型的实例, resource 必须为 action 依赖的其它资源类型的实例
- ext_resources 一次查询不能超过 1000 个, 如果超过建议分批次查询

------

### 3.3 协议

#### 3.3.1 URL

> POST /api/v1/policy/query_by_ext_resources

#### 3.3.2 Request

```json
{
  "system": "bk_job",
  "subject": {
    "type": "user",
    "id": "admin"
  },
  "action": {
    "id": "execute"
  },
  "resources": [  # 参与过滤策略的资源实例, 每种资源类型只能传1个, 可以不传, 不传时返回的表达式包含操作关联所有的资源类型的条件
    {
      "system": "bk_job",
      "type": "job",
      "id": "job1",
      "attribute": {}
    }
  ],
  "ext_resources": [  # 不参与计算的资源类型, 可以批量传入, IAM会向第三方系统查询资源的属性信息, 一次最多1000个
    {
      "system": "bk_cmdb",
      "type": "host",
      "ids": [
        "host1",
        "host2"
      ]
    }
  ]
}
```

#### 3.3.3 Response

> Status: 200 OK

```json
{
  "code": 0,
  "message": "ok",
  "data": {
    "expression": {  # 已经代入request中resources计算过后的表达式
      "op": "AND",
      "content": [
        {
          "op": "in",
          "field": "host.id",
          "value": [
            "host1",
            "host2"
          ]
        },
        {
          "op": "starts_with",
          "field": "host._bk_iam_path_",
          "value": [
            "/biz,5/"
          ]
        }
      ]
    },
    "ext_resources": [  # 查询得到的第三方资源实例, 填充了与表达式相关的属性
      {
        "system": "bk_cmdb",
        "type": "host",
        "instances": [
          {
            "id": "host1",
            "attribute": {
              "_bk_iam_path_": [
                "/biz,5/"
              ]
            }
          },
          {
            "id": "host2",
            "attribute": {
              "_bk_iam_path_": [
                "/biz,5/"
              ]
            }
          }
        ]
      }
    ]
  }
}
```