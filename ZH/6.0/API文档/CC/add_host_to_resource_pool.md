### 功能描述

根据主机列表信息添加主机到指定 id 的资源池

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code   | string | 是 | 应用 ID     |
| bk_app_secret | string | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token      | string | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username   | string | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                  |  类型        | 必选	 |  描述                |
|----------------------|--------------|--------|---------------------|
| host_info            | object array | 是     | 主机信息              |
| directory            | int          | 否     | 资源池目录 ID           |

#### host_info
| 字段             |  类型  | 必选 |  描述                    |
|-----------------|--------|-----|-------------------------|
| bk_host_innerip | string | 是  | 主机内网 ip                |
| bk_host_name    | string | 否  | 主机名，也可以为其它属性    |
| operator        | string | 否  | 主要维护人，也可以为其它属性 |
| bk_comment      | string | 否  | 备注，也可以为其它属性      |

### 请求参数示例

```json
{
    "bk_supplier_account": "0", 
    "host_info": [
        {
            "bk_host_innerip": "127.0.0.1",
            "bk_host_name": "host1",
            "operator": "admin"
        },
        {
            "bk_host_innerip": "",
            "bk_comment": "comment"
        }
    ],
    "directory": 1
}
```

### 返回结果示例

```json
{
  "result": false,
  "code": 1110004,
  "message": "创建主机失败",
  "permission": null,
  "data": {
    "success": [
      {
        "index": 0,
        "bk_host_id": 11,
      }
    ],
    "error": [
      {
        "index": 1,
        "error_message": "'bk_host_innerip' 未赋值",
      }
    ]
  }
}

```

### 返回结果参数说明

#### response

| 名称    | 类型   | 描述                                    |
| ------- | ------ | ------------------------------------- |
| result  | bool   | 请求成功与否。true:请求成功；false 请求失败 |
| code    | int    | 错误编码。 0 表示 success，>0 表示失败错误    |
| message | string | 请求失败返回的错误信息                    |
| data    | object | 请求返回的数据                           |

#### data 字段说明

| 字段     | 类型  | 描述                |
| ------- | ----- | ------------------ |
| success | array | 添加成功的主机信息数组 |
| error   | array | 添加失败的主机信息数组 |

#### success 字段说明

| 字段        | 类型 | 说明             |
| ---------- | ---- | --------------- |
| index      | int  | 添加成功的主机下标 |
| bk_host_id | int  | 添加成功的主机 ID   |

#### error 字段说明

| 字段           | 类型   | 说明             |
| ------------- | ------ | --------------- |
| index         | int    | 添加失败的主机下标 |
| error_message | string | 失败原因         |
