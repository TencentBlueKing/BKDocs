
### 请求方法

GET


### 请求地址

/api/c/compapi/v2/itsm/get_service_catalogs/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

服务目录查询

### 请求参数



#### 接口参数

| 字段  | 类型  | 必选  | 描述  |
| --- | --- | --- | --- |
|  has_service   |  string   |  否   |  默认返回全部服务目录，has_service="true"时只返回绑定了服务项的目录 |
|  service_key   |  string   |  否   |  服务项key值：change(变更)，event(事件)，request(请求)，question(问题)，支持通过服务项key值过滤绑定了服务的服务目录 |


### 请求参数示例

```json
{
    "bk_app_secret": "xxxx",
    "bk_app_code": "xxxx",
    "bk_token": "xxxx",
    "has_service": "true",
    "service_key": "change"
}
```

### 返回结果示例

```json
{
    "message": "success",
    "code": 0,
    "data": [
        {
            "name": "根目录",
            "level": 0,
            "id": 1,
            "key": "root",
            "desc": "",
            "children": [
                {
                    "name": "基础配置",
                    "level": 1,
                    "id": 10,
                    "key": "JICHUPEIZHI",
                    "children": [
                        {
                            "name": "业务管理",
                            "level": 2,
                            "id": 12,
                            "key": "YEWUGUANLI",
                            "children": [],
                            "desc": ""
                        }
                    ],
                    "desc": ""
                }
            ]
        }
    ],
    "result": true
}
```

### 返回结果参数说明

| 字段      | 类型     | 描述                    |
| ------- | ------ | --------------------- |
| result  | bool   | 返回结果，true为成功，false为失败 |
| code    | int    | 返回码，0表示成功，其他值表示失败     |
| message | string | 错误信息                  |
| data    | array  | 返回数据                    |

### data
| 字段      | 类型     | 描述                    |
| ------- | ------ | --------------------- |
| id | int | 服务目录id                |
| key | string | 服务目录唯一标识                |
| name | string | 服务目录名称                  |
| level | int | 服务目录等级                  |
| desc    | string  | 服务目录描述     |
| children    | array  | 服务目录子目录     |

### children
| 字段      | 类型     | 描述                    |
| ------- | ------ | --------------------- |
| id | int | 服务目录id                |
| key | string | 服务目录唯一标识                |
| name | string | 服务目录名称                  |
| level | int | 服务目录等级                  |
| desc    | string  | 服务目录描述     |
| children    | array  | 服务目录子目录     |