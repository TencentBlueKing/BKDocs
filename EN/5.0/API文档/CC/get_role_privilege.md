
### 请求地址

/api/c/compapi/v2/cc/get_role_privilege/



### 请求方法

GET


### 功能描述

获取角色绑定权限

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                 |  类型      | 必选   |  描述                 |
|----------------------|------------|--------|-----------------------|
| bk_supplier_account  | string     | 是     | 开发商账号            |
| bk_obj_id            | string     | 是     | 模型ID                |
| bk_property_id       | string     | 是     | 模型对应用户角色属性ID|

### 请求参数示例

``` python
{
    "bk_supplier_account":"0",
    "bk_obj_id":"test",
    "bk_property_id":"test"
}
```

### 返回结果示例

```python

{
    "result": true,
    "code": 0,
    "message": "",
    "data":[
        "hostupdate",
        "hosttrans",
        "topoupdate",
        "customapi",
        "proconfig"
    ]
}
```

### 返回结果参数说明

#### data

| 字段       | 类型     | 描述         |
|------------|----------|--------------|
| hostupdate | string   | 主机编辑     |
| hosttrans  | string   | 主机转移     |
| topoupdate | string   | 主机拓扑编辑 |
| customapi  | string   | 自定义api    |
| proconfig  | string   | 进程管理     |