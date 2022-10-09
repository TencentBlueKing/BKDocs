# 组件编码

组件编码，通过编写组件代码，添加组件通道配置，提供 API 服务。以如下接口为例，详细介绍如何开发新组件。

> 注：适用于需自定义处理逻辑的场景

- 系统名称：主机配置平台 HCP
- 接口名称：查询主机列表 get_host_list
- 接口地址：http://hcp.domain.com/hcp/get_host_list/

## 添加系统

添加一个新的系统，系统信息中填入以下内容：

- 系统名称：HCP
- 系统标签：主机配置平台

## 创建系统及组件文件

在项目的 `components/generic/apis/` 下，按照下面结构创建目录及文件([模版下载](https://bktencent-1252002024.file.myqcloud.com/hcp.tar.gz))：

```bash
components/generic/apis/
|
|-- hcp
|   |-- __init__.py
|   |-- toolkit
|   |   |-- __init__.py
|   |   |-- configs.py
|   |   |-- tools.py
|   |-- get_host_list.py
```

- hcp 为系统包，包名为系统名称小写。
- hcp/toolkit 为系统工具包，存储系统配置及共用方法。
- hcp/toolkit/configs.py 为系统配置模块，配置系统名称、系统域名地址等。
- hcp/toolkit/tools.py 为系统共用方法模块。
- hcp/get_host_list.py 为"查询主机列表"组件模块。

## 组件配置中添加系统信息

在"components/generic/apis/hcp/toolkit/configs.py"中添加系统配置，样例如下：

```python
# -*- coding: utf-8 -*-
from esb.utils import SmartHost

# 系统名的小写形式要与系统包名保持一致
SYSTEM_NAME = 'HCP'

host = SmartHost(
    # 需要填入系统正式环境的域名地址
    host_prod='hcp.domain.com',
)
```

## 开发组件模块

在"components/generic/apis/hcp/get_host_list.py"中添加组件代码，样例如下：

```python
# -*- coding: utf-8 -*-
import json

from django import forms

from common.forms import BaseComponentForm, TypeCheckField
from components.component import Component
from .toolkit import configs

class GetHostList(Component):
    
    # 组件所属系统的系统名
    sys_name = configs.SYSTEM_NAME

    # Form处理参数校验
    class Form(BaseComponentForm):
        bk_biz_id = forms.CharField(label=u'业务ID', required=True)
        ip_list = TypeCheckField(label=u'主机IP地址', promise_type=list, required=False)

        # clean方法返回的数据可通过组件的form_data属性获取
        def clean(self):
            return self.get_cleaned_data_when_exist(keys=['bk_biz_id', 'ip_list'])

    # 组件处理入口
    def handle(self):
        # 获取Form clean处理后的数据
        data = self.form_data

        # 设置当前操作者
        data['operator'] = self.current_user.username

        # 请求系统接口
        response = self.outgoing.http_client.post(
            host=configs.host,
            path='/hcp/get_host_list/',
            data=json.dumps(data),
        )

        # 对结果进行解析
        code = response['code']
        if code == 0:
            result = {
                'result': True,
                'data': response['data'],
            }
        else:
            result = {
                'result': False,
                'message': result['message']
            }
        # 设置组件返回结果，payload为组件实际返回结果
        self.response.payload = result
```

注意：

- 组件类名，为组件模块名去掉下划线\(\_\)，并转为驼峰形式，如 get_host_list 组件类名应为 GetHostList
- 组件开头部分为组件文档，注册组件通道后，通过下面指令可更新文档，组件文档地址

```bash
# 设置环境变量
source /root/.bkrc
source $CTRL_DIR/functions
export BK_ENV=production
export BK_FILE_PATH=/data/bkce/open_paas/cert/saas_priv.txt
export PAAS_LOGGING_DIR=/data/bkce/logs/open_paas

workon open_paas-esb
python manage.py sync_api_docs
```

## 注册组件通道

组件模块开发完成后，**注册组件通道**，通道信息中填入内容如下：

- 通道名称：查询服务列表
- 通道路径：/hcp/get_host_list/
- 所属系统：选择 HCP 系统
- 对应组件代号：generic.hcp.get_host_list

## 重启服务

组件添加完成后，重启服务，重启步骤如下:

```bash
systemctl restart bk-paas-esb.service
```
新组件的访问地址为：

```bash
http://xxx.domain.com/api/c/compapi/hcp/get_host_list/
```

## 附录

开发新组件时，在组件模块中，可根据组件基类 Component 或公用模块获取一些有用数据，帮助开发。

### Component 基类中可用数据

- request: 请求数据，其中常用的属性参考下文描述
- form_data: 组件模块中自定义 Form clean 后的数据
- current_user: 当前用户，通过其属性 username 获取当前用户的用户名
- outgoing.http_client: 请求接口 Client，可用其请求其他接口，具体参数参考下面描述

### Component 中 request 的常用属性

- request_id: 一次请求的唯一 ID，一个 uuid 字符串
- app_code: 当前请求的应用 ID
- kwargs: 当前的请求参数，GET 请求中的 QueryString 数据 或 POST 请求中 Request Body 数据，已转换为 dict

### Component 中 outgoing.http_client 支持方法

```python
# response_type: json，接口数据是否需要转换为JSON字典，其他不转换
# max_retries: 0, 接口请求异常时，重试次数
# request_encoding: 请求接口参数转码为此种类型
# response_encoding: 接口返回数据转码为此种类型
outgoing.http_client.request(
    method, host, path, params=None, data=None, headers={},
    response_type='json', max_retries=0, response_encoding=None,
    request_encoding=None, verify=False, cert=None,
    timeout=None
)
outgoing.http_client.get # 表示 request('GET', *args, **kwargs)
outgoing.http_client.post # 表示 request('POST', *args, **kwargs)
```

### common.forms 模块中自定义 Field

- ListField: 列表 Field，可将逗号，分号、换行、空格分隔的字符串，转换为列表，如可将"123;456;789"转换为["123", "456", "789"]
- TypeCheckField: 类型检测 Field, 通过设置 promise_type 参数，检测数据的类型，若参数类型不符，抛出异常
- DefaultBooleanField: 默认布尔 Field，布尔数据可通过 default 参数设置默认值

### 组件内调用其他组件的方式

- invoke_other 方式，当前用户 current_user 会传递到被调用组件

```python
result = self.invoke_other('generic.auth.get_user', kwargs={'username': 'xxx'})
```

### 直接调用方式

```python
from esb.components.generic.apis.auth.get_user import GetUser
result = GetUser().invoke(kwargs={'username': 'xxx'})
```
