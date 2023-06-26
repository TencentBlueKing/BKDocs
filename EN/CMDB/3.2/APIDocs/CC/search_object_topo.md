
### 请求地址

/api/c/compapi/v2/cc/search_object_topo/



### 请求方法

POST


### 功能描述

查询普通模型拓扑

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 | 描述 |
|-----------|------------|--------|------------|
| bk_app_code  | string    | 是 | 应用 ID     |
| bk_app_secret| string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     | string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  | string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                  | 类型      | 必选   | 描述                                    |
|----------------------|------------|--------|------------------------------------------|
| bk_classification_id |string      |是      | 对象模型的分类 ID，只能用英文字母序列命名 |


### 请求参数示例

```json
{
    "bk_classification_id": "test"
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "",
    "data": [
        {
           "arrows": "to",
           "from": {
               "bk_classification_id": "bk_host_manage",
               "bk_obj_id": "host",
               "bk_obj_name": "主机",
               "position": "{\"bk_host_manage\":{\"x\":-357,\"y\":-344},\"lhmtest\":{\"x\":163,\"y\":75}}",
               "bk_supplier_account": "0"
           },
           "label": "bk_cloud_id",
           "label_name": "",
           "label_type": "",
           "to": {
               "bk_classification_id": "bk_host_manage",
               "bk_obj_id": "plat",
               "bk_obj_name": "云区域",
               "position": "{\"bk_host_manage\":{\"x\":-172,\"y\":-160}}",
               "bk_supplier_account": "0"
           }
        }
   ]
}
```

### 返回结果参数说明

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| result    | bool      | 请求成功与否，true:请求成功，false:请求失败 |
| code      | string    | 组件返回错误编码，0 表示 success，>0 表示失败错误 |
| message   | string    | 请求失败返回的错误消息 |
| data      | object    | 请求返回的数据 |

#### data

| 字段       | 类型      | 描述                               |
|------------|-----------|------------------------------------|
| arrows     | string    | 取值 to（单向） 或 to,from（双向） |
| label_name | string    | 关联关系的名字                     |
| label      | string    | 表明 From 通过哪个字段关联到 To 的     |
| from       | string    | 对象模型的英文 id，拓扑关系的发起方 |
| to         | string    | 对象模型的英文 ID，拓扑关系的终止方 |
