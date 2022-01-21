### 功能描述

第三方系统项目 cmdb 同步注册

#### 通用参数

|   字段           |  类型       | 必选     |  描述             |
|-----------------|-------------|---------|------------------|
|   bk_app_code   |   string    |   是    |  应用 ID |
|   bk_app_secret |   string    |   是    |  安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
|   bk_token      |   string    |   否    |  当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取  |
|   bk_username   |   string    |   否    |  当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户              |

#### 接口参数

| 字段          |  类型       | 必选   |  描述             |
|-----------------|-------------|---------|------------------|
|   bk_biz_id     |   int |   是   |  CMDB 业务 ID |

### 请求参数示例

```plain
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 6,
}
```

### 返回结果示例

```plain
{
    "data": {
        "project_id": 10,
        "project_name": "test"
    },
    "result": true,
    "code": 0
}
```

### 返回结果参数说明

|      名称     |     类型   |               说明             |
| ------------  | ---------- | ------------------------------ |
|  result       | bool       | true/false 成功与否            |
|  message      | string     | result=false 时错误信息        |
|  data         | dict        | 返回数据                    |

#### data
|   名称   |  类型  |           说明             |
| ------------ | ---------- | ------------------------------ |
|  project_id |    int    |  标准运维项目 ID |
|  project_name |    string | 标准运维项目名称 |
