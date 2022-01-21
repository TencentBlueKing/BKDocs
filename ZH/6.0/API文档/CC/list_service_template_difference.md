### 功能描述

列出服务模版和服务实例之间的差异 (v3.9.19)

- 该接口专供 GSEKit 使用，在 ESB 文档中为 hidden 状态

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code   | string | 是 | 应用 ID     |
| bk_app_secret | string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token      | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username   | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

|字段|类型|必填|描述|
|---|---|---|---|
| bk_biz_id  | int64       | Yes      | 业务 ID |
|bk_module_ids|int64 array|No|模块 ID 列表，最多不能超过 20 个|
|service_template_ids|int64 array|No|服务模板 ID 列表，最多不能超过 20 个|
|is_partial|bool|Yes|为 true 时，使用 service_template_ids 参数，返回 service_template 的状态；为 false 时，使用 bk_module_ids 参数，返回 module 的状态|


### 请求参数示例

- 示例 1
``` json
{
    "bk_biz_id": 3,
    "service_template_ids": [
        1,
        2
    ],
    "is_partial": true
}
```
- 示例 2
```plain
{
    "bk_biz_id": 3,
    "bk_module_ids": [
        11,
        12
    ],
    "is_partial": false
}
```

### 返回结果示例
- 示例 1
``` json
{
    "result": true,
    "code": 0,
    "message": "success",
    "permission": null,
    "data": {
        "service_templates": [
            {
                "service_template_id": 1,
                "need_sync": true
            },
            {
                "service_template_id": 2,
                "need_sync": false
            }
        ]
    }
}
```
- 示例 2
```plain
{
    "result": true,
    "code": 0,
    "message": "success",
    "permission": null,
    "data": {
        "modules": [
            {
                "bk_module_id": 11,
                "need_sync": false
            },
            {
                "bk_module_id": 12,
                "need_sync": true
            }
        ]
    }
}
```

### 返回结果参数说明

| 名称  | 类型  | 描述 |
|---|---|--- |
| result | bool | 请求成功与否。true:请求成功；false 请求失败 |
| code | int | 错误编码。 0 表示 success，>0 表示失败错误 |
| message | string | 请求失败返回的错误信息 |

- data 字段说明

| 名称  | 类型  | 描述 |
|---|---|--- |
|service_templates|object array|服务模板信息列表|
|modules|object array|模块信息列表|

- service_templates 字段说明

| 名称  | 类型  | 描述 |
|---|---|--- |
|service_template_id|int|服务模板 ID|
|need_sync|bool|服务模版所应用的模块下的服务实例和服务模板是否有差异|

- modules 字段说明

| 名称  | 类型  | 描述 |
|---|---|--- |
|bk_module_id|int|模块 ID|
|need_sync|bool|模块下的服务实例和服务模板是否有差异|
