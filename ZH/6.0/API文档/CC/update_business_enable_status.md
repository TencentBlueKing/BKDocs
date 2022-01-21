### 功能描述

根据业务 id 和状态值修改业务启用状态

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code   | string | 是 | 应用 ID     |
| bk_app_secret | string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token      | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username   | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                |  类型      | 必选   |  描述      |
|---------------------|------------|--------|------------|
| bk_biz_id           | int        | 是     | 业务 id     |
| flag                | string     | 是     | 启用状态，为 disabled 或者 enable |

### 请求参数示例

```json
{
    "bk_biz_id": "3",
    "bk_supplier_account": "0",
    "flag": "enable"
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
