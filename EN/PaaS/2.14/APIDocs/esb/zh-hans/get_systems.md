
### 请求方法

GET


### 请求地址

/api/c/compapi/v2/esb/get_systems/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用 ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

获取 ESB 中的组件系统列表

### 请求参数



### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx"
}
```

### 返回结果示例

```python
{
    "result": true
    "code": 0,
    "message": "OK",
    "data": [
        {
            "id": 1,
            "name": "BK_LOGIN",
            "label": "蓝鲸统一登录",
            "remark": "蓝鲸统一登录，管理用户登录验证，及用户信息"
        },
        {
            "id": 2,
            "name": "BK_PAAS",
            "label": "蓝鲸开发者中心",
            "remark": "蓝鲸开发者中心"
        }
    ]
}
```

### 返回结果参数说明

| 字段      | 类型      | 描述      |
|-----------|----------|-----------|
|  result   |    bool    |      返回结果，true 为成功，false 为失败     |
|  code     |    int     |      返回码，0 表示成功，其它值表示失败 |
|  message  |    string  |      错误信息      |
|  data     |    array   |      结果数据，详细信息请见下面说明 |

#### data

|   名称   |  类型  |           说明             |
| ------------ | ---------- | ------------------------------ |
|  id        |    int       |    系统 id    |
|  name      |    string    |    系统名称   |
|  label     |    string    |    系统标签   |
|  remark    |    string    |    备注   |