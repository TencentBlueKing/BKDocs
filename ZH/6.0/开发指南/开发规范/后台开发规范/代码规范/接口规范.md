## 1 请求规范

### 1.1 编码方式

统一采用 utf-8 字符集

Ajax 全局配置

```javascript
$.ajaxSetup({
    contentType: "application/json; charset=utf-8"
});
```

Axios 全局配置

```javascript
axios.defaults.headers.common['Content-Type'] = 'application/json;charset=utf-8'
```

### 1.2 请求方法

API 的 Method，要符合实际请求的类型。

| 动词   | 含义       |
|--------|------------|
| GET    | 查看       |
| POST   | 创建       |
| DELETE | 删除       |
| PUT    | 更新或创建 |

具体可以参考文档《RESTful Web Services Cookbook》 。

### 1.3 传参方式

1. GET 请求

    参数放在请求路径后以 `?` 开头的参数串中，参数以 urlencode 编码。

2. POST/PUT/PATCH 请求

    对于复杂数据结构的传参，建议将参数 JSON 编码后放在请求体中。

### 1.4 请求参数

1. 批量数据必须排序，例如：`?sortOrder=asc&sortField=created_time`

2. 批量数据必须分页，例如：`?page=5&pagesize=50`

3. 可以批量请求的 API，不允许轮询，例如：`?id=1,2,3`

## 2 响应规范

### 2.1 统一的返回格式

接口返回内容开发建议直接参考蓝鲸 apigateway 规范，返回的内容中包含`result`, `code` , `data`, `message`, `request_id`这几个字段

| 字段名                                                      | 返回内容描述                                                   |
|-------------------------------------------------------------|----------------------------------------------------------------|
| `result`                                                      | True/False                                                     |
| `code`                                                        | 现阶段可以不使用, 0 代表正确，非 0 代表不同的错误情况；          |
| `data`                                                        | 成功时，返回的数据的内容                                       |
| `message`                                                     | 失败时，返回的错误信息                                         |
| `request_id`                                                  | 标识 请求的 id（可以自动生成的唯一标识，方便追踪请求记录 uuid） |

### 2.2 统一且合理的数据格式

1. 同一个接口，其返回的数据结构必须保持一致

2. 对返回列表数据的接口，当数据集为空时，应返回空列表，而不是 None
```json
{
    "result": true,
    "message": "",
    "code": 200,
    "data": []
}
```

3. 对于支持分页的列表数据接口，必须提供关于数据集总数信息的字段。

    输出样例（仅供参考）
```json
        {
            "result": true,
            "message": "",
            "code": 200,
            "data": [
                {
                    "id": 1,
                    "name": "test1"
                },
                {
                    "id": 2,
                    "name": "test2"
                }
            ],
            "meta": {
                "total": 100,
            }
        }
```

或者

```json
        {
            "result": true,
            "message": "",
            "code": 200,
            "data": {
                "total": 10,
                "results": [
                    {
                        "id": 1,
                        "name": "test1"
                    },
                    {
                        "id": 2,
                        "name": "test2"
                    }
                ],
            }
        }
```
4. 不允许使用变量作为 JSON key

    根据[JSON 规范](http://www.json.org/json-zh.html) ，JSON 的 key 仅用于解释其对应的 value 的含义，而不应该用于存放数据本身。

    错误的写法
```json
        {
            "result": true,
            "message": "",
            "code": 200,
            "data": {
                "110000": "北京市",
                "120000": "天津市"
            }
        }
```
应改为
```json
        {
            "result": true,
            "message": "",
            "code": 200,
            "data": [
                {
                    "code": "110000",
                    "name": "北京市"
                },
                {
                    "code": "120000",
                    "name": "天津市"
                }
            ]
        }
```
### 2.3 合适的状态码

建议充分利用 HTTP Status Code 作为响应结果的基本状态码，基本状态码不能区分的
status，再用响应中"约定"的 code 进行补充。

| 状态码 | 含义 |
|-----|----------------------------------------------------------------------------------|
| 200 | GET 请求成功，及 DELETE 或 PATCH 同步请求完成，或者 PUT 同步更新一个已存在的资源 |
| 201 | POST 同步请求完成，或者 PUT 同步创建一个新的资源                                 |
| 401 | Unauthorized : 用户未认证，请求失败                                              |
| 403 | Forbidden : 用户无权限访问该资源，请求失败                                       |
| 429 | Too Many Requests : 因为访问频繁，你已经被限制访问，稍后重试                     |
| 500 | Internal Server Error : 服务器错误，确认状态并报告问题                           |

> http 状态码详细说明请参考：https://zh.wikipedia.org/wiki/HTTP%E7%8A%B6%E6%80%81%E7%A0%81

### 2.4 参数获取方式

1. 使用 Django URL 的正则匹配获取参数

```bash
url(r'\^area/(?P\<cityID\>\\d{6})/\$', 'get_area')
```

2. 使用 Django Forms 获取参数

```python
class FilterForm(forms.Form):
    sys_type = forms.ChoiceField(choices=choices.SYS_CHOICES, required=True, label=u'类型')

def my_view(request):
    form = FilterForm(request.GET)

    if not form.is_valid():
        # 数据不合法
    else:
        # 通过 form.cleaned_data 获取数据
```

### 2.5 权限校验

1. 垂直越权

    普通用户不允许访问管理员用户资源

2. 平行越权

    普通用户不能访问没有授权的其他普通用户资源

### 3 错误码规范

#### 3.1 错误码设计

下面是两种错误码设计方法，仅供参考。

1. 数字错误码设计

    | 200        | 05           | 02           |
    |------------|--------------|--------------|
    | HTTP 状态码 | 服务模块代码 | 具体错误代码 |

2. 英文错误码设计，格式：`ERROR_错误名称`。例如：

    `ERROR_INVALID_FUNCTION`

    `ERROR_PATH_NOT_FOUND`

    `ERROR_TOO_MANY_OPEN_FILES`

    `ERROR_ACCESS_DENIED`

### 3.2 错误提示应准确并有用

需要提供两个基本内容：

1. 返回错误状态，解释原因

2. 提示用户如何解决，例如：

   - 调用 XXX 接口异常，请稍后重试，或联系管理员 XXX
   - 连接 MySQL 数据库异常，请联系管理员 XXX
   - 您输入的 XXX 不符合格式要求，请输入 XXX 格式的数据

### 3.3 提供错误说明对照表

提供一个页面或接口，展示错误码-错误详情的信息。例如：接口
`/api/v1/error_code/`，返回：

```javascript
{

    "http_status_code - error_code - message": [
        [412, "Error_LOGIN_FRONT_NOT_GIFT", "礼品不充足"],
        [503, "ERROR_FAULT", "服务器内部错误"]
    ]
}
```

## 4 对外提供微服务接口规范

SaaS 作为微服务，对外提供 API 接口，如果跨系统、跨平台，必须接入 API Gateway。

## 5 调用第三方接口规范

不允许 SaaS 直接调用第三方或底层的接口，原则上只允许调用 ESB 和 API-GateWay 提供的接口。
