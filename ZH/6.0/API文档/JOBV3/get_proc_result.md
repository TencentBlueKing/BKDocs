### 功能描述

操作服务器上的进程结果查询

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段        |  类型      | 必选   |  描述      |
|-------------|------------|--------|------------|
| bk_biz_id     |  int       | 是     | 业务 ID |
| bk_gse_taskid |  string    | 是     | GSE 任务 ID |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "bk_gse_taskid": "GSETASK:20180315180551:1000"
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        "status": 115,
        "result": {
            "/usr/local/gse/gseagent/plugins/unifyTlogc/sbin/bk_gse_unifyTlogc:0:10.0.0.1": {
                "content": {
                    "process": [
                        {
                            "instance": [
                                {
                                    "cpuUsageAve": 0,
                                    "stat": "",
                                    "phyMemUsage": 0,
                                    "cmdline": "",
                                    "freeVMem": "0",
                                    "pid": -1,
                                    "threadCount": 0,
                                    "cpuUsage": 0,
                                    "elapsedTime": 0,
                                    "processName": "bk_gse_unifyTlogc",
                                    "diskSize": -1,
                                    "stime": "0",
                                    "startTime": "",
                                    "usePhyMem": 0,
                                    "utime": "0"
                                }
                            ],
                            "procname": "bk_gse_unifyTlogc"
                        }
                    ],
                    "ip": "10.0.0.1",
                    "utctime": "2018-04-04 09:56:20",
                    "utctime2": "2018-04-04 01:56:20",
                    "timezone": 8
                },
                "error_code": 0,
                "error_msg": "success"
            }
        }
    },
    "request_id": "2d00aa03e3034f29a07ee1b9c889d38e"
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| status       | int       | 预留字段。GSE 任务状态码 |
| result       | object      | 真正的数据，依赖于 GSE 数据结构 |
