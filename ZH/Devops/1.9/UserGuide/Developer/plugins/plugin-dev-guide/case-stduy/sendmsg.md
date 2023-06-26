# **sendmsg-通用消息发送插件**


## 构思

企业微信消息、邮件都能通过蓝鲸ESB接口来发送，群消息也能通过群机器人webhook地址发送text格式信息以及markdown信息，其中text格式信息还支持@群成员，这几个消息发送需求集合在一个插件里实现

## 前端设计

需要同时支持企业微信消息、邮件、群机器人这三种消息发送方式，并且需要这三者都是可选的，可以选择复选框。

![](../../../../assets/image-plugin-casestudy-sendmsg0.png)

其他输入项，比如发送目标，消息标题、消息内容等需要用户输入的内容，会在用户勾选消息发送方式的时候，显示出来。比如当勾选「企业微信」发送方式，就会出现「发送目标」「消息标题」「消息内容」的输入框。邮件和企业微信共用「发送目标」、「消息标题」、「消息内容」这三个输入框，所以选中「企业微信」「邮件」这两个选项中的任何一个，都会显示这些输入框。

![](../../../../assets/image-plugin-casestudy-sendmsg1.png)



选中「发送至企业微信群机器人」，会出现以下配置项，其中「@群成员」只有在用户选中消息类型为「text」时才会出现

![](../../../../assets/image-plugin-casestudy-sendmsg2.png)

## 后端设计

### 基础概念

插件通常包含三部分：

1. task.json: 定义前端输入组件、输出变量，插件执行入口
2. sdk包：提供了插件开发需要使用到的各种函数
3. 用户自定义代码

以python插件为例，参考[plugin-demo-python](https://github.com/ci-plugins/plugin-demo-python)

```
|- demo                       # 插件包名
    |- demo                   # 插件包名
        |- __init__.py py     # py包标识
        |- command_line.py    # 命令入口文件, 用户自定义代码部分
        |- error_code.py      # 自定义错误码
    |- python_atom_sdk        # 插件开发SDK包
    |- MANIFEST.in            # 包文件类型申明
    |- requirements.txt       # 依赖申明
    |- setup.py               # 执行包打包配置
    |- task.json              # 定义前端输入组件、输出变量，插件执行入口
```

建议直接在plugin-demo-python代码基础上进行开发

本项目架构：

```
|- plugin-sendmsg-demo                # 插件包名
    |- sendmsgDemo                   	# 插件包名
        |- __init__.py py     				# py包标识
        |- command_line.py    				# 命令入口文件, 用户自定义代码部分
        |- error_code.py      				# 自定义错误码
    |- python_atom_sdk        				# 插件开发SDK包
    |- MANIFEST.in            				# 包文件类型申明
    |- requirements.txt       				# 依赖申明
    |- setup.py               				# 执行包打包配置
    |- task.json              				# 定义前端输入组件、输出变量，插件执行入口
```



### task.json

task.json主要包含以下字段：

1. atomCode: 描述插件名称
2. execution: 描述插件包名称、开发语言、插件运行前置命令、插件命令
3. input：描述输入组件
4. output：描述输出变量

```
{
  "atomCode": "sendmsgDemo",
  "execution": {
    "packagePath": "sendmsgDemo-1.0.0.tar.gz", # 包名称，根据实际打包版本填写,需和setup.py里定义一致
    "language": "python",                       # 开发语言
    "demands": [                                # 插件运行前置命令
        "pip install sendmsgDemo-1.0.0.tar.gz"
    ],
    "target": "sendmsg"                          # 插件命令
  },
  "input":{},                                    # 输入组件
  "output": {}                                   # 输出变量, 没有输出变量可不用定义output
}  
```

#### 输入组件

消息发送方式选择复选框，复选框组件有两种atom-checkbox-list和atom-checkbox，这两者的区别在于，atom-checkbox-list会将选项横向排列，atom-checkbox的选项会独占一行。企业微信和邮件发送方式可以共用消息内容，所以这两种方式适合用atom-checkbox-list，群消息发送需要选择消息类型（text/markdown），且不需要标题，所以适合使用atom-checkbox组件。

```
{
    ......
    "input":{
        "send_by":{
            "label": "消息发送方式",         # 组件标识
            "type": "atom-checkbox-list",  # 组件类型为atom-checkbox-list
            "list": [                      # 选项列表，这里会有两个选项，企业微信和邮件
                {
                    "id": "weixin",        # 选项id
                    "name": "企业微信",     # 选项名称
                    "disable": false,      # 是否设置为不可选择
                    "desc": "消息会发送到企业微信应用号，需先在ESB配置企业微信应用号信息"   # 选项描述
                }, 
                {
                    "id": "mail",
                    "name": "邮件",
                    "disable": false,
                    "desc": "发送到邮件"
                }
            ]
        },
        "send_by_robot":{
            "label": "",                    # 可不填
            "type": "atom-checkbox",        # 组件类型为atom-checkbox
            "default": false,               # 默认值，为false表示默认不勾选
            "text": "发送至企业微信群机器人",   # 选项功能
            "desc": ""                      # 选项描述
        }
    }
}
```

可在BKCI「研发商店」-「控制台」-「调试task.json」查看task.json可视化结果

![](../../../../assets/image-plugin-casestudy-sendmsg3.png)



接下来添加「发送目标」、「消息标题」、「消息内容」这三个输入组件，当用户选中「企业微信」、「邮件」时，这三个输入组件才会显示

```
{
    ......
    "input":{
        ......
        "send_to": {
            "label":"发送目标",  
            "default":"",                   
            "placeholder":"用户名",
            "type":"vuex-input",               # 组件类型为vuex-input，单行文本框
            "desc":"使用分号;分隔多个用户名",
            "required": true,                  # 是否必须，为true表示必须有值
            "rely":{                           # 表示依赖于其他组件
                "operation": "OR",             # 依赖逻辑或，即下述expression任一结果符合即可显示
                "expression":[                 # 依赖的多个组件的名称、值，表示当send_by组件出现任一以下值时，当前组件就会显示
                    {
                        "key": "send_by",
                        "value": ["weixin","mail"]
                    }
                ]
            }
        },
        "title": {
            "label":"标题",
            "default":"",
            "placeholder":"标题",
            "type":"vuex-input",
            "desc":"企业微信消息标题或邮件标题",
            "required": true,
            "rely":{
                "operation": "OR",
                "expression":[
                    {
                        "key": "send_by",
                        "value": ["weixin","mail"]
                    }
                ]
            }
        },
        "content": {
            "label": "消息内容",
            "default": "",
            "type": "vuex-textarea",    # 组件类型为vuex-textarea，多行文本框
            "disabled": false,
            "hidden": false,
            "isSensitive": false,
            "desc": "消息内容，可使用变量${VAR}",
            "required": true,
            "rely":{
                "operation": "OR",
                "expression":[
                    {
                        "key": "send_by",
                        "value": ["weixin","mail"]
                    }
                ]
            }
        },
    }
}
```

可视化结果：

![](../../../../assets/image-plugin-casestudy-sendmsg4.png)



接下来添加企业微信群机器人的输入组件

```
{
    ......
    "input":{
       ......
        "robot_key": {
            "label":"机器人webhook key",
            "default":"",
            "placeholder":"机器人webhook key",
            "type":"vuex-input",
            "desc":"企业微信机器人webhook key，建议使用凭证管理",
            "required": true,
            "rely": {                # 依赖于send_by_robot组件值为true，即勾选「发送至企业微信机器人」
                "operation": "AND",  # 依赖逻辑与
                "expression": [
                    {
                        "key": "send_by_robot",
                        "value": true
                    }
                ]
            }
        },
        "msgtype": {
            "label": "消息类型",
            "type": "selector",       # 类型为selector，下拉选项
            "default": "text",
            "desc": "消息类型可以为text/markdown",
            "options": [              # 下拉项
                {
                    "id": "text",
                    "name": "text",
                    "desc": "",
                    "disable": false
                },
                {
                    "id": "markdown",
                    "name": "markdown",
                    "desc": "",
                    "disable": false
                }
            ],
            "rely": {
                "operation": "AND",
                "expression": [
                    {
                        "key": "send_by_robot",
                        "value": true
                    }
                ]
            }
        },
        "mentioned": {
            "label": "@群成员",
            "type": "vuex-input",
            "default": "",
            "placeholder": "PonyMa;@all",
            "desc":"使用企业微信UserId，通过管理员后台可获取，分号分隔多个UserId",
            "rely": {
                "operation":"AND",   # 依赖逻辑与，当用户勾选「发送至企业微信群机器人」，并且选中消息类型为text时，当前组件才会显示
                "expression":[
                    {
                        "key":"send_by_robot",
                        "value": true
                    },
                    {
                        "key": "msgtype",
                        "value": "text"
                    }
                ]
            }
        },
        "robot_content": {
            "label": "群消息内容",
            "type": "vuex-textarea",
            "default": "",
            "placeholder": "消息类型为markdown时，可使用markdown语法",
            "desc":"消息类型为markdown时，可使用markdown语法",
            "required": true,
            "rely": {
                "operation": "AND",
                "expression": [
                    {
                        "key": "send_by_robot",
                        "value": true
                    }
                ]
            }
        }
    }
}
```

可视化结果：

![](../../../../assets/image-plugin-casestudy-sendmsg5.png)

![](../../../../assets/image-plugin-casestudy-sendmsg6.png)


如果插件需要设置输出，可以添加output字段

```
{
    ......
    "output": {
        "TEST_OUTPUT": {
            "type": "string",
            "description": "测试输出"
        }
    }
}
```

可视化结果：

![](../../../../assets/image-plugin-casestudy-sendmsg7.png)

### sdk

主要关注几个函数，即可完成业务逻辑编码

1. sdk.get_input()获取组件的输入，输入组件获取到的值都是字符串

```
# 输入
input_params = sdk.get_input()
send_to = input_params.get("send_to", None)

# 注意atom-checkbox-list类型的组件，获取到的字符串需要使用json.loads将字符串转化成list
send_by_str = input_params.get("send_by", None)
send_by= json.load(send_by_str)

# atom-checkbox获取到的是字符串'true'或者'false'，需要自行转换成True/False
send_by_robot_str = input_params.get("send_by_robot", None)
send_by = True if send_by_robot_str == 'true' else False
```

2. sdk.get_sensitive_conf("key")获取私有配置变量

```
bk_app_code = sdk.get_sensitive_conf("bk_app_code")
```

3. sdk.log日志输出

```
sdk.log.info("xxx")
sdk.log.error("xxx")
```

4. exit_with_succ(data=data)设置输出变量

```
# exit_with_succ封装sdk.set_output了，方便用户设置输出变量
data = {
    "TEST_OUTPUT":{
        "type": sdk.output_field_type.STRING,   # 需要task.json设置的类型一致
        "value": "test"                         # 输出变量的值，需和声明的类型一致
    }
}

exit_with_succ(data=data)
```

## 打包

1. 进入插件代码工程根目录下

2. 执行 python setup.py sdist (或其他打包命令，本示例以sdist为例)

3. 在任意位置新建文件夹，如 sendmsgDemo_release

4. 将步骤 2 生产的执行包拷贝到 sendmsgDemo_release 下

5. 添加task.json文件到 sendmsgDemo_release 下

6. 把 sendmsgDemo_release 使用`zip -r sendmsgDemo.zip sendmsgDemo_release`打成zip包即可 

setup.py

```
# -*- coding: utf-8 -*-

import os

from setuptools import setup, find_packages

BASE_DIR = os.path.realpath(os.path.dirname(__file__))


def parse_requirements():
    """
    @summary: 获取依赖
    """
    reqs = []
    if os.path.isfile(os.path.join(BASE_DIR, "requirements.txt")):
        with open(os.path.join(BASE_DIR, "requirements.txt"), 'r') as fd:
            for line in fd.readlines():
                line = line.strip()
                if line:
                    reqs.append(line)
    return reqs


if __name__ == "__main__":
    setup(
        version="1.0.0",
        name="sendmsgDemo",
        description="",

        cmdclass={},
        packages=find_packages(),
        package_data={'': ['*.txt', '*.TXT', '*.JS', 'test/*']},
        install_requires=parse_requirements(),

        entry_points={'console_scripts': ['sendmsgDemo = sendmsgDemo.command_line:main']},

        author="vincohuang",
        author_email="vincohuang@tencent.com",
        license="Copyright(c)2021-2022 vincohuang All Rights Reserved."
    )
```

## 项目参考

plugin-demo-python: https://github.com/ci-plugins/plugin-demo-python

plugin-sendmsg-demo: https://github.com/wenchao-h/plugin-sendmsg-demo
