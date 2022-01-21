### 功能描述

根据业务 id,集群 id,模块 id,将指定业务集群模块下的主机上交到业务的空闲机模块

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code   | string | 是 | 应用 ID     |
| bk_app_secret | string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token      | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username   | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段          |  类型      | 必选     |  描述    |
|---------------|------------|----------|----------|
| bk_biz_id     | int        | 是       | 业务 id   |
| bk_set_id     | int        | 是       | 集群 id   |
| bk_module_id  | int        | 是       | 模块 id   |


### 请求参数示例

```json
{
    "bk_biz_id":10,
    "bk_module_id":58,
    "bk_set_id":1
}
```

### 返回结果示例

```json

{
    "result": true,
    "code": 0,
    "message": "",
    "data": "sucess"
}
```
