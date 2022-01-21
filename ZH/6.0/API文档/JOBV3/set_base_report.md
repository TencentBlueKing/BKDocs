### 功能描述

开启/关闭 Agent 基础数据采集上报功能

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
| bk_biz_id   |  int       | 是     | 业务 ID |
| sys_id      |  int       | 是     | 系统信息上报 dataid，为-1 则关闭上报 |
| cpu_id      |  int       | 是     | cpu 信息上报 dataid，为-1 则关闭上报 |
| mem_id      |  int       | 是     | mem 信息上报 dataid，为-1 则关闭上报 |
| net_id      |  int       | 是     | 网卡信息上报 dataid，为-1 则关闭上报 |
| disk_id     |  int       | 是     | 磁盘 IO 信息上报 dataid，为-1 则关闭上报 |
| proc_id     |  int       | 是     | 进程信息上报 dataid，为-1 则关闭上报 |
| crontab_id  |  int       | 是     | crontab 上报 dataid，为-1 则关闭上报 |
| iptables_id |  int       | 是     | iptables 信息上报 dataid，为-1 则关闭上报 |
| ip_list     |  array     | 是     | IP 对象数组，见下面 ip_list 结构定义 |

#### ip_list

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| bk_cloud_id |  int    | 是     | 云区域 ID |
| ip          |  string | 是     | IP 地址 |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "sys_id": -1,
    "cpu_id": -1,
    "mem_id": -1,
    "net_id": -1,
    "disk_id": -1,
    "proc_id": -1,
    "crontab_id": -1,
    "iptables_id": -1,
    "ip_list": [
        {
            "bk_cloud_id": 0,
            "ip": "10.0.0.1"
        }
    ]
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "",
    "data": {
        "bk_gse_taskid": "GSETASK:20170621165117:10000"
    }
}
```

### 返回结果参数说明

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| bk_gse_taskid       | string       | GSE 任务 ID |
