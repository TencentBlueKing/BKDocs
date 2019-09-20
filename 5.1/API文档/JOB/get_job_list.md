
### 请求地址

/api/c/compapi/v2/job/get_job_list/



### 请求方法

GET


### 功能描述

查询作业模板

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
| creator                |  string    | 否     | 作业创建人帐号 |
| name                   |  string    | 否     | 作业名称，模糊匹配 |
| create_time_start      |  string    | 否     | 创建起始时间，YYYY-MM-DD格式 |
| create_time_end        |  string    | 否     | 创建结束时间，YYYY-MM-DD格式 |
| last_modify_user       |  string    | 否     | 作业修改人帐号 |
| last_modify_time_start |  string    | 否     | 最后修改起始时间，YYYY-MM-DD格式 |
| last_modify_time_end   |  string    | 否     | 最后修改结束时间，YYYY-MM-DD格式 |
| tag_id                 |  string    | 否     | 作业标签ID，1.未分类、2.运营发布、3.故障处理、4.常用工具、5.产品自助、6.测试专用、7.持续集成 |
| start                  |  int       | 否     | 默认0表示从第1条记录开始返回 |
| length                 |  int       | 否     | 返回记录数量，不传此参数默认返回全部 |

### 请求参数示例

```python
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "creator": "admin",
    "name": "test",
    "create_time_start": "2016-02-22",
    "create_time_end": "2016-02-22",
    "last_modify_user": "admin",
    "last_modify_time_start": "2016-02-22",
    "last_modify_time_end": "2016-02-22",
    "tag_id": "1",
    "start": 0,
    "length": 100
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
            "bk_biz_id": 1,
            "bk_job_id": 100,
            "name": "test",
            "step_num": 3,
            "tag_id": "1",
            "creator": "admin",
            "last_modify_user": "admin",
            "create_time": "2018-01-23 15:05:41 +0800",
            "last_modify_time": "2018-01-23 16:04:51 +0800"
        }
    ]
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| bk_biz_id       | int       | 业务ID |
| bk_job_id       | int       | 作业模板ID |
| name            | string    | 作业名称 |
| step_num        | int       | 作业模板中的步骤数量 |
| tag_id          | string    | 作业标签ID，1.未分类、2.运营发布、3.故障处理、4.常用工具、5.产品自助、6.测试专用、7.持续集成 |
| creator         | string    | 作业创建人帐号 |
| create_time     | string    | 创建时间，YYYY-MM-DD HH:mm:ss格式 |
| last_modify_user| string    | 作业修改人帐号 |
| last_modify_time| string    | 最后修改时间，YYYY-MM-DD HH:mm:ss格式 |