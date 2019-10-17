
### 请求地址

/api/c/compapi/v2/cc/create_object/



### 请求方法

POST


### 功能描述

创建模型

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                 |  类型      | 必选   |  描述                                                    |
|----------------------|------------|--------|----------------------------------------------------------|
| creator              |string      | 否     | 本条数据创建者                                           |
| bk_classification_id | string     | 是     | 对象模型的分类ID，只能用英文字母序列命名                 |
| bk_obj_id            | string     | 是     | 对象模型的ID，只能用英文字母序列命名                     |
| bk_obj_name          | string     | 是     | 对象模型的名字，用于展示，可以使用人类可以阅读的任何语言 |
| bk_supplier_account  | string     | 是     | 开发商账号                                               |
| bk_obj_icon          | string     | 否     | 对象模型的ICON信息，用于前端显示，取值可参考[(modleIcon.json)](/static/esb/api_docs/res/cc/modleIcon.json)|


### 请求参数示例

```python
{
    "creator": "admin",
    "bk_classification_id": "test",
    "bk_obj_name": "test",
    "bk_supplier_account": "0",
    "bk_obj_icon": "icon-cc-business",
    "bk_obj_id": "test"
}
```


### 返回结果示例

```python

{
    "result": true,
    "code": 0,
    "message": "",
    "data": {
        "id": 1038
    }
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述               |
|-----------|-----------|--------------------|
| id        | int       | 新增的数据记录的ID |