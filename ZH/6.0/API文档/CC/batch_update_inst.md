### 功能描述

批量更新对象实例

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code   | string | 是 | 应用 ID     |
| bk_app_secret | string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token      | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username   | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                |  类型       | 必选   |  描述                            |
|---------------------|-------------|--------|----------------------------------|
| bk_obj_id           | string      | 是     | 模型 ID                           |
| update              | object array| 是     | 实例被更新的字段及值             |

#### update
| 字段         | 类型   | 必选  | 描述                           |
|--------------|--------|-------|--------------------------------|
| bk_inst_name | string | 否    | 实例名，也可以为其它自定义字段 |
| datas        | object | 是    | 实例被更新的字段取值           |
| inst_id      | int    | 是    | 指明 datas 用于更新的具体实例   |

#### datas

**datas 是 map 类型的对象，key 是实例对应的模型定义的字段，value 是字段的取值**


### 请求参数示例

```json
{
    "bk_supplier_account":"0",
    "bk_obj_id":"test",
    "update":[
        {
          "datas":{
            "bk_inst_name":"batch_update"
          },
          "inst_id":46
         }
        ]
}
```


### 返回结果示例

```json

{
    "result": true,
    "code": 0,
    "message": "",
    "data": "success"
}
```
