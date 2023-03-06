# python_atom_sdk接口指引

## sdk代码结构
```text
python_atom_sdk
├── __init__.py     # sdk暴露的接口
├── bklog.py        # 日志相关
├── const.py        # 常量
├── input.py        # 解析用户输入
├── openapi.py      # 调用openapi接口
├── output.py       # 设置输出
├── setting.py      # 配置
```
主要关注`__init__.py`，开发插件需要用的功能均在这个文件里定义

## \_\_init\_\_.py
```python
# -*- coding: utf-8 -*-

from .bklog import BKLogger, getLogger
from .input import ParseParams
from .output import SetOutput
from .const import Status, OutputTemplateType, OutputFieldType, OutputReportType, OutputErrorType

log = BKLogger()
parseParamsObj = ParseParams()
params = parseParamsObj.get_input()
status = Status()
output_template_type = OutputTemplateType()
output_field_type = OutputFieldType()
output_report_type = OutputReportType()
output_error_type = OutputErrorType()


def get_input():
    """
    @summary: 获取 插件输入参数
    @return dict
    """
    return params


def get_project_name():
    """
    @summary: 获取项目英文名
    """
    return params.get("project.name", None)


def get_project_name_cn():
    """
    @summary: 获取项目中文名
    """
    return params.get("project.name.chinese", None)


def get_pipeline_id():
    """
    @summary: 获取流水线ID
    """
    return params.get("pipeline.id", None)


def get_pipeline_name():
    """
    @summary: 获取流水线名称
    """
    return params.get("pipeline.name", None)


def get_pipeline_build_id():
    """
    @summary: 获取buildId
    """
    return params.get("pipeline.build.id", None)


def get_pipeline_build_num():
    """
    @summary: 获取buildno
    """
    return params.get("pipeline.build.num", None)


def get_pipeline_start_type():
    """
    @summary: 获取流水线启动类型
    """
    return params.get("pipeline.start.type", None)


def get_pipeline_start_user_id():
    """
    @summary: 获取流水线启动人
    """
    return params.get("pipeline.start.user.id", None)


def get_pipeline_start_user_name():
    """
    @summary: 获取流水线启动人
    """
    return params.get("pipeline.start.user.name", None)


def get_pipeline_creator():
    """
    @summary: 获取流水线创建人
    """
    return params.get("BK_CI_PIPELINE_CREATE_USER", None)


def get_pipeline_modifier():
    """
    @summary: 获取流水线最近修改人
    """
    return params.get("BK_CI_PIPELINE_UPDATE_USER", None)


def get_pipeline_time_start_mills():
    """
    @summary: 获取流水线启动时间
    """
    return params.get("pipeline.time.start", None)


def get_pipeline_version():
    """
    @summary: 获取流水线的版本
    """
    return params.get("pipeline.version", None)


def get_workspace():
    """
    @summary: 获取工作空间
    """
    return params.get("bkWorkspace", None)


def get_test_version_flag():
    """
    @summary: 当前插件是否是测试版本标识
    """
    return params.get("testVersionFlag", None)


def get_sensitive_conf(key):
    """
    @summary: 获取配置数据
    """
    conf_json = params.get("bkSensitiveConfInfo", None)
    if conf_json:
        return conf_json.get(key, None)
    else:
        return None


def set_output(output):
    """
    @summary: 设置输出
    """
    setOutput = SetOutput()
    setOutput.set_output(output)


def get_credential(credential_id):
    from .openapi import OpenApi
    client = OpenApi()
    return client.get_credential(credential_id)


if __name__ == "__main__":
    pass
```

接口大致可以分为一下几类：
1. 获取用户输入，`get_input`返回的是一个`{"输入组件名称":"用户输入内容"}`组成的字典，调用方法：`sdk.get_input().get("key")`
2. 设置用户输入，`set_output`设置用户输出，在command_line.py里，已经被封装成`exit_with_error`和`exit_with_succ`
3. 获取私有配置，私有配置通常配置了插件的全局变量或者普通用户不可见的账密信息，比如蓝鲸esb网关地址、请求第三方服务的地址等，调用方法：`sdk.get_sensitive_conf(key)`，key表示配置名称，如`sdk.get_sensitive_conf("BK_PAAS_URL")`
4. 获取凭证，`get_credential`，用户的私密配置，可以通过凭证管理配置，插件可以通过`get_credential`获取到这部分信息，调用方法：`sdk.get_credential("credential_id")`，credential_id为凭证英文名称
5. 获取内置变量，除上述4类外， 剩余的接口均是获取内置变量的接口
6. 此外还有日志打印的接口`sdk.log.info("info")、sdk.log.error("error")`
