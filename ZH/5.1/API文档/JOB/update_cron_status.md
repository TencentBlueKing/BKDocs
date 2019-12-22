
### 请求地址

/api/c/compapi/v2/job/update_cron_status/



### 请求方法

POST


### 功能描述

更新定时作业状态，如启动或暂停；操作者必须是业务的创建人或运维

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_biz_id   |  int    | 是     | 业务 ID |
| cron_status |  int    | 是     | 定时状态，1.启动、2.暂停 |
| cron_id     |  int    | 是     | 定时作业 ID |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "cron_status": 1,
    "cron_id": 2
}
```

### 返回结果示例

```python
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        "cron_id": 2
    }
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

| 字段      | 类型      | 描述      |
|---------- |-----------|-----------|
| cron_id   | int       | 定时任务 ID |
