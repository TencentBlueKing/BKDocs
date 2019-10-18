
### 请求地址

/api/c/compapi/v2/cc/find_object_association/



### 请求方法

POST


### 功能描述

查询模型的实例之间的关联关系。

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                 |  类型      | 是否必填	   |  描述 |
|----------------------|------------|--------|-----------------------------|
| metadata           | object     | Yes    |  meta data             |
| condition | string map     | Yes   | 查询条件 |


metadata params

| 字段                 |  类型      | 是否必填	   |  描述 |
|---------------------|------------|--------|-----------------------------|
| label           | string map     | Yes     |标签信息 |


label params

| 字段                 |  类型      | 是否必填	   |  描述 |
|---------------------|------------|--------|-----------------------------|
| bk_biz_id           | string      | Yes     | 业务id |


condition params

| 字段                 |  类型      | 是否必填	   |  描述 |
|---------------------|------------|--------|-----------------------------|
| bk_asst_id           | string     | Yes     | 模型的关联类型唯一id|
| bk_obj_id           | string     | Yes     | 源模型id|
| bk_asst_id           | string     | Yes     | 目标模型id|


### 请求参数示例

``` json
{
    "condition": {
        "bk_asst_id": "belong",
        "bk_obj_id": "bk_switch",
        "bk_asst_obj_id": "bk_host"
    },
    "metadata":{
        "label":{
            "bk_biz_id":"1"
        }
    }
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
            "id": 1,
            "bk_obj_asst_id": "bk_switch_belong_bk_host",
            "bk_obj_asst_name": "",
            "bk_asst_id": "belong",
            "bk_asst_name": "belong",
            "bk_obj_id": "bk_switch",
            "bk_obj_name": "switch",
            "bk_asst_obj_id": "bk_host",
            "bk_asst_obj_name": "host",
            "mapping": "1:n",
            "on_delete": "none"
        }
    ]
}

```


### 返回结果参数说明

#### data

| 字段       | 类型     | 描述 |
|------------|----------|--------------|
| id|int64|模型关联关系的身份id|
| bk_obj_asst_id| string|  模型关联关系的唯一id.|
| bk_obj_asst_name| string| 关联关系的别名. |
| bk_asst_id| string| 关联类型id|
| bk_asst_name| string| 关联类型名称 |
| bk_obj_id| string| 源模型id |
| bk_obj_name| string| 源模型名称 |
| bk_asst_obj_id| string| 目标模型id|
| bk_asst_obj_name| string| 目标模型名称|
| mapping| string|  源模型与目标模型关联关系实例的映身关系，可以是以下中的一种[1:1, 1:n, n:n] |
| on_delete| string| 删除关联关系时的动作, 取值为以下其中的一种 [none, delete_src, delete_dest], "none" 什么也不做, "delete_src" 删除源模型的实例, "delete_dest" 删除目标模型的实例.|