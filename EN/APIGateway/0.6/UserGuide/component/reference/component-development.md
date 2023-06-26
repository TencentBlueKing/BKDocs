# 组件类开发

自定义组件类，均需继承自 `components.component.Component` 类，该类提供了一些公共的数据或方法，用于协助组件开发。

自定义组件类，主要需定义以下几个部分：
- 类名：由组件英文名去掉下划线（\_），各单词首字母转为大写拼接而成，如组件 get_host_list 类名应为 GetHostList
- 类属性 sys_name：组件所属系统的英文名，将组件与系统关联起来
- 内部类 Form：即 Django Form，可选，用于校验请求参数
- 类方法 handle: 组件处理入口

## 内部类 Form

内部类 Form，即 Django Form，继承自 `common.forms.BaseComponentForm`，用于校验请求参数，样例如下：

```python
from common.forms import BaseComponentForm, DefaultBooleanField, ListField, TypeCheckField
from components.component import Component


class MyComponent(Component):

    class Form(BaseComponentForm):
        ip_list = TypeCheckField(label="ip list", promise_type=list, required=False)
        is_public = DefaultBooleanField(label="is public", default=True)
        maintainers = ListField(label="maintainers", required=True)

        # clean 方法返回的数据可通过组件的 form_data 属性获取
        def clean(self):
            return self.get_cleaned_data_when_exist()
```

项目 common.forms 模块中，定义了几个常用的 Field：

- ListField: 列表 Field，可将逗号、分号、换行、空格分隔的字符串，转换为列表，如可将 "123;456;789" 转换为 ["123", "456", "789"]
- TypeCheckField: 类型检测 Field, 通过设置 promise_type 参数，检测数据的类型，若类型不符，抛出异常
- DefaultBooleanField: 默认布尔 Field，布尔数据可通过 default 参数设置默认值


## 类方法 handle

类方法 handle，为组件类的处理入口。在此方法中，可获取请求参数，请求后端接口，并设置组件的响应内容。

### 获取请求信息

在方法 handle 中，可获取当前请求的信息
- self.form_data：组件自定义 Form clean 后的数据
- self.request.kwargs：当前的请求参数，GET 请求中的 QueryString 数据 或 POST 请求中 Request Body 数据，已转换为 dict
- self.request.request_id：当前请求的请求 ID，不同的请求请求 ID 不同
- self.request.app_code：当前请求的应用 ID（即蓝鲸开发者中心中，应用的 bk_app_code）
- self.current_user.username: 当前请求用户的用户名

### 请求后端接口

如果在组件中，需要请求后端接口，可使用内置的 `outgoing.http_client`，其接口协议为

```python
self.outgoing.http_client.request(
    method,
    host,
    path,
    params=None,
    data=None,
    headers={},
    # response_type: json，接口数据是否需要转换为 JSON 字典，其他不转换
    response_type="json",
    # max_retries: 0, 接口请求异常时，重试次数
    max_retries=0,
    # response_encoding: 接口返回数据转码为此种类型
    response_encoding=None,
    # request_encoding: 请求接口参数转码为此种类型
    request_encoding=None,
    verify=False,
    cert=None,
    timeout=None
)
```

也可使用简化的 get/post 方法
```python
# 表示 request("GET", *args, **kwargs)
self.outgoing.http_client.get(*args, **kwargs) 

# 表示 request("POST", *args, **kwargs)
self.outgoing.http_client.post(*args, **kwargs) 
```

### 组件内调用其他组件

invoke_other方式，当前用户 current_user 会传递到被调用组件

```python
result = self.invoke_other("generic.cc.get_biz_by_id", kwargs={"bk_biz_id": 1})
```

直接调用方式

```python
from esb.components.generic.apis.cc.get_biz_by_id import GetBizById

result = GetBizById().invoke(kwargs={"bk_biz_id": 1})
```

### 设置组件响应

组件 handle 方法内，需要显式地设置组件的响应内容

```python
# 设置组件返回结果，payload 内容为组件实际响应结果
self.response.payload = result
```
