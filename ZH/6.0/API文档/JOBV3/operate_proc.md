### 功能描述

操作服务器上的进程

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
| op_type       |  int       | 是     | 操作类型，可选值：0:启动进程(start); 1:停止进程(stop); 2:进程状态查询; 3:注册托管进程; 4:取消托管进程; 7:重启进程(restart); 8:重新加载进(reload); 9:杀死进程(kill) |
| process_infos |  array     | 是     | 进程操作参数数组，见下面 process_infos 结构定义 |

#### process_infos

| 字段        |  类型      | 必选   |  描述      |
|-------------|------------|--------|------------|
| setup_path    |  string    | 是     | 进程路径，例如/usr/local/gse/gseagent/plugins/unifyTlogc/sbin |
| proc_name     |  string    | 是     | 进程名称，例如 bk_gse_unifyTlogc |
| pid_path      |  string    | 是     | 进程的 pid 文件所在路径, 例如/usr/local/gse/gseagent/plugins/unifyTlogc/log/bk_gse_unifyTlogc.pid |
| account       |  string    | 否     | 系统帐号，默认不传为 root |
| cmd_shell_ext |  string    | 否     | 进程操作控制脚本的扩展名: sh:默认值 shell 适于 Linux 或 cygwin,bat:windows 的 dos 脚本,ps1:windows 的 Powershell 脚本;注意：这个是针对 ip_list 参数下所有 IP 统一配置，所以确保接口传递的 ip_list 参数下所有 IP 都能支持指定的脚本。 |
| cpu_lmt       |  int       | 否     | 进程使用 cpu 限制，超过限制 agent 会根据配置的 cmd_shell_ext 调用相应类型的 stopCmd 停止进程。 |
| mem_lmt       |  int       | 否     | 进程使用 mem 限制，超过限制 agent 会根据配置的 cmd_shell_ext 调用相应类型的 stopCmd 停止进程。 |
| ip_list       |  array     | 是     | IP 对象数组，见下面 ip_list 结构定义 |

#### ip_list

| 字段        |  类型      | 必选   |  描述      |
|-------------|------------|--------|------------|
| bk_cloud_id |  int    | 是     | 云区域 ID |
| ip          |  string | 是     | IP 地址 |

### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "op_type": 1,
    "process_infos": [
        {
            "setup_path": "/usr/local/xxx",
            "proc_name": "gseagent",
            "pid_path": "/usr/local/xxx",
            "account": "root",
            "cmd_shell_ext": "bat",
            "cpu_lmt": 50,
            "mem_lmt": 30,
            "ip_list": [
                {
                    "bk_cloud_id": 0,
                    "ip": "10.0.0.1"
                }
            ]
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
        "bk_gse_taskid": "GSETASK:20180315180551:1000"
    }
}
```

### 返回结果参数说明

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
| bk_gse_taskid       | string       | GSE 任务 ID |
