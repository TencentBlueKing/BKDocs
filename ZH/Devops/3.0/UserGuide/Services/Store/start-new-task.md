# 开发一个流水线插件

> 开发插件前，先进入插件工作台初始化一个插件，确定插件在平台中的唯一标识

## 工作台

可以在这里进行新增/发布/下架等管理插件的操作

### 功能区介绍

![png](../../assets/store_plugin_list.png)

1. 切换资源类型
2. 新增插件
3. 单个插件的管理入口
4. 升级、下架、删除插件快捷入口
5. 指引文档和插件 UI 调试工具入口

### 新增插件

![png](../../assets/store_plugin_add.png)

1. 标识
    - 插件在平台中的唯一标识，建议取和插件功能相关的可读性好的英文标识
2. 调试项目
    - 插件发布过程中，可以在调试项目下将插件添加到流水线执行，对插件进行测试，保证插件功能满足预期。
    - 建议新增专用的插件调试项目，避免测试过程中影响到业务。
3. 开发语言
    - 支持四种语言开发插件：
        - Java（推荐）
        - Python
        - Golang
        - Nodejs

### 开发插件

> 初始化好插件之后，可以开始开发插件  
- 根据开发语言参考对应的开发指引
  - [Java 插件开发指引](../../Developer/plugins/plugin-dev-guide/java.md)
  - [Python 插件开发指引](../../Developer/plugins/plugin-dev-guide/python.md)
  - [Golang 插件开发指引](../../Developer/plugins/plugin-dev-guide/golang.md)
  - [Nodejs 插件开发指引](../../Developer/plugins/plugin-dev-guide/nodejs.md)

### 插件私有配置

> 插件级别的敏感信息，如 token、用户名密码、IP、域名等，不建议直接提交到代码库，通过工作台私有配置界面管理

入口如下，创建后，在插件中通过 SDK 提供的方法即可获取使用
![png](../../assets/store_plugin_private_info.png)

## 接下来你可能需要

- [上传一个流水线插件](upload-new-task.md)
