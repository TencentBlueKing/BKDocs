# 表达式定义

## 背景

用户在权限中心申请的策略, 已表达式的形式存储; 而接入系统的资源信息只有各个系统自己知道;

在接入系统页面上, 展现一个用户有权限的某种资源列表时, 会到权限中心拉取对应策略, 返回得到表达式;

此时, 需要接入系统将表达式转换成自身存储的过滤逻辑, 筛选出对应的资源列表, 在页面上展现;

另一种场景: 在权限中心 SaaS 配置权限的页面上, 需要预览一个策略生效后对应的有权限的资源列表, 此时会拿条件表达式, 到接入系统提供的 API, 查询资源列表.

## 条件表达式处理策略

- 给到协议
- 各个接入方先自行解析, 转换成自己存储的查询
- 提取, 得到不同语言不同存储的查询转换, 例如`django queryset`/`raw sql`/`go mongodb`

## 1. 定义

定义

```graphql
input Filter{
    AND: [Filter!]
    OR: [Filter!]

    # String filters
    str eq: String
    str not_eq: String
    str in: [String!]
    str not_in: [String!]
    str contains: String
    str not_contains: String
    str starts_with: String
    str not_starts_with: String
    str ends_with: String
    str not_ends_with: String

    str any: String

    # Numeric filters
    num eq: Numeric
    num not_eq: Numeric
    num in: [Numeric!]
    num not_in: [Numeric!]
    num lt: Numeric
    num lte: Numeric
    num gt: Numeric
    num gte: Numeric

    # Boolean filters
    bool eq: Boolean
    bool not_eq: Boolean
}
```

## 2. 操作符


| 操作符 | 操作对象类型 | 支持类型 | V1 版支持(当前版本) | V2 版支持 |
|:---|:---|:---|:---|:---|
| AND             | [Filter] | Filter                 | 是           |       |
| OR              | [Filter] | Filter                 | 是           |       |
|                 |          |                        |             |       |
| eq              |          | string/numeric/boolean | 是           |       |
| not_eq          |          | string/numeric/boolean |             |       |
| in              | [type]   | string/numeric/boolean | 是          |       |
| not_in          | [type]   | string/numeric/boolean |             |       |
|                 |          |                        |             |       |
| contains        |          | string                 |             |       |
| not_contains    |          | string                 |             |       |
| starts_with     |          | string                 | 是           |       |
| not_starts_with |          | string                 |             |       |
| ends_with       |          | string                 |             |       |
| not_ends_with   |          | string                 |             |       |
|                 |          |                        |             |       |
| lt              |          | numeric                |             |       |
| lte             |          | numeric                |             |       |
| gt              |          | numeric                |             |       |
| gte             |          | numeric                |             |       |
|             |          |                |             |       |
| any             |          | string                |    是, 目前只会用于 resource.id, 表示用户有所有这类资源的权限         |       |


## 3. 协议示例

> and/or 是存在嵌套的


```bash
id in [1, 2, 3]
|| os = linux
|| owner = admin
|| (path.startswith(/biz,1/) or path.startswith(/biz,2/))
|| (biz = bk and status = online)
```




```json
{
    "op": "OR",
    "content": [
    {
        "op": "in",
        "field": "host.id",
        "value": [1, 2, 3]
    },
    {
        "op": "eq",
        "field": "host.os",
        "value": "linux"
    },
    {
        "op": "eq",
        "field": "host.owner",
        "value": "admin"
    },
    {
        "op": "OR",
        "content": [
        {
            "op": "starts_with",
            "field": "host._bk_iam_path_",
            "value": "/biz,1/",
        },
        {
            "op": "starts_with",
            "field": "host._bk_iam_path_",
            "value": "/biz,2/",
        }]
    },
    {
        "op": "AND",
        "content": [
        {
            "op": "eq",
            "field": "host.biz",
            "value": "bk"
        },
        {
            "op": "eq",
            "field": "host.status",
            "value": "online"
        }]
    }]
}
```

#### !! 注意 field 的格式

```bash
- host.id 前缀host表示id属性需要查找的是host资源实例的id属性
- 如果操作有多个依赖资源, 比如job执行, 表达式中field可能会有host.id与job.id分别对于host资源的id属性与job资源的id属性
```

## 4. 转换成对应存储查询示例

上面的条件表达式(给了一个相对复杂的配置, 实际获取得到的可能很简单, 取决于权限配置的复杂程度)

如果转换成`django queryset`

```bash
Resource.objects.filter(
	  Q(id__in=[1,2,3])
      | Q(os="linux")
      | Q(owner="admin")
      | (Q(path__startswith("/biz,1/")) |  Q(path__startswith("/biz,2/")))
      | (Q(biz="bk") & Q(status="online"))
)
```

如果转换成 sql

```sql
SELECT *
FROM resource
WHERE id IN (1, 2, 3)
       OR os="linux"
       OR owner="admin"
       OR (path like "/biz,1/%" OR path like "/biz,2/%")
       OR (biz="bk" AND status="online")
```

- 其他存储, 例如 mongodb/elasticsearch 等等, 需要接入系统自行转换
- 权限中心返回的表达式中的 key/value 等, 是接入系统注册的模型 + 用户配置权限填充的内容;

## 5. 无关联资源的操作表达式说明

```bash
{
    "code": 0,
    "data": {
        "field": "",
        "op": "any",
        "value": []
    },
    "message": "ok"
}
```

没有关联资源类型的操作, 比如创建主机, 用户有权限的情况下返回的表达式如上, field 由于资源类型为空直接置空

## 6. 参考资料

- 表达式协议参考了 graphql 的规范, 但是 graphql 没有具体的实现, 所以以下资料仅供参考, 需要自行实现
- graphql spec 中没有涉及 filter 的, 目前是每种语言的实现自行定义了 filter 处理;
    - [graphql spec](https://github.com/graphql/graphql-spec)
    - [Proposal: Basic expression language for filters inside GraphQL](https://github.com/graphql/graphql-spec/issues/271)
    - [Graphene: How to make an OR/AND filtering](https://github.com/graphql-python/graphene/issues/528)

- 多语言版本实现参考 [howtographql](https://www.howtographql.com/graphql-python/7-filtering/)
