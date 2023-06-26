# 资源拉取 API

## API 地址

接入系统注册模型到权限中心时
- 注册`system`有提供`system.provider_config.host`; 假设为`http://cmdb.consul`
- 注册`resource_type`有提供`system.provider_config.path`; 假设为`/api/v1/resources`

那么权限中心将调用`http://cmdb.consul/api/v1/resources`去拉取该资源类型相关信息

即: 接入系统需要实现一个 API, 用于权限中心拉取不同资源类型的信息;

这个 API 需要支持: (一个接口根据参数做分发)
1. `list_attr` 查询某个资源类型可用于配置权限的属性列表
2. `list_attr_value` 获取一个资源类型某个属性的值列表
3. `list_instance` 根据过滤条件查询实例
4. `fetch_instance_info` 批量获取资源实例详情
5. `list_instance_by_policy` 根据策略表达式查询资源实例(目前没有用到, 暂时可以不实现或直接返回空)
6. `search_instance` 搜索资源实例

---

## 接口协议前置说明

Request Header: 
- [系统间调用接口鉴权:权限中心->接入系统](../01-Overview/03-APIAuth.md)
- `Blueking-Language`  国际化多语言，值为：zh-cn 或 en，当值为 en 时，则接口数据返回中包含的 display_name 字段的值为英文，否则默认返回中文；
- `X-Request-Id` 请求 request_id, 请记录, 用于错误排查
- `Request-Username`, 只有`list_instance/search_instance` 两个回调接口有, 非空时为当前正在使用权限中心配置接入系统权限的用户名. (可用于接入系统配置权限展示时做一些个性化的逻辑, 例如某些实例不展示给该用户看到); 注意, 值可能为空(非用户态的API 调用无法获取用户名).

Response Header:
-  `X-Request-Id`  将请求 Header 头里的 request_id 返回, 用于错误排查

Response Body: 
遵循蓝鲸官方 API 协议进行返回, `code != 0` 表示出错, `message`包含具体信息
```bash
{
    "code": 0,
    "message": "",
    "data": {
    }
}
```
**重要**: 接入系统 API 都需要返回一个`request_id`, 权限中心将会在日志中记录, 以便后续联调及正式环境中进行问题排查; 

---

## 协议

- Method: `POST` (注意, 是`POST`)
- Path: `system.provider_config.host` + `system.provider_config.path`
- Request.Body:

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| type | string | 是 | 对应查询的资源类型 |
| method |string | 是 | 需要查询资源信息的方式，不同方式对应查询资源的不同信息，目前值有：[list_attr](./10-list_attr.md)、[list_attr_value](./11-list_attr_value.md)、 [list_instance](./12-list_instance.md)、[fetch_instance_info](./13-fetch_instance_info.md)、[list_instance_by_policy](./14-list_instance_by_policy.md)、[search_instance](./15-search_instance.md)，具体每个值的协议请往下看 |
| filter | object | 否 | 根据不同查询方式(method)，传入不同的过滤参数 |
| page | object | 否 | 当返回数据需要支持分页时，需要参数，具体包含 limit 和 offset 字段，其值类型为 int，比如 {limit: 10, "offset": 0}, limit 表示查询数量，offset 表示从第几个开始查询，offset 从 0 开始计算 |

- Response.Body: 

| 字段 |  类型 |是否必须  | 描述  |
|:---|:---|:---|:---|
| code | int | 是 |  表示请求是否成功，0 表示成功，`code != 0` 表示出错 |
| message |string | 是 | code != 0 时，message 表示错误信息，code=0 时 可返回 ok 或空字符串 |
| data | object/array | 是 | 根据不同查询方式(method)，返回的内容也不一样，类型可为数组或者字典 |

 * code 字段特别说明：

| 值 | 说明 |
| :--- | :--- |
| `code = 401` | 代表接口认证失败 |
| `code = 404` | 代表查询的 type(资源类型)或 method(查询资源信息的方式) 不存在，或其他不存在的返回，message 为具体错误信息 |
| `code = 500` | 代表查询时出现系统错误或异常，message 为具体错误或异常信息 |
| `code = 422` | 代表查询时，特别是有过滤搜索时，扫描的资源内容过多，拒绝返回数据 |
| `code = 406` | 代表搜索时 keyword 不符合要求 |
| `code = 429` | 代表接口请求超过接入系统的频率控制  |


说明:
- 接口只提供给 iam 使用, 需要单独 url/鉴权/逻辑等, 避免同现有业务使用 api 重复
- 上面的 URL 只是一个示例, 可自行定义, 注册到权限中心即可
- 需要支持版本, url 格式如`/api/v1/`, 确保后续可以进行 api 升级
- 性能要求: 

```bash
[list_attr] 
< 50ms

[list_attr_value]
无keyword搜索和id过滤条件 < 50ms
keyword搜索 < 100ms
批量 id 过滤（id数量小于10个）< 100ms
批量 id 过滤（id数量大于10个）< 200ms

[list_instance]
按照资源的上级过滤查询 < 50ms

[fetch_instance_info] 性能敏感，由于用于鉴权，所以必须严格保证该接口性能
单个资源获取 < 20ms
批量资源获取 < 100ms

[list_instance_by_policy]
< 500ms

[search_instance]
按照资源实例进行keyword搜索查询 < 100ms
```