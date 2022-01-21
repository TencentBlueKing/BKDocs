### 功能描述

进程操作

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| meta | dict | 是 | 进程管理元数据，详见 meta 定义 |
| hosts | array | 是 | 主机对象数组，详见 hosts 定义 |
| op_type | int | 是 | 进程操作类型：<br>0:启动进程（start）,调用 spec.control 中的 start_cmd 启动进程，启动成功会注册托管； <br>1:停止进程（stop）, 调用 spec.control 中的 stop_cmd 启动进程，停止成功会取消托管； <br>2:进程状态查询； <br>3:注册托管进程，令 gse_agent 对该进程进行托管（托管：当托管进程异常退出时，agent 会自动拉起托管进程；当托管进程资源超限时，agent 会杀死托管进程）； <br>4:取消托管进程，令 gse_agent 对该进程不再托管； <br>7:重启进程（restart）,调用 spec.control 中的 restart_cmd 启动进程； <br>8:重新加载进程（reload）,调用 spec.control 中的 reload_cmd 启动进程； <br>9:杀死进程（kill）,调用 spec.control 中的 kill_cmd 启动进程，杀死成功会取消托管 |

#### meta

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| namespace | string | 是 | 命名空间，用于进程分组管理 |
| name | string | 是 | 进程名，用户自定义，与 namespace 共同用于进程标识 |
| labels | dict | 否 | 进程标签，方便用户按标签管理进程，key 和 value 为用户自定义，value 为 string 类型。默认为空 |

#### hosts

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| ip | string | 是 | IP 地址 |
| bk_cloud_id | int | 是 |  云区域 id |
| bk_supplier_id | int | 是 | 开发商 id |

### 请求参数示例

``` json
{
  "meta": {
	"namespace": "gse",
    "name": "proc-test",
    "labels": {
        "proc_name": "proc-test"
    }
  },
  "op_type": 0,
  "hosts": [
    {
      "ip": "10.0.0.1",
      "bk_cloud_id": 1,
      "bk_supplier_id": 2
    }
  ]
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message":"success",
    "data":{
        "task_id": "GSETASK:XXXXXXXXXX"
    }
}
```

### 返回结果参数说明

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
|result| bool | 返回结果，true 为成功，false 为失败 |
|code|int|返回码，0 表示成功，其他值表示失败|
|message|string|返回信息 |
|data| dict| 详细结果，详见 data 定义 |

#### data

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
|task_id|String|进程操作实例 ID |