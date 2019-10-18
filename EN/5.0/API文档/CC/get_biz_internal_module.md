
### 请求地址

/api/c/compapi/v2/cc/get_biz_internal_module/



### 请求方法

GET


### 功能描述

获取业务空闲机和故障机模块

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_biz_id | int        | 是     | 业务ID     |
| bk_supplier_account | string        | 是     | 开发商账号    |

### 请求参数示例

```python

{
    "bk_biz_id":0,
    "bk_supplier_account":"0"
}
```

### 返回结果示例

```python
{
  "result": true,
  "code": 0,
  "message": "success",
  "data": {
    "bk_set_id": 2,
    "bk_set_name": "空闲机池",
    "module": [
      {
        "bk_module_id": 3,
        "bk_module_name": "空闲机"
      },
      {
        "bk_module_id": 4,
        "bk_module_name": "故障机"
      }
    ]
  }
}
```

### 返回结果参数说明

#### data说明
| 字段      |  类型      |  描述      |
|-----------|------------|------------|
|bk_set_id | int64 | 空闲机和故障机所属的set的实例ID |
|bk_set_name | string |空闲机和故障机所属的set的实例名称|

#### module说明
| 字段      |  类型      |  描述      |
|-----------|------------|------------|
|bk_module_id | int64 | 空闲机或故障机的的实例ID |
|bk_module_name | string |空闲机或故障机的实例名称|