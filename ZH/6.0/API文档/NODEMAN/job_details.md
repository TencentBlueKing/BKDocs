### 功能描述

查询任务详情

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段     | 类型       | 必选 |描述                  |
|----------|------------|----------|-----------------------------|
| job_id | int | 是 | 任务 ID |
| conditions | dict | 是 | 搜索条件 |
| page | int | 是 | 当前页数 |
| pagesize | int | 是 | 分页大小 |

### 请求参数示例
```plain
{
		"job_id": 306,
    "page":1,
    "pagesize":50,
    "conditions":[
        {
            "key":"ip",
            "value":"127.0.0.1"
        },
        {
            "key":"status",
            "value":[
                "SUCCESS"
            ]
        }
    ]
}
```

### 返回结果示例
```plain
{
    "message": "",
    "code": 0,
    "data": {
        "status": "SUCCESS",
        "ip_filter_list": [],
        "job_type_display": "启动插件",
        "job_type": "MAIN_START_PLUGIN",
        "start_time": "2021-03-01 16:01:55+0800",
        "list": [
            {
                "bk_biz_id": 5,
                "status": "SUCCESS",
                "bk_host_id": 35,
                "bk_cloud_name": "直连区域",
                "instance_id": "host|instance|host|35",
                "node_id": 7,
                "inner_ip": "127.0.0.1",
                "bk_cloud_id": 0,
                "is_manual": false,
                "status_display": "执行成功",
                "bk_biz_name": "节点管理测试用",
                "ap_id": 1
            }
        ],
        "statistics": {
            "running_count": 0,
            "total_count": 1,
            "success_count": 1,
            "failed_count": 0,
            "pending_count": 0
        },
        "total": 1
    },
    "result": true,
    "request_id": "101531702f6b4d858356473db82dd27a"
}
```
