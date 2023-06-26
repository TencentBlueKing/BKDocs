# 系统 System API

### 参数说明
| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| id | string | 是 | 系统 id, 全局唯一, 只允许小写字母开头、包含小写字母、数字、下划线(_)和连接符(-), 最长 32 个字符. |
| name |string | 是 | 系统名称，全局唯一 |
| name_en | string | 是 | 系统英文名，国际化时切换到英文版本显示 |
| description |string | 否 | 系统描述，全局唯一 |
| description_en | string | 否 | 系统描述英文，国际化时切换到英文版本显示 |
| clients | string | 是 | 有权限调用的客户端，即有权限调用的 app_code 列表，多个使用英文逗号分隔，注册系统时会校验 Header 头里的 app_code 必须在列表里 [更多概念说明](./00-Concepts.md) |
| provider_config | Object | 是 | 权限中心回调接入系统的配置文件 [更多概念说明](./00-Concepts.md)  |

provider_config 内元素 参数：

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| host | string | 是 | 权限中心调用查询资源实例接口的 HOST，格式：scheme://netloc，与 resource_type.provider_config.path 配合使用 |
| auth | string | 是 | 权限中心调用查询资源实例接口的鉴权方式, 当前可选: `none`/`basic`, 详细说明文档 [系统间调用接口鉴权:权限中心->接入系统](../01-Overview/03-APIAuth.md)  |
| healthz | string | 否 | 权限中心调用接入系统的 healthz 检查系统是否健康; 与 provider_config.host 配合使用, `例如system.provider_config.host=http://cmdb.consul, provider_config.healthz=/healthz/`, 那么将调用`http://cmdb.consul/healthz/`检查系统是否健康.   |

### 1. 新增 system

注意: 

- 一个 app_code 只能创建一个 system, 且 system_id 必须等于 app_code; 如果不符合要求, 接口返回 `1901400 bad request:system_id should be the app_code!`
- 创建 system 时如果没有把自己加入 clients, 会自动将当前发起`新增system`的 app_code 加入`clients`



-------

#### URL

> POST /api/v1/model/systems

#### Request

```json
{
    "id": "bk_cmdb",
    "name": "配置平台",
    "name_en": "CMDB",
    "description": "配置平台是一个...",
    "description_en": "CMDB is a...",
    "clients": "bk_cmdb,cmdb",
    "provider_config": {
        "host": "http://cmdb.service.consul",
        "auth": "basic",
        "healthz": "/api/v1/healthz"
    }
}
```
#### Response
```json
{
    "code": 0,
    "message": "",
    "data": {
        "id": "bk_cmdb"
    }
}
```

### 2. 更新 system

`路径中system_id是唯一标识; body中只需要传入要更新的字段, 其中对于provider_config是全覆盖更新，不支持只更新provider_config中某个字段`

注意: 
- 更新 system 时如果没有把自己加入 clients, 会自动将当前发起`更新system`的 app_code 加入`clients`(即, 更新发起者无法将自己移除`clients`)

#### URL

> PUT /api/v1/model/systems/{system_id}

#### Parameters

|字段 |类型 |是否必须 |位置 |描述 |
|:--|:--|:--|:--|:--|
|system_id |string |是 |path |系统 ID |

#### Request

   ```json
{
    "name": "配置平台",
    "name_en": "CMDB",
    "clients": "bk_cmdb,cmdb",
    "provider_config": {
        "host": "http://cmdb_new.service.consul"
    }
}
   ```

#### Response
```json
{
    "code": 0,
    "message": "",
    "data": {}
}
```
