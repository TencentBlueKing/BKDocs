### 功能描述

设置进程进程组信息

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
| spec | dict | 是 | 进程详细信息，详见 spec 定义 |

#### meta

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| namespace | string | 是 | 命名空间，用于进程分组管理 |
| name | string | 否 | 进程名，用户自定义，与 namespace 共同用于进程标识 |
| labels | dict | 否 | 进程标签，方便用户按标签管理进程，key 和 value 为用户自定义，value 为 string 类型。默认为空 |

#### hosts

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| ip | string | 是 | IP 地址 |
| bk_cloud_id | int | 是 |  云区域 id |
| bk_supplier_id | int | 是 | 开发商 id |

#### spec

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| process_group | array | 是 | 进程组信息对象数组，详见 spec.process_group 定义 |

#### spec.process_group

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| id | string | 是 |  进程组 id |
| resource | dict | 是 |  进程组资源信息，详见 spec.process_group.resource 定义 |

#### spec.process_group.resource

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| cpu_pool_limit | double | 是 | 进程组 cpu 使用率上限百分比（总占比，非单核占比）,例如：30 表示 cpu 总使用率上限为 30% |
| mem_pool_limit | double | 是 | 进程组 mem 使用率上限百分比（总占比，非单核占比）,例如：30 表示 mem 总使用率上限为 30% |
| cpu_pool_weight | int | 是 | cpu 资源权值，0 或 1。<br>当为 0 时，进程资源得分等于进程资源使用率，则进程使用率越高越容易被 kill；<br>当为 1 时，进程资源得分既参考了进程资源使用率，也参考了资源倾斜（进程的资源使用率阈值越高，代表向其倾斜的资源越多，资源占用得分越低，也越不容易被 kill） |
| mem_pool_weight | int | 是 | mem 资源权值，0 或 1。<br>当为 0 时，进程资源得分等于进程资源使用率，则进程使用率越高越容易被 kill；<br>当为 1 时，进程资源得分既参考了进程资源使用率，也参考了资源倾斜（进程的资源使用率阈值越高，代表向其倾斜的资源越多，资源占用得分越低，也越不容易被 kill） |

### 请求参数示例

``` json
{
  "meta": {
	"namespace": "gse",
    "name": "",
    "labels": {
    }
  },
  "hosts": [
    {
      "ip": "10.0.0.1",
      "bk_cloud_id": 1,
      "bk_supplier_id": 2
    }
  ],
  "spec": {
	"process_group": [{
      "id": "gse",
      "resource":{
        "cpu_pool_limit": 20,
        "mem_pool_limit": 20,
        "cpu_pool_weight": 0,
        "mem_pool_weight": 0
      }
    }]
  }
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message":"success",
    "data":{
		"1:2:10.0.0.1:gse": {
			"error_code": 0,
			"error_msg": "success",
			"content": ""
		}
    }
}
```

### 返回结果参数说明

| 字段      | 类型      | 描述      |
|-----------|-----------|-----------|
|result| bool | 返回结果，true 为成功，false 为失败 |
|code|int|返回码，0 表示成功，其他值表示失败|
|message|string|返回信息 |
|data| dict| 详细结果，内容格式见下面说明:<br>`data中key为bk_cloud_id:bk_supplier_id:ip:namespace的组合，例如1:2:10.0.0.1:gse，value为对应的结果；`<br>`value为json格式，包含error_code、error_msg、content字段。其中error_code为0，表示成功；为115，表示处理中，需要重试；为其他非0字段表示失败；content字段无确切含义。` |
