# 常用操作配置 CommonActions API
### 参数说明
| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| name |string | 是 | 常用操作名称  |
| name_en | string | 是 | 常用操作英文名，国际化时切换到英文版本显示 |
| actions | Array(Object) | 是 | 操作列表 |

### 1. 注册或更新 常用操作

#### URL

注册
> POST /api/v1/model/systems/{system_id}/configs/common_actions

更新 (整个列表完全覆盖更新)
> PUT /api/v1/model/systems/{system_id}/configs/common_actions

#### Parameters

| 字段 | 类型 | 是否必须 | 位置 | 描述 |
| :--- | :--- | :--- |:--- |:--- |
| system_id | string | 是 | path | 系统 ID |

#### Request

```json
[
    {
        "name": "测试",
        "name_en": "test",
        "actions": [
            {
                "id": "biz_delete"
            }
        ]
    }
]
```
#### Response
```json
{
    "code": 0,
    "message": "",
    "data": {}
}
```