### 请求地址

/api/c/compapi/v2/cc/get_mainline_object_topo/

### 请求方法

GET

### 功能描述

获取主线模型的业务拓扑

### 请求参数

#### 通用参数

| 字段 | 类型 | 必选 | 描述 |
|-----------|------------|--------|------------|
| bk_app_code | string | 是 | 应用 ID |
| bk_app_secret| string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段 | 类型 | 必选 | 描述 |
|-----------|----------|--------|------------|
| bk_supplier_account | string | 是 | 开发商账号 |

### 请求参数示例

```json
{
    "bk_supplier_account":"0"
}
```

### 返回结果示例

```json
{
  "result": true,
  "bk_error_code": 0,
  "bk_error_msg": "success",
  "data": [
    {
      "bk_obj_id": "biz",
      "bk_obj_name": "业务",
      "bk_supplier_account": "0",
      "bk_next_obj": "set",
      "bk_next_name": "集群",
      "bk_pre_obj_id": "",
      "bk_pre_obj_name": ""
    },
    {
      "bk_obj_id": "set",
      "bk_obj_name": "集群",
      "bk_supplier_account": "0",
      "bk_next_obj": "module",
      "bk_next_name": "模块",
      "bk_pre_obj_id": "biz",
      "bk_pre_obj_name": "业务"
    },
    {
      "bk_obj_id": "module",
      "bk_obj_name": "模块",
      "bk_supplier_account": "0",
      "bk_next_obj": "host",
      "bk_next_name": "主机",
      "bk_pre_obj_id": "set",
      "bk_pre_obj_name": "集群"
    },
    {
      "bk_obj_id": "host",
      "bk_obj_name": "主机",
      "bk_supplier_account": "0",
      "bk_next_obj": "",
      "bk_next_name": "",
      "bk_pre_obj_id": "module",
      "bk_pre_obj_name": "模块"
    }
  ]
}
```

### 返回结果参数说明

| 字段 | 类型 | 描述 |
|-----------|-----------|-----------|
| result  | bool | 请求成功与否，true:请求成功，false:请求失败 |
| bk_error_code | string | 组件返回错误编码。0 表示 success，>0 表示失败错误 |
| bk_error_msg | string | 请求失败返回的错误消息 |
| data    | object | 请求返回的数据 |

#### data
| 字段 | 类型 | 描述 |
|-----------|------------|------------|
| bk_obj_id | string | 模型的唯一 ID |
| bk_obj_name | string |模型名称|
| bk_supplier_account | string |开发商帐户名称|
| bk_next_obj | string |当前模型的下一个模型唯一 ID|
| bk_next_name | string |当前模型的下一个模型名称|
| bk_pre_obj_id | string |当前模型的前一个模型的唯一 ID|
| bk_pre_obj_name | string |当前模型的前一个模型的名称|
