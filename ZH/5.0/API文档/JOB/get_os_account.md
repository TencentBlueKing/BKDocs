
### 请求地址

/api/c/compapi/v2/job/get_os_account/



### 请求方法

GET


### 功能描述

查询业务下的执行账号

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段       |  类型      | 必选   |  描述      |
|----------------------|------------|--------|------------|
| bk_biz_id              |  int       | 是     | 业务ID |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1
}
```

### 返回结果示例

```python
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": [
        {
            "id": 2,
            "account": "Administrator",
            "creator": "system",
            "os": "Windows",
            "alias": "Administrator",
            "bk_biz_id": 2,
            "create_time": "2018-03-22 15:36:31"
        },
        {
            "id": 19,
            "account": "SDFDSFDFDS",
            "creator": "admin",
            "os": null,
            "alias": "SDFDSFDFDS",
            "bk_biz_id": 2,
            "create_time": "2018-08-10 11:49:20"
        }
    ]
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| id              | int       | 账号ID |
| account         | string    | 账号名称 |
| creator         | string    | 账号创建人 |
| os              | string    | 账号对应的OS |
| alias           | string    | 账号别名 |
| bk_biz_id       | int       | 业务ID |
| create_time     | string    | 账号创建时间 |