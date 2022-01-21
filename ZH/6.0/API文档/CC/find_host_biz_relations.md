### 功能描述

根据主机 ID 查询业务相关信息

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code   | string | 是 | 应用 ID     |
| bk_app_secret | string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token      | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username   | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                |  类型      | 必选   |  描述                       |
|---------------------|------------|--------|-----------------------------|
| bk_host_id | int array     | 是     | 主机 ID 数组，ID 个数不能超过 500 |
| bk_biz_id  | int           | 否     | 业务 ID |

### 请求参数示例

```json
{
    "bk_host_id": [
        3,
        4
    ]
}
```

### 返回结果示例

```json
{
  "result":true,
  "code":0,
  "message":"success",
  "data": [
    {
      "bk_biz_id": 3,
      "bk_host_id": 3,
      "bk_module_id": 59,
      "bk_set_id": 11,
      "bk_supplier_account": "0"
    },
    {
      "bk_biz_id": 3,
      "bk_host_id": 3,
      "bk_module_id": 60,
      "bk_set_id": 11,
      "bk_supplier_account": "0"
    },
    {
      "bk_biz_id": 3,
      "bk_host_id": 3,
      "bk_module_id": 61,
      "bk_set_id": 12,
      "bk_supplier_account": "0"
    },
    {
      "bk_biz_id": 3,
      "bk_host_id": 4,
      "bk_module_id": 60,
      "bk_set_id": 11,
      "bk_supplier_account": "0"
    }
  ]
}
```

### 返回结果参数说明

data 字段说明：

| 名称  | 类型  | 说明 |
|---|---|---|
| bk_biz_id| int| 业务 ID |
| bk_host_id| int | 主机 ID |
| bk_module_id| int| 模块 ID |
| bk_set_id| int | 集群 ID |
| bk_supplier_account| string| 开发商账户 |

