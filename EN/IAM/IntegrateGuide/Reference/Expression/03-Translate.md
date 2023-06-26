# 表达式解析

如果想获取`某个用户有某个操作权限的资源列表`

此时, 使用`用户+操作`到权限中心查询, 获取得到策略条件表达式;

需要解析条件表达式为`自身存储`的查询条件, 查询得到资源列表.

## 转换成 SQL 语句

```json
{
        "op": "AND",
        "content": [
            {
                "op": "eq",
                "field": "id",
                "value": "1",
            },
            {
                "op": "eq",
                "field": "name",
                "value": "test",
            }
        ]
    }
```
    
 得到: `(id == '1' AND name == 'test')`
 
 参考实现: [Python SDK SQLConverter](https://github.com/TencentBlueKing/iam-python-sdk/blob/master/iam/contrib/converter/sql.py)

## 转换成 Django QuerySet

```json
{
        "op": "AND",
        "content": [
            {
                "op": "eq",
                "field": "id",
                "value": "1"
            }, 
            {
                "op": "eq",
                "field": "name",
                "value": "test"
            }
        ],
    }
```

得到: `Q(id="1") & Q(name="test")`

参考实现: [Python SDK DjangoQuerySetConverter](https://github.com/TencentBlueKing/iam-python-sdk/blob/master/iam/contrib/converter/queryset.py)